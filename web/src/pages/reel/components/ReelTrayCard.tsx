import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { REEL_TYPE } from '@constants';
import { cn, colorForName, reelPreviewMedia } from '@lib';
import type { Reel } from '@app-types';
import { ReelCanvas } from './ReelCanvas';
import { ReelPlusIcon, ReelVideoIcon } from './ReelIcons';

function cardClass(fluid: boolean) {
  return cn(
    'relative overflow-hidden rounded-xl',
    fluid ? 'aspect-[9/16] w-full' : 'h-40 w-[90px] shrink-0'
  );
}

interface ReelTrayCardProps {
  reel: Reel;
  label: string;
  ringed: boolean;
  fluid?: boolean;
  onClick: () => void;
}

export function ReelTrayCard({
  reel,
  label,
  ringed,
  fluid = false,
  onClick,
}: ReelTrayCardProps) {
  const author = reel.author;
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        cardClass(fluid),
        'bg-black text-left shadow-[0_1px_3px_rgba(0,0,0,0.25)] transition hover:brightness-95'
      )}
    >
      <ReelCanvas
        background={reel.background}
        media={reelPreviewMedia(reel)}
        overlays={reel.overlays}
      />
      <span className="pointer-events-none absolute inset-x-0 bottom-0 h-16 bg-gradient-to-t from-black/75 to-transparent" />
      <span
        className={`absolute top-2 left-2 rounded-full p-[2px] ${ringed ? 'bg-ola-primary' : 'bg-white/80'}`}
      >
        <span className="block rounded-full bg-white p-[1.5px]">
          <Avatar
            name={author.fullName || author.username}
            color={colorForName(author.username)}
            src={author.avatar ?? undefined}
            size={30}
          />
        </span>
      </span>
      {reel.type === REEL_TYPE.video && (
        <span className="absolute top-2 right-2 flex h-6 w-6 items-center justify-center rounded-full bg-black/45 text-white">
          <ReelVideoIcon className="h-3.5 w-3.5" />
        </span>
      )}
      <span
        className={cn(
          'absolute inset-x-2 bottom-2 line-clamp-2 leading-tight font-semibold break-words text-white',
          fluid ? 'text-sm' : 'text-xs'
        )}
      >
        {label}
      </span>
    </button>
  );
}

export function ReelAddCard({
  fluid = false,
  onClick,
}: {
  fluid?: boolean;
  onClick: () => void;
}) {
  const { t } = useTranslation();
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        cardClass(fluid),
        'flex flex-col items-center justify-center gap-3 border-2 border-dashed border-ola-border-strong bg-ola-surface text-black/70 transition hover:bg-ola-surface-cool'
      )}
    >
      <span className="flex h-10 w-10 items-center justify-center rounded-full bg-ola-primary text-ola-on-primary shadow">
        <ReelPlusIcon className="h-5 w-5" />
      </span>
      <span
        className={cn(
          'px-1 text-center font-semibold',
          fluid ? 'text-sm' : 'text-xs'
        )}
      >
        {t('reel.add')}
      </span>
    </button>
  );
}
