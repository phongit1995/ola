import { cssInterop } from 'nativewind';
import {
  KeyboardAvoidingView,
  type KeyboardAvoidingViewProps,
} from 'react-native-keyboard-controller';

cssInterop(KeyboardAvoidingView, { className: 'style' });

export function KeyboardView(props: KeyboardAvoidingViewProps) {
  return <KeyboardAvoidingView behavior="padding" {...props} />;
}
