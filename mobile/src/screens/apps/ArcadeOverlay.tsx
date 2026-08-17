import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  BackHandler,
  Platform,
  Pressable,
  StyleSheet,
  View,
  useWindowDimensions,
} from 'react-native';
import Animated, {
  cancelAnimation,
  runOnJS,
  useAnimatedStyle,
  useSharedValue,
  withRepeat,
  withSequence,
  withTiming,
} from 'react-native-reanimated';
import { Gesture, GestureDetector } from 'react-native-gesture-handler';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import WebView, { type WebViewMessageEvent } from 'react-native-webview';
import { ensureFreshToken } from '@ola/shared/api';
import { ARCADE_BRIDGE_EVENT, ARCADE_BRIDGE_SOURCE } from '@ola/shared/constants';
import type { ArcadeBridgeMessage, ArcadeKenUpdatedData } from '@ola/shared/types';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { WARNING } from '@constants';
import { CachedImage } from '@components/ui/CachedImage';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { mmkvStorage } from '@platform/storage';
import { LEFT_MINIMIZE_GAME_SLUGS } from './constants';

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
  const close = useArcadeOverlayStore(state => state.close);
  const ken = useAuthStore(state => state.user?.ken);
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
  const notifyOpacity = useSharedValue(1);

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

  useEffect(() => {
    cancelAnimation(notifyOpacity);
    if (notify) {
      notifyOpacity.value = withRepeat(
        withSequence(
          withTiming(0.2, { duration: 450 }),
          withTiming(1, { duration: 450 }),
        ),
        -1,
      );
    } else {
      notifyOpacity.value = 1;
    }
    return () => cancelAnimation(notifyOpacity);
  }, [notify, notifyOpacity]);

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
  const notifyAnimatedStyle = useAnimatedStyle(() => ({
    opacity: notifyOpacity.value,
  }));

  const sendToGame = useCallback((message: ArcadeBridgeMessage) => {
    const payload = JSON.stringify(JSON.stringify(message));
    webRef.current?.injectJavaScript(
      `document.dispatchEvent(new MessageEvent('message',{data:${payload}}));true;`,
    );
  }, []);

  const sendKenToGame = useCallback(
    (nextKen: number | undefined) => {
      if (
        typeof nextKen !== 'number' ||
        !Number.isSafeInteger(nextKen) ||
        nextKen < 0
      ) {
        return;
      }
      sendToGame({
        source: ARCADE_BRIDGE_SOURCE.Host,
        type: ARCADE_BRIDGE_EVENT.KenUpdated,
        data: { ken: nextKen } satisfies ArcadeKenUpdatedData,
      });
    },
    [sendToGame],
  );

  useEffect(() => {
    sendKenToGame(ken);
  }, [ken, sendKenToGame]);

  async function handleGetToken() {
    try {
      const token = await ensureFreshToken();
      sendToGame({
        source: ARCADE_BRIDGE_SOURCE.Host,
        type: ARCADE_BRIDGE_EVENT.Token,
        data: token,
      });
    } catch {
      sendToGame({
        source: ARCADE_BRIDGE_SOURCE.Host,
        type: ARCADE_BRIDGE_EVENT.Token,
        data: null,
      });
    }
  }

  function handleMessage(event: WebViewMessageEvent) {
    let message: ArcadeBridgeMessage | null = null;
    try {
      message = JSON.parse(event.nativeEvent.data) as ArcadeBridgeMessage;
    } catch {
      return;
    }
    if (message?.source !== ARCADE_BRIDGE_SOURCE.Game) return;
    if (message.type === ARCADE_BRIDGE_EVENT.Ready) {
      sendKenToGame(useAuthStore.getState().user?.ken);
    }
    if (message.type === ARCADE_BRIDGE_EVENT.GetToken) void handleGetToken();
    if (message.type === ARCADE_BRIDGE_EVENT.RefreshUser) {
      void useAuthStore.getState().refreshUser();
    }
    const overlay = useArcadeOverlayStore.getState();
    if (
      overlay.minimized &&
      (message.type === ARCADE_BRIDGE_EVENT.AttentionRequired ||
        message.type === ARCADE_BRIDGE_EVENT.GameOver ||
        (message.type === ARCADE_BRIDGE_EVENT.TurnChanged &&
          (message.data as { yourTurn?: boolean } | undefined)?.yourTurn ===
            true))
    ) {
      overlay.setNotify(true);
    }
    if (message.type === ARCADE_BRIDGE_EVENT.Exit) close();
  }

  if (!active) return null;

  const minimizeOnLeft = LEFT_MINIMIZE_GAME_SLUGS.includes(active.slug);
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
          style={[
            styles.minimizeButton,
            { top: insets.top + 12 },
            minimizeOnLeft ? styles.minimizeLeft : styles.minimizeRight,
          ]}
        >
          <View style={styles.minimizeLine} />
        </Pressable>
      </View>

      {minimized && (
        <GestureDetector gesture={bubbleGesture}>
          <Animated.View
            accessible
            accessibilityRole="button"
            accessibilityLabel={
              notify
                ? `${t('arcade.restore')}. ${t('arcade.hasNotification')}`
                : t('arcade.restore')
            }
            accessibilityHint={t('arcade.restore')}
            onAccessibilityTap={restore}
            style={[
              styles.bubble,
              { bottom: insets.bottom + BUBBLE_BOTTOM_GAP },
              notify && styles.bubbleNotify,
              bubbleAnimatedStyle,
            ]}
          >
            <CachedImage
              uri={active.iconUrl || undefined}
              placeholder={iconGameDefault}
              style={styles.bubbleIcon}
              resizeMode="cover"
            />
            {notify && (
              <Animated.View
                pointerEvents="none"
                style={[styles.notifyDot, notifyAnimatedStyle]}
              />
            )}
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
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.45)',
  },
  minimizeLeft: {
    left: 12,
  },
  minimizeRight: {
    right: 12,
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
    borderColor: WARNING,
  },
  bubbleIcon: {
    width: BUBBLE_SIZE - 4,
    height: BUBBLE_SIZE - 4,
    borderRadius: (BUBBLE_SIZE - 4) / 2,
  },
  notifyDot: {
    position: 'absolute',
    top: -4,
    right: -4,
    width: 16,
    height: 16,
    borderRadius: 8,
    borderWidth: 2,
    borderColor: '#ffffff',
    backgroundColor: WARNING,
  },
});
