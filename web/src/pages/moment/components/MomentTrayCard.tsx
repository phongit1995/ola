import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { MOMENT_TYPE } from '@constants';
import { cn, colorForName, momentPreviewMedia } from '@lib';
import type { Moment } from '@app-types';
import { MomentCanvas } from './MomentCanvas';
import { MomentPlusIcon, MomentVideoIcon } from './MomentIcons';

const CARD_CLASS = 'relative h-40 w-[90px] shrink-0 overflow-hidden rounded-xl';

interface MomentTrayCardProps {
  moment: Moment;
  label: string;
  ringed: boolean;
  onClick: () => void;
}

export function MomentTrayCard({
  moment,
  label,
  ringed,
  onClick,
}: MomentTrayCardProps) {
  const author = moment.author;
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        CARD_CLASS,
        'bg-black text-left shadow-[0_1px_3px_rgba(0,0,0,0.25)] transition hover:brightness-95'
      )}
    >
      <MomentCanvas
        background={moment.background}
        media={momentPreviewMedia(moment)}
        overlays={moment.overlays}
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
      {moment.type === MOMENT_TYPE.video && (
        <span className="absolute top-2 right-2 flex h-6 w-6 items-center justify-center rounded-full bg-black/45 text-white">
          <MomentVideoIcon className="h-3.5 w-3.5" />
        </span>
      )}
      <span className="absolute inset-x-2 bottom-2 line-clamp-2 text-xs leading-tight font-semibold break-words text-white">
        {label}
      </span>
    </button>
  );
}

export function MomentAddCard({ onClick }: { onClick: () => void }) {
  const { t } = useTranslation();
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        CARD_CLASS,
        'flex flex-col items-center justify-center gap-3 border-2 border-dashed border-ola-border-strong bg-ola-surface text-black/70 transition hover:bg-ola-surface-cool'
      )}
    >
      <span className="flex h-10 w-10 items-center justify-center rounded-full bg-ola-primary text-ola-on-primary shadow">
        <MomentPlusIcon className="h-5 w-5" />
      </span>
      <span className="px-1 text-center text-xs font-semibold">
        {t('moment.add')}
      </span>
    </button>
  );
}
