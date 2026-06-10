import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import olaLogo from '@/assets/ola-logo.png';

const USERNAME_RE = /^[a-z0-9._]{6,24}$/;

function validateUsername(v: string): string | null {
  if (v.length < 6 || v.length > 24) return 'Tên đăng nhập phải 6–24 ký tự.';
  if (!USERNAME_RE.test(v))
    return 'Chỉ dùng chữ thường, số, dấu . và _ (không khoảng trắng).';
  return null;
}

function validatePassword(v: string): string | null {
  if (v.length < 6) return 'Mật khẩu ít nhất 6 ký tự.';
  return null;
}

/**
 * Màn hình Đăng ký Ola — form tạo tài khoản: tên đăng nhập, mật khẩu,
 * nhập lại mật khẩu. Giữ phong cách nền xanh + thẻ trắng giống màn login,
 * header dạng action bar (Huỷ · "Tạo tài khoản Ola").
 */
export function RegisterPage() {
  const navigate = useNavigate();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [agreed, setAgreed] = useState(false);
  const [triedSubmit, setTriedSubmit] = useState(false);
  const [touched, setTouched] = useState({
    username: false,
    password: false,
    confirm: false,
  });
  const [loading, setLoading] = useState(false);

  const errors = {
    username: validateUsername(username),
    password: validatePassword(password),
    confirm: confirm !== password ? 'Mật khẩu nhập lại không khớp.' : null,
  };

  function handleRegister() {
    setTriedSubmit(true);
    setTouched({ username: true, password: true, confirm: true });
    if (errors.username || errors.password || errors.confirm || !agreed) return;
    // App thật xác thực SĐT qua Facebook AccountKit; ở đây mô phỏng tạo tài khoản.
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      navigate('/home');
    }, 1200);
  }

  return (
    <div className="flex min-h-full flex-col items-center bg-ola-primary px-4 pb-8 font-sans">
      {/* Header (action bar): Huỷ trái · tiêu đề giữa */}
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

      {/* Logo Ola (mặt cười trắng) */}
      <img src={olaLogo} alt="Ola" className="my-3 mt-6 h-14 w-14 object-contain" />

      {/* Tên đăng nhập */}
      <Field
        label="TÊN ĐĂNG NHẬP"
        value={username}
        onChange={setUsername}
        placeholder="6–24 ký tự, chữ thường và số (a–z, 0–9, . _)"
        type="text"
        autoComplete="username"
        onBlur={() => setTouched((t) => ({ ...t, username: true }))}
        error={touched.username ? errors.username : null}
      />

      {/* Mật khẩu */}
      <Field
        label="MẬT KHẨU"
        value={password}
        onChange={setPassword}
        placeholder="Ít nhất 6 ký tự"
        type="password"
        autoComplete="new-password"
        onBlur={() => setTouched((t) => ({ ...t, password: true }))}
        error={touched.password ? errors.password : null}
      />

      {/* Nhập lại mật khẩu */}
      <Field
        label="NHẬP LẠI MẬT KHẨU"
        value={confirm}
        onChange={setConfirm}
        placeholder="Nhập lại mật khẩu"
        type="password"
        autoComplete="new-password"
        onBlur={() => setTouched((t) => ({ ...t, confirm: true }))}
        onEnter={handleRegister}
        error={touched.confirm ? errors.confirm : null}
      />

      {/* Đồng ý điều khoản */}
      <div className="mt-4 w-full max-w-md">
        <label className="flex cursor-pointer items-start gap-2 text-sm text-white">
          <input
            type="checkbox"
            checked={agreed}
            onChange={(e) => setAgreed(e.target.checked)}
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
        {triedSubmit && !agreed && (
          <p className="mt-1 pl-6 text-xs font-medium text-white italic">
            Bạn cần đồng ý với Điều khoản sử dụng để tiếp tục.
          </p>
        )}
      </div>

      {/* Nút chính (xanh) — giống nút login */}
      <button
        type="button"
        onClick={handleRegister}
        className="mt-3 mb-3 h-12 w-full max-w-md rounded-sm border border-ola-primary-dark bg-ola-button text-2xl text-white transition hover:brightness-105 active:border-2"
      >
        Hoàn tất
      </button>

      {/* Link phụ */}
      <button
        type="button"
        onClick={() => navigate('/login')}
        className="h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        Đã có tài khoản?
      </button>

      {/* Overlay loading */}
      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <span className="h-12 w-12 animate-spin rounded-full border-4 border-white/40 border-t-white" />
        </div>
      )}
    </div>
  );
}

interface FieldProps {
  label: string;
  value: string;
  onChange: (v: string) => void;
  placeholder: string;
  type: 'text' | 'password';
  autoComplete: string;
  onBlur: () => void;
  hints?: string[];
  error?: string | null;
  onEnter?: () => void;
}

/** Một nhóm: nhãn (chữ trắng) + ô nhập trắng + hint/lỗi. */
function Field({
  label,
  value,
  onChange,
  placeholder,
  type,
  autoComplete,
  onBlur,
  hints,
  error,
  onEnter,
}: FieldProps) {
  return (
    <div className="mt-3 w-full max-w-md">
      <label className="block px-1 pb-1 text-xs font-medium tracking-wide text-white/90">
        {label}
      </label>
      <div
        className={`flex items-center overflow-hidden rounded-sm bg-white shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)] ${
          error ? 'ring-1 ring-ola-error' : ''
        }`}
      >
        <input
          type={type}
          value={value}
          placeholder={placeholder}
          autoComplete={autoComplete}
          onChange={(e) => onChange(e.target.value)}
          onBlur={onBlur}
          onKeyDown={(e) => {
            if (e.key === 'Enter' && onEnter) {
              e.preventDefault();
              onEnter();
            }
          }}
          className="flex-1 bg-transparent px-4 py-4 text-sm text-black/87 outline-none placeholder:text-black/38"
        />
        {value && (
          <button
            type="button"
            aria-label="Xoá"
            onClick={() => onChange('')}
            className="mr-1.5 flex h-9 w-9 items-center justify-center text-xl text-black/54"
          >
            ×
          </button>
        )}
      </div>

      {/* Lỗi (đỏ-trắng) hoặc hint (trắng mờ) — chỉ hiện khi có nội dung */}
      {(error || hints?.length) && (
        <div className="px-1 pt-1 text-xs">
          {error ? (
            <p className="font-medium text-white italic">{error}</p>
          ) : (
            hints?.map((h) => (
              <p key={h} className="text-white/70">
                {h}
              </p>
            ))
          )}
        </div>
      )}
    </div>
  );
}
