import { useState, type ChangeEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { ROUTES } from '@constants';
import olaLogo from '@/assets/images/ola-logo.png';
import { TextField } from '@components/form/TextField';
import { SubmitButton } from '@components/form/SubmitButton';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { USERNAME_MAX, sanitizeUsername } from '@lib';

const USERNAME_MIN = 5;

interface ForgotForm {
  username: string;
}

export function ForgotPasswordPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [submitted, setSubmitted] = useState(false);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    formState: { errors },
  } = useForm<ForgotForm>({
    mode: 'onTouched',
    defaultValues: { username: '' },
  });

  const username = watch('username');

  function handleUsernameChange(event: ChangeEvent<HTMLInputElement>) {
    setValue('username', sanitizeUsername(event.target.value), { shouldValidate: true });
  }

  function onSubmit() {
    setSubmitted(true);
  }

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="flex min-h-full flex-col items-center bg-ola-primary px-4 pb-8 font-sans"
    >
      <header className="flex h-12 w-full items-center text-white">
        <button
          type="button"
          onClick={() => navigate(ROUTES.login)}
          className="-ml-2 px-2 text-base"
        >
          {t('common.cancel')}
        </button>
        <span className="flex-1 text-center text-base font-medium">{t('forgot.title')}</span>
        <LanguageSwitcher />
      </header>

      <img src={olaLogo} alt="Ola" className="my-3 mt-6 h-14 w-14 object-contain" />

      {submitted ? (
        <div className="mt-2 w-full max-w-md rounded-sm bg-white p-5 text-center shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)]">
          <p className="text-base font-medium text-black/87">{t('forgot.doneTitle')}</p>
          <p className="mt-2 text-sm text-black/54">{t('forgot.doneDesc')}</p>
        </div>
      ) : (
        <>
          <p className="w-full max-w-md px-1 text-sm text-white/90">{t('forgot.desc')}</p>
          <TextField
            label={t('forgot.usernameLabel')}
            placeholder={t('forgot.usernamePlaceholder')}
            error={errors.username?.message}
            field={register('username', {
              onChange: handleUsernameChange,
              required: t('forgot.errUsernameRequired'),
              minLength: { value: USERNAME_MIN, message: t('forgot.errUsernameRequired') },
              maxLength: { value: USERNAME_MAX, message: t('forgot.errUsernameRequired') },
            })}
            showClear={!!username}
            onClear={() => setValue('username', '', { shouldValidate: true })}
          />
          <SubmitButton className="mt-3">{t('forgot.submit')}</SubmitButton>
        </>
      )}

      <button
        type="button"
        onClick={() => navigate(ROUTES.login)}
        className="h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        {t('forgot.backToLogin')}
      </button>
    </form>
  );
}
