import { cssInterop } from 'nativewind';
import {
  KeyboardAvoidingView,
  type KeyboardAvoidingViewProps,
} from 'react-native-keyboard-controller';

function KeyboardViewBase(props: KeyboardAvoidingViewProps) {
  return <KeyboardAvoidingView behavior="padding" {...props} />;
}

// Giới hạn NativeWind interop ở KeyboardView thay vì đăng ký toàn cục cho
// KeyboardAvoidingView của RNKC; các chỗ dùng RNKC trực tiếp không cần className.
export const KeyboardView = cssInterop(KeyboardViewBase, {
  className: 'style',
});
