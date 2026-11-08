import type { ReactNode } from 'react';
import { cn } from '@lib';
import { FRAME_TILE_AVATAR_SIZE } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { OwnFramedAvatar } from './OwnFramedAvatar';

interface AvatarFrameTileProps {
  frameId: string;
  subtitle?: ReactNode;
  badge?: string;
  highlighted?: boolean;
  onClick: () => void;
}

export function AvatarFrameTile({
  frameId,
  subtitle,
  badge,
  highlighted = false,
  onClick,
}: AvatarFrameTileProps) {
  return (
    <button
      type="button"
      onClick={onClick}
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
      {badge != null && (
        <span className="absolute top-1 right-1 rounded-full bg-ola-primary px-1.5 py-0.5 text-[10px] leading-none font-medium text-ola-on-primary">
          {badge}
        </span>
      )}
    </button>
  );
}
