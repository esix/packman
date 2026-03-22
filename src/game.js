// src/game.js — main game logic
// Faithful port of PACKMAN.EXE (Kiev'90 Free Masters)
// Based on ASM analysis of fn0800_0BDC, fn0800_111E, fn0800_128C,
// fn0800_12B7 (Pacman update), fn0800_13EE (collision), fn0800_0F63 (movement),
// fn0800_10F8/fn0800_1096 (enemy AI), fn0800_0A2F (keyboard handler).
'use strict';

// ── Constants (from ASM analysis) ────────────────────────────────────────────

const STARTING_LIVES = 5;    // ASM: 0x23 / 7 = 5

// Movement per step (from ASM movement function at 0x0E86)
const STEP_X = 4;   // horizontal pixels per move step
const STEP_Y = 2;   // vertical pixels per move step

// Direction encoding (ASM: 1=up, 2=right, 3=down, 4=left)
const DIR_NONE  = 0;
const DIR_UP    = 1;
const DIR_RIGHT = 2;
const DIR_DOWN  = 3;
const DIR_LEFT  = 4;

// Direction vectors
const DIR_DX = { [DIR_NONE]: 0, [DIR_UP]: 0, [DIR_RIGHT]: 1, [DIR_DOWN]: 0, [DIR_LEFT]: -1 };
const DIR_DY = { [DIR_NONE]: 0, [DIR_UP]: -1, [DIR_RIGHT]: 0, [DIR_DOWN]: 1, [DIR_LEFT]: 0 };

// Game states (from ASM: [0xA380] values)
const S_MENU           = 'MENU';
const S_PLAYING        = 'PLAYING';
const S_DYING          = 'DYING';
const S_LEVEL_COMPLETE = 'LEVEL_COMPLETE';
const S_VICTORY        = 'VICTORY';
const S_GAME_OVER      = 'GAME_OVER';

// Score per eaten tile (from ASM: add [0xA118], 2)
const SCORE_PER_TILE = 2;

// Speed table: frames between movement steps
// Speed 0 = fastest (fewer frames between moves), speed 9 = slowest
// This maps the speed setting to a frame delay multiplier
const SPEED_TABLE = [1, 2, 2, 3, 3, 4, 5, 6, 8, 10];

// ── LCG random number generator (from ASM fn0800_6F53) ──────────────────────
let _rngSeed = 0x1234;
function rng() {
  _rngSeed = (Math.imul(_rngSeed, 0x015A4E35) + 1) >>> 0;
  return (_rngSeed >>> 16) & 0x7FFF;
}

// ── Utility ──────────────────────────────────────────────────────────────────

// Ghost count formula (from ASM fn0800_111E): (levelIdx * 3) / levelCount + 2
// But the init loop runs from 1 to <count, so actual enemies = count - 1
function enemyCount(levelIdx) {
  const count = Math.floor(levelIdx * 3 / N_LEVELS) + 2;
  return Math.min(count, 4) - 1;  // -1 because loop starts at 1
}

// Check if a tile is walkable
function isWalkable(maze, col, row) {
  if (col < 0 || col >= COLS) return true;   // tunnel edges
  if (row < 0 || row >= ROWS) return false;
  return WALKABLE.has(maze[row][col]);
}

// Check if entity is at exact tile boundary (from ASM fn0800_0D23)
function atTileBoundary(x, y) {
  return (x % TILE_W === 0) && (y % TILE_H === 0);
}

// Get tile ahead in direction (from ASM fn0800_0F7E)
// Returns the tile ID ahead, or -1 if at map edge
function tileAhead(maze, x, y, dir) {
  let col, row;
  switch (dir) {
    case DIR_UP:
      col = Math.floor(x / TILE_W);
      row = Math.floor((y + TILE_H - 1) / TILE_H);
      row--;
      break;
    case DIR_DOWN:
      col = Math.floor(x / TILE_W);
      row = Math.floor(y / TILE_H);
      row++;
      break;
    case DIR_RIGHT:
      col = Math.floor(x / TILE_W);
      col++;
      row = Math.floor(y / TILE_H);
      break;
    case DIR_LEFT:
      col = Math.floor((x + TILE_W - 1) / TILE_W);
      col--;
      row = Math.floor(y / TILE_H);
      break;
    default:
      return -1;
  }
  if (col < 0 || col >= COLS) return 0;  // tunnel = walkable
  if (row < 0 || row >= ROWS) return -1;
  return maze[row][col];
}

