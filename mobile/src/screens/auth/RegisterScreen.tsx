import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { Trans, useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  ScrollView,
  Text,
  View,
} from 'react-native';
import { KeyboardView } from '../../components/KeyboardView';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { AuthService } from '@ola/shared/services';
import { resolveAuthError, USERNAME_MAX, USERNAME_PATTERN } from '@ola/shared/lib';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import { LanguageSwitcher } from '../../components/LanguageSwitcher';
import { TextField } from '../../components/TextField';
import type { AuthStackParamList } from '../../navigation/types';
import { AUTH_ROUTES } from '../../navigation/routes';
import { REGISTER_USERNAME_MIN } from './constants';

interface RegisterForm {
  username: string;
  password: string;
  confirm: string;
  agree: boolean;
}

type Props = NativeStackScreenProps<AuthStackParamList, typeof AUTH_ROUTES.Register>;

export function RegisterScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
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
    defaultValues: { username: '', password: '', confirm: '', agree: false },
  });

  async function onSubmit(data: RegisterForm) {
    setLoading(true);
    setSubmitError(null);
    try {
      await AuthService.register({ username: data.username, password: data.password });
      setSuccess(true);
      setTimeout(() => navigation.navigate(AUTH_ROUTES.Login), 800);
    } catch (err) {
      setSubmitError(resolveAuthError(err, t));
    } finally {
      setLoading(false);
    }
  }

  return (
    <KeyboardView
      className="flex-1 bg-ola-primary"
      style={{ paddingTop: insets.top + 8 }}
    >
      <ScrollView
        contentContainerClassName="flex-grow items-center px-4 pb-8"
        keyboardShouldPersistTaps="handled"
      >
        <View className="h-12 w-full flex-row items-center">
          <Pressable className="-ml-2 px-2" onPress={() => navigation.navigate(AUTH_ROUTES.Login)}>
            <Text className="text-base text-white">{t('common.cancel')}</Text>
          </Pressable>
          <Text className="flex-1 text-center text-lg font-medium text-white">
            {t('register.title')}
          </Text>
          <LanguageSwitcher />
        </View>

        <Image
          source={require('../../assets/ola-logo.png')}
          className="my-3 mt-6 h-14 w-14"
          resizeMode="contain"
        />

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
            <TextField
              label={t('register.usernameLabel')}
              placeholder={t('register.usernamePlaceholder')}
              error={errors.username?.message}
              value={value}
              onChangeText={onChange}
              onBlur={onBlur}
              onClear={() => onChange('')}
            />
          )}
        />

        <Controller
          control={control}
          name="password"
          rules={{
            required: t('register.errPasswordRequired'),
            minLength: { value: PASSWORD_MIN, message: t('register.errPasswordMin') },
            maxLength: { value: PASSWORD_MAX, message: t('register.errPasswordMax') },
          }}
          render={({ field: { onChange, onBlur, value } }) => (
            <TextField
              label={t('register.passwordLabel')}
              placeholder={t('register.passwordPlaceholder')}
              error={errors.password?.message}
              value={value}
              onChangeText={onChange}
              onBlur={onBlur}
              onClear={() => onChange('')}
              secureTextEntry
            />
          )}
        />

        <Controller
          control={control}
          name="confirm"
          rules={{
            required: t('register.errConfirmRequired'),
            validate: (value) =>
              value === getValues('password') || t('register.errConfirmMismatch'),
          }}
          render={({ field: { onChange, onBlur, value } }) => (
            <TextField
              label={t('register.confirmLabel')}
              placeholder={t('register.confirmPlaceholder')}
              error={errors.confirm?.message}
              value={value}
              onChangeText={onChange}
              onBlur={onBlur}
              onClear={() => onChange('')}
              secureTextEntry
            />
          )}
        />

        <View className="mt-4 w-full max-w-md">
          <Controller
            control={control}
            name="agree"
            rules={{ validate: (value) => value || t('register.errAgreeRequired') }}
            render={({ field: { onChange, value } }) => (
              <Pressable className="flex-row items-start gap-2" onPress={() => onChange(!value)}>
                <View
                  className={`mt-0.5 h-4 w-4 items-center justify-center rounded-sm border border-white ${
                    value ? 'bg-ola-primary-dark' : ''
                  }`}
                >
                  {value && <Text className="text-[10px] font-bold text-white">✓</Text>}
                </View>
                <Text className="flex-1 text-sm text-white">
                  <Trans
                    i18nKey="register.agree"
                    components={{
                      terms: (
                        <Text
                          className="font-medium text-white underline"
                          onPress={() => navigation.navigate(AUTH_ROUTES.Terms)}
                        />
                      ),
                    }}
                  />
                </Text>
              </Pressable>
            )}
          />
          {errors.agree != null && (
            <Text className="mt-1 pl-6 text-xs font-medium italic text-white">
              {errors.agree.message}
            </Text>
          )}
        </View>

        {submitError != null && (
          <Text className="mt-3 w-full max-w-md text-sm font-medium italic text-white">
            {submitError}
          </Text>
        )}
        {success && (
          <Text className="mt-3 w-full max-w-md text-sm font-medium text-white">
            {t('register.success')}
          </Text>
        )}

        <Pressable
          className="mb-3 mt-3 h-12 w-full max-w-md items-center justify-center rounded-sm border border-ola-primary-dark bg-ola-button active:opacity-80"
          disabled={loading}
          onPress={handleSubmit(onSubmit)}
        >
          <Text className="text-2xl text-white">{t('register.submit')}</Text>
        </Pressable>

        <Pressable
          className="h-12 w-full max-w-md items-center justify-center"
          onPress={() => navigation.navigate(AUTH_ROUTES.Login)}
        >
          <Text className="text-xl text-white/70">{t('register.hasAccount')}</Text>
        </Pressable>
      </ScrollView>

      {loading && (
        <View className="absolute bottom-0 left-0 right-0 top-0 z-50 items-center justify-center bg-black/40">
          <ActivityIndicator size="large" color="#ffffff" />
        </View>
      )}
    </KeyboardView>
  );
}
