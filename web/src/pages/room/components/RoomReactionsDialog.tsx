import { useTranslation } from 'react-i18next';
import { Dialog } from '@components';
import { REACTION_EMOJI, REACTION_ORDER } from '@lib';
import type { RoomReactor } from '@app-types';

interface RoomReactionsDialogProps {
  open: boolean;
  reactions?: Record<string, RoomReactor[]>;
  onClose: () => void;
}

export function RoomReactionsDialog({ open, reactions, onClose }: RoomReactionsDialogProps) {
  const { t } = useTranslation();
  const rows = REACTION_ORDER.flatMap((type) =>
    (reactions?.[type] ?? []).map((reactor) => ({ type, reactor }))
  );

  return (
    <Dialog open={open} onClose={onClose} title={t('room.reactionsTitle')}>
      {rows.length === 0 ? (
        <p className="py-4 text-center text-sm text-black/54">{t('room.reactionsEmpty')}</p>
      ) : (
        <ul className="max-h-72 divide-y divide-black/8 overflow-y-auto">
          {rows.map(({ type, reactor }) => (
            <li key={`${type}-${reactor.userId}`} className="flex items-center gap-3 py-2">
              <span className="text-xl">{REACTION_EMOJI[type] ?? '❓'}</span>
              <span className="min-w-0 flex-1 truncate text-base text-black/87">
                @{reactor.username}
              </span>
            </li>
          ))}
        </ul>
      )}
    </Dialog>
  );
}
