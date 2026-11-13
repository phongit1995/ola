import { useCallback, useRef, useState, type ReactNode } from 'react';
import { Platform, View, type ViewInstance } from 'react-native';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

interface ChatKeyboardAreaProps {
  children: ReactNode;
  bottomInset?: number;
}

const IS_ANDROID = Platform.OS === 'android';

export function resolveChatKeyboardVerticalOffset(
  isAndroid: boolean,
  iosOffsetY: number,
  bottomInset: number,
): number {
  return (isAndroid ? 0 : iosOffsetY) - bottomInset;
}

export function ChatKeyboardArea({
  children,
  bottomInset = 0,
}: ChatKeyboardAreaProps) {
  const contentRef = useRef<ViewInstance>(null);
  const [iosOffsetY, setIosOffsetY] = useState(0);

  const measureIos = useCallback(() => {
    contentRef.current?.measureInWindow((_x, y) => setIosOffsetY(y));
  }, []);

  const keyboardVerticalOffset = resolveChatKeyboardVerticalOffset(
    IS_ANDROID,
    iosOffsetY,
    bottomInset,
  );

  return (
    <View
      ref={contentRef}
      className="flex-1"
      style={{ overflow: 'hidden' }}
      onLayout={IS_ANDROID ? undefined : measureIos}
    >
      <KeyboardAvoidingView
        automaticOffset={IS_ANDROID}
        keyboardVerticalOffset={keyboardVerticalOffset}
        behavior="translate-with-padding"
        style={{ flex: 1 }}
      >
        {children}
      </KeyboardAvoidingView>
    </View>
  );
}
