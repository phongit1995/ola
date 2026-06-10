import type { UseFormRegisterReturn } from 'react-hook-form';
import { ClearableInput } from './ClearableInput';

interface TextFieldProps {
  label: string;
  placeholder: string;
  type?: 'text' | 'email' | 'password';
  error?: string;
  field: UseFormRegisterReturn;
  showClear: boolean;
  onClear: () => void;
}

export function TextField({
  label,
  placeholder,
  type = 'text',
  error,
  field,
  showClear,
  onClear,
}: TextFieldProps) {
  return (
    <div className="mt-3 w-full max-w-md">
      <label className="block px-1 pb-1 text-xs font-medium tracking-wide text-white/90">
        {label}
      </label>
      <div
        className={`overflow-hidden rounded-sm bg-white shadow-[0_1px_4px_rgba(0,0,0,.24),0_0_2px_rgba(0,0,0,.12)] ${
          error ? 'ring-1 ring-ola-error' : ''
        }`}
      >
        <ClearableInput
          field={field}
          placeholder={placeholder}
          type={type}
          showClear={showClear}
          onClear={onClear}
        />
      </div>
      {error && (
        <p className="px-1 pt-1 text-xs font-medium text-white italic">{error}</p>
      )}
    </div>
  );
}
