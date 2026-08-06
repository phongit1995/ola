import { useEffect, useRef } from 'react';
import {
  Pressable,
  StyleSheet,
  Text,
  useWindowDimensions,
  View,
} from 'react-native';
import Animated, {
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
  ZoomIn,
  ZoomOut,
} from 'react-native-reanimated';
import { Gesture, GestureDetector } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { Track } from 'livekit-client';
import { isTrackReference, useTracks } from '@livekit/components-react';
import { VideoTrack } from '@livekit/react-native';
import {
  CALL_MINI_BOTTOM_GAP,
  CALL_MINI_EDGE_GAP,
  CALL_MINI_HEIGHT,
  CALL_MINI_WIDTH,
} from '@ola/shared/constants';
import { colorForName } from '@ola/shared/lib';
import { Avatar } from '@components/ui/Avatar';
import { useCallStore } from '@store/callStore';
import { EndCallIcon, ExpandIcon, MicIcon, MicOffIcon } from './icons';
import { useCallMediaToggle } from './hooks/useCallMediaToggle';

const DRAG_START_DISTANCE = 4;

function clampWorklet(value: number, min: number, max: number): number {
  'worklet';
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

interface CallMiniWidgetProps {
  peerName: string;
  statusLabel: string;
  isVideo: boolean;
}

export function CallMiniWidget({
  peerName,
  statusLabel,
  isVideo,
}: CallMiniWidgetProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const peerAvatar = useCallStore(s => s.active?.peer.avatar);
  const miniPos = useCallStore(s => s.miniPos);
  const setMiniPos = useCallStore(s => s.setMiniPos);
  const setExpanded = useCallStore(s => s.setExpanded);
  const endActive = useCallStore(s => s.endActive);
  const { micMuted, toggleMic } = useCallMediaToggle();
  const tracks = useTracks([Track.Source.Camera], { onlySubscribed: false });
  const remoteTrack = tracks.find(item => !item.participant.isLocal);
  const showVideo = isVideo && isTrackReference(remoteTrack);

  const baseLeft = windowWidth - CALL_MINI_EDGE_GAP - CALL_MINI_WIDTH;
  const baseTop =
    windowHeight - insets.bottom - CALL_MINI_BOTTOM_GAP - CALL_MINI_HEIGHT;
  const minTranslateX = CALL_MINI_EDGE_GAP - baseLeft;
  const maxTranslateX =
    windowWidth - CALL_MINI_WIDTH - CALL_MINI_EDGE_GAP - baseLeft;
  const minTranslateY = insets.top + CALL_MINI_EDGE_GAP - baseTop;
  const maxTranslateY =
    windowHeight - insets.bottom - CALL_MINI_EDGE_GAP - CALL_MINI_HEIGHT - baseTop;

  const positionRef = useRef(miniPos ?? { x: 0, y: 0 });
  const tx = useSharedValue(
    clampWorklet(positionRef.current.x, minTranslateX, maxTranslateX),
  );
  const ty = useSharedValue(
    clampWorklet(positionRef.current.y, minTranslateY, maxTranslateY),
  );
  const startX = useSharedValue(0);
  const startY = useSharedValue(0);

  useEffect(() => {
    const next = {
      x: clampWorklet(positionRef.current.x, minTranslateX, maxTranslateX),
      y: clampWorklet(positionRef.current.y, minTranslateY, maxTranslateY),
    };
    positionRef.current = next;
    tx.value = next.x;
    ty.value = next.y;
    setMiniPos(next);
  }, [maxTranslateX, maxTranslateY, minTranslateX, minTranslateY, setMiniPos, tx, ty]);

  function commitPosition(x: number, y: number) {
    const next = { x, y };
    positionRef.current = next;
    setMiniPos(next);
  }

  const dragGesture = Gesture.Pan()
    .minDistance(DRAG_START_DISTANCE)
    .maxPointers(1)
    .onStart(() => {
      startX.value = tx.value;
      startY.value = ty.value;
    })
    .onUpdate(event => {
      tx.value = clampWorklet(
        startX.value + event.translationX,
        minTranslateX,
        maxTranslateX,
      );
      ty.value = clampWorklet(
        startY.value + event.translationY,
        minTranslateY,
        maxTranslateY,
      );
    })
    .onFinalize(() => {
      runOnJS(commitPosition)(tx.value, ty.value);
    });

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: tx.value }, { translateY: ty.value }],
  }));

  return (
    <GestureDetector gesture={dragGesture}>
      <Animated.View
        entering={ZoomIn.duration(200)}
        exiting={ZoomOut.duration(150)}
        style={[styles.card, { left: baseLeft, top: baseTop }, animatedStyle]}
      >
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('call.expand')}
          onPress={() => setExpanded(true)}
          style={styles.body}
        >
          {showVideo && (
            <VideoTrack
              trackRef={remoteTrack}
              objectFit="cover"
              zOrder={1}
              style={StyleSheet.absoluteFill}
            />
          )}
          <View style={styles.scrim} pointerEvents="box-none">
            <View style={styles.headerRow} pointerEvents="none">
              {!showVideo && (
                <Avatar
                  name={peerName}
                  uri={peerAvatar}
                  size={32}
                  color={colorForName(peerName)}
                />
              )}
              <View style={styles.headerText}>
                <Text style={styles.name} numberOfLines={1}>
                  {peerName}
                </Text>
                <Text style={styles.status} numberOfLines={1}>
                  {statusLabel}
                </Text>
              </View>
            </View>
            <View style={styles.buttonRow}>
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={micMuted ? t('call.unmute') : t('call.mute')}
                onPress={() => void toggleMic()}
                style={styles.button}
              >
                {micMuted ? <MicOffIcon size={16} /> : <MicIcon size={16} />}
              </Pressable>
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('call.expand')}
                onPress={() => setExpanded(true)}
                style={styles.button}
              >
                <ExpandIcon size={16} />
              </Pressable>
              <Pressable
                accessibilityRole="button"
                accessibilityLabel={t('call.endCall')}
                onPress={() => void endActive()}
                style={[styles.button, styles.endButton]}
              >
                <EndCallIcon size={16} />
              </Pressable>
            </View>
          </View>
        </Pressable>
      </Animated.View>
    </GestureDetector>
  );
}

const styles = StyleSheet.create({
  card: {
    position: 'absolute',
    width: CALL_MINI_WIDTH,
    height: CALL_MINI_HEIGHT,
    borderRadius: 16,
    overflow: 'hidden',
    zIndex: 101,
    elevation: 101,
    backgroundColor: '#33691e',
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.28,
    shadowRadius: 5,
  },
  body: {
    flex: 1,
  },
  scrim: {
    position: 'absolute',
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
    justifyContent: 'space-between',
    padding: 8,
    backgroundColor: 'rgba(0,0,0,0.35)',
  },
  headerRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  headerText: {
    flex: 1,
    minWidth: 0,
  },
  name: {
    color: '#ffffff',
    fontSize: 12,
    fontWeight: '600',
  },
  status: {
    color: 'rgba(255,255,255,0.7)',
    fontSize: 11,
  },
  buttonRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  button: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(255,255,255,0.15)',
  },
  endButton: {
    backgroundColor: '#e34545',
  },
});