// Check X overlap between two entities (from ASM fn0800_0D4E)
function xOverlap(e1, e2) {
  return Math.abs(e1.x - e2.x) < TILE_W;
}

// Check Y overlap (from ASM fn0800_0D6E)
function yOverlap(e1, e2) {
  return Math.abs(e1.y - e2.y) < TILE_H;
}

// Get collision/chase direction (from ASM fn0800_0D90)
// Returns direction enemy should move to approach Pacman
function chaseDirection(enemy, pac) {
  if (xOverlap(enemy, pac)) {
    return enemy.y > pac.y ? DIR_UP : DIR_DOWN;
  }
  if (yOverlap(enemy, pac)) {
    return enemy.x > pac.x ? DIR_LEFT : DIR_RIGHT;
  }
  return DIR_NONE;
}

// ── Entity structure ─────────────────────────────────────────────────────────
// Mirrors ASM entity at DS:0xA124 (30 bytes per entity)
// +00: x (pixel), +02: y (pixel), +04: pattern base, +06: pattern pos,
// +08: pattern length, +0A: direction, +0C/+0E: anim counter/target,
// +10/+12: x speed counter/target, +14/+16: y speed counter/target,
// +18: sprite base, +1A: sprite current, +1C: sprite frame count

function createEntity() {
  return {
    x: 0, y: 0,
    patternIdx: 0,      // which ENEMY_PATTERNS to use
    patternPos: 0,       // current position in pattern (0-15)
    dir: DIR_NONE,       // current direction (1-4)
    animCounter: 1,      // animation frame counter
    animTarget: 0,       // animation target (cycles sprite)
    xCounter: 1,         // horizontal move counter
    xTarget: 4,          // horizontal move target
    yCounter: 1,         // vertical move counter
    yTarget: 2,          // vertical move target
    spriteFrames: [],    // sprite IDs for animation
    spriteIdx: 0,        // current sprite frame index
    alive: true,         // entity active flag
  };
}

// ── Game class ───────────────────────────────────────────────────────────────

class Game {
  constructor(canvas) {
    this.renderer = new Renderer(canvas);
    window.renderer = this.renderer;

    this.state     = S_MENU;
    const touch    = window.matchMedia('(pointer: coarse)').matches;
    this.speed     = touch ? 2 : 5;  // default speed (0=fastest, 9=slowest); faster on mobile
    this.score     = 0;
    this.hiScore   = +localStorage.getItem('packman_hi') || 0;
    this.lives     = STARTING_LIVES;
    this.levelIdx  = 0;
    this.tick      = 0;
    this.updateCounter = 0;
    this.stateTimer    = 0;
    this.soundOn       = localStorage.getItem('packman_muted') !== '1';

    this.maze      = null;
    this.dotsTotal = 0;        // total eatable tiles in level
    this.dotsEaten = 0;        // eaten counter (ASM: [0xA19C])
    this.pac       = null;
    this.enemies   = [];
    this.inputDir  = DIR_NONE; // keyboard direction (ASM: [0x927A])

    this._loop = this._loop.bind(this);
  }

  start() {
    requestAnimationFrame(this._loop);
  }

  // ── Main loop ──────────────────────────────────────────────────────────────

  _loop() {
    this.tick++;
    this._update();
    this._render();
    requestAnimationFrame(this._loop);
  }

  // ── State machine ──────────────────────────────────────────────────────────

  _update() {
    switch (this.state) {
      case S_MENU:           this._updateMenu();          break;
      case S_PLAYING:        this._updatePlaying();       break;
      case S_DYING:          this._updateDying();         break;
      case S_LEVEL_COMPLETE: this._updateLevelComplete(); break;
      case S_VICTORY:        this._updateVictory();       break;
      case S_GAME_OVER:      this._updateGameOver();      break;
    }
  }

  _setState(s) {
    this.state      = s;
    this.stateTimer = 0;
  }

  // ── MENU state (from ASM fn0800_06F3) ──────────────────────────────────────

