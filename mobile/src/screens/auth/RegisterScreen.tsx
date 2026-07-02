import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { AuthService } from '@ola/shared/services';
import { resolveAuthError, USERNAME_MAX, USERNAME_PATTERN } from '@ola/shared/lib';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import type { AuthStackParamList } from '../../navigation/types';
import { REGISTER_USERNAME_MIN } from './constants';

interface RegisterForm {
  username: string;
  password: string;
  confirm: string;
}

type Props = NativeStackScreenProps<AuthStackParamList, 'Register'>;

export function RegisterScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  const {
    control,
    handleSubmit,
    getValues,
    formState: { errors },
  } = useForm<RegisterForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '', confirm: '' },
  });

  async function onSubmit(data: RegisterForm) {
    setLoading(true);
    setSubmitError(null);
    try {
      await AuthService.register({ username: data.username, password: data.password });
      setSuccess(true);
      setTimeout(() => navigation.navigate('Login'), 800);
    } catch (err) {
      setSubmitError(resolveAuthError(err, t));
    } finally {
      setLoading(false);
    }
  }

  const fieldError =
    errors.username?.message ?? errors.password?.message ?? errors.confirm?.message ?? submitError;

  return (
    <KeyboardAvoidingView
      className="flex-1 bg-ola-primary"
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerClassName="flex-grow items-center px-4 pb-8"
        keyboardShouldPersistTaps="handled"
      >
        <View className="h-12 w-full flex-row items-center">
          <Pressable className="px-2" onPress={() => navigation.goBack()}>
            <Text className="text-base text-white">‹ {t('forgot.backToLogin')}</Text>
          </Pressable>
        </View>

        <Text className="mb-4 mt-4 text-xl font-semibold text-white">{t('register.title')}</Text>

        <View className="w-full max-w-md gap-4">
          <View>
            <Text className="mb-1 text-xs font-semibold text-white/90">
              {t('register.usernameLabel')}
            </Text>
            <Controller
              control={control}
              name="username"
              rules={{
                required: t('register.errUsernameRequired'),
                minLength: { value: REGISTER_USERNAME_MIN, message: t('register.errUsernameMin') },
                maxLength: { value: USERNAME_MAX, message: t('register.errUsernameMax') },
                pattern: { value: USERNAME_PATTERN, message: t('register.errUsernameFormat') },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <TextInput
                  className="h-12 rounded-sm bg-white px-4 text-base text-neutral-900"
                  placeholder={t('register.usernamePlaceholder')}
                  placeholderTextColor="#9ca3af"
                  autoCapitalize="none"
                  autoCorrect={false}
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                />
              )}
            />
          </View>

          <View>
            <Text className="mb-1 text-xs font-semibold text-white/90">
              {t('register.passwordLabel')}
            </Text>
            <Controller
              control={control}
              name="password"
              rules={{
                required: t('register.errPasswordRequired'),
                minLength: { value: PASSWORD_MIN, message: t('register.errPasswordMin') },
                maxLength: { value: PASSWORD_MAX, message: t('register.errPasswordMax') },
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <TextInput
                  className="h-12 rounded-sm bg-white px-4 text-base text-neutral-900"
                  placeholder={t('register.passwordPlaceholder')}
                  placeholderTextColor="#9ca3af"
                  secureTextEntry
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                />
              )}
            />
          </View>

          <View>
            <Text className="mb-1 text-xs font-semibold text-white/90">
              {t('register.confirmLabel')}
            </Text>
            <Controller
              control={control}
              name="confirm"
              rules={{
                required: t('register.errConfirmRequired'),
                validate: (value) =>
                  value === getValues('password') || t('register.errConfirmMismatch'),
              }}
              render={({ field: { onChange, onBlur, value } }) => (
                <TextInput
                  className="h-12 rounded-sm bg-white px-4 text-base text-neutral-900"
                  placeholder={t('register.confirmPlaceholder')}
                  placeholderTextColor="#9ca3af"
                  secureTextEntry
                  value={value}
                  onChangeText={onChange}
                  onBlur={onBlur}
                />
              )}
            />
          </View>
        </View>

        {fieldError != null && (
          <Text className="mt-2 w-full max-w-md text-sm text-white">{fieldError}</Text>
        )}
        {success && (
          <Text className="mt-2 w-full max-w-md text-sm text-white">{t('register.success')}</Text>
        )}

        <Pressable
          className="mt-6 h-12 w-full max-w-md items-center justify-center rounded-sm bg-ola-button active:opacity-80"
          disabled={loading}
          onPress={handleSubmit(onSubmit)}
        >
          {loading ? (
            <ActivityIndicator color="#ffffff" />
          ) : (
            <Text className="text-base font-semibold text-white">{t('register.submit')}</Text>
          )}
        </Pressable>

        <View className="mt-4 flex-row items-center gap-1">
          <Text className="text-sm text-white/90">{t('register.hasAccount')}</Text>
          <Pressable onPress={() => navigation.navigate('Login')}>
            <Text className="text-sm font-semibold text-white underline">{t('login.submit')}</Text>
          </Pressable>
        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
