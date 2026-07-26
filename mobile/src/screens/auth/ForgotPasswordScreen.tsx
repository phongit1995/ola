import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { USERNAME_MAX, USERNAME_PATTERN } from '@ola/shared/lib';
import type { AuthStackParamList } from '@navigation/types';
import { AUTH_ROUTES } from '@navigation/routes';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { FORGOT_USERNAME_MIN } from './constants';

interface ForgotForm {
  username: string;
}

type Props = NativeStackScreenProps<AuthStackParamList, typeof AUTH_ROUTES.ForgotPassword>;

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
          <Text className="text-base text-white">{t('common.cancel')}</Text>
        </Pressable>
        <Text className="flex-1 text-center text-lg font-medium text-white">
          {t('forgot.title')}
        </Text>
        <LanguageSwitcher />
      </View>

      <Image
        source={require('@assets/ola-logo.png')}
        style={{ width: 56, height: 56, marginTop: 24, marginBottom: 12 }}
        resizeMode="contain"
      />

      {submitted ? (
        <View className="mt-2 w-full max-w-md items-center gap-2 rounded-sm bg-white p-5">
          <Text className="text-base font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('forgot.doneTitle')}
          </Text>
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('forgot.doneDesc')}
          </Text>
        </View>
      ) : (
        <View className="w-full max-w-md gap-4">
          <Text className="text-sm text-white/90">{t('forgot.desc')}</Text>
          <Text className="-mb-3 text-xs font-medium text-white/90">
            {t('forgot.usernameLabel')}
          </Text>
          <Controller
            control={control}
            name="username"
            rules={{
              required: t('forgot.errUsernameRequired'),
              minLength: { value: FORGOT_USERNAME_MIN, message: t('forgot.errUsernameRequired') },
              maxLength: { value: USERNAME_MAX, message: t('forgot.errUsernameRequired') },
              pattern: { value: USERNAME_PATTERN, message: t('forgot.errUsernameFormat') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className="h-12 rounded-sm bg-white px-4 text-base"
                style={{ color: '#171717' }}
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

      <Pressable
        className="mt-4 h-12 w-full max-w-md items-center justify-center"
        onPress={() => navigation.goBack()}
      >
        <Text className="text-xl text-white/70">{t('forgot.backToLogin')}</Text>
      </Pressable>
    </ScrollView>
  );
}
