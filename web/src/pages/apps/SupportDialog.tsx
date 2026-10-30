import { useTranslation } from 'react-i18next';
import { Dialog } from '@components';
import { SUPPORT_ACCOUNT_USERNAME, SUPPORT_EMAIL } from '@ola/shared/constants';
import supportIcon from '@/assets/icons/apps/support.png';
import { ExternalLinkIcon } from './ExternalLinkIcon';

export function SupportDialog({
  open,
  onClose,
}: {
  open: boolean;
  onClose: () => void;
}) {
  const { t } = useTranslation();

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('support.title')}
      showClose
      icon={<img src={supportIcon} alt="" className="h-8 w-8" />}
    >
      <div className="-m-2 text-base font-semibold text-black/85">
        <p className="flex min-h-16 items-center gap-1 border-b border-black/8 px-4 py-2">
          {t('support.contactAccount')}
          <span className="text-ola-accent">@{SUPPORT_ACCOUNT_USERNAME}</span>
        </p>
        <a
          href={`mailto:${SUPPORT_EMAIL}`}
          className="flex min-h-16 items-center gap-3 px-4 py-2 hover:bg-gray-50 active:bg-gray-100"
        >
          <span className="min-w-0 flex-1 truncate">
            {t('support.emailLabel')}{' '}
            <span className="text-ola-primary underline">{SUPPORT_EMAIL}</span>
          </span>
          <span className="shrink-0 text-black/35">
            <ExternalLinkIcon />
          </span>
        </a>
      </div>
    </Dialog>
  );
}
