import { Text, View } from 'react-native';
import { ClearableInput } from './ClearableInput';

interface TextFieldProps {
  label: string;
  placeholder: string;
  error?: string;
  value: string;
  onChangeText: (text: string) => void;
  onBlur?: () => void;
  onClear: () => void;
  secureTextEntry?: boolean;
  autoCapitalize?: 'none' | 'sentences' | 'words' | 'characters';
}

export function TextField({
  label,
  placeholder,
  error,
  value,
  onChangeText,
  onBlur,
  onClear,
  secureTextEntry,
  autoCapitalize = 'none',
}: TextFieldProps) {
  return (
    <View className="mt-3 w-full max-w-md">
      <Text className="px-1 pb-1 text-xs font-medium tracking-wide text-white/90">{label}</Text>
      <View
        className={`overflow-hidden rounded-sm bg-white shadow ${
          error != null ? 'border border-ola-error' : ''
        }`}
      >
        <ClearableInput
          value={value}
          onChangeText={onChangeText}
          onBlur={onBlur}
          onClear={onClear}
          placeholder={placeholder}
          secureTextEntry={secureTextEntry}
          autoCapitalize={autoCapitalize}
        />
      </View>
      {error != null && (
        <Text className="px-1 pt-1 text-xs font-medium italic text-white">{error}</Text>
      )}
    </View>
  );
}