  _updateMenu() {
    // Speed keys (ASM: speed = '9' - key, so pressing '0' → internal 9 = slowest)
    const d = input.getDigit();
    if (d >= 0) this.speed = 9 - d;

    if (input.wasPressed('Space') || input.wasPressed('Enter')) {
      this._startGame(0);
      return;
    }
    if (input.wasPressed('KeyS')) { this._save(); return; }
    if (input.wasPressed('KeyL')) { this._load(); return; }
    // F1/F2 sound toggle
    if (input.wasPressed('F1')) { this.soundOn = false; localStorage.setItem('packman_muted', '1'); }
    if (input.wasPressed('F2')) { this.soundOn = true; localStorage.setItem('packman_muted', '0'); }
  }

  // ── PLAYING state ──────────────────────────────────────────────────────────

  _updatePlaying() {
    this.updateCounter++;
    const interval = SPEED_TABLE[this.speed] || 4;
    if (this.updateCounter < interval) return;
    this.updateCounter = 0;

    // Keyboard handler (from ASM fn0800_0A2F)
    this._handlePlayingKeys();

    // Entity updates (ASM entity handler chain)
    this._updatePacman();       // fn0800_12B7: dot eating + direction
    this._moveAllEntities();    // fn0800_0F63: movement for all entities
    this._updateEnemyAI();      // fn0800_10F8: enemy AI direction
    this._checkCollisions();    // fn0800_13EE: collision detection
  }

  _handlePlayingKeys() {
    // Speed keys (ASM: speed = '9' - key)
    const d = input.getDigit();
    if (d >= 0) this.speed = 9 - d;

    // Direction input (ASM sets [0x927A])
    if (input.isDown('ArrowUp')    || input.isDown('KeyW')) this.inputDir = DIR_UP;
    else if (input.isDown('ArrowRight') || input.isDown('KeyD')) this.inputDir = DIR_RIGHT;
    else if (input.isDown('ArrowDown')  || input.isDown('KeyS')) this.inputDir = DIR_DOWN;
    else if (input.isDown('ArrowLeft')  || input.isDown('KeyA')) this.inputDir = DIR_LEFT;

    // F1/F2 sound toggle
    if (input.wasPressed('F1')) { this.soundOn = false; localStorage.setItem('packman_muted', '1'); }
    if (input.wasPressed('F2')) { this.soundOn = true; localStorage.setItem('packman_muted', '0'); }

    // ESC exits to menu
    if (input.wasPressed('Escape')) { this._setState(S_MENU); return; }
  }

  // ── DYING state ────────────────────────────────────────────────────────────

  _updateDying() {
    this.stateTimer++;
    if (this.stateTimer === 20 && this.soundOn) sound.die();
    if (this.stateTimer < 90) return;

    this.lives--;
    if (this.lives < 0) {
      if (this.score > this.hiScore) {
        this.hiScore = this.score;
        localStorage.setItem('packman_hi', this.hiScore);
      }
      if (this.soundOn) sound.gameOver();
      this._setState(S_GAME_OVER);
    } else {
      this._resetPositions();
      this._setState(S_PLAYING);
    }
  }

  // ── LEVEL_COMPLETE state (ASM: just increment levelIdx and init next) ──────
  // Original has no pause between levels — immediately starts the next one.
  // We add a brief pause (60 frames ≈ 1s) so the player sees the cleared maze.

  _updateLevelComplete() {
    this.stateTimer++;
    if (this.stateTimer < 60) return;

    this.levelIdx++;
    if (this.levelIdx >= N_LEVELS) {
      // All 15 levels beaten → "Победа !" (ASM: fn0800_0B33, then back to menu)
      this._setState(S_VICTORY);
      return;
    }
    this._initLevel();
    this._setState(S_PLAYING);
  }

  // ── VICTORY state (ASM fn0800_0B33) ──────────────────────────────────────
  // Shown only after beating ALL 15 levels. Color-cycling "Победа !" with
  // sweeping tone. Waits for any keypress, then returns to menu.

  _updateVictory() {
    this.stateTimer++;
    // Sweeping tone (ASM: frequency 600↔900, step ±3)
    if (this.soundOn && this.stateTimer % 4 === 0) {
      const freq = 1193181 / (600 + 150 * Math.sin(this.stateTimer * 0.05));
      sound.eatDot();  // approximate the sweep with short beeps
    }
    if (input.wasPressed('Space') || input.wasPressed('Enter') || input.wasPressed('Escape')) {
      if (this.score > this.hiScore) {
        this.hiScore = this.score;
        localStorage.setItem('packman_hi', this.hiScore);
      }
      this._setState(S_MENU);
    }
  }

