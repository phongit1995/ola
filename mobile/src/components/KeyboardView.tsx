import { KeyboardAvoidingView, Platform, type KeyboardAvoidingViewProps } from 'react-native';

export function KeyboardView(props: KeyboardAvoidingViewProps) {
  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      {...props}
    />
  );
}
