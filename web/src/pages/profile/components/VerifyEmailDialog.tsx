import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { isAllowedVerifyEmailDomain } from '@ola/shared/constants';
import { ApiError, toast } from '@lib';
import { AuthService } from '@services';
import { Dialog, DialogButton, OtpInput } from '@components';

const RESEND_SECONDS = 60;
const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

interface VerifyEmailDialogProps {
  open: boolean;
  initialEmail: string;
  onClose: () => void;
  onVerified: () => void;
}

type VerifyEmailErrorKey =
  | 'verifyEmail.errGeneric'
  | 'verifyEmail.errDomainNotAllowed'
  | 'verifyEmail.errDailyLimit'
  | 'verifyEmail.errCooldown'
  | 'verifyEmail.errTaken'
  | 'verifyEmail.errTooMany'
  | 'verifyEmail.errCodeExpired'
  | 'verifyEmail.errCodeInvalid';

function messageKey(err: unknown): VerifyEmailErrorKey {
  if (!(err instanceof ApiError)) return 'verifyEmail.errGeneric';
  const msg = err.message.toLowerCase();
  if (msg.includes('domain')) return 'verifyEmail.errDomainNotAllowed';
  if (msg.includes('daily')) return 'verifyEmail.errDailyLimit';
  if (msg.includes('wait')) return 'verifyEmail.errCooldown';
  if (msg.includes('already exists')) return 'verifyEmail.errTaken';
  if (msg.includes('too many')) return 'verifyEmail.errTooMany';
  if (msg.includes('expired') || msg.includes('invalid verification request')) return 'verifyEmail.errCodeExpired';
  if (msg.includes('invalid verification code')) return 'verifyEmail.errCodeInvalid';
  return 'verifyEmail.errGeneric';
}

export function VerifyEmailDialog({ open, initialEmail, onClose, onVerified }: VerifyEmailDialogProps) {
  const { t } = useTranslation();
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
    if (!value) {
      toast.error(t('verifyEmail.errEmailRequired'));
      return;
    }
    if (!EMAIL_PATTERN.test(value)) {
      toast.error(t('verifyEmail.errEmailInvalid'));
      return;
    }
    if (!isAllowedVerifyEmailDomain(value)) {
      toast.error(t('verifyEmail.errDomainNotAllowed'));
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
      toast.error(t(messageKey(err)));
    } finally {
      setSubmitting(false);
    }
  }

  async function confirm() {
    if (code.length !== 6) {
      toast.error(t('verifyEmail.errCodeRequired'));
      return;
    }
    setSubmitting(true);
    try {
      const result = await AuthService.confirmVerifyEmail({ verifyId, code });
      if (result.vipRewardDays != null && result.vipRewardDays > 0) {
        toast.success(t('verifyEmail.rewardToast', { days: result.vipRewardDays }));
      } else {
        toast.success(t('verifyEmail.success'));
      }
      onVerified();
      reset();
      onClose();
    } catch (err) {
      toast.error(t(messageKey(err)));
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={close}
      title={t('verifyEmail.title')}
      dismissOnBackdrop={!submitting}
      footer={
        step === 'email' ? (
          <>
            <DialogButton type="button" onClick={close} disabled={submitting}>
              {t('common.cancel')}
            </DialogButton>
            <DialogButton type="button" variant="green" onClick={sendCode} disabled={submitting}>
              {t('verifyEmail.sendCode')}
            </DialogButton>
          </>
        ) : (
          <>
            <DialogButton type="button" onClick={close} disabled={submitting}>
              {t('common.cancel')}
            </DialogButton>
            <DialogButton
              type="button"
              variant="green"
              onClick={confirm}
              disabled={submitting || code.length !== 6}
            >
              {t('verifyEmail.confirm')}
            </DialogButton>
          </>
        )
      }
    >
      {step === 'email' ? (
        <div className="flex flex-col gap-2">
          <label className="text-xs text-black/54">{t('verifyEmail.emailLabel')}</label>
          <input
            type="email"
            inputMode="email"
            autoComplete="email"
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            placeholder={t('verifyEmail.emailPlaceholder')}
            className="w-full rounded border border-black/15 bg-white px-3 py-2 text-sm text-black/87 outline-none focus:border-ola-primary"
          />
        </div>
      ) : (
        <div className="flex flex-col gap-3">
          <p className="text-xs text-black/54">{t('verifyEmail.codeSentTo', { email })}</p>
          <OtpInput value={code} onChange={setCode} disabled={submitting} autoFocus />
          <div className="flex justify-center">
            {cooldown > 0 ? (
              <span className="text-xs text-black/40">{t('verifyEmail.resendIn', { seconds: cooldown })}</span>
            ) : (
              <button
                type="button"
                onClick={sendCode}
                disabled={submitting}
                className="text-xs font-medium text-ola-primary disabled:opacity-50"
              >
                {t('verifyEmail.resend')}
              </button>
            )}
          </div>
        </div>
      )}
    </Dialog>
  );
}
