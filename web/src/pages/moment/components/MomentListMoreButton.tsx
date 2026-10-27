import { useTranslation } from 'react-i18next';

interface MomentListMoreButtonProps {
  loading: boolean;
  onClick: () => Promise<void>;
}

export function MomentListMoreButton({
  loading,
  onClick,
}: MomentListMoreButtonProps) {
  const { t } = useTranslation();
  return (
    <li>
      <button
        type="button"
        disabled={loading}
        onClick={() => void onClick()}
        className="w-full py-2.5 text-sm font-semibold text-ola-primary hover:bg-black/5 disabled:opacity-50"
      >
        {t('moment.viewersMore')}
      </button>
    </li>
  );
}
