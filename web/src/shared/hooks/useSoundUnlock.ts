import { useEffect } from 'react';
import { unlockSounds } from '@lib';

const UNLOCK_EVENTS = ['pointerdown', 'keydown', 'touchend'] as const;

export function useSoundUnlock() {
  useEffect(() => {
    const handler = () => {
      unlockSounds();
      UNLOCK_EVENTS.forEach((event) => window.removeEventListener(event, handler));
    };
    UNLOCK_EVENTS.forEach((event) => window.addEventListener(event, handler, { passive: true }));
    return () => UNLOCK_EVENTS.forEach((event) => window.removeEventListener(event, handler));
  }, []);
}
