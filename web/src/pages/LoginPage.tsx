import { useRef, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import olaLogo from '@/assets/ola-logo.png';

const APP_VERSION = '15240093';

/**
 * Màn hình Đăng nhập Ola — dựng lại từ `login_view_layout.xml` (OlaLoginActivity).
 * Nền xanh #7CB342, thẻ nhập trắng, nút xanh #9CCC65.
 * Nút xanh: 2 ô trống → "Tạo tài khoản Ola"; đã nhập → "Đăng nhập".
 */
export function LoginPage() {
  const navigate = useNavigate();
  const passwordRef = useRef<HTMLInputElement>(null);

  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const isEmpty = username.trim() === '' && password.trim() === '';

  function handleLogin() {
    // App thật mở socket (handshake 96 → login 206 → online 97); ở đây mô phỏng.
    setLoading(true);
    setTimeout(() => {
      setLoading(false);
      navigate('/home');
    }, 1200);
  }

  // Nút xanh: trống → sang đăng ký; đã nhập → đăng nhập.
  function handlePrimary() {
    if (isEmpty) {
      navigate('/register');
    } else {
      handleLogin();
    }
  }

  return (
    <div className="flex min-h-full flex-col items-center bg-ola-primary px-4 font-sans">
      {/* Logo Ola (mặt cười trắng) */}
      <img
        src={olaLogo}
        alt="Ola"
        className="my-4 mt-24 h-14 w-14 object-contain"
      />

      {/* Thẻ nhập (card trắng đổ bóng) */}
      <div className="w-full max-w-md overflow-hidden rounded-sm bg-white shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)]">
        <Field
          value={username}
          onChange={setUsername}
          placeholder="Tên đăng nhập"
          type="email"
          autoComplete="username"
          fontClass="text-sm"
          onClear={() => setUsername('')}
          onEnter={() => passwordRef.current?.focus()}
        />
        <div className="mx-1 h-px bg-black/12" />
        <Field
          inputRef={passwordRef}
          value={password}
          onChange={setPassword}
          placeholder="Mật khẩu"
          type="password"
          autoComplete="current-password"
          fontClass="text-base"
          onClear={() => setPassword('')}
          onEnter={handleLogin}
        />
      </div>

      {/* Nút chính (xanh) */}
      <button
        type="button"
        onClick={handlePrimary}
        className="mt-2 mb-3 h-12 w-full max-w-md rounded-sm border border-ola-primary-dark bg-ola-button text-2xl text-white transition active:border-2 hover:brightness-105"
      >
        {isEmpty ? 'Tạo tài khoản Ola' : 'Đăng nhập'}
      </button>

      {/* Link phụ */}
      <button
        type="button"
        onClick={() => navigate('/forgot-password')}
        className="w-full max-w-md py-3 text-right text-sm text-white"
      >
        Bạn quên mật khẩu?
      </button>

      <button
        type="button"
        onClick={() => navigate('/register')}
        className="mt-1 h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        Tạo tài khoản Ola
      </button>

      <button
        type="button"
        onClick={() => navigate('/register')}
        className="mt-5 h-12 w-full max-w-md text-center text-xl text-white/70"
      >
        Đăng ký bằng Facebook
      </button>

      <div className="mt-4 w-full max-w-md pb-4 text-right text-[9px] text-white/70">
        Phiên bản: {APP_VERSION}
      </div>

      {/* Overlay loading khi đang đăng nhập */}
      {loading && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/38">
          <span className="h-12 w-12 animate-spin rounded-full border-4 border-white/40 border-t-white" />
        </div>
      )}
    </div>
  );
}

interface FieldProps {
  value: string;
  onChange: (v: string) => void;
  placeholder: string;
  type: 'email' | 'password';
  autoComplete: string;
  fontClass: string;
  onClear: () => void;
  onEnter: () => void;
  inputRef?: React.RefObject<HTMLInputElement | null>;
}

/** Một ô nhập + nút × xoá (chỉ hiện khi có nội dung). */
function Field({
  value,
  onChange,
  placeholder,
  type,
  autoComplete,
  fontClass,
  onClear,
  onEnter,
  inputRef,
}: FieldProps) {
  return (
    <div className="flex items-center">
      <input
        ref={inputRef}
        type={type}
        value={value}
        autoComplete={autoComplete}
        placeholder={placeholder}
        onChange={(e) => onChange(e.target.value)}
        onKeyDown={(e) => {
          if (e.key === 'Enter') {
            e.preventDefault();
            onEnter();
          }
        }}
        className={`flex-1 bg-transparent px-4 py-4 text-black/87 outline-none placeholder:text-black/38 ${fontClass}`}
      />
      {value && (
        <button
          type="button"
          aria-label="Xoá"
          onClick={onClear}
          className="mr-1.5 flex h-9 w-9 items-center justify-center text-xl text-black/54"
        >
          ×
        </button>
      )}
    </div>
  );
}
