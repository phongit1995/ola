import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import type { UseFormRegisterReturn } from 'react-hook-form';

interface ClearableInputProps {
  field: UseFormRegisterReturn;
  placeholder: string;
  type?: 'text' | 'email' | 'password';
  showClear: boolean;
  onClear: () => void;
  inputClassName?: string;
}

function EyeIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} fill="currentColor" aria-hidden="true">
      <path d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z" />
    </svg>
  );
}

function EyeOffIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} fill="currentColor" aria-hidden="true">
      <path d="M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65a3 3 0 0 0 3 3c.22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53a5 5 0 0 1-5-5c0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16a3 3 0 0 0-3-3l-.17.01z" />
    </svg>
  );
}

export function ClearableInput({
  field,
  placeholder,
  type = 'text',
  showClear,
  onClear,
  inputClassName = 'text-base',
}: ClearableInputProps) {
  const { t } = useTranslation();
  const [revealed, setRevealed] = useState(false);
  const isPassword = type === 'password';
  const inputType = isPassword && revealed ? 'text' : type;
  return (
    <div className="flex items-center">
      <input
        type={inputType}
        placeholder={placeholder}
        {...field}
        className={`flex-1 bg-transparent px-4 py-4 text-black/87 outline-none placeholder:text-black/38 ${inputClassName}`}
      />
      {isPassword
        ? showClear && (
            <button
              type="button"
              aria-label={t(revealed ? 'common.hidePassword' : 'common.showPassword')}
              tabIndex={-1}
              onClick={() => setRevealed((prev) => !prev)}
              className="mr-1.5 flex h-9 w-9 items-center justify-center text-black/54"
            >
              {revealed ? <EyeOffIcon /> : <EyeIcon />}
            </button>
          )
        : showClear && (
            <button
              type="button"
              aria-label={t('common.clear')}
              tabIndex={-1}
              onClick={onClear}
              className="mr-1.5 flex h-9 w-9 items-center justify-center text-xl text-black/54"
            >
              ×
            </button>
          )}
    </div>
  );
}
