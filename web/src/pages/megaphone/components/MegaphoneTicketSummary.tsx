import { useTranslation } from 'react-i18next';
import { MEGAPHONE_TICKET_ICON } from '@constants';
import {
  selectMegaphoneTicketCount,
  useMegaphoneTicketStore,
} from '@ola/shared/stores/megaphone/megaphoneTicketStore';

interface MegaphoneTicketSummaryProps {
  onOpen: () => void;
}

export function MegaphoneTicketSummary({ onOpen }: MegaphoneTicketSummaryProps) {
  const { t } = useTranslation();
  const count = useMegaphoneTicketStore(selectMegaphoneTicketCount);
  if (count === 0) return null;
  return (
    <button
      type="button"
      onClick={onOpen}
      className="mt-1 flex max-w-full items-center gap-1 text-left text-sm text-ola-megaphone-ink active:opacity-70"
    >
      <img src={MEGAPHONE_TICKET_ICON} alt="" className="h-6 w-6 shrink-0 object-contain" draggable={false} />
      <span className="min-w-0 tabular-nums">
        {t('megaphone.ticket.summary', { count })}
        <span aria-hidden className="ml-1 text-black/38">
          ›
        </span>
      </span>
    </button>
  );
}
