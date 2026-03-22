// src/input.js — keyboard + touch state tracker
'use strict';

const input = (() => {
  const held = new Set();        // keys currently held down
  const justDown = new Set();    // keys pressed this frame (cleared by consumer)

  // ── Keyboard ──────────────────────────────────────────────────────────────
  document.addEventListener('keydown', e => {
    if (!held.has(e.code)) justDown.add(e.code);
    held.add(e.code);
    if (['ArrowUp','ArrowDown','ArrowLeft','ArrowRight','Space'].includes(e.code)) {
      e.preventDefault();
    }
  });

  document.addEventListener('keyup', e => {
    held.delete(e.code);
  });

  // ── Touch ─────────────────────────────────────────────────────────────────
  let _touchStartX = 0, _touchStartY = 0;
  const SWIPE_MIN = 20;  // px minimum to count as a swipe

  document.addEventListener('touchstart', e => {
    _touchStartX = e.changedTouches[0].clientX;
    _touchStartY = e.changedTouches[0].clientY;
  }, { passive: true });

  document.addEventListener('touchend', e => {
    const dx = e.changedTouches[0].clientX - _touchStartX;
    const dy = e.changedTouches[0].clientY - _touchStartY;
    const adx = Math.abs(dx), ady = Math.abs(dy);

    if (adx < SWIPE_MIN && ady < SWIPE_MIN) {
      // Tap → Space (start game / advance screen)
      justDown.add('Space');
    } else if (adx > ady) {
      justDown.add(dx > 0 ? 'ArrowRight' : 'ArrowLeft');
      held.add(dx > 0 ? 'ArrowRight' : 'ArrowLeft');
      setTimeout(() => {
        held.delete('ArrowRight'); held.delete('ArrowLeft');
      }, 150);
    } else {
      justDown.add(dy > 0 ? 'ArrowDown' : 'ArrowUp');
      held.add(dy > 0 ? 'ArrowDown' : 'ArrowUp');
      setTimeout(() => {
        held.delete('ArrowDown'); held.delete('ArrowUp');
      }, 150);
    }
  }, { passive: true });

  // ── D-pad injection (called from HTML buttons) ─────────────────────────────
  function dpad(code) {
    justDown.add(code);
    held.add(code);
    setTimeout(() => held.delete(code), 200);
  }

  return {
    isDown(code) { return held.has(code); },

    wasPressed(code) {
      if (justDown.has(code)) { justDown.delete(code); return true; }
      return false;
    },

    getDir() {
      if (held.has('ArrowUp')    || held.has('KeyW')) return { dx: 0, dy: -1 };
      if (held.has('ArrowDown')  || held.has('KeyS')) return { dx: 0, dy:  1 };
      if (held.has('ArrowLeft')  || held.has('KeyA')) return { dx: -1, dy: 0 };
      if (held.has('ArrowRight') || held.has('KeyD')) return { dx:  1, dy: 0 };
      return null;
    },

    getDigit() {
      for (let i = 0; i <= 9; i++) {
        if (held.has('Digit' + i)) return i;
      }
      return -1;
    },

    // Called by D-pad buttons
    dpadUp()    { dpad('ArrowUp');    },
    dpadDown()  { dpad('ArrowDown');  },
    dpadLeft()  { dpad('ArrowLeft');  },
    dpadRight() { dpad('ArrowRight'); },
    dpadFire()  { justDown.add('Space'); },

    clearAll() { justDown.clear(); },
  };
})();