  // ── GAME_OVER state ────────────────────────────────────────────────────────

  // ASM: game over waits for any keypress (fn0800_0ADF calls fn0800_044C)
  _updateGameOver() {
    this.stateTimer++;
    if (input.wasPressed('Space') || input.wasPressed('Enter') || input.wasPressed('Escape')) {
      this._setState(S_MENU);
    }
  }

  // ── Game initialisation (from ASM fn0800_0BDC + fn0800_111E) ───────────────

  _startGame(levelIdx) {
    this.score    = 0;
    this.lives    = STARTING_LIVES;
    this.levelIdx = levelIdx;
    this.soundOn  = localStorage.getItem('packman_muted') !== '1';
    _rngSeed      = (this.tick ^ 0xABCD) >>> 0 || 0x1234;
    this._initLevel();
    this._setState(S_PLAYING);
  }

  _initLevel() {
    // Copy level grid (from ASM: memcpy to 0xA19E)
    const src = LEVELS[this.levelIdx];
    this.maze = src.map(row => row.slice());

    // Count eatable tiles (from ASM: scan 240 tiles for value 1)
    // Original only counts T_DOT (0x01), but all non-zero non-wall tiles are eaten
    this.dotsTotal = 0;
    this.dotsEaten = 0;
    for (const row of this.maze)
      for (const t of row)
        if (t === T_DOT) this.dotsTotal++;

    this.inputDir = DIR_NONE;
    this._initPacman();
    this._initEnemies();
  }

  _resetPositions() {
    this.inputDir = DIR_NONE;
    this._initPacman();
    this._initEnemies();
  }

  // ── Pacman init (from ASM fn0800_111E, lines 1540-1563) ────────────────────

  _initPacman() {
    const pac = createEntity();
    // ASM: [0xA124] = 4, [0xA126] = 0x54 = 84
    pac.x = 4;
    pac.y = 84;
    pac.dir = DIR_RIGHT;  // ASM: [0xA12E] = 2 (right)
    pac.spriteFrames = PAC_SPRITES[DIR_RIGHT];
    pac.spriteIdx = 0;
    // Speed targets from ASM: speed * 14 + offset
    // For gameplay, we use simpler fixed values tuned for 60fps
    pac.xTarget = 1;
    pac.yTarget = 1;
    pac.xCounter = 1;
    pac.yCounter = 1;
    pac.animTarget = 4;  // animation cycle
    this.pac = pac;
  }

  // ── Enemy init (from ASM fn0800_111E, lines 1479-1531) ─────────────────────

  _initEnemies() {
    this.enemies = [];
    const n = enemyCount(this.levelIdx);

    for (let i = 0; i < n; i++) {
      const e = createEntity();
      // ASM: [si] = 0x12C = 300, [si+2] = 0x54 = 84 (off-screen right)
      e.x = 300;
      e.y = 84;
      e.dir = DIR_LEFT;  // ASM: [si+0Ah] = 4 (left, entering maze)
      // Random movement pattern (from ASM: rng() % 3)
      e.patternIdx = rng() % 3;
      e.patternPos = 0;
      e.spriteFrames = ENEMY_SPRITES;
      e.spriteIdx = 0;
      // Speed: slightly different per enemy (ASM adds random delay)
      e.xTarget = 1 + (rng() % 2) + (this._enemySlowBonus || 0);
      e.yTarget = 1 + (rng() % 2) + (this._enemySlowBonus || 0);
      e.xCounter = 1;
      e.yCounter = 1;
      e.animTarget = 8;
      this.enemies.push(e);
    }
  }

  // ── Pacman update (from ASM fn0800_12B7) ───────────────────────────────────
  // Handles: dot eating, direction change from input, wall check

