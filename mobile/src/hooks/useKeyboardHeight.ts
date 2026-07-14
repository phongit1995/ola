import { useRef } from 'react';
import { useKeyboardState } from 'react-native-keyboard-controller';

export function useKeyboardHeight(): number {
  return useKeyboardState((state) => (state.isVisible ? state.height : 0));
}

export function useLastKeyboardHeight(): number {
  const height = useKeyboardHeight();
  const lastRef = useRef(0);
  if (height > 0) lastRef.current = height;
  return lastRef.current;
}
