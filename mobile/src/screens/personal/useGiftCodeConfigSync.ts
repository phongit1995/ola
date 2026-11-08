import { useCallback } from 'react';
import { AppState } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { useGiftCodeConfigStore } from '@ola/shared/stores/gift-code/giftCodeConfigStore';

export function useGiftCodeConfigSync() {
  const load = useGiftCodeConfigStore((s) => s.load);

  useFocusEffect(
    useCallback(() => {
      void load();
      const subscription = AppState.addEventListener('change', (state) => {
        if (state === 'active') void load();
      });
      return () => subscription.remove();
    }, [load]),
  );
}
