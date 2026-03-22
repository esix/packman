#!/usr/bin/env node
// extract.js — one-time extractor for PACKMAN.EXE data
// Outputs js/src/data.js
//
// File layout formula: DS_offset (segment 0800) -> file_offset = DS_offset + 0x0400
// (Program loads at physical 0x8000, header = 0x400 bytes)
//
// Key addresses (DS = segment 0800):
//   DS:0x6FFA = number of levels (word, = 0x0F = 15)
//   DS:0x6FFC = level data (15 * 480 bytes, each 20 cols * 12 rows * 2 bytes/tile)
//   DS:0x8C1E = sprite table (56 bytes/sprite, 2bpp CGA 16x14 px)

'use strict';

const fs = require('fs');
const path = require('path');

const EXE_PATH  = path.join(__dirname, '../original/PACKMAN.EXE');
const OUT_PATH  = path.join(__dirname, '../src/data.js');

const data = fs.readFileSync(EXE_PATH);

// DS:offset -> file offset
function fo(dsOff) { return dsOff + 0x400; }

// ── Level data ──────────────────────────────────────────────────────────────
const N_LEVELS   = data.readUInt16LE(fo(0x6FFA));  // = 15
const LEVEL_BASE = fo(0x6FFC);
const COLS = 20, ROWS = 12, LEVEL_BYTES = COLS * ROWS * 2; // 480

const levels = [];
for (let lvl = 0; lvl < N_LEVELS; lvl++) {
    const grid = [];
    for (let r = 0; r < ROWS; r++) {
        const row = [];
        for (let c = 0; c < COLS; c++) {
            const off = LEVEL_BASE + lvl * LEVEL_BYTES + r * COLS * 2 + c * 2;
            row.push(data.readUInt16LE(off));
        }
        grid.push(row);
    }
    levels.push(grid);
}

// ── Sprite data ──────────────────────────────────────────────────────────────
// Sprites 0x00..0x1C (29 total), 56 bytes each (14 rows * 4 bytes/row, 2bpp)
const SPRITE_BASE = fo(0x8C1E);
const SPRITE_SIZE = 56;
const N_SPRITES = 0x1D; // 29

const sprites = [];
for (let i = 0; i < N_SPRITES; i++) {
    const off = SPRITE_BASE + i * SPRITE_SIZE;
    sprites.push(Array.from(data.slice(off, off + SPRITE_SIZE)));
}

// ── ASCII art validation ─────────────────────────────────────────────────────
const TILE_CHARS = {
    0x00: ' ', 0x01: '.', 0x02: 'J', 0x03: 'T', 0x04: 'F',
    0x05: '-', 0x06: '-', 0x07: 'r', 0x08: 'L', 0x09: 'j',
    0x0A: '|', 0x0B: '=', 0x0C: '+',
    0x0D: 'P', 0x0E: 'p', 0x0F: 'Q', 0x10: 'q', 0x11: 'U', 0x12: 'u',
    0x13: 'G', 0x14: 'g',
    0x15: '*', 0x16: '&',
    0x17: 'X', 0x18: 'A', 0x19: 'V', 0x1A: 'a', 0x1B: 'v', 0x1C: 'x',
};

for (let lvl = 0; lvl < N_LEVELS; lvl++) {
    const grid = levels[lvl];
    const dots = grid.flat().filter(t => t === 0x01).length;
    const unique = [...new Set(grid.flat())].sort((a,b)=>a-b);
    console.log(`=== Level ${lvl + 1} (${dots} dots, tiles: [${unique.map(x=>'0x'+x.toString(16)).join(',')}]) ===`);
    for (const row of grid) {
        console.log(row.map(t => TILE_CHARS[t] ?? `?${t.toString(16)}`).join(''));
    }
    console.log();
}

// ── Identify level 13 (index 12) issues ─────────────────────────────────────
const lvl13 = levels[12];
const emptyTiles = [];
for (let r = 0; r < ROWS; r++)
    for (let c = 0; c < COLS; c++)
        if (lvl13[r][c] === 0x00)
            emptyTiles.push([r, c]);
if (emptyTiles.length) {
    console.log(`Level 13 has ${emptyTiles.length} empty (0x00) tiles: ${JSON.stringify(emptyTiles)}`);
    console.log('→ Fixing by replacing with 0x0A (vertical corridor)');
    for (const [r, c] of emptyTiles)
        lvl13[r][c] = 0x0A;
}

