import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  BackHandler,
  Image,
  Platform,
  Pressable,
  StyleSheet,
  View,
  useWindowDimensions,
} from 'react-native';
import Animated, {
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
} from 'react-native-reanimated';
import { Gesture, GestureDetector } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import WebView, { type WebViewMessageEvent } from 'react-native-webview';
import { ensureFreshToken } from '@ola/shared/api';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { mmkvStorage } from '@platform/storage';

interface GameBridgeMessage {
  source?: string;
  type?: string;
  data?: unknown;
}

interface BubblePosition {
  x: number;
  y: number;
}

const iconGameDefault = require('@assets/icons/apps/game.png');
const BUBBLE_POSITION_STORAGE_KEY = 'ola.arcade.bubble-position';
const BUBBLE_SIZE = 56;
const BUBBLE_EDGE_GAP = 8;
const BUBBLE_RIGHT = 16;
const BUBBLE_BOTTOM_GAP = 76;
const DRAG_START_DISTANCE = 4;

function clamp(value: number, min: number, max: number): number {
  'worklet';
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

function readBubblePosition(): BubblePosition {
  try {
    const raw = mmkvStorage.getItem(BUBBLE_POSITION_STORAGE_KEY);
    if (!raw) return { x: 0, y: 0 };
    const parsed = JSON.parse(raw) as Partial<BubblePosition>;
    if (!Number.isFinite(parsed.x) || !Number.isFinite(parsed.y))
      return { x: 0, y: 0 };
    return { x: parsed.x as number, y: parsed.y as number };
  } catch {
    return { x: 0, y: 0 };
  }
}

function storeBubblePosition(position: BubblePosition) {
  mmkvStorage.setItem(BUBBLE_POSITION_STORAGE_KEY, JSON.stringify(position));
}

export function ArcadeOverlay() {
  const { t } = useTranslation();
  const active = useArcadeOverlayStore(state => state.active);
  const minimized = useArcadeOverlayStore(state => state.minimized);
  const notify = useArcadeOverlayStore(state => state.notify);
  const minimize = useArcadeOverlayStore(state => state.minimize);
  const restore = useArcadeOverlayStore(state => state.restore);
  const setNotify = useArcadeOverlayStore(state => state.setNotify);
  const close = useArcadeOverlayStore(state => state.close);
  const insets = useSafeAreaInsets();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const webRef = useRef<WebView<object>>(null);
  const [initialPosition] = useState(readBubblePosition);
  const positionRef = useRef(initialPosition);

  const baseLeft = windowWidth - BUBBLE_RIGHT - BUBBLE_SIZE;
  const baseTop =
    windowHeight - insets.bottom - BUBBLE_BOTTOM_GAP - BUBBLE_SIZE;
  const minTranslateX = BUBBLE_EDGE_GAP - baseLeft;
  const maxTranslateX = windowWidth - BUBBLE_SIZE - BUBBLE_EDGE_GAP - baseLeft;
  const minTranslateY = insets.top + BUBBLE_EDGE_GAP - baseTop;
  const maxTranslateY =
    windowHeight - insets.bottom - BUBBLE_EDGE_GAP - BUBBLE_SIZE - baseTop;

  const tx = useSharedValue(
    clamp(initialPosition.x, minTranslateX, maxTranslateX),
  );
  const ty = useSharedValue(
    clamp(initialPosition.y, minTranslateY, maxTranslateY),
  );
  const startX = useSharedValue(0);
  const startY = useSharedValue(0);

  useEffect(() => {
    const next = {
      x: clamp(positionRef.current.x, minTranslateX, maxTranslateX),
      y: clamp(positionRef.current.y, minTranslateY, maxTranslateY),
    };
    positionRef.current = next;
    tx.value = next.x;
    ty.value = next.y;
    storeBubblePosition(next);
  }, [maxTranslateX, maxTranslateY, minTranslateX, minTranslateY, tx, ty]);

  useEffect(() => {
    if (!active || minimized) return;
    const subscription = BackHandler.addEventListener(
      'hardwareBackPress',
      () => {
        minimize();
        return true;
      },
    );
    return () => subscription.remove();
  }, [active, minimize, minimized]);

  function commitBubblePosition(x: number, y: number) {
    const next = {
      x: clamp(x, minTranslateX, maxTranslateX),
      y: clamp(y, minTranslateY, maxTranslateY),
    };
    positionRef.current = next;
    storeBubblePosition(next);
  }

  const dragGesture = Gesture.Pan()
    .minDistance(DRAG_START_DISTANCE)
    .maxPointers(1)
    .onStart(() => {
      startX.value = tx.value;
      startY.value = ty.value;
    })
    .onUpdate(event => {
      tx.value = clamp(
        startX.value + event.translationX,
        minTranslateX,
        maxTranslateX,
      );
      ty.value = clamp(
        startY.value + event.translationY,
        minTranslateY,
        maxTranslateY,
      );
    })
    .onFinalize(() => {
      runOnJS(commitBubblePosition)(tx.value, ty.value);
    });

  const tapGesture = Gesture.Tap()
    .maxDistance(DRAG_START_DISTANCE)
    .onEnd((_event, success) => {
      if (success) runOnJS(restore)();
    });

  const bubbleGesture = Gesture.Race(dragGesture, tapGesture);
  const bubbleAnimatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: tx.value }, { translateY: ty.value }],
  }));

  function sendToGame(message: {
    source: string;
    type: string;
    data?: unknown;
  }) {
    const payload = JSON.stringify(JSON.stringify(message));
    webRef.current?.injectJavaScript(
      `document.dispatchEvent(new MessageEvent('message',{data:${payload}}));true;`,
    );
  }

  async function handleGetToken() {
    try {
      const token = await ensureFreshToken();
      sendToGame({ source: 'ola-host', type: 'token', data: token });
    } catch {
      // The game bridge will fall back to its guest token timeout.
    }
  }

  function handleMessage(event: WebViewMessageEvent) {
    let message: GameBridgeMessage | null = null;
    try {
      message = JSON.parse(event.nativeEvent.data) as GameBridgeMessage;
    } catch {
      return;
    }
    if (message?.source !== 'ola-game') return;
    if (message.type === 'get_token') void handleGetToken();
    if (
      minimized &&
      (message.type === 'game_over' ||
        (message.type === 'turn_changed' &&
          (message.data as { yourTurn?: boolean } | undefined)?.yourTurn ===
            true))
    ) {
      setNotify(true);
    }
    if (message.type === 'exit') close();
  }

  if (!active) return null;

  const androidInsets =
    Platform.OS === 'android'
      ? { paddingTop: insets.top, paddingBottom: insets.bottom }
      : undefined;

  return (
    <>
      <View
        pointerEvents={minimized ? 'none' : 'auto'}
        accessibilityElementsHidden={minimized}
        importantForAccessibility={minimized ? 'no-hide-descendants' : 'auto'}
        style={[
          styles.gameOverlay,
          androidInsets,
          { opacity: minimized ? 0 : 1 },
        ]}
      >
        <WebView<object>
          ref={webRef}
          source={{ uri: active.gameUrl }}
          onMessage={handleMessage}
          style={styles.webView}
          allowsInlineMediaPlayback
          mediaPlaybackRequiresUserAction={false}
        />
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('arcade.minimize')}
          onPress={minimize}
          style={[styles.minimizeButton, { top: insets.top + 12 }]}
        >
          <View style={styles.minimizeLine} />
        </Pressable>
      </View>

      {minimized && (
        <GestureDetector gesture={bubbleGesture}>
          <Animated.View
            accessible
            accessibilityRole="button"
            accessibilityLabel={t('arcade.restore')}
            accessibilityHint={t('arcade.restore')}
            onAccessibilityTap={restore}
            style={[
              styles.bubble,
              { bottom: insets.bottom + BUBBLE_BOTTOM_GAP },
              notify && styles.bubbleNotify,
              bubbleAnimatedStyle,
            ]}
          >
            <Image
              source={
                active.iconUrl ? { uri: active.iconUrl } : iconGameDefault
              }
              style={styles.bubbleIcon}
              resizeMode="cover"
            />
            {notify && <View pointerEvents="none" style={styles.notifyDot} />}
          </Animated.View>
        </GestureDetector>
      )}
    </>
  );
}

