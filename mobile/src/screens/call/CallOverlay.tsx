import { useEffect, useState, type ReactNode } from 'react';
import { BackHandler, Pressable, StyleSheet, Text, View } from 'react-native';
import Animated, {
  useAnimatedStyle,
  useSharedValue,
  withTiming,
} from 'react-native-reanimated';
import i18n from 'i18next';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { LiveKitRoom, VideoTrack } from '@livekit/react-native';
import {
  isTrackReference,
  useRoomContext,
  useTracks,
} from '@livekit/components-react';
import { Track } from 'livekit-client';
import { Avatar } from '@components/ui/Avatar';
import {
  callPeerNameView,
  colorForName,
  computeCallStatusLabel,
  peerDisplayName,
} from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { CallerBrief } from '@ola/shared/types';
import { useCallStore } from '@store/callStore';
import { CALL_BG } from './constants';
import { CallControls } from './CallControls';
import { CallMiniWidget } from './CallMiniWidget';
import { CallVideoArea } from './CallVideoArea';
import { IncomingCallCard } from './IncomingCallCard';
import { EndCallIcon, MinimizeIcon } from './icons';
import { useCallConnectTimeout } from './hooks/useCallConnectTimeout';
import { useConnectionState, useElapsedSeconds } from './hooks/useCallTelemetry';
import { usePeerPresenceWatcher } from './hooks/usePeerPresenceWatcher';
import { usePipMode } from './hooks/usePipMode';
import { exitPip, setPipSupported, subscribePipClosed } from './lib/callPip';
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

// Lớp fullscreen chỉ ẩn bằng opacity + pointerEvents khi thu nhỏ — unmount là
// rớt audio session/foreground service giữa cuộc gọi.
function FullscreenLayer({
  hidden,
  children,
}: {
  hidden: boolean;
  children: ReactNode;
}) {
  const progress = useSharedValue(hidden ? 0 : 1);

  useEffect(() => {
    progress.value = withTiming(hidden ? 0 : 1, { duration: 200 });
  }, [hidden, progress]);

  const animatedStyle = useAnimatedStyle(() => ({
    opacity: progress.value,
    transform: [{ scale: 0.94 + 0.06 * progress.value }],
  }));

  return (
    <Animated.View
      pointerEvents={hidden ? 'none' : 'auto'}
      accessibilityElementsHidden={hidden}
      importantForAccessibility={hidden ? 'no-hide-descendants' : 'auto'}
      style={[styles.fullscreen, animatedStyle]}
    >
      {children}
    </Animated.View>
  );
}

interface CallLayoutProps {
  peer: CallerBrief;
  peerName: string;
  title: string;
  subtitle: string | null;
  statusLabel: string;
  videoArea?: React.ReactNode;
  controls?: React.ReactNode;
  onMinimize?: () => void;
}

