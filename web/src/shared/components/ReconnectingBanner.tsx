import { useTranslation } from 'react-i18next';
import { useConnectionStatus } from '@hooks';
import { Spinner } from './ui/Spinner';

export function ReconnectingBanner() {
  const { t } = useTranslation();
  const status = useConnectionStatus();
  if (status !== 'reconnecting') return null;
  return (
    <div className="pointer-events-none absolute inset-x-0 top-0 z-50 flex justify-center p-2">
      <div className="pointer-events-auto flex items-center gap-2 rounded-full bg-black/75 px-3 py-1 text-sm text-white shadow-lg">
        <Spinner size={14} tone="light" />
        {t('connection.reconnecting')}
      </div>
    </div>
  );
}
