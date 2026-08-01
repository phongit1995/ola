import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { Track } from 'livekit-client';
import {
  VideoTrack,
  isTrackReference,
  useTracks,
} from '@livekit/components-react';
import { Avatar } from '@components';
import { colorForName } from '@lib';
import type { CallerBrief } from '@app-types';
import { useCallStore } from '@/store/callStore';
import { PIP_ASPECT, PIP_DEFAULT_WIDTH } from './constants';
import {
  useCallDraggable,
  type CallDraggableInitial,
} from './hooks/useCallDraggable';
import { usePipResize } from './hooks/usePipResize';
import { useSpeaking } from './hooks/useSpeaking';

interface CallVideoAreaProps {
  peer: CallerBrief;
  peerName: string;
  isVideo: boolean;
  camOff: boolean;
}

export function CallVideoArea({
  peer,
  peerName,
  isVideo,
  camOff,
}: CallVideoAreaProps) {
  const { t } = useTranslation();
  const tracks = useTracks([Track.Source.Camera], { onlySubscribed: false });
  const localVideoPos = useCallStore((s) => s.localVideoPos);
  const localVideoWidth = useCallStore((s) => s.localVideoWidth);
  const setLocalVideoPos = useCallStore((s) => s.setLocalVideoPos);
  const setLocalVideoWidth = useCallStore((s) => s.setLocalVideoWidth);

  const localTrack = tracks.find((item) => item.participant.isLocal);
  const remoteTrack = tracks.find((item) => !item.participant.isLocal);
  const remoteSpeaking = useSpeaking(remoteTrack?.participant);
  const localSpeaking = useSpeaking(localTrack?.participant);

  const width = localVideoWidth ?? PIP_DEFAULT_WIDTH;

  const initialPosition = useCallback<CallDraggableInitial>(
    (bounds, element) => ({ x: bounds.width - element.width - 16, y: 16 }),
    []
  );

  const drag = useCallDraggable<HTMLDivElement>({
    position: localVideoPos,
    onChange: setLocalVideoPos,
    initial: initialPosition,
  });

  const resize = usePipResize<HTMLButtonElement>({
    width,
    onChange: setLocalVideoWidth,
  });

  const showRemoteVideo = isVideo && isTrackReference(remoteTrack);
  const showLocalVideo = isVideo && !camOff && isTrackReference(localTrack);

  return (
    <div className="relative flex flex-1 items-center justify-center overflow-hidden">
      {showRemoteVideo ? (
        <VideoTrack
          trackRef={remoteTrack}
          className="absolute inset-0 h-full w-full object-cover"
        />
      ) : (
        <Avatar
          name={peerName}
          color={colorForName(peerName)}
          src={peer.avatar}
          size={112}
        />
      )}

      {remoteSpeaking && (
        <span className="pointer-events-none absolute inset-0 rounded-none ring-4 ring-inset ring-emerald-400/70" />
      )}

      {showLocalVideo && (
        <div
          {...drag}
          style={{ width, height: width / PIP_ASPECT }}
          className={`absolute left-0 top-0 touch-none overflow-hidden rounded-2xl border shadow-lg ${
            localSpeaking ? 'border-emerald-400' : 'border-white/20'
          }`}
        >
          <VideoTrack
            trackRef={localTrack}
            className="h-full w-full scale-x-[-1] object-cover"
          />
          <button
            type="button"
            aria-label={t('call.resize')}
            {...resize}
            className="absolute bottom-0 left-0 h-6 w-6 cursor-nesw-resize touch-none bg-white/20"
          />
        </div>
      )}
    </div>
  );
}
