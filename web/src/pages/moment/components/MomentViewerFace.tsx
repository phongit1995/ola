import { useMemo, useState, type Ref } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import {
  MOMENT_FADE_MS,
  MOMENT_STATUS,
  MOMENT_TURN_SHADE,
  MOMENT_TYPE,
} from '@constants';
import { cn, colorForName, momentMedia, momentNoticeKey } from '@lib';
import type { Moment, MomentAuthor, ReactionType } from '@app-types';
import type { MomentMediaStatus } from '../types';
import { momentTurnStyle } from '../utils';
import { MomentCanvas } from './MomentCanvas';
import {
  MomentCloseIcon,
  MomentMoreIcon,
  MomentPauseIcon,
  MomentPlayIcon,
  MomentSoundIcon,
} from './MomentIcons';
import { MomentReactionBar } from './MomentReactionBar';

const PAGE_FADE = `ken-fade-in ${MOMENT_FADE_MS}ms ease-out`;

interface MomentViewerFaceProps {
  author: MomentAuthor;
  moments: Moment[];
  moment: Moment;
  itemIndex: number;
  offset: number;
  active: boolean;
  progress: number;
  mediaStatus: MomentMediaStatus;
  time: string;
  muted: boolean;
  paused: boolean;
  videoRef?: Ref<HTMLVideoElement>;
  onVideoEnded?: () => void;
  onMediaStatus: (momentId: string, status: MomentMediaStatus) => void;
  onToggleMute: () => void;
  onTogglePause: () => void;
  onOpenMenu?: () => void;
  onOpenProfile?: () => void;
  onReact?: (type: ReactionType) => void;
  onClose: () => void;
}

export function MomentViewerFace({
  author,
  moments,
  moment,
  itemIndex,
  offset,
  active,
  progress,
  mediaStatus,
  time,
  muted,
  paused,
  videoRef,
  onVideoEnded,
  onMediaStatus,
  onToggleMute,
  onTogglePause,
  onOpenMenu,
  onOpenProfile,
  onReact,
  onClose,
}: MomentViewerFaceProps) {
  const { t } = useTranslation();
  const [pages, setPages] = useState<{ shown: Moment; previous: Moment | null }>({
    shown: moment,
    previous: null,
  });
  if (pages.shown.id !== moment.id) {
    setPages({ shown: moment, previous: pages.shown });
  }
  const media = useMemo(() => momentMedia(moment), [moment]);
  const isVideo = media?.type === MOMENT_TYPE.video;
  const processing = moment.status === MOMENT_STATUS.processing;
  const noticeKey = momentNoticeKey(moment, mediaStatus === 'error');
  const momentId = moment.id;
  const previous = pages.previous;

  return (
    <div
      inert={!active}
      className="pointer-events-none absolute inset-0 overflow-hidden rounded-xl max-sm:rounded-none"
      style={momentTurnStyle(offset)}
    >
      {[previous, moment].map((page) => {
        if (page == null) return null;
        const current = page.id === momentId;
        return (
          <div
            key={page.id}
            className="absolute inset-0"
            style={current && previous ? { animation: PAGE_FADE } : undefined}
            onAnimationEnd={(event) => {
              if (event.target === event.currentTarget) {
                setPages((value) => ({ ...value, previous: null }));
              }
            }}
          >
            {current ? (
              <MomentCanvas
                background={moment.background}
                media={media}
                overlays={moment.overlays}
                videoMode={active ? 'controlled' : 'still'}
                videoRef={active ? videoRef : undefined}
                onVideoEnded={onVideoEnded}
                onMediaReady={() => onMediaStatus(momentId, 'ready')}
                onMediaError={() => onMediaStatus(momentId, 'error')}
              />
            ) : (
              <MomentCanvas
                background={page.background}
                media={momentMedia(page)}
                overlays={page.overlays}
              />
            )}
          </div>
        );
      })}
      <div className="absolute inset-x-0 top-0 h-28 bg-gradient-to-b from-black/55 to-transparent" />
      <div className="absolute inset-x-0 top-0 px-3 pt-3">
        <div className="flex gap-1">
          {moments.map((item, index) => (
            <span
              key={item.id}
              className="h-[3px] flex-1 overflow-hidden rounded-full bg-white/35"
            >
              <span
                className="block h-full rounded-full bg-white"
                style={{
                  width: `${index < itemIndex ? 100 : index === itemIndex ? progress * 100 : 0}%`,
                }}
              />
            </span>
          ))}
        </div>
        <div className="mt-3 flex items-center gap-2">
          <button
            type="button"
            aria-label={t('me.viewProfile')}
            disabled={onOpenProfile == null}
            onClick={onOpenProfile}
            className="pointer-events-auto flex min-w-0 flex-1 items-center gap-2 text-left disabled:pointer-events-none"
          >
            <Avatar
              name={author.username}
              color={colorForName(author.username)}
              src={author.avatar ?? undefined}
              size={36}
            />
            <span className="min-w-0 flex-1">
              <span className="block truncate text-sm font-semibold">
                {author.username}
              </span>
              <span className="block text-xs text-white/75">{time}</span>
            </span>
          </button>
          {isVideo && (
            <button
              type="button"
              aria-label={muted ? t('moment.unmute') : t('moment.mute')}
              onClick={onToggleMute}
              className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
            >
              <MomentSoundIcon muted={muted} />
            </button>
          )}
          <button
            type="button"
            aria-label={paused ? t('moment.play') : t('moment.pause')}
            onClick={onTogglePause}
            className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
          >
            {paused ? <MomentPlayIcon /> : <MomentPauseIcon />}
          </button>
          {onOpenMenu != null && (
            <button
              type="button"
              aria-label={t('moment.menu')}
              onClick={onOpenMenu}
              className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
            >
              <MomentMoreIcon />
            </button>
          )}
          <button
            type="button"
            aria-label={t('dialog.close')}
            onClick={onClose}
            className="pointer-events-auto rounded-full p-2 hover:bg-white/15"
          >
            <MomentCloseIcon />
          </button>
        </div>
      </div>
      {onReact != null && <MomentReactionBar onReact={onReact} />}
      {active && noticeKey != null && (
        <p
          className={cn(
            'absolute inset-x-6 rounded-lg bg-black/55 px-3 py-2 text-center text-sm',
            onReact != null ? 'bottom-24' : 'bottom-20'
          )}
        >
          {t(noticeKey)}
        </p>
      )}
      {active && mediaStatus === 'loading' && !processing && (
        <span className="absolute top-1/2 left-1/2 h-8 w-8 -translate-x-1/2 -translate-y-1/2 animate-spin rounded-full border-2 border-white/30 border-t-white" />
      )}
      {offset !== 0 && (
        <div
          className="absolute inset-0 bg-black"
          style={{ opacity: Math.min(Math.abs(offset), 1) * MOMENT_TURN_SHADE }}
        />
      )}
    </div>
  );
}