function CallLayout({
  peer,
  peerName,
  title,
  subtitle,
  statusLabel,
  videoArea,
  controls,
  onMinimize,
}: CallLayoutProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const endActive = useCallStore((s) => s.endActive);

  return (
    <View className="flex-1" style={{ backgroundColor: CALL_BG }}>
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
          {title}
        </Text>
        {subtitle != null && (
          <Text className="text-sm text-white/80" numberOfLines={1}>
            {subtitle}
          </Text>
        )}
        <Text className="text-sm text-white/70">{statusLabel}</Text>
      </View>

      {onMinimize != null && (
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('call.minimize')}
          onPress={onMinimize}
          style={[styles.minimizeButton, { top: insets.top + 12 }]}
        >
          <MinimizeIcon size={18} />
        </Pressable>
      )}

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

function PipCallLayer({
  peer,
  peerName,
  isVideo,
}: {
  peer: CallerBrief;
  peerName: string;
  isVideo: boolean;
}) {
  const tracks = useTracks([Track.Source.Camera], { onlySubscribed: false });
  const remoteTrack = tracks.find((item) => !item.participant.isLocal);
  const showVideo = isVideo && isTrackReference(remoteTrack);

  return (
    <View
      className="flex-1 items-center justify-center"
      style={{ backgroundColor: CALL_BG }}
    >
      {showVideo ? (
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
          size={64}
          color={colorForName(peerName)}
        />
      )}
    </View>
  );
}

function CallSessionUi({ withVideo }: { withVideo: boolean }) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const room = useRoomContext();
  const mode = useCallStore((s) => s.mode);
  const active = useCallStore((s) => s.active);
  const expanded = useCallStore((s) => s.expanded);
  const camOff = useCallStore((s) => s.camOff);
  const setExpanded = useCallStore((s) => s.setExpanded);
  const endActive = useCallStore((s) => s.endActive);
  const inPip = usePipMode();

  usePeerPresenceWatcher();
  useCallConnectTimeout();
  const connectionState = useConnectionState(room);
  const elapsed = useElapsedSeconds(mode === 'active');

  useEffect(() => {
    setPipSupported(mode === 'active' || mode === 'outgoing', withVideo);
  }, [mode, withVideo]);

  useEffect(
    () => subscribePipClosed(() => void endActive()),
    [endActive],
  );

  // Chỉ chạy khi call kết thúc (unmount) — đặt trong cleanup của effect
  // [mode] thì chuyển outgoing→active lúc đang PiP sẽ dismiss nhầm cửa sổ.
  useEffect(
    () => () => {
      setPipSupported(false, false);
      exitPip();
    },
    [],
  );

  if (active == null) return null;

  const peerName = peerDisplayName(active.peer, t('call.unknownUser'));
  const nameView = callPeerNameView(active.peer, t('call.unknownUser'));
  const statusLabel = computeCallStatusLabel(t, mode, connectionState, elapsed);

  if (inPip) {
    return (
      <View style={styles.fullscreen}>
        <PipCallLayer
          peer={active.peer}
          peerName={peerName}
          isVideo={withVideo}
        />
      </View>
    );
  }

  return (
    <>
      <FullscreenLayer hidden={!expanded}>
        <CallLayout
          peer={active.peer}
          peerName={peerName}
          title={nameView.title}
          subtitle={nameView.subtitle}
          statusLabel={statusLabel}
          onMinimize={() => setExpanded(false)}
          videoArea={
            <CallVideoArea
              peer={active.peer}
              peerName={peerName}
              isVideo={withVideo}
              camOff={camOff}
              pipBottom={insets.bottom + CONTROLS_GAP + CONTROLS_HEIGHT + CONTROLS_GAP}
              visible={expanded}
            />
          }
          controls={<CallControls isVideo={withVideo} />}
        />
      </FullscreenLayer>

      {!expanded && (
        <CallMiniWidget
          peerName={nameView.title}
          statusLabel={statusLabel}
          isVideo={withVideo}
        />
      )}
    </>
  );
}

// LiveKit publish mic ngay khi connect, nên phải đợi audio session native cấu
// hình xong mới cho LiveKitRoom mount — mount trước thì track lên trước route.
function useCallSession(withVideo: boolean, onFailed: () => void) {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    let cancelled = false;

    const start = async () => {
      try {
        await enterCallAudioSession(withVideo);
        if (cancelled) return;
        await startCallForegroundService(withVideo);
        if (cancelled) {
          await stopCallForegroundService().catch(() => {});
          return;
        }
        setReady(true);
      } catch {
        if (cancelled) return;
        useToastStore.getState().push('error', i18n.t('call.startFailed'));
        onFailed();
      }
    };

    void start();
    return () => {
      cancelled = true;
      void stopCallForegroundService().catch(() => {});
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
    const nameView = callPeerNameView(active.peer, t('call.unknownUser'));
    return (
      <FullscreenLayer hidden={false}>
        <CallLayout
          peer={active.peer}
          peerName={peerDisplayName(active.peer, t('call.unknownUser'))}
          title={nameView.title}
          subtitle={nameView.subtitle}
          statusLabel={t('call.connecting')}
        />
      </FullscreenLayer>
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
      <CallSessionUi withVideo={active.callType === 'video'} />
    </LiveKitRoom>
  );
}

export function CallOverlay() {
  const mode = useCallStore((s) => s.mode);
  const callType = useCallStore((s) => s.active?.callType ?? null);
  const expanded = useCallStore((s) => s.expanded);
  const declineIncoming = useCallStore((s) => s.declineIncoming);
  const setExpanded = useCallStore((s) => s.setExpanded);

  const incoming = mode === 'incoming';
  const inCall = !incoming && mode !== 'idle' && callType != null;

  useEffect(() => {
    if (!incoming && !(inCall && expanded)) return;
    const subscription = BackHandler.addEventListener(
      'hardwareBackPress',
      () => {
        if (incoming) declineIncoming();
        else setExpanded(false);
        return true;
      },
    );
    return () => subscription.remove();
  }, [incoming, inCall, expanded, declineIncoming, setExpanded]);

  if (!incoming && !inCall) return null;

  return (
    <View style={styles.root} pointerEvents="box-none">
      {incoming ? (
        <FullscreenLayer hidden={false}>
          <IncomingCallCard />
        </FullscreenLayer>
      ) : (
        <ActiveCallBody withVideo={callType === 'video'} />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  root: {
    position: 'absolute',
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
    zIndex: 102,
    elevation: 102,
  },
  fullscreen: {
    position: 'absolute',
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
  },
  minimizeButton: {
    position: 'absolute',
    right: 12,
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(255,255,255,0.12)',
  },
});
