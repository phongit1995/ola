import { useEffect, useRef, useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
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
import DeviceInfo from 'react-native-device-info';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { AuthService } from '@ola/shared/services';
import { ApiError, USERNAME_MAX, decodeSecret } from '@ola/shared/lib';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import { useAuthStore } from '@ola/shared/stores/authStore';
import {
  useSavedAccountsStore,
  type SavedAccount,
} from '@ola/shared/stores/savedAccountsStore';
import { ClearableInput } from '../../components/ClearableInput';
import { LanguageSwitcher } from '../../components/LanguageSwitcher';
import { SavedAccountGallery } from './SavedAccountGallery';
import type { AuthStackParamList } from '../../navigation/types';
import { AUTH_ROUTES } from '../../navigation/routes';
import { USERNAME_MIN } from './constants';

const APP_VERSION = `${DeviceInfo.getVersion()} (${DeviceInfo.getBuildNumber()})`;

interface LoginForm {
  username: string;
  password: string;
}

type Props = NativeStackScreenProps<AuthStackParamList, typeof AUTH_ROUTES.Login>;

export function LoginScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const setUser = useAuthStore((s) => s.setUser);
  const accounts = useSavedAccountsStore((s) => s.accounts);
  const saveAccount = useSavedAccountsStore((s) => s.saveAccount);
  const removeAccount = useSavedAccountsStore((s) => s.removeAccount);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const {
    control,
    handleSubmit,
    setValue,
    getValues,
    formState: { errors },
  } = useForm<LoginForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '' },
  });

  const prefilled = useRef(false);
  useEffect(() => {
    if (prefilled.current) {
      return;
    }
    prefilled.current = true;
    const recent = accounts[0];
    if (recent != null) {
      setValue('username', recent.username);
      setValue('password', decodeSecret(recent.secret));
    }
  }, [accounts, setValue]);

  function clearError() {
    if (error) {
      setError(null);
    }
  }

  function pickAccount(account: SavedAccount) {
    setValue('username', account.username, { shouldValidate: true });
    setValue('password', decodeSecret(account.secret), { shouldValidate: true });
    clearError();
  }

  function handleRemoveAccount(removedUsername: string) {
    removeAccount(removedUsername);
    if (getValues('username').trim().toLowerCase() === removedUsername.toLowerCase()) {
      setValue('username', '');
      setValue('password', '');
      clearError();
    }
  }

  async function onSubmit(data: LoginForm) {
    setLoading(true);
    setError(null);
    const username = data.username.trim().toLowerCase();
    try {
      const { user } = await AuthService.login({ username, password: data.password });
      saveAccount(username, data.password, user.avatar);
      setUser(user);
    } catch (err) {
      setError(err instanceof ApiError ? err.message : t('auth.errGeneric'));
    } finally {
      setLoading(false);
    }
  }

  const hasFieldError = errors.username != null || errors.password != null;

  return (
    <KeyboardView
      className="flex-1 bg-ola-primary"
      style={{ paddingTop: insets.top + 8 }}
    >
      <ScrollView
        contentContainerClassName="flex-grow items-center px-4"
        keyboardShouldPersistTaps="handled"
      >
        <LanguageSwitcher className="mt-3 self-end" />

        <View className="w-full flex-1 items-center justify-center py-6">
          {accounts.length > 0 ? (
            <SavedAccountGallery
              accounts={accounts}
              onPick={pickAccount}
              onRemove={handleRemoveAccount}
            />
          ) : (
            <Image
              source={require('../../assets/ola-logo.png')}
              className="mb-4 h-14 w-14"
              resizeMode="contain"
            />
          )}

        <View
          className={`w-full max-w-md overflow-hidden rounded-sm bg-white shadow ${
            hasFieldError ? 'border border-ola-error' : ''
          }`}
        >
          <Controller
            control={control}
            name="username"
            rules={{
              required: t('login.errUsernameRequired'),
              minLength: { value: USERNAME_MIN, message: t('login.errUsernameLength') },
              maxLength: { value: USERNAME_MAX, message: t('login.errUsernameLength') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <ClearableInput
                value={value}
                onChangeText={(text) => {
                  onChange(text);
                  clearError();
                }}
                onBlur={onBlur}
                onClear={() => onChange('')}
                placeholder={t('login.username')}
              />
            )}
          />
          <View className="mx-1 h-px bg-black/[0.12]" />
          <Controller
            control={control}
            name="password"
            rules={{
              required: t('login.errPasswordRequired'),
              minLength: { value: PASSWORD_MIN, message: t('login.errPasswordLength') },
              maxLength: { value: PASSWORD_MAX, message: t('login.errPasswordLength') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <ClearableInput
                value={value}
                onChangeText={(text) => {
                  onChange(text);
                  clearError();
                }}
                onBlur={onBlur}
                onClear={() => onChange('')}
                placeholder={t('login.password')}
                secureTextEntry
              />
            )}
          />
        </View>

        {(errors.username != null || errors.password != null || error != null) && (
          <View className="mt-2 w-full max-w-md gap-0.5">
            {errors.username != null && (
              <Text className="text-sm font-medium italic text-white">
                {errors.username.message}
              </Text>
            )}
            {errors.password != null && (
              <Text className="text-sm font-medium italic text-white">
                {errors.password.message}
              </Text>
            )}
            {error != null && (
              <Text className="text-sm font-medium italic text-white">{error}</Text>
            )}
          </View>
        )}

        <Pressable
          className="mb-3 mt-2 h-12 w-full max-w-md items-center justify-center rounded-sm border border-ola-primary-dark bg-ola-button active:opacity-80"
          disabled={loading}
          onPress={handleSubmit(onSubmit)}
        >
          <Text className="text-2xl text-white">{t('login.submit')}</Text>
        </Pressable>

        <Pressable
          className="w-full max-w-md py-3"
          onPress={() => navigation.navigate(AUTH_ROUTES.ForgotPassword)}
        >
          <Text className="text-right text-sm text-white">{t('login.forgot')}</Text>
        </Pressable>

          <Pressable
            className="mt-1 h-12 w-full max-w-md items-center justify-center"
            onPress={() => navigation.navigate(AUTH_ROUTES.Register)}
          >
            <Text className="text-xl text-white/70">{t('login.createAccount')}</Text>
          </Pressable>
        </View>

        <Text className="w-full max-w-md pb-4 text-right text-[9px] text-white/70">
          {t('login.version')}: {APP_VERSION}
        </Text>
      </ScrollView>

      {loading && (
        <View className="absolute bottom-0 left-0 right-0 top-0 z-50 items-center justify-center bg-black/40">
          <ActivityIndicator size="large" color="#ffffff" />
        </View>
      )}
    </KeyboardView>
  );
}
