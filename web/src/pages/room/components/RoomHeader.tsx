import { useTranslation } from 'react-i18next';

interface RoomHeaderProps {
  name: string;
  onBack: () => void;
}

export function RoomHeader({ name, onBack }: RoomHeaderProps) {
  const { t } = useTranslation();

  return (
    <header className="relative flex h-12 shrink-0 items-center justify-center bg-ola-primary px-12 text-white">
      <button
        type="button"
        aria-label={t('chat.back')}
        onClick={onBack}
        className="absolute left-2 flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
      >
        <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
          <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
        </svg>
      </button>
      <span className="truncate text-base font-medium">{name}</span>
    </header>
  );
}
