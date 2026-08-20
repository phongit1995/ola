export type XiangqiSound = 'click' | 'place' | 'capture' | 'check' | 'win' | 'lose';

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

export function playSound(sound: XiangqiSound): void {
  if (!enabled) return;
  const audio = context();
  if (!audio) return;
  if (audio.state === 'suspended') void audio.resume();
  const now = audio.currentTime;
  switch (sound) {
    case 'click':
      tone(audio, now, 660, 0.05, 0.12, 'square');
      break;
    case 'place':
      tone(audio, now, 190, 0.07, 0.3, 'sine');
      tone(audio, now + 0.01, 120, 0.09, 0.2, 'sine');
      break;
    case 'capture':
      tone(audio, now, 220, 0.06, 0.3, 'square');
      tone(audio, now + 0.07, 150, 0.1, 0.25, 'square');
      break;
    case 'check':
      tone(audio, now, 660, 0.09, 0.2, 'sawtooth');
      tone(audio, now + 0.1, 880, 0.14, 0.2, 'sawtooth');
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
  }
}