  _updatePacman() {
    const pac = this.pac;

    // Only process at tile boundary (ASM: call isAtTileBoundary)
    if (!atTileBoundary(pac.x, pac.y)) return;

    // Eat tile under Pacman (ASM: check tile != 0, clear it)
    const col = Math.floor(pac.x / TILE_W);
    const row = Math.floor(pac.y / TILE_H);
    if (col >= 0 && col < COLS && row >= 0 && row < ROWS) {
      const t = this.maze[row][col];
      if (t !== T_EMPTY && WALKABLE.has(t)) {
        this.maze[row][col] = T_EMPTY;
        if (this.soundOn) sound.eatDot();

        // Increment eaten counter
        if (t === T_DOT) {
          this.dotsEaten++;
        }

        // Add score (ASM: add [0xA118], 2)
        this.score += SCORE_PER_TILE;

        // Check level complete (ASM: cmp eaten, dotTotal)
        if (this.dotsEaten >= this.dotsTotal) {
          if (this.soundOn) sound.levelComplete();
          this._setState(S_LEVEL_COMPLETE);
          return;
        }

        // Extra life milestones (ASM: cmp score, 600/1200/2000/2600)
        for (const milestone of EXTRA_LIFE_SCORES) {
          if (this.score === milestone) {
            this.lives++;
            if (this.soundOn) sound.eatPower();
            break;
          }
        }

        // Update hi-score
        if (this.score > this.hiScore) {
          this.hiScore = this.score;
          localStorage.setItem('packman_hi', this.hiScore);
        }
      }
    }

    // Direction change from keyboard (ASM: cmp [si+0Ah], [0x927A])
    // Turn buffering: only apply the turn if the new direction is walkable.
    // If not walkable, keep going in current direction and retry next tile boundary.
    if (this.inputDir !== DIR_NONE && this.inputDir !== pac.dir) {
      const turnAhead = tileAhead(this.maze, pac.x, pac.y, this.inputDir);
      if (turnAhead < 0 || WALKABLE.has(turnAhead)) {
        // Turn direction is walkable (or tunnel) — apply it
        pac.dir = this.inputDir;

        // Update sprite frames for new direction
        if (PAC_SPRITES[pac.dir]) {
          pac.spriteFrames = PAC_SPRITES[pac.dir];
          pac.spriteIdx = 0;
        }
      }
      // else: wall in turn direction — keep pac.dir, keep inputDir buffered for retry
    }

    // Check if next tile in CURRENT direction is walkable (ASM: call fn0800_1076)
    if (pac.dir !== DIR_NONE) {
      const ahead = tileAhead(this.maze, pac.x, pac.y, pac.dir);
      if (ahead >= 0 && !WALKABLE.has(ahead)) {
        pac.dir = DIR_NONE;      // stop (ASM: mov [si+0Ah], 0)
        // Don't clear inputDir — keep buffered turn for when Pacman reaches
        // a tile boundary where the desired direction IS walkable
      }
    }
  }

  // ── Move all entities (from ASM fn0800_0F63) ───────────────────────────────
  // Loops through all entities and moves them based on direction

  _moveAllEntities() {
    this._moveEntity(this.pac);
    for (const e of this.enemies) {
      if (e.alive) this._moveEntity(e);
    }
  }

  // Single entity movement (from ASM fn0800_0E86)
  _moveEntity(e) {
    // Animate sprite (ASM: increment counter, cycle frames)
    e.animCounter++;
    if (e.animCounter >= e.animTarget) {
      e.animCounter = 1;
      e.spriteIdx = (e.spriteIdx + 1) % e.spriteFrames.length;
    }

    // Move based on direction (ASM movement function)
    if (e.dir === DIR_NONE) return;

    const isHoriz = (e.dir === DIR_RIGHT || e.dir === DIR_LEFT);
    if (isHoriz) {
      e.xCounter++;
      if (e.xCounter < e.xTarget) return;
      e.xCounter = 1;
      const dx = (e.dir === DIR_RIGHT) ? STEP_X : -STEP_X;
      e.x += dx;
    } else {
      e.yCounter++;
      if (e.yCounter < e.yTarget) return;
      e.yCounter = 1;
      const dy = (e.dir === DIR_DOWN) ? STEP_Y : -STEP_Y;
      e.y += dy;
    }

    // Tunnel wrap
    if (e.x < -TILE_W) e.x = COLS * TILE_W;
    else if (e.x > COLS * TILE_W) e.x = -TILE_W;
  }

  // ── Enemy AI (from ASM fn0800_10F8 / fn0800_1096) ─────────────────────────
  // At tile boundary: try to chase Pacman, otherwise follow pattern

