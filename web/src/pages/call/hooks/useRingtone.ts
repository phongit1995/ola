import { useEffect } from 'react';
import { useSettingsStore } from '@/store/settingsStore';

const RING_INTERVAL_MS = 1500;
const BEEP_GAP_SECONDS = 0.45;
const BEEP_LENGTH_SECONDS = 0.35;

function scheduleBeep(context: AudioContext, at: number) {
  const oscillator = context.createOscillator();
  const gain = context.createGain();
  oscillator.type = 'sine';
  oscillator.frequency.value = 440;
  gain.gain.setValueAtTime(0.0001, at);
  gain.gain.exponentialRampToValueAtTime(0.16, at + 0.02);
  gain.gain.exponentialRampToValueAtTime(0.0001, at + 0.3);
  oscillator.connect(gain).connect(context.destination);
  oscillator.start(at);
  oscillator.stop(at + BEEP_LENGTH_SECONDS);
}

export function useRingtone(enabled: boolean) {
  useEffect(() => {
    if (!enabled) return;
    if (!useSettingsStore.getState().settings.notifSound) return;

    let context: AudioContext | null = null;
    let timer: ReturnType<typeof setInterval> | null = null;
    let disposed = false;

    const ring = (target: AudioContext) => {
      const now = target.currentTime;
      scheduleBeep(target, now);
      scheduleBeep(target, now + BEEP_GAP_SECONDS);
    };

    const start = async () => {
      try {
        const created = new AudioContext();
        await created.resume();
        if (disposed) {
          void created.close();
          return;
        }
        context = created;
        ring(created);
        timer = setInterval(() => ring(created), RING_INTERVAL_MS);
      } catch {
        return;
      }
    };

    void start();

    return () => {
      disposed = true;
      if (timer != null) clearInterval(timer);
      if (context != null) void context.close();
    };
  }, [enabled]);
}
