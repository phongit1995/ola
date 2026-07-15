import { useSafeInsets } from './useSafeInsets';
import { useKeyboardHeight } from './useKeyboardHeight';

export function useBottomBarInset(): number {
  const insets = useSafeInsets();
  const keyboardHeight = useKeyboardHeight();
  return keyboardHeight > 0 ? 0 : insets.bottom;
}
