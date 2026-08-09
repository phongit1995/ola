import { useTranslation } from 'react-i18next';
import composeIcon from '@/assets/icons/chat/ic_action_compose_message.png';

export function ComposeButton({ onClick }: { onClick: () => void }) {
  const { t } = useTranslation();
  return (
    <button
      type="button"
      onClick={onClick}
      aria-label={t('home.composeAria')}
      className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary shadow-lg transition hover:brightness-105"
    >
      <img src={composeIcon} alt="" className="h-6 w-6 object-contain icon-on-primary" />
    </button>
  );
}