  _updateEnemyAI() {
    for (const e of this.enemies) {
      if (!e.alive) continue;
      if (!atTileBoundary(e.x, e.y)) continue;

      // Check if next tile in current direction is walkable
      const pac = this.pac;
      const ecol = Math.floor(e.x / TILE_W);
      const erow = Math.floor(e.y / TILE_H);

      // Try chase direction (from ASM fn0800_0DD9: setCollisionDirection)
      const chase = chaseDirection(e, pac);
      if (chase !== DIR_NONE) {
        e.dir = chase;
      }

      // Check walkability (from ASM fn0800_1076)
      if (e.dir !== DIR_NONE) {
        const ahead = tileAhead(this.maze, e.x, e.y, e.dir);
        if (ahead >= 0 && !WALKABLE.has(ahead)) {
          // Wall ahead — read next direction from pattern
          e.dir = DIR_NONE;
        }
      }

      // If stopped or chase failed, use pattern (ASM: read from movement pattern)
      if (e.dir === DIR_NONE) {
        const pattern = ENEMY_PATTERNS[e.patternIdx];
        e.dir = pattern[e.patternPos];
        e.patternPos = (e.patternPos + 1) % pattern.length;

        // Check if pattern direction is walkable
        const ahead = tileAhead(this.maze, e.x, e.y, e.dir);
        if (ahead >= 0 && !WALKABLE.has(ahead)) {
          // Try all 4 directions to find a walkable one
          for (let tryDir = 1; tryDir <= 4; tryDir++) {
            const ta = tileAhead(this.maze, e.x, e.y, tryDir);
            if (ta < 0 || WALKABLE.has(ta)) {
              e.dir = tryDir;
              break;
            }
          }
        }
      }

      // If enemy is off-screen (entering), force direction toward maze
      if (e.x >= COLS * TILE_W - TILE_W) {
        e.dir = DIR_LEFT;
      } else if (e.x <= 0) {
        // If at left edge, pick a valid direction
        if (e.dir === DIR_LEFT) {
          const ahead = tileAhead(this.maze, e.x, e.y, DIR_LEFT);
          if (ahead >= 0 && !WALKABLE.has(ahead)) {
            e.dir = DIR_DOWN;
          }
        }
      }
    }
  }

  // ── Collision detection (from ASM fn0800_13EE) ─────────────────────────────
  // Simple overlap check — collision always kills Pacman (no fright mode!)

  _checkCollisions() {
    const pac = this.pac;
    for (const e of this.enemies) {
      if (!e.alive) continue;
      // ASM: isXOverlap && isYOverlap (both < tile dimensions)
      if (xOverlap(e, pac) && yOverlap(e, pac)) {
        // Pacman dies (ASM: dec [0xA11E], mov [0xA380], 2)
        this._setState(S_DYING);
        return;
      }
    }
  }

  // ── Save / Load ────────────────────────────────────────────────────────────

  _save() {
    const data = { level: this.levelIdx, score: this.score, lives: this.lives };
    localStorage.setItem('packman', JSON.stringify(data));
  }

  _load() {
    try {
      const raw = localStorage.getItem('packman');
      if (!raw) return;
      const { level, score, lives } = JSON.parse(raw);
      this.score    = score || 0;
      this.lives    = lives || STARTING_LIVES;
      this.levelIdx = (level || 0) % N_LEVELS;
      this._initLevel();
      this._setState(S_PLAYING);
    } catch (_) {}
  }

  // ── Rendering ──────────────────────────────────────────────────────────────

  _render() {
    const r = this.renderer;
    r.clear();

    switch (this.state) {
      case S_MENU:           this._renderMenu();          break;
      case S_PLAYING:        this._renderGame();          break;
      case S_DYING:          this._renderGame(true);      break;
      case S_LEVEL_COMPLETE: this._renderGame();          break;
      case S_VICTORY:        this._renderVictory();       break;
      case S_GAME_OVER:      this._renderGameOver();      break;
    }
  }

  _renderMaze() {
    const maze = this.maze;
    for (let row = 0; row < ROWS; row++) {
      for (let col = 0; col < COLS; col++) {
        const t = maze[row][col];
        if (t !== T_EMPTY) {
          this.renderer.drawTile(t, col * TILE_W, row * TILE_H);
        }
      }
    }
  }

  _renderEntity(e) {
    if (!e.alive) return;
    if (e.x < -TILE_W || e.x > COLS * TILE_W) return;  // off-screen
    const spriteId = e.spriteFrames[e.spriteIdx % e.spriteFrames.length];
    this.renderer.drawSprite(spriteId, e.x, e.y);
  }

