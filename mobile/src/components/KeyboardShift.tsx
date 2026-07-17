import { useCallback, useEffect, useRef, type ReactNode } from 'react';
import { View } from 'react-native';
import Reanimated, { useAnimatedStyle, useSharedValue } from 'react-native-reanimated';
import {
  useReanimatedKeyboardAnimation,
  useWindowDimensions,
} from 'react-native-keyboard-controller';
import { useKeyboardHeight } from '@hooks/useKeyboardHeight';

interface KeyboardShiftProps {
  children: ReactNode;
}

export function KeyboardShift({ children }: KeyboardShiftProps) {
  const { height } = useReanimatedKeyboardAnimation();
  const { height: screenHeight } = useWindowDimensions();
  const keyboardHeight = useKeyboardHeight();
  const wrapperRef = useRef<View>(null);
  const bottomGap = useSharedValue(0);

  const remeasure = useCallback(() => {
    requestAnimationFrame(() => {
      wrapperRef.current?.measureInWindow((_x, y, _width, h) => {
        bottomGap.value = Math.max(0, screenHeight - y - h);
      });
    });
  }, [bottomGap, screenHeight]);

  useEffect(() => {
    if (keyboardHeight >= 0) remeasure();
  }, [keyboardHeight, remeasure]);

  const shiftStyle = useAnimatedStyle(
    () => ({
      flex: 1,
      transform: [{ translateY: Math.min(0, height.value + bottomGap.value) }],
    }),
    []
  );

  return (
    <View ref={wrapperRef} className="flex-1" style={{ overflow: 'hidden' }} onLayout={remeasure}>
      <Reanimated.View style={shiftStyle}>{children}</Reanimated.View>
    </View>
  );
}
