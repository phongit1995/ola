import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';

interface ClearableInputProps {
  value: string;
  onChangeText: (text: string) => void;
  onBlur?: () => void;
  onClear: () => void;
  placeholder: string;
  secureTextEntry?: boolean;
  autoCapitalize?: 'none' | 'sentences' | 'words' | 'characters';
}

export function ClearableInput({
  value,
  onChangeText,
  onBlur,
  onClear,
  placeholder,
  secureTextEntry,
  autoCapitalize = 'none',
}: ClearableInputProps) {
  const { t } = useTranslation();
  return (
    <View className="flex-row items-center">
      <TextInput
        className="h-14 flex-1 px-4 text-base text-ola-ink"
        placeholder={placeholder}
        placeholderTextColor="rgba(0,0,0,0.38)"
        secureTextEntry={secureTextEntry}
        autoCapitalize={autoCapitalize}
        autoCorrect={false}
        value={value}
        onChangeText={onChangeText}
        onBlur={onBlur}
      />
      {value !== '' && (
        <Pressable
          accessibilityLabel={t('common.clear')}
          onPress={onClear}
          className="mr-1.5 h-9 w-9 items-center justify-center"
        >
          <Text className="text-xl text-ola-ink-soft">×</Text>
        </Pressable>
      )}
    </View>
  );
}