const styles = StyleSheet.create({
  gameOverlay: {
    position: 'absolute',
    top: 0,
    right: 0,
    bottom: 0,
    left: 0,
    zIndex: 100,
    elevation: 100,
    backgroundColor: '#141428',
  },
  webView: {
    flex: 1,
    backgroundColor: '#141428',
  },
  minimizeButton: {
    position: 'absolute',
    right: 12,
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.45)',
  },
  minimizeLine: {
    width: 16,
    height: 2,
    borderRadius: 1,
    backgroundColor: '#ffffff',
  },
  bubble: {
    position: 'absolute',
    right: BUBBLE_RIGHT,
    zIndex: 101,
    elevation: 101,
    width: BUBBLE_SIZE,
    height: BUBBLE_SIZE,
    borderRadius: BUBBLE_SIZE / 2,
    borderWidth: 2,
    borderColor: '#ffffff',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#ffffff',
    shadowColor: '#000000',
    shadowOffset: { width: 0, height: 3 },
    shadowOpacity: 0.28,
    shadowRadius: 5,
  },
  bubbleNotify: {
    borderColor: '#ff4081',
  },
  bubbleIcon: {
    width: BUBBLE_SIZE - 4,
    height: BUBBLE_SIZE - 4,
    borderRadius: (BUBBLE_SIZE - 4) / 2,
  },
  notifyDot: {
    position: 'absolute',
    top: -2,
    right: -2,
    width: 14,
    height: 14,
    borderRadius: 7,
    borderWidth: 2,
    borderColor: '#ffffff',
    backgroundColor: '#ff4081',
  },
});
