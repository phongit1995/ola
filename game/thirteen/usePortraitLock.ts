import { useEffect, useState } from 'react';
import { isPhoneScreen, portraitLockRotation, type PortraitLockRotation } from './helpers/portraitLock';

function readRotation(): PortraitLockRotation {
  const legacy = (window as Window & { orientation?: number }).orientation;
  const angle = window.screen.orientation?.angle ?? legacy;
  const phone = isPhoneScreen(window.matchMedia('(pointer: coarse)').matches, window.screen.width, window.screen.height);
  return portraitLockRotation(angle, phone);
}

export function usePortraitLock(): PortraitLockRotation {
  const [rotation, setRotation] = useState(readRotation);
  useEffect(() => {
    const update = (): void => setRotation(readRotation());
    window.screen.orientation?.addEventListener('change', update);
    window.addEventListener('orientationchange', update);
    window.addEventListener('resize', update);
    return () => {
      window.screen.orientation?.removeEventListener('change', update);
      window.removeEventListener('orientationchange', update);
      window.removeEventListener('resize', update);
    };
  }, []);
  return rotation;
}
