import { useRef } from 'react';
import {
  TextInput,
  View,
  type NativeSyntheticEvent,
  type TextInputKeyPressEventData,
} from 'react-native';

interface OtpInputProps {
  value: string;
  onChange: (value: string) => void;
  length?: number;
  disabled?: boolean;
  autoFocus?: boolean;
}

function padTo(value: string, length: number): string[] {
  const chars = value.split('');
  while (chars.length < length) chars.push('');
  return chars;
}

export function OtpInput({ value, onChange, length = 6, disabled = false, autoFocus = false }: OtpInputProps) {
  const inputs = useRef<Array<TextInput | null>>([]);

  function focusAt(index: number) {
    inputs.current[Math.max(0, Math.min(index, length - 1))]?.focus();
  }

  function handleChange(index: number, text: string) {
    const digits = text.replace(/\D/g, '');
    if (digits === '') {
      const chars = padTo(value, length);
      chars[index] = '';
      onChange(chars.join('').slice(0, length));
      return;
    }
    if (digits.length > 1) {
      const next = (value.slice(0, index) + digits).replace(/\D/g, '').slice(0, length);
      onChange(next);
      focusAt(next.length >= length ? length - 1 : next.length);
      return;
    }
    const chars = padTo(value, length);
    chars[index] = digits;
    onChange(chars.join('').slice(0, length));
    if (index < length - 1) focusAt(index + 1);
  }

  function handleKeyPress(index: number, event: NativeSyntheticEvent<TextInputKeyPressEventData>) {
    if (event.nativeEvent.key === 'Backspace' && !value[index] && index > 0) {
      const chars = padTo(value, length);
      chars[index - 1] = '';
      onChange(chars.join('').slice(0, length));
      focusAt(index - 1);
    }
  }

  return (
    <View className="flex-row justify-center gap-2">
      {Array.from({ length }, (_, index) => (
        <TextInput
          key={index}
          ref={(el) => {
            inputs.current[index] = el;
          }}
          value={value[index] ?? ''}
          onChangeText={(text) => handleChange(index, text)}
          onKeyPress={(event) => handleKeyPress(index, event)}
          keyboardType="number-pad"
          maxLength={1}
          editable={!disabled}
          autoFocus={autoFocus && index === 0}
          textAlign="center"
          className="rounded text-lg font-semibold"
          style={{
            width: 40,
            height: 48,
            borderWidth: 1,
            borderColor: 'rgba(0,0,0,0.2)',
            color: 'rgba(0,0,0,0.87)',
            opacity: disabled ? 0.5 : 1,
          }}
        />
      ))}
    </View>
  );
}
