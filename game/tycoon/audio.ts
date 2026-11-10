export type TycoonSound =
  | 'click'
  | 'shake'
  | 'roll'
  | 'double'
  | 'hop'
  | 'land'
  | 'coin'
  | 'stamp'
  | 'pop'
  | 'card'
  | 'whistle'
  | 'bars'
  | 'crack'
  | 'fanfare'
  | 'turn'
  | 'win'
  | 'lose'
  | 'tick';

const COIN_GAP_MS = 150;

let ctx: AudioContext | null = null;
let enabled = true;
let lastCoinAt = 0;

type AudioContextCtor = typeof AudioContext;

function context(): AudioContext | null {
  if (ctx) return ctx;
  const Ctor: AudioContextCtor | undefined =
    window.AudioContext ?? (window as Window & { webkitAudioContext?: AudioContextCtor }).webkitAudioContext;
  if (!Ctor) return null;
  ctx = new Ctor();
  return ctx;
}

function tone(audio: AudioContext, delayMs: number, freq: number, durationMs: number, volume = 0.05, type: OscillatorType = 'triangle'): void {
  const osc = audio.createOscillator();
  const gain = audio.createGain();
  const start = audio.currentTime + delayMs / 1000;
  const end = start + durationMs / 1000;
  osc.type = type;
  osc.frequency.value = freq;
  gain.gain.setValueAtTime(0.0001, start);
  gain.gain.exponentialRampToValueAtTime(volume, start + 0.008);
  gain.gain.exponentialRampToValueAtTime(0.0001, end);
  osc.connect(gain).connect(audio.destination);
  osc.start(start);
  osc.stop(end + 0.02);
}

function noise(audio: AudioContext, delayMs: number, durationMs: number, volume = 0.05): void {
  const length = Math.floor((audio.sampleRate * durationMs) / 1000);
  const buffer = audio.createBuffer(1, length, audio.sampleRate);
  const data = buffer.getChannelData(0);
  for (let i = 0; i < length; i++) data[i] = (Math.random() * 2 - 1) * (1 - i / length);
  const source = audio.createBufferSource();
  const gain = audio.createGain();
  gain.gain.value = volume;
  source.buffer = buffer;
  source.connect(gain).connect(audio.destination);
  source.start(audio.currentTime + delayMs / 1000);
}

export function setSoundEnabled(on: boolean): void {
  enabled = on;
}

export function playSound(sound: TycoonSound): void {
  if (!enabled) return;
  const audio = context();
  if (!audio) return;
  if (audio.state === 'suspended') void audio.resume();
  switch (sound) {
    case 'click':
      tone(audio, 0, 760, 30, 0.02);
      break;
    case 'shake':
      [0, 80, 160].forEach((delay) => noise(audio, delay, 50));
      break;
    case 'roll':
      [0, 90, 200, 340, 520].forEach((delay, i) => noise(audio, delay, 40, 0.07 - i * 0.01));
      break;
    case 'double':
      tone(audio, 0, 880, 90, 0.06);
      tone(audio, 90, 1175, 150, 0.06);
      break;
    case 'hop':
      tone(audio, 0, 500 + Math.random() * 60, 45, 0.018);
      break;
    case 'land':
      tone(audio, 0, 330, 110);
      break;
    case 'coin': {
      const now = performance.now();
      if (now - lastCoinAt < COIN_GAP_MS) return;
      lastCoinAt = now;
      tone(audio, 0, 1800 * (0.95 + Math.random() * 0.1), 60, 0.03, 'sine');
      tone(audio, 40, 2400, 80, 0.02, 'sine');
      break;
    }
    case 'stamp':
      tone(audio, 0, 120, 100, 0.09, 'square');
      noise(audio, 0, 40);
      break;
    case 'pop':
      tone(audio, 0, 620, 70, 0.04);
      break;
    case 'card':
      noise(audio, 0, 90, 0.04);
      tone(audio, 50, 700, 100, 0.03);
      break;
    case 'whistle':
      tone(audio, 0, 1500, 130, 0.04, 'square');
      tone(audio, 150, 1900, 180, 0.04, 'square');
      break;
    case 'bars':
      tone(audio, 0, 220, 180, 0.06, 'sawtooth');
      tone(audio, 20, 330, 160, 0.04, 'square');
      break;
    case 'crack':
      noise(audio, 0, 160, 0.09);
      tone(audio, 0, 90, 260, 0.08, 'sawtooth');
      break;
    case 'fanfare':
      [523, 659, 784, 1047].forEach((freq, i) => tone(audio, i * 110, freq, 200, 0.06));
      break;
    case 'turn':
      tone(audio, 0, 660, 90);
      tone(audio, 90, 880, 140);
      break;
    case 'win':
      [523, 659, 784].forEach((freq, i) => tone(audio, i * 130, freq, 200, 0.08));
      break;
    case 'lose':
      [392, 330, 262].forEach((freq, i) => tone(audio, i * 150, freq, 220, 0.08));
      break;
    case 'tick':
      tone(audio, 0, 1200, 30, 0.03, 'square');
      break;
  }
}
