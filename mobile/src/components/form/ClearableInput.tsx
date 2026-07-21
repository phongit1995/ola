import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, TextInput, View } from 'react-native';

const EYE_SHOW = require('@assets/icons/form/eye.png');
const EYE_HIDE = require('@assets/icons/form/eye-off.png');

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
  const [revealed, setRevealed] = useState(false);
  const isPassword = secureTextEntry === true;
  return (
    <View className="flex-row items-center">
      <TextInput
        className="h-14 flex-1 px-4 text-base"
        style={{ color: 'rgba(0,0,0,0.87)' }}
        placeholder={placeholder}
        placeholderTextColor="rgba(0,0,0,0.38)"
        secureTextEntry={isPassword && !revealed}
        autoCapitalize={autoCapitalize}
        autoCorrect={false}
        value={value}
        onChangeText={onChangeText}
        onBlur={onBlur}
      />
      {value !== '' &&
        (isPassword ? (
          <Pressable
            accessibilityLabel={t(revealed ? 'common.hidePassword' : 'common.showPassword')}
            onPress={() => setRevealed((prev) => !prev)}
            className="mr-1.5 h-9 w-9 items-center justify-center"
          >
            <Image
              source={revealed ? EYE_HIDE : EYE_SHOW}
              style={{ width: 22, height: 22, tintColor: 'rgba(0,0,0,0.5)' }}
              resizeMode="contain"
            />
          </Pressable>
        ) : (
          <Pressable
            accessibilityLabel={t('common.clear')}
            onPress={onClear}
            className="mr-1.5 h-9 w-9 items-center justify-center"
          >
            <Text className="text-xl" style={{ color: 'rgba(0,0,0,0.54)' }}>×</Text>
          </Pressable>
        ))}
    </View>
  );
}
