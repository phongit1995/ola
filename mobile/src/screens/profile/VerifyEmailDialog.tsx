import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';
import { ApiError } from '@ola/shared/lib';
import { AuthService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { Dialog, DialogButton } from '../../components/Dialog';
import { OtpInput } from './OtpInput';

const RESEND_SECONDS = 60;
const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface VerifyEmailDialogProps {
  visible: boolean;
  initialEmail: string;
  onClose: () => void;
  onVerified: () => void;
}

type VerifyEmailErrorKey =
  | 'verifyEmail.errGeneric'
  | 'verifyEmail.errDailyLimit'
  | 'verifyEmail.errCooldown'
  | 'verifyEmail.errTaken'
  | 'verifyEmail.errTooMany'
  | 'verifyEmail.errCodeExpired'
  | 'verifyEmail.errCodeInvalid';

function messageKey(err: unknown): VerifyEmailErrorKey {
  if (!(err instanceof ApiError)) return 'verifyEmail.errGeneric';
  const msg = err.message.toLowerCase();
  if (msg.includes('daily')) return 'verifyEmail.errDailyLimit';
  if (msg.includes('wait')) return 'verifyEmail.errCooldown';
  if (msg.includes('already exists')) return 'verifyEmail.errTaken';
  if (msg.includes('too many')) return 'verifyEmail.errTooMany';
  if (msg.includes('expired') || msg.includes('invalid verification request')) return 'verifyEmail.errCodeExpired';
  if (msg.includes('invalid verification code')) return 'verifyEmail.errCodeInvalid';
  return 'verifyEmail.errGeneric';
}

export function VerifyEmailDialog({ visible, initialEmail, onClose, onVerified }: VerifyEmailDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [step, setStep] = useState<'email' | 'code'>('email');
  const [email, setEmail] = useState(initialEmail);
  const [verifyId, setVerifyId] = useState('');
  const [code, setCode] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [cooldown, setCooldown] = useState(0);

  useEffect(() => {
    if (cooldown <= 0) return;
    const id = setInterval(() => setCooldown((s) => Math.max(0, s - 1)), 1000);
    return () => clearInterval(id);
  }, [cooldown]);

  function reset() {
    setStep('email');
    setEmail(initialEmail);
    setVerifyId('');
    setCode('');
    setCooldown(0);
  }

  function close() {
    if (submitting) return;
    reset();
    onClose();
  }

  async function sendCode() {
    const value = email.trim().toLowerCase();
    if (value === '') {
      push('error', t('verifyEmail.errEmailRequired'));
      return;
    }
    if (!EMAIL_PATTERN.test(value)) {
      push('error', t('verifyEmail.errEmailInvalid'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await AuthService.sendVerifyEmail({ email: value });
      setVerifyId(result.verifyId);
      setEmail(value);
      setCode('');
      setStep('code');
      setCooldown(RESEND_SECONDS);
    } catch (err) {
      push('error', t(messageKey(err)));
    } finally {
      setSubmitting(false);
    }
  }

  async function confirm() {
    if (code.length !== 6) {
      push('error', t('verifyEmail.errCodeRequired'));
      return;
    }
    setSubmitting(true);
    try {
      await AuthService.confirmVerifyEmail({ verifyId, code });
      push('success', t('verifyEmail.success'));
      onVerified();
      reset();
      onClose();
    } catch (err) {
      push('error', t(messageKey(err)));
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog
      visible={visible}
      title={t('verifyEmail.title')}
      onClose={close}
      dismissOnBackdrop={!submitting}
      footer={
        step === 'email' ? (
          <>
            <DialogButton onPress={close} disabled={submitting}>
              {t('common.cancel')}
            </DialogButton>
            <DialogButton variant="green" onPress={() => void sendCode()} disabled={submitting}>
              {t('verifyEmail.sendCode')}
            </DialogButton>
          </>
        ) : (
          <>
            <DialogButton onPress={close} disabled={submitting}>
              {t('common.cancel')}
            </DialogButton>
            <DialogButton
              variant="green"
              onPress={() => void confirm()}
              disabled={submitting || code.length !== 6}
            >
              {t('verifyEmail.confirm')}
            </DialogButton>
          </>
        )
      }
    >
      {step === 'email' ? (
        <View className="gap-2">
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>{t('verifyEmail.emailLabel')}</Text>
          <TextInput
            value={email}
            onChangeText={setEmail}
            keyboardType="email-address"
            autoCapitalize="none"
            autoCorrect={false}
            placeholder={t('verifyEmail.emailPlaceholder')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            className="rounded bg-white px-3 py-2 text-sm"
            style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.15)', color: 'rgba(0,0,0,0.87)' }}
          />
        </View>
      ) : (
        <View className="gap-3">
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('verifyEmail.codeSentTo', { email })}
          </Text>
          <OtpInput value={code} onChange={setCode} disabled={submitting} autoFocus />
          <View className="items-center">
            {cooldown > 0 ? (
              <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                {t('verifyEmail.resendIn', { seconds: cooldown })}
              </Text>
            ) : (
              <Pressable onPress={() => void sendCode()} disabled={submitting}>
                <Text className="text-xs font-medium text-ola-primary" style={{ opacity: submitting ? 0.5 : 1 }}>
                  {t('verifyEmail.resend')}
                </Text>
              </Pressable>
            )}
          </View>
        </View>
      )}
    </Dialog>
  );
}
