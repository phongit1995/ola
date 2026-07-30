import { Text, TextInput } from 'react-native';
import { DIVIDER, TEXT_PRIMARY } from '@constants';

interface TransferPasswordFieldProps {
  label: string;
  placeholder: string;
  value: string;
  onChangeText: (value: string) => void;
}

export function TransferPasswordField({
  label,
  placeholder,
  value,
  onChangeText,
}: TransferPasswordFieldProps) {
  return (
    <>
      <Text className="mt-4 text-base" style={{ color: TEXT_PRIMARY }}>
        {label}
      </Text>
      <TextInput
        autoFocus
        secureTextEntry
        value={value}
        onChangeText={onChangeText}
        placeholder={placeholder}
        placeholderTextColor="rgba(0,0,0,0.38)"
        className="mt-1 w-full rounded px-3 py-2 text-base"
        style={{
          borderWidth: 1,
          borderColor: DIVIDER,
          color: TEXT_PRIMARY,
        }}
      />
    </>
  );
}
