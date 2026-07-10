import { useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { KeyboardAvoidingView, Modal, Platform, Pressable, Text, TextInput, View } from 'react-native';
import { PASSWORD_MAX, PASSWORD_MIN } from '@ola/shared/constants';
import { ApiError } from '@ola/shared/lib';
import { AuthService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';

interface ChangePasswordForm {
  current: string;
  next: string;
  confirm: string;
}

function PasswordField({
  placeholder,
  error,
  value,
  onChangeText,
  onBlur,
}: {
  placeholder: string;
  error?: string;
  value: string;
  onChangeText: (text: string) => void;
  onBlur: () => void;
}) {
  const [focused, setFocused] = useState(false);
  return (
    <View>
      <TextInput
        secureTextEntry
        autoCapitalize="none"
        placeholder={placeholder}
        placeholderTextColor="rgba(0,0,0,0.38)"
        value={value}
        onChangeText={onChangeText}
        onFocus={() => setFocused(true)}
        onBlur={() => {
          setFocused(false);
          onBlur();
        }}
        className="rounded bg-white px-3 py-2 text-sm"
        style={{
          borderWidth: 1,
          borderColor: focused ? '#7cb342' : 'rgba(0,0,0,0.15)',
          color: 'rgba(0,0,0,0.87)',
        }}
      />
      {error != null && (
        <Text className="mt-1 text-xs" style={{ color: '#e34545' }}>{error}</Text>
      )}
    </View>
  );
}

export function ChangePasswordDialog({ visible, onClose }: { visible: boolean; onClose: () => void }) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [submitting, setSubmitting] = useState(false);
  const {
    control,
    handleSubmit,
    reset,
    getValues,
    setError,
    formState: { errors },
  } = useForm<ChangePasswordForm>({
    mode: 'onTouched',
    defaultValues: { current: '', next: '', confirm: '' },
  });

  function close() {
    if (submitting) return;
    reset();
    onClose();
  }

  async function onSubmit(data: ChangePasswordForm) {
    setSubmitting(true);
    try {
      await AuthService.changePassword({ currentPassword: data.current, newPassword: data.next });
      push('success', t('changePassword.success'));
      reset();
      onClose();
    } catch (err) {
      const wrongCurrent = err instanceof ApiError && /current password/i.test(err.message);
      const message = wrongCurrent ? t('changePassword.errCurrentWrong') : t('changePassword.errGeneric');
      if (wrongCurrent) setError('current', { message });
      push('error', message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={close}>
      <KeyboardAvoidingView className="flex-1" behavior={Platform.OS === 'ios' ? 'padding' : undefined}>
      <Pressable className="flex-1 items-center justify-center bg-black/40 px-8" onPress={close}>
        <Pressable className="w-full max-w-md rounded-2xl bg-white p-4" onPress={() => undefined}>
          <Text className="mb-3 text-base font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {t('changePassword.title')}
          </Text>
          <View className="gap-3">
            <Controller
              control={control}
              name="current"
              rules={{ required: t('changePassword.errCurrentRequired') }}
              render={({ field }) => (
                <PasswordField
                  placeholder={t('changePassword.currentPlaceholder')}
                  error={errors.current?.message}
                  value={field.value}
                  onChangeText={field.onChange}
                  onBlur={field.onBlur}
                />
              )}
            />
            <Controller
              control={control}
              name="next"
              rules={{
                required: t('changePassword.errNewRequired'),
                minLength: { value: PASSWORD_MIN, message: t('changePassword.errNewMin', { min: PASSWORD_MIN }) },
                maxLength: { value: PASSWORD_MAX, message: t('changePassword.errNewMax', { max: PASSWORD_MAX }) },
                validate: (value) => value !== getValues('current') || t('changePassword.errSameAsOld'),
              }}
              render={({ field }) => (
                <PasswordField
                  placeholder={t('changePassword.newPlaceholder')}
                  error={errors.next?.message}
                  value={field.value}
                  onChangeText={field.onChange}
                  onBlur={field.onBlur}
                />
              )}
            />
            <Controller
              control={control}
              name="confirm"
              rules={{
                required: t('changePassword.errConfirmRequired'),
                validate: (value) => value === getValues('next') || t('changePassword.errConfirmMismatch'),
              }}
              render={({ field }) => (
                <PasswordField
                  placeholder={t('changePassword.confirmPlaceholder')}
                  error={errors.confirm?.message}
                  value={field.value}
                  onChangeText={field.onChange}
                  onBlur={field.onBlur}
                />
              )}
            />
          </View>
          <View className="mt-4 flex-row justify-end gap-2">
            <Pressable onPress={close} disabled={submitting} className="rounded-full px-4 py-2">
              <Text className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('common.cancel')}
              </Text>
            </Pressable>
            <Pressable
              onPress={handleSubmit(onSubmit)}
              disabled={submitting}
              className="rounded-full px-4 py-2"
              style={{ backgroundColor: '#7cb342', opacity: submitting ? 0.6 : 1 }}
            >
              <Text className="text-sm font-semibold text-white">{t('changePassword.submit')}</Text>
            </Pressable>
          </View>
        </Pressable>
      </Pressable>
      </KeyboardAvoidingView>
    </Modal>
  );
}
