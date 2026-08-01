import type { ReactNode } from 'react';
import { View } from 'react-native';
import { KeyboardAvoidingView } from 'react-native-keyboard-controller';

interface ChatKeyboardAreaProps {
  children: ReactNode;
}

// Vùng nội dung của 2 màn chat: clip (overflow hidden) + translate-with-padding để
// suốt animation chỉ transform trên UI thread, list không relayout từng frame.
// Dùng automaticOffset để RNKC lấy tọa độ tuyệt đối bằng getLocationOnScreen trên Android.
// Không dùng View.measureInWindow: khi cờ edge-to-edge của RN đang tắt
// (Android <= 14 với cấu hình hiện tại), Fabric trừ status-bar inset dù cửa sổ
// đã edge-to-edge, khiến composer bị IME che đúng phần inset bị trừ.
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
