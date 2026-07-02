import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
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
import { ApiError, USERNAME_MAX } from '@ola/shared/lib';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import { useAuthStore } from '@ola/shared/stores/authStore';
import type { AuthStackParamList } from '../../navigation/types';
import { USERNAME_MIN } from './constants';

interface LoginForm {
  username: string;
  password: string;
}

type Props = NativeStackScreenProps<AuthStackParamList, 'Login'>;

export function LoginScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const setUser = useAuthStore((s) => s.setUser);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const {
    control,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '' },
  });

  async function onSubmit(data: LoginForm) {
    setLoading(true);
    setError(null);
    const username = data.username.trim().toLowerCase();
    try {
      const { user } = await AuthService.login({ username, password: data.password });
      setUser(user);
    } catch (err) {
      setError(err instanceof ApiError ? err.message : t('auth.errGeneric'));
    } finally {
      setLoading(false);
    }
  }

  const fieldError = errors.username?.message ?? errors.password?.message ?? error;

  return (
    <KeyboardAvoidingView
      className="flex-1 bg-ola-primary"
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView
        contentContainerClassName="flex-grow items-center px-4 pb-8"
        keyboardShouldPersistTaps="handled"
      >
        <Image
          source={require('../../assets/ola-logo.png')}
          className="mb-4 mt-16 h-14 w-14"
          resizeMode="contain"
        />

        <View className="w-full max-w-md overflow-hidden rounded-sm bg-white shadow">
          <Controller
            control={control}
            name="username"
            rules={{
              required: t('login.errUsernameRequired'),
              minLength: { value: USERNAME_MIN, message: t('login.errUsernameLength') },
              maxLength: { value: USERNAME_MAX, message: t('login.errUsernameLength') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className="h-12 border-b border-neutral-200 px-4 text-base text-neutral-900"
                placeholder={t('login.username')}
                placeholderTextColor="#9ca3af"
                autoCapitalize="none"
                autoCorrect={false}
                value={value}
                onChangeText={(text) => {
                  onChange(text);
                  setError(null);
                }}
                onBlur={onBlur}
              />
            )}
          />
          <Controller
            control={control}
            name="password"
            rules={{
              required: t('login.errPasswordRequired'),
              minLength: { value: PASSWORD_MIN, message: t('login.errPasswordLength') },
              maxLength: { value: PASSWORD_MAX, message: t('login.errPasswordLength') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className="h-12 px-4 text-base text-neutral-900"
                placeholder={t('login.password')}
                placeholderTextColor="#9ca3af"
                secureTextEntry
                value={value}
                onChangeText={(text) => {
                  onChange(text);
                  setError(null);
                }}
                onBlur={onBlur}
              />
            )}
          />
        </View>

        {fieldError != null && (
          <Text className="mt-2 w-full max-w-md text-sm text-white">{fieldError}</Text>
        )}

        <Pressable
          className="mt-4 h-12 w-full max-w-md items-center justify-center rounded-sm bg-ola-button active:opacity-80"
          disabled={loading}
          onPress={handleSubmit(onSubmit)}
        >
          {loading ? (
            <ActivityIndicator color="#ffffff" />
          ) : (
            <Text className="text-base font-semibold text-white">{t('login.submit')}</Text>
          )}
        </Pressable>

        <Pressable className="mt-4" onPress={() => navigation.navigate('ForgotPassword')}>
          <Text className="text-sm text-white underline">{t('login.forgot')}</Text>
        </Pressable>

        <View className="flex-1" />

        <Pressable
          className="mt-8 h-12 w-full max-w-md items-center justify-center rounded-sm border border-white/70"
          onPress={() => navigation.navigate('Register')}
        >
          <Text className="text-base font-semibold text-white">{t('login.createAccount')}</Text>
        </Pressable>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}
