import { useCallback } from 'react';
import { Track } from 'livekit-client';
import { useTranslation } from 'react-i18next';
import {
  VideoTrack,
  isTrackReference,
  useTracks,
} from '@livekit/components-react';
import { useCallStore } from '@/store/callStore';
import {
  MINI_WIDGET_HEIGHT,
  MINI_WIDGET_WIDTH,
} from './constants';
import { EndCallIcon, ExpandIcon, MicIcon, MicOffIcon } from './icons';
import {
  useCallDraggable,
  type CallDraggableInitial,
} from './hooks/useCallDraggable';
import { useCallMediaToggle } from './hooks/useCallMediaToggle';

interface CallMiniWidgetProps {
  peerName: string;
  statusLabel: string;
}

export function CallMiniWidget({
  peerName,
  statusLabel,
}: CallMiniWidgetProps) {
  const { t } = useTranslation();
  const tracks = useTracks([Track.Source.Camera], { onlySubscribed: false });
  const miniPos = useCallStore((s) => s.miniPos);
  const setMiniPos = useCallStore((s) => s.setMiniPos);
  const setExpanded = useCallStore((s) => s.setExpanded);
  const endActive = useCallStore((s) => s.endActive);
  const { micMuted, toggleMic } = useCallMediaToggle();

  const initialPosition = useCallback<CallDraggableInitial>(
    (bounds, element) => ({
      x: bounds.width - element.width - 12,
      y: bounds.height - element.height - 84,
    }),
    []
  );

  const drag = useCallDraggable<HTMLDivElement>({
    position: miniPos,
    onChange: setMiniPos,
    initial: initialPosition,
  });

  const remoteTrack = tracks.find((item) => !item.participant.isLocal);
  const showVideo = isTrackReference(remoteTrack);

  const stop = (event: React.PointerEvent) => event.stopPropagation();

  return (
    <div
      {...drag}
      style={{ width: MINI_WIDGET_WIDTH, height: MINI_WIDGET_HEIGHT }}
      className="absolute left-0 top-0 z-[124] touch-none overflow-hidden rounded-2xl bg-gradient-to-br from-ola-primary-dark to-ola-primary-darker text-white shadow-2xl"
    >
      {showVideo && (
        <VideoTrack
          trackRef={remoteTrack}
          className="absolute inset-0 h-full w-full object-cover"
        />
      )}
      <div className="absolute inset-0 flex flex-col justify-between bg-black/35 p-2">
        <div className="min-w-0">
          <p className="truncate text-xs font-semibold">{peerName}</p>
          <p className="truncate text-[11px] text-white/70">{statusLabel}</p>
        </div>
        <div className="flex items-center justify-between">
          <button
            type="button"
            aria-label={micMuted ? t('call.unmute') : t('call.mute')}
            onPointerDown={stop}
            onClick={toggleMic}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-white/15 hover:bg-white/25"
          >
            {micMuted ? (
              <MicOffIcon className="h-4 w-4" />
            ) : (
              <MicIcon className="h-4 w-4" />
            )}
          </button>
          <button
            type="button"
            aria-label={t('call.expand')}
            onPointerDown={stop}
            onClick={() => setExpanded(true)}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-white/15 hover:bg-white/25"
          >
            <ExpandIcon className="h-4 w-4" />
          </button>
          <button
            type="button"
            aria-label={t('call.endCall')}
            onPointerDown={stop}
            onClick={endActive}
            className="flex h-8 w-8 items-center justify-center rounded-full bg-ola-error hover:brightness-110"
          >
            <EndCallIcon className="h-4 w-4" />
          </button>
        </div>
      </div>
    </div>
  );
}
