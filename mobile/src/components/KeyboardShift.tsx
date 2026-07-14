import { useCallback, useRef, useState, type ReactNode } from 'react';
import { View } from 'react-native';
import Reanimated, { useAnimatedStyle } from 'react-native-reanimated';
import {
  useReanimatedKeyboardAnimation,
  useWindowDimensions,
} from 'react-native-keyboard-controller';

interface KeyboardShiftProps {
  children: ReactNode;
}

export function KeyboardShift({ children }: KeyboardShiftProps) {
  const { height } = useReanimatedKeyboardAnimation();
  const { height: screenHeight } = useWindowDimensions();
  const wrapperRef = useRef<View>(null);
  const [bottomOffset, setBottomOffset] = useState(0);

  const measure = useCallback(() => {
    wrapperRef.current?.measureInWindow((_x, y, _width, h) => {
      setBottomOffset(Math.max(0, screenHeight - y - h));
    });
  }, [screenHeight]);

  const shiftStyle = useAnimatedStyle(
    () => ({
      flex: 1,
      transform: [{ translateY: Math.min(0, height.value + bottomOffset) }],
    }),
    [bottomOffset]
  );

  return (
    <View ref={wrapperRef} className="flex-1" style={{ overflow: 'hidden' }} onLayout={measure}>
      <Reanimated.View style={shiftStyle}>{children}</Reanimated.View>
    </View>
  );
}
