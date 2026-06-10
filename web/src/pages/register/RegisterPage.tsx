import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import olaLogo from '@/assets/images/ola-logo.png';
import { TextField } from '@/components/form/TextField';
import { SubmitButton } from '@/components/form/SubmitButton';
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
          Huỷ
        </button>
        <span className="flex-1 text-center text-base font-medium">
          Tạo tài khoản Ola
        </span>
        <span className="w-12" />
      </header>

      <img src={olaLogo} alt="Ola" className="my-3 mt-6 h-14 w-14 object-contain" />

      <TextField
        label="TÊN ĐĂNG NHẬP"
        placeholder="6–24 ký tự, chữ thường và số (a–z, 0–9, . _)"
        error={errors.username?.message}
        field={register('username', {
          required: 'Vui lòng nhập tên đăng nhập.',
          pattern: {
            value: USERNAME_RE,
            message: '6–24 ký tự, chỉ chữ thường, số, dấu . và _.',
          },
        })}
        showClear={!!username}
        onClear={() => setValue('username', '', { shouldValidate: true })}
      />

      <TextField
        label="MẬT KHẨU"
        placeholder="Ít nhất 6 ký tự"
        type="password"
        error={errors.password?.message}
        field={register('password', {
          required: 'Vui lòng nhập mật khẩu.',
          minLength: { value: 6, message: 'Mật khẩu ít nhất 6 ký tự.' },
        })}
        showClear={!!password}
        onClear={() => setValue('password', '', { shouldValidate: true })}
      />

      <TextField
        label="NHẬP LẠI MẬT KHẨU"
        placeholder="Nhập lại mật khẩu"
        type="password"
        error={errors.confirm?.message}
        field={register('confirm', {
          required: 'Vui lòng nhập lại mật khẩu.',
          validate: (v) =>
            v === getValues('password') || 'Mật khẩu nhập lại không khớp.',
        })}
        showClear={!!confirm}
        onClear={() => setValue('confirm', '', { shouldValidate: true })}
      />

      <div className="mt-4 w-full max-w-md">
        <label className="flex cursor-pointer items-start gap-2 text-sm text-white">
          <input
            type="checkbox"
            {...register('agree', {
              required: 'Bạn cần đồng ý với Điều khoản sử dụng để tiếp tục.',
            })}
            className="mt-0.5 h-4 w-4 shrink-0 accent-ola-primary-dark"
          />
          <span>
            Tôi đồng ý với{' '}
            <Link
              to="/dieu-khoan"
              className="font-medium text-white underline underline-offset-2"
            >
              Điều khoản sử dụng
            </Link>{' '}
            của Ola
          </span>
        </label>
        {errors.agree && (
          <p className="mt-1 pl-6 text-xs font-medium text-white italic">
            {errors.agree.message}
          </p>
        )}
      </div>

      <SubmitButton className="mt-3">Hoàn tất</SubmitButton>

      <button
        type="button"
        onClick={() => navigate('/login')}
        className="h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        Đã có tài khoản?
      </button>

      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <span className="h-12 w-12 animate-spin rounded-full border-4 border-white/40 border-t-white" />
        </div>
      )}
    </form>
  );
}
