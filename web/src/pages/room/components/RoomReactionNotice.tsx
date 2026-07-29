import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useRoomChatStore } from '@/store/roomChatStore';
import { REACTION_IMAGE } from '@lib';
import type { ReactionType } from '@app-types';

const NOTICE_DURATION_MS = 2500;

export function RoomReactionNotice() {
  const { t } = useTranslation();
  const notice = useRoomChatStore((state) => state.reactionNotice);
  const clearReactionNotice = useRoomChatStore(
    (state) => state.clearReactionNotice
  );

  useEffect(() => {
    if (notice == null) return;
    const seq = notice.seq;
    const timer = setTimeout(
      () => clearReactionNotice(seq),
      NOTICE_DURATION_MS
    );
    return () => clearTimeout(timer);
  }, [notice, clearReactionNotice]);

  if (notice == null) return null;

  const image = REACTION_IMAGE[notice.type as ReactionType] ?? '';

  return (
    <div className="pointer-events-none absolute inset-x-0 top-6 z-20 flex justify-center px-4">
      <span
        key={notice.seq}
        className="animate-reaction-notice flex max-w-full items-center gap-2 rounded-full bg-white py-1.5 pl-1.5 pr-4 shadow-[0_6px_20px_rgba(0,0,0,0.18)] ring-1 ring-black/5"
      >
        {image !== '' && (
          <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-ola-primary-light">
            <img src={image} alt="" className="h-5 w-5 object-contain" />
          </span>
        )}
        <span className="min-w-0 truncate text-sm leading-tight">
          <span className="font-semibold text-black/85">
            @{notice.username}
          </span>
          <span className="text-black/50"> {t('room.reactionNotice')}</span>
        </span>
      </span>
    </div>
  );
}
