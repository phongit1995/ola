import { cssInterop } from 'nativewind';
import {
  KeyboardAvoidingView,
  type KeyboardAvoidingViewProps,
} from 'react-native-keyboard-controller';

function KeyboardViewBase(props: KeyboardAvoidingViewProps) {
  return <KeyboardAvoidingView behavior="padding" {...props} />;
}

// Chỉ đăng ký interop cho wrapper cục bộ. Đăng ký trực tiếp
// KeyboardAvoidingView của RNKC sẽ bọc cả những chỗ không dùng className,
// khiến automaticOffset không còn giữ ref thẳng tới native view.
export const KeyboardView = cssInterop(KeyboardViewBase, {
  className: 'style',
});
