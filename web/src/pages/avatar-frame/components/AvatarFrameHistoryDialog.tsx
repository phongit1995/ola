import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner } from '@components';
import { AVATAR_FRAME_HISTORY_TABS } from '@constants';
import {
  avatarFramePurchaseLine,
  avatarFrameTransferLine,
  cn,
  createTimeFormatter,
  type AvatarFrameHistoryLine,
} from '@lib';
import type { AvatarFrameHistoryTab } from '@app-types';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAvatarFrameHistory } from '@ola/shared/stores/avatar-frame/useAvatarFrameHistory';
import { useAuthStore } from '@/store/authStore';
import { FRAME_HISTORY_TONE_CLASS } from '../constants';
import { AvatarFrameThumb } from './AvatarFrameThumb';

interface HistoryRowProps {
  line: AvatarFrameHistoryLine;
  time: string;
}

function HistoryRow({ line, time }: HistoryRowProps) {
  return (
    <li className="flex items-center justify-between gap-3 py-2">
      <div className="flex min-w-0 items-center gap-2">
        <AvatarFrameThumb frameId={line.frameId} />
        <div className="min-w-0">
          <p className="truncate font-medium text-black/87">
            {avatarFrameLabel(line.frameId)}
          </p>
          <p
            className={cn(
              'truncate text-xs',
              FRAME_HISTORY_TONE_CLASS[line.tone]
            )}
          >
            {line.text}
          </p>
        </div>
      </div>
      <div className="shrink-0 text-right">
        <p className="text-xs text-black/45">{time}</p>
        {line.amount != null && (
          <p className="text-xs text-ola-error">{line.amount}</p>
        )}
      </div>
    </li>
  );
}

interface AvatarFrameHistoryDialogProps {
  onClose: () => void;
}

export function AvatarFrameHistoryDialog({
  onClose,
}: AvatarFrameHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id);
  const [tab, setTab] = useState<AvatarFrameHistoryTab>('purchases');
  const { purchases, transfers, loading, hasMore, loadMore } =
    useAvatarFrameHistory(tab, true);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );
  const lines =
    tab === 'purchases'
      ? purchases.map((item) => avatarFramePurchaseLine(t, item, myId))
      : transfers.map((item) => avatarFrameTransferLine(t, item, myId));
  const itemCount = lines.length;

  return (
    <Dialog
      open
      onClose={onClose}
      title={t('avatarFrame.history.title')}
      footer={
        <DialogButton onClick={onClose}>{t('dialog.close')}</DialogButton>
      }
    >
      <div className="mb-2 flex gap-1.5">
        {AVATAR_FRAME_HISTORY_TABS.map((item) => (
          <button
            key={item.key}
            type="button"
            onClick={() => setTab(item.key)}
            className={cn(
              'rounded-full px-3 py-1 text-xs font-medium transition-colors',
              tab === item.key
                ? 'bg-ola-primary text-ola-on-primary'
                : 'bg-ola-surface text-black/60 hover:bg-ola-surface-cool'
            )}
          >
            {t(item.labelKey)}
          </button>
        ))}
      </div>
      <div className="max-h-[60vh] min-h-30 overflow-y-auto">
        {itemCount === 0 && loading ? (
          <div className="flex h-30 items-center justify-center">
            <Spinner />
          </div>
        ) : itemCount === 0 ? (
          <p className="py-6 text-center text-black/45">
            {t('avatarFrame.history.empty')}
          </p>
        ) : (
          <ul className="divide-y divide-black/8">
            {lines.map((line) => (
              <HistoryRow
                key={line.id}
                line={line}
                time={formatTime(line.createdAt)}
              />
            ))}
          </ul>
        )}
        {hasMore && itemCount > 0 && (
          <button
            type="button"
            onClick={() => void loadMore().catch(() => undefined)}
            disabled={loading}
            className="mt-2 w-full rounded-[3px] border border-black/12 bg-ola-surface py-1.5 text-sm text-black/87 hover:bg-ola-surface-cool disabled:opacity-50"
          >
            {loading ? t('common.loading') : t('avatarFrame.history.loadMore')}
          </button>
        )}
      </div>
    </Dialog>
  );
}