  // HUD bottom bar at Y=188 (from ASM fn0800_0C6D)
  // Layout: "Очки:" x=0, score x=45, "Рекорд:" x=130, hi x=186, "Жизнь:" x=250, lives x=310
  _renderHUD() {
    const r = this.renderer;
    const pal = CGA_PALETTES[r.palIdx];
    const c3 = `rgb(${pal[3].join(',')})`;
    const c2 = `rgb(${pal[2].join(',')})`;
    const c1 = `rgb(${pal[1].join(',')})`;

    // Clear bottom bar area (Y=188 to 200)
    r.fillRect(0, 188, 320, 12, '#000');

    // "Очки:" label + score number
    r.drawText(0,  189, '\u041E\u0447\u043A\u0438:', c3, 8);   // Очки:
    r.drawText(45, 189, String(this.score), c3, 8);

    // "Рекорд:" label + hi-score number
    r.drawText(130, 189, '\u0420\u0435\u043A\u043E\u0440\u0434:', c2, 8); // Рекорд:
    r.drawText(186, 189, String(this.hiScore), c2, 8);

    // "Жизнь:" label + lives number
    r.drawText(230, 189, '\u0416\u0438\u0437\u043D\u044C:', c3, 8); // Жизнь:
    r.drawText(280, 189, String(this.lives), c2, 8);

    // Level / total
    r.drawText(295, 189, `${this.levelIdx + 1}/${N_LEVELS}`, c1, 8);
  }

  _renderGame(dying = false) {
    this._renderMaze();

    // Draw enemies first, then Pacman on top
    for (const e of this.enemies) {
      this._renderEntity(e);
    }

    if (!dying || (this.stateTimer % 8 < 4)) {
      this._renderEntity(this.pac);
    }

    this._renderHUD();
  }

