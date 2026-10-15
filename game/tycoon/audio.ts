export type TycoonSound =
  | 'click'
  | 'dice'
  | 'step'
  | 'cash-in'
  | 'cash-out'
  | 'card'
  | 'build'
  | 'jail'
  | 'bankrupt'
  | 'win'
  | 'lose'
  | 'tick';

let ctx: AudioContext | null = null;
let enabled = true;

type AudioContextCtor = typeof AudioContext;

function context(): AudioContext | null {
  if (ctx) return ctx;
  const Ctor: AudioContextCtor | undefined =
    window.AudioContext ?? (window as Window & { webkitAudioContext?: AudioContextCtor }).webkitAudioContext;
  if (!Ctor) return null;
  ctx = new Ctor();
  return ctx;
}

function tone(audio: AudioContext, start: number, freq: number, duration: number, volume: number, type: OscillatorType): void {
  const osc = audio.createOscillator();
  const gain = audio.createGain();
  osc.type = type;
  osc.frequency.value = freq;
  gain.gain.setValueAtTime(volume, start);
  gain.gain.exponentialRampToValueAtTime(0.001, start + duration);
  osc.connect(gain);
  gain.connect(audio.destination);
  osc.start(start);
  osc.stop(start + duration);
}

export function setSoundEnabled(on: boolean): void {
  enabled = on;
}

export function playSound(sound: TycoonSound): void {
  if (!enabled) return;
  const audio = context();
  if (!audio) return;
  if (audio.state === 'suspended') void audio.resume();
  const now = audio.currentTime;
  switch (sound) {
    case 'click':
      tone(audio, now, 660, 0.05, 0.12, 'square');
      break;
    case 'dice':
      tone(audio, now, 240, 0.05, 0.2, 'square');
      tone(audio, now + 0.07, 300, 0.05, 0.2, 'square');
      tone(audio, now + 0.14, 200, 0.08, 0.25, 'square');
      break;
    case 'step':
      tone(audio, now, 150, 0.04, 0.16, 'sine');
      break;
    case 'cash-in':
      tone(audio, now, 880, 0.08, 0.16, 'triangle');
      tone(audio, now + 0.09, 1320, 0.12, 0.16, 'triangle');
      break;
    case 'cash-out':
      tone(audio, now, 520, 0.08, 0.16, 'triangle');
      tone(audio, now + 0.09, 340, 0.14, 0.16, 'triangle');
      break;
    case 'card':
      tone(audio, now, 720, 0.05, 0.1, 'sawtooth');
      tone(audio, now + 0.05, 960, 0.08, 0.1, 'sawtooth');
      break;
    case 'build':
      tone(audio, now, 180, 0.06, 0.28, 'square');
      tone(audio, now + 0.08, 180, 0.06, 0.2, 'square');
      break;
    case 'jail':
      tone(audio, now, 220, 0.14, 0.22, 'sawtooth');
      tone(audio, now + 0.16, 160, 0.2, 0.22, 'sawtooth');
      break;
    case 'bankrupt':
      tone(audio, now, 440, 0.12, 0.2, 'triangle');
      tone(audio, now + 0.13, 370, 0.12, 0.2, 'triangle');
      tone(audio, now + 0.26, 294, 0.12, 0.2, 'triangle');
      tone(audio, now + 0.39, 220, 0.22, 0.2, 'triangle');
      break;
    case 'win':
      tone(audio, now, 523, 0.12, 0.2, 'triangle');
      tone(audio, now + 0.13, 659, 0.12, 0.2, 'triangle');
      tone(audio, now + 0.26, 784, 0.2, 0.2, 'triangle');
      break;
    case 'lose':
      tone(audio, now, 392, 0.14, 0.2, 'triangle');
      tone(audio, now + 0.15, 330, 0.14, 0.2, 'triangle');
      tone(audio, now + 0.3, 262, 0.22, 0.2, 'triangle');
      break;
    case 'tick':
      tone(audio, now, 1200, 0.03, 0.08, 'square');
      break;
  }
}
