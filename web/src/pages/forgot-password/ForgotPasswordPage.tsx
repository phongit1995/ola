import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { PASSWORD_MAX, PASSWORD_MIN, ROUTES } from '@constants';
import olaLogo from '@/assets/images/ola-logo.png';
import { TextField } from '@components/form/TextField';
import { SubmitButton } from '@components/form/SubmitButton';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import {
  FORGOT_CODE_PATTERN,
  FORGOT_RESEND_COOLDOWN_SECONDS,
  resolveForgotConfirmError,
  resolveForgotSendError,
  USERNAME_MAX,
  USERNAME_PATTERN,
} from '@lib';
import { AuthService } from '@services';
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

export function ForgotPasswordPage() {
  const navigate = useNavigate();
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

  const usernameValue = usernameForm.watch('username');
  const codeValue = resetForm.watch('code');
  const newPasswordValue = resetForm.watch('newPassword');
  const confirmValue = resetForm.watch('confirm');

  async function sendCode(values: UsernameForm) {
    if (sending) return;
    setSending(true);
    setApiError(null);
    const name = values.username.trim().toLowerCase();
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
    <div className="flex min-h-full flex-col items-center bg-ola-primary px-4 pb-8 font-sans">
      <header className="flex h-12 w-full items-center text-ola-on-primary">
        <button
          type="button"
          onClick={() => navigate(ROUTES.login)}
          className="-ml-2 px-2 text-base"
        >
          {t('common.cancel')}
        </button>
        <span className="flex-1 text-center text-lg font-medium">
          {t('forgot.title')}
        </span>
        <LanguageSwitcher />
      </header>

      <img
        src={olaLogo}
        alt="Ola"
        className="my-3 mt-6 h-14 w-14 object-contain"
      />

      {step === 'username' && (
        <form
          onSubmit={usernameForm.handleSubmit(sendCode)}
          className="flex w-full flex-col items-center"
        >
          <p className="w-full max-w-md px-1 text-sm text-ola-on-primary/90">
            {t('forgot.desc')}
          </p>
          <TextField
            label={t('forgot.usernameLabel')}
            placeholder={t('forgot.usernamePlaceholder')}
            error={usernameForm.formState.errors.username?.message}
            field={usernameForm.register('username', {
              required: t('forgot.errUsernameRequired'),
              minLength: {
                value: USERNAME_MIN,
                message: t('forgot.errUsernameRequired'),
              },
              maxLength: {
                value: USERNAME_MAX,
                message: t('forgot.errUsernameRequired'),
              },
              pattern: {
                value: USERNAME_PATTERN,
                message: t('forgot.errUsernameFormat'),
              },
            })}
            showClear={!!usernameValue}
            onClear={() =>
              usernameForm.setValue('username', '', { shouldValidate: true })
            }
          />
          {apiError && (
            <p className="w-full max-w-md px-1 pt-1 text-sm font-medium text-ola-on-primary italic">
              {apiError}
            </p>
          )}
          <SubmitButton className="mt-3">
            {sending ? t('common.loading') : t('forgot.submit')}
          </SubmitButton>
        </form>
      )}

      {step === 'code' && (
        <form
          onSubmit={resetForm.handleSubmit(confirmReset)}
          className="flex w-full flex-col items-center"
        >
          <p className="w-full max-w-md px-1 text-base font-medium text-ola-on-primary">
            {t('forgot.codeSentTitle')}
          </p>
          <p className="mt-1 w-full max-w-md px-1 text-sm text-ola-on-primary/90">
            {t('forgot.codeSentDesc', { username })}
          </p>
          <TextField
            label={t('forgot.codeLabel')}
            placeholder={t('forgot.codePlaceholder')}
            error={resetForm.formState.errors.code?.message}
            field={resetForm.register('code', {
              required: t('forgot.errCodeFormat'),
              pattern: {
                value: FORGOT_CODE_PATTERN,
                message: t('forgot.errCodeFormat'),
              },
            })}
            showClear={!!codeValue}
            onClear={() => resetForm.setValue('code', '', { shouldValidate: true })}
          />
          <TextField
            label={t('forgot.newPasswordLabel')}
            placeholder={t('forgot.newPasswordPlaceholder')}
            type="password"
            error={resetForm.formState.errors.newPassword?.message}
            field={resetForm.register('newPassword', {
              required: t('forgot.errPasswordLength'),
              minLength: {
                value: PASSWORD_MIN,
                message: t('forgot.errPasswordLength'),
              },
              maxLength: {
                value: PASSWORD_MAX,
                message: t('forgot.errPasswordLength'),
              },
            })}
            showClear={!!newPasswordValue}
            onClear={() =>
              resetForm.setValue('newPassword', '', { shouldValidate: true })
            }
          />
          <TextField
            label={t('forgot.confirmLabel')}
            placeholder={t('forgot.confirmPlaceholder')}
            type="password"
            error={resetForm.formState.errors.confirm?.message}
            field={resetForm.register('confirm', {
              validate: (value) =>
                value === resetForm.getValues('newPassword') ||
                t('forgot.errConfirmMismatch'),
            })}
            showClear={!!confirmValue}
            onClear={() =>
              resetForm.setValue('confirm', '', { shouldValidate: true })
            }
          />
          {apiError && (
            <p className="w-full max-w-md px-1 pt-1 text-sm font-medium text-ola-on-primary italic">
              {apiError}
            </p>
          )}
          <SubmitButton className="mt-3">
            {resetting ? t('common.loading') : t('forgot.resetSubmit')}
          </SubmitButton>
          <div className="flex w-full max-w-md items-center justify-between px-1">
            <button
              type="button"
              disabled={sending || resendSeconds > 0}
              onClick={() => void resend()}
              className="text-sm text-ola-on-primary disabled:opacity-50"
            >
              {resendSeconds > 0
                ? t('forgot.resendIn', { seconds: resendSeconds })
                : t('forgot.resend')}
            </button>
            <button
              type="button"
              onClick={backToUsername}
              className="text-sm text-ola-on-primary underline"
            >
              {t('forgot.changeUsername')}
            </button>
          </div>
          <p className="mt-3 w-full max-w-md px-1 text-xs text-ola-on-primary/70">
            {t('forgot.noEmailHint')}
          </p>
        </form>
      )}

      {step === 'success' && (
        <div className="mt-2 w-full max-w-md rounded-sm bg-white p-5 text-center shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)]">
          <p className="text-base font-medium text-black/87">
            {t('forgot.successTitle')}
          </p>
          <p className="mt-2 text-sm text-black/54">{t('forgot.successDesc')}</p>
        </div>
      )}

      <button
        type="button"
        onClick={() => navigate(ROUTES.login)}
        className="h-12 w-full max-w-md text-center text-xl text-ola-on-primary/70"
      >
        {t('forgot.backToLogin')}
      </button>
    </div>
  );
}
