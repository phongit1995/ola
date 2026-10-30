import { useCallback } from 'react';
import { TurboModuleRegistry } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import type { CaptureProtectionFunction } from 'react-native-capture-protection';

const captureProtection: CaptureProtectionFunction | null =
  TurboModuleRegistry.get('CaptureProtection') == null
    ? null
    : require('react-native-capture-protection').CaptureProtection;

export function useBlockScreenCapture() {
  useFocusEffect(
    useCallback(() => {
      if (captureProtection == null) return undefined;
      captureProtection.prevent().catch(() => undefined);
      return () => {
        captureProtection.allow().catch(() => undefined);
      };
    }, []),
  );
}
