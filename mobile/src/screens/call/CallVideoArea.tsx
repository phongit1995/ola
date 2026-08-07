import { View } from 'react-native';
import { Track } from 'livekit-client';
import { isTrackReference, useTracks } from '@livekit/components-react';
import { VideoTrack } from '@livekit/react-native';
import { Avatar } from '@components/ui/Avatar';
import { colorForName } from '@ola/shared/lib';
import type { CallerBrief } from '@ola/shared/types';

const PIP_WIDTH = 108;
const PIP_HEIGHT = 156;

interface CallVideoAreaProps {
  peer: CallerBrief;
  peerName: string;
  isVideo: boolean;
  camOff: boolean;
  pipBottom: number;
  visible: boolean;
}

export function CallVideoArea({
  peer,
  peerName,
  isVideo,
  camOff,
  pipBottom,
  visible,
}: CallVideoAreaProps) {
  const tracks = useTracks([Track.Source.Camera], { onlySubscribed: false });
  const localTrack = tracks.find((item) => item.participant.isLocal);
  const remoteTrack = tracks.find((item) => !item.participant.isLocal);

  // SurfaceView của VideoTrack trên Android không tôn trọng opacity:0, nên khi
  // overlay bị ẩn (thu nhỏ) phải gỡ hẳn renderer thay vì chỉ làm mờ.
  const showRemoteVideo = visible && isVideo && isTrackReference(remoteTrack);
  const showLocalVideo =
    visible && isVideo && !camOff && isTrackReference(localTrack);

  return (
    <View className="absolute inset-0 items-center justify-center">
      {showRemoteVideo ? (
        <VideoTrack
          trackRef={remoteTrack}
          objectFit="cover"
          zOrder={0}
          style={{ flex: 1, alignSelf: 'stretch' }}
        />
      ) : (
        <Avatar
          name={peerName}
          uri={peer.avatar}
          size={112}
          color={colorForName(peerName)}
        />
      )}

      {showLocalVideo && (
        <View
          className="absolute overflow-hidden rounded-2xl border border-white/20"
          style={{ right: 16, bottom: pipBottom, width: PIP_WIDTH, height: PIP_HEIGHT }}
        >
          <VideoTrack
            trackRef={localTrack}
            objectFit="cover"
            mirror
            zOrder={1}
            style={{ flex: 1 }}
          />
        </View>
      )}
    </View>
  );
}
