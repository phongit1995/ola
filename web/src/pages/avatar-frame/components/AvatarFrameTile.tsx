import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ItemExpiryText, ItemLockButton } from '@components';
import { cn } from '@lib';
import { FRAME_TILE_AVATAR_SIZE } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { OwnFramedAvatar } from './OwnFramedAvatar';

interface AvatarFrameTileProps {
  frameId: string;
  subtitle?: ReactNode;
  badge?: string;
  highlighted?: boolean;
  locked?: boolean;
  expiresAt?: string | null;
  title?: string;
  onClick: () => void;
}

export function AvatarFrameTile({
  frameId,
  subtitle,
  badge,
  highlighted = false,
  locked = false,
  expiresAt,
  title,
  onClick,
}: AvatarFrameTileProps) {
  const { t } = useTranslation();
  return (
    <button
      type="button"
      onClick={onClick}
      title={title}
      className={cn(
        'relative flex flex-col items-center gap-1 rounded-lg bg-white px-1 pt-3 pb-2 shadow-[0_1px_2px_rgba(0,0,0,0.12)] active:bg-black/5',
        highlighted && 'ring-2 ring-ola-primary'
      )}
    >
      <OwnFramedAvatar frameId={frameId} size={FRAME_TILE_AVATAR_SIZE} />
      <span className="mt-1 w-full truncate text-center text-xs text-black/87">
        {avatarFrameLabel(frameId)}
      </span>
      {subtitle != null && (
        <span className="w-full truncate text-center text-xs font-medium text-ola-primary-ink">
          {subtitle}
        </span>
      )}
      <ItemExpiryText item={{ expiresAt }} />
      {locked && (
        <ItemLockButton
          message={t('avatarFrame.lockedNotTransferable')}
          className="absolute top-1 left-1"
        />
      )}
      {badge != null && (
        <span className="absolute top-1 right-1 rounded-full bg-ola-primary px-1.5 py-0.5 text-[10px] leading-none font-medium text-ola-on-primary">
          {badge}
        </span>
      )}
    </button>
  );
}
