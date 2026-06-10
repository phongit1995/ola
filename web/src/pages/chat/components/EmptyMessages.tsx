import { useTranslation } from 'react-i18next';

export function EmptyMessages() {
  const { t } = useTranslation();
  return (
    <div className="flex flex-col gap-2 bg-white p-4">
      <p className="text-base font-medium text-gray-900">
        {t('chat.emptyMessagesTitle')}
      </p>
      <p className="text-sm text-gray-500">{t('chat.emptyMessagesBody')}</p>
    </div>
  );
}
