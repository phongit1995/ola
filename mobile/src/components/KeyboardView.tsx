import { cssInterop } from 'nativewind';
import {
  KeyboardAvoidingView,
  type KeyboardAvoidingViewProps,
} from 'react-native-keyboard-controller';

function KeyboardViewBase(props: KeyboardAvoidingViewProps) {
  return <KeyboardAvoidingView behavior="padding" {...props} />;
}

export const KeyboardView = cssInterop(KeyboardViewBase, {
  className: 'style',
});
