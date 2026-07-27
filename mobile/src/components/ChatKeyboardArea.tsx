import { useCallback, useRef, useState, type ReactNode } from 'react';
import { View } from 'react-native';
import { KeyboardView } from './KeyboardView';

interface ChatKeyboardAreaProps {
  children: ReactNode;
}

// Vùng nội dung của 2 màn chat: clip (overflow hidden) + translate-with-padding để
// suốt animation chỉ transform trên UI thread, list không relayout từng frame.
// automaticOffset của RNKC không đo được vị trí KAV qua wrapper cssInterop của
// KeyboardView (xem fabb71cab) làm composer bị bàn phím che, nên phải tự
// measureInWindow rồi truyền keyboardVerticalOffset tường minh.
export function ChatKeyboardArea({ children }: ChatKeyboardAreaProps) {
  const contentRef = useRef<View>(null);
  const [contentOffsetY, setContentOffsetY] = useState(0);

  const measure = useCallback(() => {
    contentRef.current?.measureInWindow((_x, y) => setContentOffsetY(y));
  }, []);

  return (
    <View ref={contentRef} className="flex-1" style={{ overflow: 'hidden' }} onLayout={measure}>
      <KeyboardView
        behavior="translate-with-padding"
        keyboardVerticalOffset={contentOffsetY}
        className="flex-1"
      >
        {children}
      </KeyboardView>
    </View>
  );
}
