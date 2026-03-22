// src/renderer.js — BGI-equivalent Canvas 2D renderer
// Decodes 2bpp CGA sprite data and blits them onto the canvas.
// All entities (Pacman + enemies) use actual CGA sprites from the original EXE.
'use strict';

class Renderer {
  constructor(canvas) {
    this.canvas = canvas;
    this.ctx    = canvas.getContext('2d');
    this.palIdx = DEFAULT_PALETTE;
    this._tiles = [];       // ImageData cache, indexed by tile id
    this._decodeAll();
  }

  // ── Palette ──────────────────────────────────────────────────────────────────

  setPalette(idx) {
    this.palIdx = idx;
    this._decodeAll();
  }

  // ── Sprite decode ─────────────────────────────────────────────────────────────

  _decodeAll() {
    const pal = CGA_PALETTES[this.palIdx];
    this._tiles = SPRITES_RAW.map(raw => this._decode(raw, pal));
  }

  // Decode one 56-byte 2bpp sprite into an ImageData (TILE_W × TILE_H).
  // 2bpp layout: each byte = 4 pixels, bits 7-6 = px0, 5-4 = px1, 3-2 = px2, 1-0 = px3.
  _decode(raw, pal) {
    const img = this.ctx.createImageData(TILE_W, TILE_H);
    const d = img.data;
    for (let row = 0; row < TILE_H; row++) {
      for (let col = 0; col < TILE_W; col++) {
        const byteIdx = row * 4 + Math.floor(col / 4);
        const shift   = (3 - (col & 3)) * 2;
        const ci      = (raw[byteIdx] >> shift) & 3;
        const [r, g, b] = pal[ci];
        const px = (row * TILE_W + col) * 4;
        d[px]     = r;
        d[px + 1] = g;
        d[px + 2] = b;
        d[px + 3] = 255;
      }
    }
    return img;
  }

  // ── Core draw calls ──────────────────────────────────────────────────────────

  clear() {
    this.ctx.fillStyle = '#000';
    this.ctx.fillRect(0, 0, 320, 200);
  }

  // Blit a decoded tile sprite at canvas pixel position (px, py).
  drawTile(tileId, px, py) {
    const img = this._tiles[tileId];
    if (img) this.ctx.putImageData(img, px, py);
  }

  // Draw a sprite with XOR compositing (like BGI putimage XOR mode).
  // Used for moving entities — XOR draws/erases cleanly over background.
  drawSprite(spriteId, px, py) {
    if (spriteId < 0 || spriteId >= this._tiles.length) return;
    // Clip: don't draw if fully off-screen
    if (px < -TILE_W || px >= 320 || py < -TILE_H || py >= 200) return;
    // Use putImageData (opaque blit) — same as the original BGI putimage COPY_PUT
    this.ctx.putImageData(this._tiles[spriteId], px, py);
  }

  // Draw pixel-font text at (px, py). size in px. Left-aligned.
  drawText(px, py, str, color = '#fff', size = 8, font = 'monospace') {
    const ctx = this.ctx;
    ctx.save();
    ctx.fillStyle = color;
    ctx.font = `bold ${size}px ${font}`;
    ctx.textBaseline = 'top';
    ctx.textAlign = 'left';
    ctx.fillText(str, px, py);
    ctx.restore();
  }

  // Draw centered text at (px, py). BGI-style: x=160 centers on screen.
  drawTextCenter(px, py, str, color = '#fff', size = 8, font = 'monospace') {
    const ctx = this.ctx;
    ctx.save();
    ctx.fillStyle = color;
    ctx.font = `bold ${size}px ${font}`;
    ctx.textBaseline = 'top';
    ctx.textAlign = 'center';
    ctx.fillText(str, px, py);
    ctx.restore();
  }

  // Fill a solid rectangle.
  fillRect(px, py, w, h, color) {
    this.ctx.fillStyle = color;
    this.ctx.fillRect(px, py, w, h);
  }
}
