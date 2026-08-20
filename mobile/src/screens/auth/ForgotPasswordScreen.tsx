import { useEffect, useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, TextInput, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { AuthService } from '@ola/shared/services';
import {
  FORGOT_CODE_PATTERN,
  FORGOT_RESEND_COOLDOWN_SECONDS,
  resolveForgotConfirmError,
  resolveForgotSendError,
  USERNAME_MAX,
  USERNAME_PATTERN,
} from '@ola/shared/lib';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import type { AuthStackParamList } from '@navigation/types';
import { AUTH_ROUTES } from '@navigation/routes';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { USERNAME_MIN } from './constants';

interface UsernameForm {
  username: string;
}

interface ResetForm {
  code: string;
  newPassword: string;
  confirm: string;
}

type Step = 'username' | 'code' | 'success';

type Props = NativeStackScreenProps<AuthStackParamList, typeof AUTH_ROUTES.ForgotPassword>;

const inputClass = 'h-12 rounded-sm bg-white px-4 text-base';
const inputTextColor = { color: '#171717' } as const;

export function ForgotPasswordScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const [step, setStep] = useState<Step>('username');
  const [username, setUsername] = useState('');
  const [sending, setSending] = useState(false);
  const [resetting, setResetting] = useState(false);
  const [apiError, setApiError] = useState<string | null>(null);
  const [resendSeconds, setResendSeconds] = useState(0);

  useEffect(() => {
    if (resendSeconds <= 0) return;
    const timer = setTimeout(() => setResendSeconds((s) => s - 1), 1000);
    return () => clearTimeout(timer);
  }, [resendSeconds]);

  const usernameForm = useForm<UsernameForm>({
    mode: 'onTouched',
    defaultValues: { username: '' },
  });

  const resetForm = useForm<ResetForm>({
    mode: 'onTouched',
    defaultValues: { code: '', newPassword: '', confirm: '' },
  });

  async function sendCode(name: string) {
    if (sending) return;
    setSending(true);
    setApiError(null);
    try {
      await AuthService.forgotPasswordSend(name);
      setUsername(name);
      setResendSeconds(FORGOT_RESEND_COOLDOWN_SECONDS);
      setStep('code');
    } catch (err) {
      setApiError(resolveForgotSendError(err, t));
    }
    setSending(false);
  }

  async function resend() {
    if (sending || resendSeconds > 0) return;
    setSending(true);
    setApiError(null);
    try {
      await AuthService.forgotPasswordSend(username);
      setResendSeconds(FORGOT_RESEND_COOLDOWN_SECONDS);
    } catch (err) {
      setApiError(resolveForgotSendError(err, t));
    }
    setSending(false);
  }

  async function confirmReset(values: ResetForm) {
    if (resetting) return;
    setResetting(true);
    setApiError(null);
    try {
      await AuthService.forgotPasswordConfirm({
        username,
        code: values.code,
        newPassword: values.newPassword,
      });
      setStep('success');
    } catch (err) {
      setApiError(resolveForgotConfirmError(err, t));
    }
    setResetting(false);
  }

  function backToUsername() {
    setApiError(null);
    resetForm.reset();
    setStep('username');
  }

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

      {step === 'username' && (
        <View className="w-full max-w-md gap-4">
          <Text className="text-sm text-white/90">{t('forgot.desc')}</Text>
          <Text className="-mb-3 text-xs font-medium text-white/90">
            {t('forgot.usernameLabel')}
          </Text>
          <Controller
            control={usernameForm.control}
            name="username"
            rules={{
              required: t('forgot.errUsernameRequired'),
              minLength: { value: USERNAME_MIN, message: t('forgot.errUsernameRequired') },
              maxLength: { value: USERNAME_MAX, message: t('forgot.errUsernameRequired') },
              pattern: { value: USERNAME_PATTERN, message: t('forgot.errUsernameFormat') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className={inputClass}
                style={inputTextColor}
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
          {usernameForm.formState.errors.username?.message != null && (
            <Text className="text-sm text-white">
              {usernameForm.formState.errors.username.message}
            </Text>
          )}
          {apiError != null && <Text className="text-sm text-white">{apiError}</Text>}
          <Pressable
            className="h-12 items-center justify-center rounded-sm bg-ola-button active:opacity-80"
            disabled={sending}
            onPress={usernameForm.handleSubmit((values) =>
              sendCode(values.username.trim().toLowerCase())
            )}
          >
            {sending ? (
              <ActivityIndicator color="#ffffff" />
            ) : (
              <Text className="text-base font-semibold text-white">{t('forgot.submit')}</Text>
            )}
          </Pressable>
        </View>
      )}

      {step === 'code' && (
        <View className="w-full max-w-md gap-4">
          <Text className="text-base font-medium text-white">{t('forgot.codeSentTitle')}</Text>
          <Text className="text-sm text-white/90">
            {t('forgot.codeSentDesc', { username })}
          </Text>
          <Text className="-mb-3 text-xs font-medium text-white/90">{t('forgot.codeLabel')}</Text>
          <Controller
            control={resetForm.control}
            name="code"
            rules={{
              required: t('forgot.errCodeFormat'),
              pattern: { value: FORGOT_CODE_PATTERN, message: t('forgot.errCodeFormat') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className={inputClass}
                style={inputTextColor}
                placeholder={t('forgot.codePlaceholder')}
                placeholderTextColor="#9ca3af"
                keyboardType="number-pad"
                maxLength={6}
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
              />
            )}
          />
          {resetForm.formState.errors.code?.message != null && (
            <Text className="text-sm text-white">{resetForm.formState.errors.code.message}</Text>
          )}
          <Text className="-mb-3 text-xs font-medium text-white/90">
            {t('forgot.newPasswordLabel')}
          </Text>
          <Controller
            control={resetForm.control}
            name="newPassword"
            rules={{
              required: t('forgot.errPasswordLength'),
              minLength: { value: PASSWORD_MIN, message: t('forgot.errPasswordLength') },
              maxLength: { value: PASSWORD_MAX, message: t('forgot.errPasswordLength') },
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className={inputClass}
                style={inputTextColor}
                placeholder={t('forgot.newPasswordPlaceholder')}
                placeholderTextColor="#9ca3af"
                autoCapitalize="none"
                secureTextEntry
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
              />
            )}
          />
          {resetForm.formState.errors.newPassword?.message != null && (
            <Text className="text-sm text-white">
              {resetForm.formState.errors.newPassword.message}
            </Text>
          )}
          <Text className="-mb-3 text-xs font-medium text-white/90">
            {t('forgot.confirmLabel')}
          </Text>
          <Controller
            control={resetForm.control}
            name="confirm"
            rules={{
              validate: (value) =>
                value === resetForm.getValues('newPassword') || t('forgot.errConfirmMismatch'),
            }}
            render={({ field: { onChange, onBlur, value } }) => (
              <TextInput
                className={inputClass}
                style={inputTextColor}
                placeholder={t('forgot.confirmPlaceholder')}
                placeholderTextColor="#9ca3af"
                autoCapitalize="none"
                secureTextEntry
                value={value}
                onChangeText={onChange}
                onBlur={onBlur}
              />
            )}
          />
          {resetForm.formState.errors.confirm?.message != null && (
            <Text className="text-sm text-white">
              {resetForm.formState.errors.confirm.message}
            </Text>
          )}
          {apiError != null && <Text className="text-sm text-white">{apiError}</Text>}
          <Pressable
            className="h-12 items-center justify-center rounded-sm bg-ola-button active:opacity-80"
            disabled={resetting}
            onPress={resetForm.handleSubmit(confirmReset)}
          >
            {resetting ? (
              <ActivityIndicator color="#ffffff" />
            ) : (
              <Text className="text-base font-semibold text-white">
                {t('forgot.resetSubmit')}
              </Text>
            )}
          </Pressable>
          <View className="flex-row items-center justify-between">
            <Pressable disabled={sending || resendSeconds > 0} onPress={() => void resend()}>
              <Text
                className="text-sm text-white"
                style={{ opacity: sending || resendSeconds > 0 ? 0.5 : 1 }}
              >
                {resendSeconds > 0
                  ? t('forgot.resendIn', { seconds: resendSeconds })
                  : t('forgot.resend')}
              </Text>
            </Pressable>
            <Pressable onPress={backToUsername}>
              <Text className="text-sm text-white underline">{t('forgot.changeUsername')}</Text>
            </Pressable>
          </View>
          <Text className="text-xs text-white/70">{t('forgot.noEmailHint')}</Text>
        </View>
      )}

      {step === 'success' && (
        <View className="mt-2 w-full max-w-md items-center gap-2 rounded-sm bg-white p-5">
          <Text className="text-base font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('forgot.successTitle')}
          </Text>
          <Text className="text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('forgot.successDesc')}
          </Text>
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
