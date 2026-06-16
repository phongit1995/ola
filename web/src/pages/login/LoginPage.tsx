import { useState, type ChangeEvent } from 'react';
import { useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { useTranslation } from 'react-i18next';
import { PASSWORD_MAX, PASSWORD_MIN, ROUTES } from '@constants';
import olaLogo from '@/assets/images/ola-logo.png';
import { ClearableInput } from '@components/form/ClearableInput';
import { SubmitButton } from '@components/form/SubmitButton';
import { LanguageSwitcher } from '@components/LanguageSwitcher';
import { AuthService } from '@services';
import { ApiError, USERNAME_MAX, sanitizeUsername, toast } from '@lib';
import { useAuthStore } from '@/store/authStore';

const APP_VERSION = '15240093';
const USERNAME_MIN = 5;

interface LoginForm {
  username: string;
  password: string;
}

export function LoginPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const setUser = useAuthStore((s) => s.setUser);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    watch,
    setValue,
    formState: { errors },
  } = useForm<LoginForm>({
    mode: 'onTouched',
    defaultValues: { username: '', password: '' },
  });

  const username = watch('username');
  const password = watch('password');

  function clearError() {
    if (error) {
      setError(null);
    }
  }

  function handleUsernameChange(event: ChangeEvent<HTMLInputElement>) {
    setValue('username', sanitizeUsername(event.target.value), { shouldValidate: true });
    clearError();
  }

  async function onSubmit(data: LoginForm) {
    setLoading(true);
    setError(null);
    try {
      const { user } = await AuthService.login(data);
      setUser(user);
      navigate(ROUTES.home);
    } catch (err) {
      const message = err instanceof ApiError ? err.message : t('auth.errGeneric');
      setError(message);
      toast.error(message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <form
      onSubmit={handleSubmit(onSubmit)}
      className="flex min-h-full flex-col items-center bg-ola-primary px-4 font-sans"
    >
      <LanguageSwitcher className="mt-3 self-end" />

      <img
        src={olaLogo}
        alt="Ola"
        className="mt-8 mb-4 h-14 w-14 object-contain"
      />

      <div
        className={`w-full max-w-md overflow-hidden rounded-sm bg-white shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)] ${
          errors.username || errors.password ? 'ring-1 ring-ola-error' : ''
        }`}
      >
        <ClearableInput
          field={register('username', {
            onChange: handleUsernameChange,
            required: t('login.errUsernameRequired'),
            minLength: { value: USERNAME_MIN, message: t('login.errUsernameLength') },
            maxLength: { value: USERNAME_MAX, message: t('login.errUsernameLength') },
          })}
          placeholder={t('login.username')}
          type="text"
          inputClassName="text-sm"
          showClear={!!username}
          onClear={() => setValue('username', '', { shouldValidate: true })}
        />
        <div className="mx-1 h-px bg-black/12" />
        <ClearableInput
          field={register('password', {
            onChange: clearError,
            required: t('login.errPasswordRequired'),
            minLength: { value: PASSWORD_MIN, message: t('login.errPasswordLength') },
            maxLength: { value: PASSWORD_MAX, message: t('login.errPasswordLength') },
          })}
          placeholder={t('login.password')}
          type="password"
          inputClassName="text-base"
          showClear={!!password}
          onClear={() => setValue('password', '')}
        />
      </div>

      {(errors.username || errors.password || error) && (
        <div className="mt-2 w-full max-w-md space-y-0.5 text-sm font-medium text-white italic">
          {errors.username && <p>{errors.username.message}</p>}
          {errors.password && <p>{errors.password.message}</p>}
          {error && <p>{error}</p>}
        </div>
      )}

      <SubmitButton className="mt-2">{t('login.submit')}</SubmitButton>

      <button
        type="button"
        onClick={() => navigate(ROUTES.forgotPassword)}
        className="w-full max-w-md py-3 text-right text-sm text-white"
      >
        {t('login.forgot')}
      </button>

      <button
        type="button"
        onClick={() => navigate(ROUTES.register)}
        className="mt-1 h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        {t('login.createAccount')}
      </button>

      <div className="mt-5 w-full max-w-md pb-4 text-right text-[9px] text-white/70">
        {t('login.version')}: {APP_VERSION}
      </div>

      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <span className="h-12 w-12 animate-spin rounded-full border-4 border-white/40 border-t-white" />
        </div>
      )}
    </form>
  );
}
