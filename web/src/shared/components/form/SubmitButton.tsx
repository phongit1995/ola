interface SubmitButtonProps {
  children: React.ReactNode;
  className?: string;
}

export function SubmitButton({ children, className = '' }: SubmitButtonProps) {
  return (
    <button
      type="submit"
      className={`mb-3 h-12 w-full max-w-md rounded-sm border border-ola-primary-dark bg-ola-button text-2xl text-white transition hover:brightness-105 active:border-2 ${className}`}
    >
      {children}
    </button>
  );
}