// ── CGA palettes (4 palette choices from game menu) ─────────────────────────
// 2bpp: color 0=bg, 1, 2, 3
// Palette 0 low:  black, green,        red,          brown/yellow
// Palette 1 low:  black, cyan,         magenta,      white
// Palette 0 hi:   black, bright green, bright red,   yellow
// Palette 1 hi:   black, bright cyan,  bright magenta, white
const CGA_PALETTES = [
    [[0,0,0], [0,170,0],   [170,0,0],   [170,85,0]],    // 0: C0 (low)
    [[0,0,0], [0,170,170], [170,0,170], [170,170,170]], // 1: C1 (low)
    [[0,0,0], [85,255,85], [255,85,85], [255,255,85]], // 2: C2 (high)
    [[0,0,0], [85,255,255],[255,85,255],[255,255,255]], // 3: C3 (high) – default
];

// ── Output data.js ───────────────────────────────────────────────────────────
const spritesJs = sprites
    .map((s, i) => `  /* 0x${i.toString(16).padStart(2,'0')} */ [${s.join(',')}]`)
    .join(',\n');

const levelsJs = levels
    .map((grid, i) =>
        `  /* Level ${i+1} */\n  [\n` +
        grid.map(row => `    [${row.join(',')}]`).join(',\n') +
        '\n  ]'
    )
    .join(',\n');

const out = `// src/data.js — extracted from PACKMAN.EXE
// DO NOT EDIT — regenerate with: node tools/extract.js
// Sprite format: 56 bytes per tile, 14 rows × 4 bytes, 2bpp CGA
// Grid: 20 cols × 12 rows, tile 16×14 px, screen 320×200

'use strict';

const N_LEVELS  = ${N_LEVELS};
const COLS      = ${COLS};
const ROWS      = ${ROWS};
const TILE_W    = 16;
const TILE_H    = 14;

// Raw 2bpp sprite data (56 bytes each, index = tile id)
// 2bpp: each byte holds 4 pixels, bits 7-6=px0, 5-4=px1, 3-2=px2, 1-0=px3
// color 0=black, 1=cyan(X), 2=magenta(@), 3=white(#)
const SPRITES_RAW = [
${spritesJs}
];

// Tile IDs
const T_EMPTY   = 0x00;  // open gap (fixed level 13 edges)
const T_DOT     = 0x01;  // small dot (10 pts)
const T_POWER   = 0x15;  // power pellet / ghost house ghost (50 pts, fright mode)

// Tiles that Pacman can walk through
const WALKABLE = new Set([T_EMPTY, T_DOT, T_POWER]);

// Level grids: levels[lvl][row][col] = tile id (0-indexed levels)
const LEVELS = [
${levelsJs}
];

// CGA 4-color palettes: [[r,g,b], [r,g,b], [r,g,b], [r,g,b]]
// Index matches 2bpp color value (0..3)
const CGA_PALETTES = ${JSON.stringify(CGA_PALETTES, null, 2)};

// Default palette (CGA palette 1 high intensity: black/cyan/magenta/white)
const DEFAULT_PALETTE = 3;

// Tile character map for debugging
const TILE_CHARS = ${JSON.stringify(TILE_CHARS)};

// Ghost appearance variants (3 color schemes, chosen randomly at level start)
const GHOST_COLORS = [
    { body: '#ff55ff', eye: '#0000aa', pupil: '#ffffff' },  // magenta
    { body: '#ff5555', eye: '#0000aa', pupil: '#ffffff' },  // red
    { body: '#55ffff', eye: '#0000aa', pupil: '#ffffff' },  // cyan
    { body: '#ffff55', eye: '#0000aa', pupil: '#ffffff' },  // yellow
];
const FRIGHT_GHOST_COLOR = { body: '#0000aa', eye: '#ff55ff', pupil: '#ffffff' };

// Export
if (typeof module !== 'undefined') module.exports = {
    N_LEVELS, COLS, ROWS, TILE_W, TILE_H,
    SPRITES_RAW, T_EMPTY, T_DOT, T_POWER, WALKABLE, LEVELS,
    CGA_PALETTES, DEFAULT_PALETTE, TILE_CHARS, GHOST_COLORS, FRIGHT_GHOST_COLOR,
};
`;

fs.writeFileSync(OUT_PATH, out);
console.log(`\nWrote ${OUT_PATH} (${out.length} bytes)`);
console.log(`  ${N_LEVELS} levels, ${N_SPRITES} sprites, ${N_LEVELS * COLS * ROWS} total tiles`);
