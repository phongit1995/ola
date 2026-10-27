import type { ReactNode, Ref } from 'react';
import { MOMENT_TYPE } from '@constants';
import { cn, resolveMomentBackground } from '@lib';
import type { MomentMediaDraft, MomentOverlay } from '@app-types';
import { MOMENT_FIT_STYLE } from '../constants';
import type { MomentVideoMode } from '../types';
import {
  overlayBoxStyle,
  overlayTextStyle,
  momentBackgroundCss,
} from '../utils';

const STILL_FRAME_FRAGMENT = '#t=0.1';
const MEDIA_CLASS = 'absolute inset-0 h-full w-full object-contain select-none';

export function MomentOverlayLabel({ overlay }: { overlay: MomentOverlay }) {
  return <span style={overlayTextStyle(overlay)}>{overlay.text}</span>;
}

function MomentOverlayText({ overlay }: { overlay: MomentOverlay }) {
  return (
    <div
      style={overlayBoxStyle(overlay)}
      className="pointer-events-none select-none"
    >
      <MomentOverlayLabel overlay={overlay} />
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

interface MomentMediaEvents {
  onMediaReady?: () => void;
  onMediaError?: () => void;
}

interface MomentVideoProps extends MomentMediaEvents {
  url: string;
  posterUrl?: string;
  mode: MomentVideoMode;
  videoRef?: Ref<HTMLVideoElement>;
  onEnded?: () => void;
}

function MomentVideo({
  url,
  posterUrl,
  mode,
  videoRef,
  onEnded,
  onMediaReady,
  onMediaError,
}: MomentVideoProps) {
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

interface MomentCanvasProps extends MomentMediaEvents {
  background?: string;
  media?: MomentMediaDraft | null;
  overlays: MomentOverlay[];
  fit?: boolean;
  videoMode?: MomentVideoMode;
  videoRef?: Ref<HTMLVideoElement>;
  onVideoEnded?: () => void;
  className?: string;
  children?: ReactNode;
}

export function MomentCanvas({
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
}: MomentCanvasProps) {
  const backdropUrl =
    media?.type === MOMENT_TYPE.image ? media.url : media?.posterUrl;
  return (
    <div
      className={cn(
        'relative overflow-hidden bg-black [container-type:inline-size]',
        fit ? 'rounded-xl' : 'h-full w-full',
        className
      )}
      style={fit ? MOMENT_FIT_STYLE : undefined}
    >
      {media == null && (
        <div
          className="absolute inset-0"
          style={{
            background: momentBackgroundCss(resolveMomentBackground(background)),
          }}
        />
      )}
      {backdropUrl && <BlurredBackdrop url={backdropUrl} />}
      {media?.type === MOMENT_TYPE.image && (
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
      {media?.type === MOMENT_TYPE.video && (
        <MomentVideo
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
        <MomentOverlayText key={overlay.id} overlay={overlay} />
      ))}
      {children}
    </div>
  );
}

export function MomentStage({
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
