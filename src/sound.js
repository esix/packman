// src/sound.js — PC speaker emulation via Web Audio API
// Square wave oscillator, matching the original's PIT-driven speaker output.
// PC speaker frequency formula: freq = 1193181 / pit_divisor
'use strict';

const sound = (() => {
  let ctx = null;
  let muted = false;

  function getCtx() {
    if (!ctx) {
      ctx = new (window.AudioContext || window.webkitAudioContext)();
    }
    // Resume if suspended (browser autoplay policy)
    if (ctx.state === 'suspended') ctx.resume();
    return ctx;
  }

  function beep(freq, duration, vol = 0.25) {
    if (muted) return;
    const ac = getCtx();
    const osc  = ac.createOscillator();
    const gain = ac.createGain();
    osc.connect(gain);
    gain.connect(ac.destination);
    osc.type = 'square';
    osc.frequency.value = freq;
    gain.gain.setValueAtTime(vol, ac.currentTime);
    gain.gain.exponentialRampToValueAtTime(0.001, ac.currentTime + duration);
    osc.start(ac.currentTime);
    osc.stop(ac.currentTime + duration + 0.01);
  }

  // Sequence of (freq, duration) pairs played one after another
  function sequence(notes, vol = 0.25) {
    if (muted) return;
    const ac = getCtx();
    let t = ac.currentTime;
    for (const [freq, dur] of notes) {
      const osc  = ac.createOscillator();
      const gain = ac.createGain();
      osc.connect(gain);
      gain.connect(ac.destination);
      osc.type = 'square';
      osc.frequency.value = freq;
      gain.gain.setValueAtTime(vol, t);
      gain.gain.exponentialRampToValueAtTime(0.001, t + dur);
      osc.start(t);
      osc.stop(t + dur + 0.01);
      t += dur;
    }
  }

  return {
    setMuted(m) { muted = !!m; },

    // Dot eaten: short high click (mapped from PIT divisor ~1000 → ~1193 Hz)
    eatDot() { beep(600, 0.04, 0.15); },

    // Power pellet: lower warble
    eatPower() {
      sequence([[400, 0.08], [300, 0.08], [400, 0.08]], 0.25);
    },

    // Ghost eaten: ascending chord
    eatGhost(combo = 0) {
      const freqs = [400, 600, 800, 1000];
      const f = freqs[Math.min(combo, 3)];
      sequence([[f, 0.06], [f * 1.5, 0.06]], 0.3);
    },

    // Pacman death: descending wail
    die() {
      if (muted) return;
      const ac = getCtx();
      const osc  = ac.createOscillator();
      const gain = ac.createGain();
      osc.connect(gain);
      gain.connect(ac.destination);
      osc.type = 'square';
      osc.frequency.setValueAtTime(700, ac.currentTime);
      osc.frequency.linearRampToValueAtTime(80, ac.currentTime + 1.0);
      gain.gain.setValueAtTime(0.3, ac.currentTime);
      gain.gain.linearRampToValueAtTime(0, ac.currentTime + 1.0);
      osc.start(ac.currentTime);
      osc.stop(ac.currentTime + 1.05);
    },

    // Level complete: ascending fanfare
    levelComplete() {
      sequence([
        [523, 0.09], [659, 0.09], [784, 0.09], [1047, 0.18],
      ], 0.3);
    },

    // Game over: descending phrase
    gameOver() {
      sequence([
        [392, 0.15], [330, 0.15], [262, 0.30],
      ], 0.3);
    },
  };
})();
