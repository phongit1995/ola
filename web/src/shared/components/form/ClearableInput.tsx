import type { UseFormRegisterReturn } from 'react-hook-form';

interface ClearableInputProps {
  field: UseFormRegisterReturn;
  placeholder: string;
  type?: 'text' | 'email' | 'password';
  showClear: boolean;
  onClear: () => void;
  inputClassName?: string;
}

export function ClearableInput({
  field,
  placeholder,
  type = 'text',
  showClear,
  onClear,
  inputClassName = 'text-sm',
}: ClearableInputProps) {
  return (
    <div className="flex items-center">
      <input
        type={type}
        placeholder={placeholder}
        {...field}
        className={`flex-1 bg-transparent px-4 py-4 text-black/87 outline-none placeholder:text-black/38 ${inputClassName}`}
      />
      {showClear && (
        <button
          type="button"
          aria-label="Xoá"
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
