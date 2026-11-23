import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, ItemCountdown } from '@components';
import { MEGAPHONE_TICKET_ICON } from '@constants';
import { megaphoneTicketSourceText } from '@lib';
import { useMegaphoneTicketStore } from '@ola/shared/stores/megaphone/megaphoneTicketStore';

interface MegaphoneTicketListDialogProps {
  onClose: () => void;
}

export function MegaphoneTicketListDialog({ onClose }: MegaphoneTicketListDialogProps) {
  const { t } = useTranslation();
  const tickets = useMegaphoneTicketStore((s) => s.tickets);
  return (
    <Dialog
      open
      onClose={onClose}
      title={t('megaphone.ticket.listTitle')}
      icon={<img src={MEGAPHONE_TICKET_ICON} alt="" className="h-7 w-7 object-contain" />}
      showClose
      footer={
        <DialogButton variant="green" className="flex-1" onClick={onClose}>
          {t('dialog.close')}
        </DialogButton>
      }
    >
      <div className="flex flex-col gap-2 px-1 py-1">
        <p className="text-sm text-black/54">{t('megaphone.ticket.listHint')}</p>
        {tickets.length === 0 ? (
          <p className="py-6 text-center text-sm text-black/54">{t('megaphone.ticket.empty')}</p>
        ) : (
          <ul className="max-h-[50vh] divide-y divide-black/6 overflow-y-auto rounded-lg bg-ola-surface">
            {tickets.map((ticket, index) => (
              <li key={ticket.id} className="flex items-center gap-3 px-3 py-2.5">
                <span className="w-5 shrink-0 text-center text-xs font-semibold text-black/38 tabular-nums">
                  {index + 1}
                </span>
                <img src={MEGAPHONE_TICKET_ICON} alt="" className="h-6 w-6 shrink-0 object-contain" draggable={false} />
                <span className="min-w-0 flex-1 truncate text-sm text-black/87">
                  {megaphoneTicketSourceText(t, ticket.source)}
                </span>
                {ticket.expiresAt != null ? (
                  <ItemCountdown expiresAt={ticket.expiresAt} className="text-sm" />
                ) : (
                  <span className="shrink-0 text-sm text-black/54">{t('megaphone.ticket.noExpiry')}</span>
                )}
              </li>
            ))}
          </ul>
        )}
      </div>
    </Dialog>
  );
}
