import HapticFeedback from 'react-native-haptic-feedback';

export function hapticImpact() {
  HapticFeedback.trigger('impactMedium', {
    enableVibrateFallback: false,
    ignoreAndroidSystemSettings: false,
  });
}