  // Menu screen (from ASM fn0800_06F3)
  // Title at Y=0 font=4(Gothic), subtitle at Y=40, 11 items at Y=70+i*10
  _renderMenu() {
    const r = this.renderer;
    const pal = CGA_PALETTES[r.palIdx];
    const c3 = `rgb(${pal[3].join(',')})`;
    const c2 = `rgb(${pal[2].join(',')})`;
    const c1 = `rgb(${pal[1].join(',')})`;

    // Title "ПакМен" — Y=0, color=3, font=4(Gothic), large blocky text
    r.drawTextCenter(160, 0, '\u041F\u0430\u043A\u041C\u0435\u043D', c3, 38, 'serif');

    // Subtitle "Free Masters (R)" — Y=48, color=2, italic serif
    r.drawTextCenter(160, 48, 'Free Masters (R)', c2, 12, 'serif');

    // 11 menu text lines — Y=70+i*13, color=3, proportional serif font
    // Original BGI Triplex font fills full 320px width with ~38 chars
    const F = 'serif';
    const SZ = 12;
    const LH = 12;  // line height matching original 10px at this scale
    const items = [
      '\u0412\u044B \u0438\u043C\u0435\u0435\u0442\u0435 \u0432\u043E\u0437\u043C\u043E\u0436\u043D\u043E\u0441\u0442\u044C \u043F\u043E\u0441\u0435\u0442\u0438\u0442\u044C \u043C\u0438\u0440',       // Вы имеете возможность посетить мир
      '\u043F\u0440\u0438\u043A\u043B\u044E\u0447\u0435\u043D\u0438\u0439 \u043D\u0435\u043D\u0430\u0441\u044B\u0442\u043D\u043E\u0439 \u043C\u043E\u0440\u0434\u0430\u0448\u043A\u0438 \u041F\u0430\u043A\u041C\u0435\u043D',   // приключений ненасытной мордашки ПакМен
      '\u0418\u043C\u0435\u044F 5 \u043F\u043E\u043F\u044B\u0442\u043E\u043A \u0435\u0433\u043E \u043D\u0443\u0436\u043D\u043E \u043F\u0440\u043E\u0432\u0435\u0441\u0442\u0438 \u0447\u0435-',         // Имея 5 попыток его нужно провести че-
      '\u0440\u0435\u0437 15 \u043A\u043E\u043C\u043D\u0430\u0442.  \u041F\u0435\u0440\u0435\u0445\u043E\u0434  \u043A  \u0441\u043B\u0435\u0434\u0443\u044E\u0449\u0435\u0439',   // рез 15 комнат.  Переход  к  следующей
      '\u043F\u0440\u043E\u0438\u0441\u0445\u043E\u0434\u0438\u0442,  \u043A\u043E\u0433\u0434\u0430  \u041F\u0430\u043A\u041C\u0435\u043D  \u0441\u044A\u0435\u0441\u0442  \u0432\u0441\u0435', // происходит,  когда  ПакМен  съест  все
      '\u044F\u0431\u043B\u043E\u0447\u043A\u0438. \u041E\u043F\u0430\u0441\u0430\u0439\u0442\u0435\u0441\u044C \u043A\u0440\u043E\u0432\u0430\u0432\u044B\u0445 \u0436\u0443\u043A\u043E\u0432 !',     // яблочки. Опасайтесь кровавых жуков !
      '\u0423\u043F\u0440\u0430\u0432\u043B\u0435\u043D\u0438\u0435 :',                              // Управление :
      '   K/D    \u2013 \u043A\u043B\u0430\u0432\u0438\u0430\u0442\u0443\u0440\u0430/\u0434\u0436\u043E\u0439\u0441\u0442\u0438\u043A',            // K/D    – клавиатура/джойстик
      '   F1/F2  \u2013 \u0432\u043A\u043B\u044E\u0447\u0438\u0442\u044C/\u0432\u044B\u043A\u043B\u044E\u0447\u0438\u0442\u044C \u0437\u0432\u0443\u043A',    // F1/F2  – включить/выключить звук
      '   \u0421\u0422\u0420\u0415\u041B\u041A\u0418\u2013 \u043F\u0435\u0440\u0435\u043C\u0435\u0449\u0435\u043D\u0438\u0435 \u041F\u0430\u043A\u041C\u0435\u043D\u0430',        // СТРЕЛКИ– перемещение ПакМена
      '   \u0412\u042B\u0425    \u2013 \u0432\u044B\u0445\u043E\u0434  = Kiev\'90 FM (R) =',          // ВЫХ    – выход  = Kiev'90 FM (R) =
    ];
    for (let i = 0; i < items.length; i++) {
      r.drawTextCenter(160, 68 + i * LH, items[i], c3, SZ, F);
    }

    // Bottom bar (Y=188): "Клавиатура" in red, "Скорость 0-9 : [N]" in green
    r.fillRect(0, 188, 320, 12, '#000');
    r.drawText(2,  189, '\u041A\u043B\u0430\u0432\u0438\u0430\u0442\u0443\u0440\u0430', c2, 10, 'serif');   // Клавиатура
    r.drawText(120, 189, '\u0421\u043A\u043E\u0440\u043E\u0441\u0442\u044C 0-9 : [' + (9 - this.speed) + ']', c1, 10, 'serif');
  }

  // Victory screen (from ASM fn0800_0B33) — only after beating all 15 levels
  // Clear screen, "Победа !" at Y=60, font=4, color cycles through LEVEL_COMPLETE_COLORS
  _renderVictory() {
    const r = this.renderer;
    const pal = CGA_PALETTES[r.palIdx];
    const colorIdx = LEVEL_COMPLETE_COLORS[Math.floor(this.stateTimer / 12) % LEVEL_COMPLETE_COLORS.length];
    const cc = `rgb(${pal[colorIdx].join(',')})`;
    r.drawTextCenter(160, 60, '\u041F\u043E\u0431\u0435\u0434\u0430 !', cc, 38, 'serif');  // Победа !
  }

  // Game over screen (from ASM fn0800_0ADF)
  // "Проиграли" at Y=80, color=3, font=4; "Нажмите пробел" at Y=120, color=1, font=1
  _renderGameOver() {
    const r = this.renderer;
    const pal = CGA_PALETTES[r.palIdx];
    const c3 = `rgb(${pal[3].join(',')})`;
    const c1 = `rgb(${pal[1].join(',')})`;

    r.drawTextCenter(160, 70, '\u041F\u0440\u043E\u0438\u0433\u0440\u0430\u043B\u0438', c3, 38, 'serif');  // Проиграли
    r.drawTextCenter(160, 120, '\u041D\u0430\u0436\u043C\u0438\u0442\u0435 \u043F\u0440\u043E\u0431\u0435\u043B', c1, 12, 'serif'); // Нажмите пробел
  }
}
