import { useCallback } from 'react';
import { dailyCheckinTaskTarget } from '@lib';
import { useMomentConfigStore } from '@ola/shared/stores/moment/momentConfigStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useHomeNavStore } from '@/store/homeNavStore';

export function useDailyCheckinTask(): (code: string | undefined) => void {
  return useCallback((code) => {
    const nav = useHomeNavStore.getState();
    const overlay = useAppOverlayStore.getState();
    switch (dailyCheckinTaskTarget(code)) {
      case 'meComposer':
        nav.go('me', 'meComposer');
        break;
      case 'momentCreate':
        nav.go('me', useMomentConfigStore.getState().enabled === true ? 'momentComposer' : undefined);
        break;
      case 'meTab':
      case 'momentList':
        nav.go('me');
        break;
      case 'storyTab':
        nav.go('story');
        break;
      case 'gameTab':
        nav.go('game');
        break;
      case 'gifts':
        overlay.push('gifts');
        break;
      case 'megaphone':
        overlay.push('megaphone');
        break;
      default:
        break;
    }
  }, []);
}
