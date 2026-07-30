import type { ReactNode } from 'react';
import { View } from 'react-native';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

interface ChatKeyboardAreaProps {
  children: ReactNode;
}

// Vùng nội dung của 2 màn chat: clip (overflow hidden) + translate-with-padding để
// suốt animation chỉ transform trên UI thread, list không relayout từng frame.
// Dùng automaticOffset trực tiếp trên RNKC để lấy tọa độ native tuyệt đối.
// Không dùng View.measureInWindow ở đây: tọa độ đó không tin cậy với
// Fabric + edge-to-edge trên Android mới và làm composer bị IME che.
export function ChatKeyboardArea({ children }: ChatKeyboardAreaProps) {
  return (
    <View className="flex-1" style={{ overflow: 'hidden' }}>
      <KeyboardAvoidingView
        automaticOffset
        behavior="translate-with-padding"
        style={{ flex: 1 }}
      >
        {children}
      </KeyboardAvoidingView>
    </View>
  );
}
