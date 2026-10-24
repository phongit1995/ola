import type { CSSProperties, ReactNode, Ref } from 'react';
import { REEL_TYPE } from '@constants';
import { cn, resolveReelBackground } from '@lib';
import type { ReelMediaDraft, ReelOverlay } from '@app-types';
import type { ReelVideoMode } from '../types';
import {
  overlayBoxStyle,
  overlayTextStyle,
  reelBackgroundCss,
} from '../utils';

const FIT_STYLE: CSSProperties = {
  width: 'min(100cqw, calc(100cqh * 9 / 16))',
  aspectRatio: '9 / 16',
};

const STILL_FRAME_FRAGMENT = '#t=0.1';
const MEDIA_CLASS = 'absolute inset-0 h-full w-full object-contain select-none';

export function ReelOverlayLabel({ overlay }: { overlay: ReelOverlay }) {
  return <span style={overlayTextStyle(overlay)}>{overlay.text}</span>;
}

function ReelOverlayText({ overlay }: { overlay: ReelOverlay }) {
  return (
    <div
      style={overlayBoxStyle(overlay)}
      className="pointer-events-none select-none"
    >
      <ReelOverlayLabel overlay={overlay} />
    </div>
  );
}

function BlurredBackdrop({ url }: { url: string }) {
  return (
    <>
      <img
        src={url}
        alt=""
        aria-hidden="true"
        draggable={false}
        className="absolute inset-0 h-full w-full scale-110 object-cover opacity-70 blur-xl"
      />
      <div className="absolute inset-0 bg-black/25" />
    </>
  );
}

interface ReelMediaEvents {
  onMediaReady?: () => void;
  onMediaError?: () => void;
}

interface ReelVideoProps extends ReelMediaEvents {
  url: string;
  posterUrl?: string;
  mode: ReelVideoMode;
  videoRef?: Ref<HTMLVideoElement>;
  onEnded?: () => void;
}

function ReelVideo({
  url,
  posterUrl,
  mode,
  videoRef,
  onEnded,
  onMediaReady,
  onMediaError,
}: ReelVideoProps) {
  if (mode === 'still') {
    return (
      <video
        src={`${url}${STILL_FRAME_FRAGMENT}`}
        muted
        playsInline
        preload="metadata"
        className={MEDIA_CLASS}
      />
    );
  }
  if (mode === 'loop') {
    return (
      <video src={url} autoPlay muted loop playsInline className={MEDIA_CLASS} />
    );
  }
  return (
    <video
      key={url}
      ref={videoRef}
      src={url}
      poster={posterUrl}
      playsInline
      preload="auto"
      onEnded={onEnded}
      onPlaying={onMediaReady}
      onError={onMediaError}
      className={MEDIA_CLASS}
    />
  );
}

interface ReelCanvasProps extends ReelMediaEvents {
  background?: string;
  media?: ReelMediaDraft | null;
  overlays: ReelOverlay[];
  fit?: boolean;
  videoMode?: ReelVideoMode;
  videoRef?: Ref<HTMLVideoElement>;
  onVideoEnded?: () => void;
  className?: string;
  children?: ReactNode;
}

export function ReelCanvas({
  background,
  media,
  overlays,
  fit = false,
  videoMode = 'still',
  videoRef,
  onVideoEnded,
  onMediaReady,
  onMediaError,
  className,
  children,
}: ReelCanvasProps) {
  const backdropUrl =
    media?.type === REEL_TYPE.image ? media.url : media?.posterUrl;
  return (
    <div
      className={cn(
        'relative overflow-hidden bg-black [container-type:inline-size]',
        fit ? 'rounded-xl' : 'h-full w-full',
        className
      )}
      style={fit ? FIT_STYLE : undefined}
    >
      {media == null && (
        <div
          className="absolute inset-0"
          style={{
            background: reelBackgroundCss(resolveReelBackground(background)),
          }}
        />
      )}
      {backdropUrl && <BlurredBackdrop url={backdropUrl} />}
      {media?.type === REEL_TYPE.image && (
        <img
          key={media.url}
          src={media.url}
          alt=""
          draggable={false}
          onLoad={onMediaReady}
          onError={(event) => {
            event.currentTarget.style.visibility = 'hidden';
            onMediaError?.();
          }}
          className={MEDIA_CLASS}
        />
      )}
      {media?.type === REEL_TYPE.video && (
        <ReelVideo
          url={media.url}
          posterUrl={media.posterUrl}
          mode={videoMode}
          videoRef={videoRef}
          onEnded={onVideoEnded}
          onMediaReady={onMediaReady}
          onMediaError={onMediaError}
        />
      )}
      {overlays.map((overlay) => (
        <ReelOverlayText key={overlay.id} overlay={overlay} />
      ))}
      {children}
    </div>
  );
}

export function ReelStage({
  className,
  children,
}: {
  className?: string;
  children: ReactNode;
}) {
  return (
    <div className={cn('relative min-h-0 flex-1 [container-type:size]', className)}>
      <div className="absolute inset-0 flex items-center justify-center">
        {children}
      </div>
    </div>
  );
}
