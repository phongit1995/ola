import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { Trans, useTranslation } from 'react-i18next';
import { PASSWORD_MAX, PASSWORD_MIN, ROUTES } from '@constants';
import olaLogo from '@/assets/images/ola-logo.png';
import { TextField } from '@components/form/TextField';
import { SubmitButton } from '@components/form/SubmitButton';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { AppDownloadBar, Spinner } from '@components';
import { AuthService } from '@services';
import {
  ApiError,
  resolveAuthError,
  USERNAME_MAX,
  USERNAME_PATTERN,
  toast,
} from '@lib';
import { USERNAME_MIN } from './constants';

interface RegisterForm {
  username: string;
  password: string;
  confirm: string;
  agree: boolean;
}

export function RegisterPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [loading, setLoading] = useState(false);
  const [submitError, setSubmitError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    setError,
    getValues,
    formState: { errors },
  } = useForm<RegisterForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '', confirm: '', agree: false },
  });

  const username = watch('username');
  const password = watch('password');
  const confirm = watch('confirm');

  async function onSubmit(data: RegisterForm) {
    setLoading(true);
    setSubmitError(null);
    try {
      await AuthService.register({
        username: data.username,
        password: data.password,
      });
      toast.success(t('register.success'));
      navigate(ROUTES.login);
    } catch (err) {
      if (err instanceof ApiError && err.status === 409) {
        const message = t('register.errUsernameTaken');
        setError('username', { message });
        setSubmitError(message);
        toast.error(message);
        return;
      }
      const message = resolveAuthError(err, t);
      setSubmitError(message);
      toast.error(message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="flex min-h-full flex-col items-center bg-ola-primary px-4 pb-8 font-sans"
    >
      <header className="flex h-12 w-full items-center text-ola-on-primary">
        <button
          type="button"
          onClick={() => navigate(ROUTES.login)}
          className="-ml-2 px-2 text-base"
        >
          {t('common.cancel')}
        </button>
        <span className="flex-1 text-center text-lg font-medium">
          {t('register.title')}
        </span>
        <LanguageSwitcher />
      </header>

      <img
        src={olaLogo}
        alt="Ola"
        className="my-3 mt-6 h-14 w-14 object-contain"
      />

      <TextField
        label={t('register.usernameLabel')}
        placeholder={t('register.usernamePlaceholder')}
        error={errors.username?.message}
        field={register('username', {
          required: t('register.errUsernameRequired'),
          minLength: {
            value: USERNAME_MIN,
            message: t('register.errUsernameMin'),
          },
          maxLength: {
            value: USERNAME_MAX,
            message: t('register.errUsernameMax'),
          },
          pattern: {
            value: USERNAME_PATTERN,
            message: t('register.errUsernameFormat'),
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
          minLength: {
            value: PASSWORD_MIN,
            message: t('register.errPasswordMin'),
          },
          maxLength: {
            value: PASSWORD_MAX,
            message: t('register.errPasswordMax'),
          },
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
        <label className="flex cursor-pointer items-start gap-2 text-sm text-ola-on-primary">
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
                    to={ROUTES.terms}
                    className="font-medium text-ola-on-primary underline underline-offset-2"
                  />
                ),
                privacy: (
                  <Link
                    to={ROUTES.privacy}
                    className="font-medium text-ola-on-primary underline underline-offset-2"
                  />
                ),
              }}
            />
          </span>
        </label>
        {errors.agree && (
          <p className="mt-1 pl-6 text-xs font-medium text-ola-on-primary italic">
            {errors.agree.message}
          </p>
        )}
      </div>

      {submitError && (
        <p className="mt-3 w-full max-w-md text-sm font-medium text-ola-on-primary italic">
          {submitError}
        </p>
      )}

      <SubmitButton className="mt-3">{t('register.submit')}</SubmitButton>

      <button
        type="button"
        onClick={() => navigate(ROUTES.login)}
        className="h-12 w-full max-w-md text-center text-xl text-ola-on-primary/70"
      >
        {t('register.hasAccount')}
      </button>

      <AppDownloadBar className="mt-auto pt-8" />

      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <Spinner size={48} thickness={4} tone="light" />
        </div>
      )}
    </form>
  );
}
