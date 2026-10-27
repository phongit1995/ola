import HapticFeedback from 'react-native-haptic-feedback';

const HAPTIC_OPTIONS = {
  enableVibrateFallback: false,
  ignoreAndroidSystemSettings: false,
};

export function hapticImpact() {
  HapticFeedback.trigger('impactMedium', HAPTIC_OPTIONS);
}

export function hapticTick() {
  HapticFeedback.trigger('selection', HAPTIC_OPTIONS);
}
