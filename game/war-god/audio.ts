export type GameSound = 'click' | 'match' | 'ultimate' | 'win' | 'lose';

type AudioContextConstructor = new () => AudioContext;

let enabled = true;
let context: AudioContext | null = null;

function audioContextConstructor(): AudioContextConstructor | null {
  const audioWindow = window as typeof window & {
    webkitAudioContext?: AudioContextConstructor;
  };
  return audioWindow.AudioContext ?? audioWindow.webkitAudioContext ?? null;
}

function getContext(): AudioContext | null {
  if (context) return context;
  const Context = audioContextConstructor();
  if (!Context) return null;
  context = new Context();
  return context;
}

function tone(
  ctx: AudioContext,
  start: number,
  frequency: number,
  duration: number,
  volume: number,
  type: OscillatorType = 'sine',
): void {
  const oscillator = ctx.createOscillator();
  const gain = ctx.createGain();
  oscillator.type = type;
  oscillator.frequency.setValueAtTime(frequency, start);
  gain.gain.setValueAtTime(0.0001, start);
  gain.gain.exponentialRampToValueAtTime(volume, start + 0.008);
  gain.gain.exponentialRampToValueAtTime(0.0001, start + duration);
  oscillator.connect(gain);
  gain.connect(ctx.destination);
  oscillator.start(start);
  oscillator.stop(start + duration + 0.02);
}

export function setSoundEnabled(next: boolean): void {
  enabled = next;
}

export function playSound(sound: GameSound): void {
  if (!enabled) return;
  const ctx = getContext();
  if (!ctx) return;
  if (ctx.state === 'suspended') void ctx.resume().catch(() => {});
  const now = ctx.currentTime + 0.01;

  if (sound === 'click') {
    tone(ctx, now, 520, 0.055, 0.025, 'triangle');
    return;
  }
  if (sound === 'match') {
    tone(ctx, now, 440, 0.09, 0.035, 'triangle');
    tone(ctx, now + 0.065, 660, 0.12, 0.03, 'triangle');
    return;
  }
  if (sound === 'ultimate') {
    tone(ctx, now, 180, 0.2, 0.05, 'sawtooth');
    tone(ctx, now + 0.09, 360, 0.28, 0.045, 'square');
    return;
  }
  const notes = sound === 'win' ? [523, 659, 784] : [392, 330, 262];
  notes.forEach((frequency, index) => {
    tone(ctx, now + index * 0.11, frequency, 0.2, 0.04, 'triangle');
  });
}
