import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { Trans, useTranslation } from 'react-i18next';
import olaLogo from '@/assets/images/ola-logo.png';
import { TextField } from '@/components/form/TextField';
import { SubmitButton } from '@/components/form/SubmitButton';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';
import { useAuthStore } from '@/store/authStore';

const USERNAME_RE = /^[a-z0-9._]{6,24}$/;

interface RegisterForm {
  username: string;
  password: string;
  confirm: string;
  agree: boolean;
}

export function RegisterPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const loginUser = useAuthStore((s) => s.login);
  const [loading, setLoading] = useState(false);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    getValues,
    formState: { errors },
  } = useForm<RegisterForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '', confirm: '', agree: false },
  });

  const username = watch('username');
  const password = watch('password');
  const confirm = watch('confirm');

  function onSubmit(data: RegisterForm) {
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      loginUser(data.username);
      navigate('/home');
    }, 1200);
  }

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="flex min-h-full flex-col items-center bg-ola-primary px-4 pb-8 font-sans"
    >
      <header className="flex h-12 w-full items-center text-white">
        <button
          type="button"
          onClick={() => navigate('/login')}
          className="-ml-2 px-2 text-base"
        >
          {t('common.cancel')}
        </button>
        <span className="flex-1 text-center text-base font-medium">
          {t('register.title')}
        </span>
        <LanguageSwitcher />
      </header>

      <img src={olaLogo} alt="Ola" className="my-3 mt-6 h-14 w-14 object-contain" />

      <TextField
        label={t('register.usernameLabel')}
        placeholder={t('register.usernamePlaceholder')}
        error={errors.username?.message}
        field={register('username', {
          required: t('register.errUsernameRequired'),
          pattern: {
            value: USERNAME_RE,
            message: t('register.errUsernamePattern'),
          },
        })}
        showClear={!!username}
        onClear={() => setValue('username', '', { shouldValidate: true })}
      />

      <TextField
        label={t('register.passwordLabel')}
        placeholder={t('register.passwordPlaceholder')}
        type="password"
        error={errors.password?.message}
        field={register('password', {
          required: t('register.errPasswordRequired'),
          minLength: { value: 6, message: t('register.errPasswordMin') },
        })}
        showClear={!!password}
        onClear={() => setValue('password', '', { shouldValidate: true })}
      />

      <TextField
        label={t('register.confirmLabel')}
        placeholder={t('register.confirmPlaceholder')}
        type="password"
        error={errors.confirm?.message}
        field={register('confirm', {
          required: t('register.errConfirmRequired'),
          validate: (v) =>
            v === getValues('password') || t('register.errConfirmMismatch'),
        })}
        showClear={!!confirm}
        onClear={() => setValue('confirm', '', { shouldValidate: true })}
      />

      <div className="mt-4 w-full max-w-md">
        <label className="flex cursor-pointer items-start gap-2 text-sm text-white">
          <input
            type="checkbox"
            {...register('agree', {
              required: t('register.errAgreeRequired'),
            })}
            className="mt-0.5 h-4 w-4 shrink-0 accent-ola-primary-dark"
          />
          <span>
            <Trans
              i18nKey="register.agree"
              components={{
                terms: (
                  <Link
                    to="/dieu-khoan"
                    className="font-medium text-white underline underline-offset-2"
                  />
                ),
              }}
            />
          </span>
        </label>
        {errors.agree && (
          <p className="mt-1 pl-6 text-xs font-medium text-white italic">
            {errors.agree.message}
          </p>
        )}
      </div>

      <SubmitButton className="mt-3">{t('register.submit')}</SubmitButton>

      <button
        type="button"
        onClick={() => navigate('/login')}
        className="h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        {t('register.hasAccount')}
      </button>

      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <span className="h-12 w-12 animate-spin rounded-full border-4 border-white/40 border-t-white" />
        </div>
      )}
    </form>
  );
}
