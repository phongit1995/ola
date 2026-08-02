import { useEffect, useState } from 'react';
import { Pressable, Text, View } from 'react-native';
import i18n from 'i18next';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { LiveKitRoom } from '@livekit/react-native';
import { Avatar } from '@components/ui/Avatar';
import { OlaModal } from '@components/ui/OlaModal';
import { colorForName, peerDisplayName } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { CallerBrief } from '@ola/shared/types';
import { useCallStore } from '@store/callStore';
import { CallControls } from './CallControls';
import { CallVideoArea } from './CallVideoArea';
import { IncomingCallCard } from './IncomingCallCard';
import { EndCallIcon } from './icons';
import { useCallConnectTimeout } from './hooks/useCallConnectTimeout';
import { usePeerPresenceWatcher } from './hooks/usePeerPresenceWatcher';
import {
  enterCallAudioSession,
  leaveCallAudioSession,
} from './lib/callAudioSession';
import {
  startCallForegroundService,
  stopCallForegroundService,
} from './lib/callForegroundService';

const CONTROLS_HEIGHT = 64;
const CONTROLS_GAP = 24;

interface CallLayoutProps {
  peer: CallerBrief;
  peerName: string;
  statusLabel: string;
  videoArea?: React.ReactNode;
  controls?: React.ReactNode;
}

function CallLayout({
  peer,
  peerName,
  statusLabel,
  videoArea,
  controls,
}: CallLayoutProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const endActive = useCallStore((s) => s.endActive);

  return (
    <View className="flex-1 bg-ola-primary-darker">
      {videoArea ?? (
        <View className="absolute inset-0 items-center justify-center">
          <Avatar
            name={peerName}
            uri={peer.avatar}
            size={112}
            color={colorForName(peerName)}
          />
        </View>
      )}

      <View
        className="items-center gap-1 px-6"
        style={{ paddingTop: insets.top + 32 }}
      >
        <Text className="text-xl font-bold text-white" numberOfLines={1}>
          {peerName}
        </Text>
        <Text className="text-sm text-white/70">{statusLabel}</Text>
      </View>

      <View
        className="absolute inset-x-0 bottom-0 items-center"
        style={{ paddingBottom: insets.bottom + CONTROLS_GAP }}
      >
        {controls ?? (
          <Pressable
            accessibilityLabel={t('call.endCall')}
            onPress={() => void endActive()}
            className="h-16 w-16 items-center justify-center rounded-full bg-ola-error"
          >
            <EndCallIcon size={28} />
          </Pressable>
        )}
      </View>
    </View>
  );
}

function LiveCall() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const mode = useCallStore((s) => s.mode);
  const active = useCallStore((s) => s.active);
  const camOff = useCallStore((s) => s.camOff);

  usePeerPresenceWatcher();
  useCallConnectTimeout();

  if (active == null) return null;

  const isVideo = active.callType === 'video';
  const peerName = peerDisplayName(active.peer, t('call.unknownUser'));

  return (
    <CallLayout
      peer={active.peer}
      peerName={peerName}
      statusLabel={t(mode === 'outgoing' ? 'call.ringing' : 'call.connected')}
      videoArea={
        <CallVideoArea
          peer={active.peer}
          peerName={peerName}
          isVideo={isVideo}
          camOff={camOff}
          pipBottom={insets.bottom + CONTROLS_GAP + CONTROLS_HEIGHT + CONTROLS_GAP}
        />
      }
      controls={<CallControls isVideo={isVideo} />}
    />
  );
}

// LiveKit publish mic ngay khi connect, nên phải đợi audio session native cấu
// hình xong mới cho LiveKitRoom mount — mount trước thì track lên trước route.
function useCallSession(withVideo: boolean, onFailed: () => void) {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    let cancelled = false;
    enterCallAudioSession(withVideo).then(
      () => {
        if (cancelled) return;
        startCallForegroundService(withVideo);
        setReady(true);
      },
      () => {
        if (cancelled) return;
        useToastStore.getState().push('error', i18n.t('call.startFailed'));
        onFailed();
      },
    );
    return () => {
      cancelled = true;
      stopCallForegroundService();
      void leaveCallAudioSession();
    };
  }, [withVideo, onFailed]);

  return ready;
}

function ActiveCallBody({ withVideo }: { withVideo: boolean }) {
  const { t } = useTranslation();
  const active = useCallStore((s) => s.active);
  const endActive = useCallStore((s) => s.endActive);
  const audioReady = useCallSession(withVideo, endActive);

  if (active == null) return null;
  if (!audioReady) {
    return (
      <CallLayout
        peer={active.peer}
        peerName={peerDisplayName(active.peer, t('call.unknownUser'))}
        statusLabel={t('call.connecting')}
      />
    );
  }

  return (
    <LiveKitRoom
      serverUrl={active.wsUrl}
      token={active.token}
      connect
      audio
      video={active.callType === 'video'}
      options={{ adaptiveStream: true, dynacast: true }}
      onError={() => {
        useToastStore.getState().push('error', i18n.t('call.connectTimeout'));
        endActive();
      }}
      onDisconnected={endActive}
    >
      <LiveCall />
    </LiveKitRoom>
  );
}

// Một Modal duy nhất cho cả hai trạng thái: nhận máy làm incoming đổi sang
// active ngay, mà iOS từ chối present modal thứ hai khi modal cũ đang dismiss.
export function CallOverlay() {
  const mode = useCallStore((s) => s.mode);
  const callType = useCallStore((s) => s.active?.callType ?? null);
  const declineIncoming = useCallStore((s) => s.declineIncoming);
  const endActive = useCallStore((s) => s.endActive);

  const incoming = mode === 'incoming';
  if (!incoming && (mode === 'idle' || callType == null)) return null;

  const handleRequestClose = () => {
    if (incoming) {
      declineIncoming();
      return;
    }
    endActive();
  };

  return (
    <OlaModal
      visible
      transparent={false}
      animationType="slide"
      statusBarTranslucent
      onRequestClose={handleRequestClose}
    >
      {incoming ? (
        <IncomingCallCard />
      ) : (
        <ActiveCallBody withVideo={callType === 'video'} />
      )}
    </OlaModal>
  );
}
