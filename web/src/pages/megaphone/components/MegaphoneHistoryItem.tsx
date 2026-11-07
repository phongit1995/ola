import { useTranslation } from 'react-i18next';
import { Avatar, UserName } from '@components';
import { colorForName, formatOlaTimeAgo, megaphoneSenderName, SmileyText } from '@lib';
import type { Megaphone } from '@app-types';

interface MegaphoneHistoryItemProps {
  megaphone: Megaphone;
  isMine: boolean;
  nowMs: number;
  onOpenProfile: (megaphone: Megaphone) => void;
  onMore: (megaphone: Megaphone) => void;
}

export function MegaphoneHistoryItem({ megaphone, isMine, nowMs, onOpenProfile, onMore }: MegaphoneHistoryItemProps) {
  const { t, i18n } = useTranslation();
  const name = megaphoneSenderName(megaphone);

  return (
    <li className="flex items-start gap-3 bg-white px-4 py-3">
      <button
        type="button"
        aria-label={t('megaphone.viewProfile')}
        onClick={() => onOpenProfile(megaphone)}
        className="shrink-0"
      >
        <Avatar name={name} src={megaphone.sender.avatar} color={colorForName(name)} size={40} />
      </button>
      <div className="min-w-0 flex-1">
        <div className="flex items-center gap-1">
          <button
            type="button"
            onClick={() => onOpenProfile(megaphone)}
            className="min-w-0 truncate"
          >
            <UserName
              name={`@${megaphone.sender.username}`}
              fullName={megaphone.sender.fullName}
              className="text-sm font-semibold text-ola-megaphone-name"
              fullNameClassName="font-normal text-black/54"
            />
          </button>
          <span className="ml-auto shrink-0 text-xs text-black/40">
            {formatOlaTimeAgo(megaphone.showAt, i18n.language, nowMs)}
          </span>
        </div>
        <p className="mt-0.5 text-[15px] break-words text-black/87">
          <SmileyText text={megaphone.content} />
        </p>
      </div>
      {!isMine && (
        <button
          type="button"
          aria-label={t('common.menu')}
          onClick={() => onMore(megaphone)}
          className="-mr-2 flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-black/40 hover:bg-black/5"
        >
          <svg viewBox="0 0 24 24" className="h-5 w-5" fill="currentColor" aria-hidden="true">
            <path d="M12 8a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm0 2a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm0 6a2 2 0 1 0 0 4 2 2 0 0 0 0-4z" />
          </svg>
        </button>
      )}
    </li>
  );
}
