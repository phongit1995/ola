import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { AuthStackParamList } from '../../navigation/types';

interface ForgotForm {
  username: string;
}

type Props = NativeStackScreenProps<AuthStackParamList, 'ForgotPassword'>;

export function ForgotPasswordScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const [submitted, setSubmitted] = useState(false);

  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm<ForgotForm>({
    mode: 'onTouched',
    defaultValues: { username: '' },
  });

  return (
    <ScrollView
      className="flex-1 bg-ola-primary"
      contentContainerClassName="flex-grow items-center px-4 pb-8"
      keyboardShouldPersistTaps="handled"
    >
      <View className="h-12 w-full flex-row items-center">
        <Pressable className="px-2" onPress={() => navigation.goBack()}>
          <Text className="text-base text-white">‹ {t('forgot.backToLogin')}</Text>
        </Pressable>
      </View>

      <Text className="mb-2 mt-4 text-xl font-semibold text-white">{t('forgot.title')}</Text>

      {submitted ? (
        <View className="w-full max-w-md items-center gap-2 rounded-sm bg-white/10 p-6">
          <Text className="text-base font-semibold text-white">{t('forgot.doneTitle')}</Text>
          <Text className="text-center text-sm text-white/90">{t('forgot.doneDesc')}</Text>
        </View>
      ) : (
        <View className="w-full max-w-md gap-4">
          <Text className="text-sm text-white/90">{t('forgot.desc')}</Text>
          <Controller
            control={control}
            name="username"
            rules={{ required: t('forgot.errUsernameRequired') }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className="h-12 rounded-sm bg-white px-4 text-base text-neutral-900"
                placeholder={t('forgot.usernamePlaceholder')}
                placeholderTextColor="#9ca3af"
                autoCapitalize="none"
                autoCorrect={false}
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
              />
            )}
          />
          {errors.username?.message != null && (
            <Text className="text-sm text-white">{errors.username.message}</Text>
          )}
          <Pressable
            className="h-12 items-center justify-center rounded-sm bg-ola-button active:opacity-80"
            onPress={handleSubmit(() => setSubmitted(true))}
          >
            <Text className="text-base font-semibold text-white">{t('forgot.submit')}</Text>
          </Pressable>
        </View>
      )}
    </ScrollView>
  );
}
