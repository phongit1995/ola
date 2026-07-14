import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useKeyboardHeight } from './useKeyboardHeight';

export function useBottomBarInset(): number {
  const insets = useSafeAreaInsets();
  const keyboardHeight = useKeyboardHeight();
  return keyboardHeight > 0 ? 0 : insets.bottom;
}
