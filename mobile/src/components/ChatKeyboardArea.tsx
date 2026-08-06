import { useCallback, useRef, useState, type ReactNode } from 'react';
import { Platform, View } from 'react-native';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

interface ChatKeyboardAreaProps {
  children: ReactNode;
  /** Safe-area padding that is already rendered inside the composer. */
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

// Vùng nội dung có composer: clip (overflow hidden) + translate-with-padding để
// suốt animation chỉ transform trên UI thread, list không relayout từng frame.
//
// Android: automaticOffset (RNKC lấy tọa độ tuyệt đối bằng viewPositionInWindow native)
// bắt buộc — measureInWindow không tin cậy khi cờ edge-to-edge của RN đang tắt
// (Android <= 14), Fabric trừ status-bar inset dù cửa sổ đã edge-to-edge, khiến
// composer bị IME che đúng phần inset bị trừ.
// iOS: giữ cách đo measureInWindow đã dùng trước khi automaticOffset được áp dụng.
// Lỗi edge-to-edge ở trên chỉ thuộc Android, nên tách theo nền tảng để workaround
// đó không làm thay đổi cách tính vị trí composer trên iOS.
export function ChatKeyboardArea({
  children,
  bottomInset = 0,
}: ChatKeyboardAreaProps) {
  const contentRef = useRef<View>(null);
  const [iosOffsetY, setIosOffsetY] = useState(0);

  const measureIos = useCallback(() => {
    contentRef.current?.measureInWindow((_x, y) => setIosOffsetY(y));
  }, []);

  // The composer keeps its safe-area padding while the keyboard is visible.
  // Subtract that padding from the translation so its controls still meet the
  // keyboard. On iOS this remains combined with the measured screen offset.
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
