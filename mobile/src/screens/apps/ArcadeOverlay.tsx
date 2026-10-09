import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  BackHandler,
  Platform,
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
import { ARCADE_BRIDGE_EVENT, ARCADE_BRIDGE_SOURCE } from '@ola/shared/constants';
import type { ArcadeBridgeMessage, ArcadeKenUpdatedData } from '@ola/shared/types';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { CachedImage } from '@components/ui/CachedImage';
import {
  FLOATING_BUBBLE_SIZE,
  FloatingBubble,
} from '@components/ui/FloatingBubble';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { mmkvStorage } from '@platform/storage';

interface BubblePosition {
  x: number;
  y: number;
}

const BUBBLE_POSITION_STORAGE_KEY = 'ola.arcade.bubble-position';
const MINIMIZE_POSITION_STORAGE_KEY = 'ola.arcade.minimize-position';
const MINIMIZE_SIZE = 36;
const MINIMIZE_EDGE_GAP = 8;
const MINIMIZE_INSET = 12;
const MINIMIZE_SAFE_LIFT = 12;
const BUBBLE_BOTTOM_GAP = 76;
const DRAG_START_DISTANCE = 4;

function clamp(value: number, min: number, max: number): number {
  'worklet';
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

function readMinimizePosition(slug: string): BubblePosition {
  try {
    const raw = mmkvStorage.getItem(MINIMIZE_POSITION_STORAGE_KEY);
    if (!raw) return { x: 0, y: 0 };
    const parsed = (JSON.parse(raw) as Record<string, Partial<BubblePosition>>)[
      slug
    ];
    if (
      parsed == null ||
      !Number.isFinite(parsed.x) ||
      !Number.isFinite(parsed.y)
    ) {
      return { x: 0, y: 0 };
    }
    return { x: parsed.x as number, y: parsed.y as number };
  } catch {
    return { x: 0, y: 0 };
  }
}

function storeMinimizePosition(slug: string, position: BubblePosition) {
  try {
    const raw = mmkvStorage.getItem(MINIMIZE_POSITION_STORAGE_KEY);
    const all = raw
      ? (JSON.parse(raw) as Record<string, BubblePosition>)
      : ({} as Record<string, BubblePosition>);
    all[slug] = position;
    mmkvStorage.setItem(MINIMIZE_POSITION_STORAGE_KEY, JSON.stringify(all));
  } catch {
    return;
  }
}

interface MinimizeHandleProps {
  slug: string;
  label: string;
  onMinimize: () => void;
}

function MinimizeHandle({ slug, label, onMinimize }: MinimizeHandleProps) {
  const insets = useSafeAreaInsets();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const [initialPosition] = useState(() => readMinimizePosition(slug));

  const overlayPadsInsets = Platform.OS === 'android';
  const safeTop = overlayPadsInsets ? 0 : insets.top;
  const contentHeight = overlayPadsInsets
    ? windowHeight - insets.top - insets.bottom
    : windowHeight - insets.bottom;
  const baseLeft = windowWidth - MINIMIZE_INSET - MINIMIZE_SIZE;
  const baseTop = safeTop + MINIMIZE_INSET;
  const minTranslateX = MINIMIZE_EDGE_GAP - baseLeft;
  const maxTranslateX =
    windowWidth - MINIMIZE_SIZE - MINIMIZE_EDGE_GAP - baseLeft;
  const minTop = Math.max(MINIMIZE_EDGE_GAP, safeTop - MINIMIZE_SAFE_LIFT);
  const minTranslateY = minTop - baseTop;
  const maxTranslateY =
    contentHeight - MINIMIZE_SIZE - MINIMIZE_EDGE_GAP - baseTop;

  const tx = useSharedValue(
    clamp(initialPosition.x, minTranslateX, maxTranslateX),
  );
  const ty = useSharedValue(
    clamp(initialPosition.y, minTranslateY, maxTranslateY),
  );
  const startX = useSharedValue(0);
  const startY = useSharedValue(0);

  function commitPosition(x: number, y: number) {
    storeMinimizePosition(slug, {
      x: clamp(x, minTranslateX, maxTranslateX),
      y: clamp(y, minTranslateY, maxTranslateY),
    });
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
      runOnJS(commitPosition)(tx.value, ty.value);
    });

  const tapGesture = Gesture.Tap()
    .maxDistance(DRAG_START_DISTANCE)
    .onEnd((_event, success) => {
      if (success) runOnJS(onMinimize)();
    });

  const animatedStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: tx.value }, { translateY: ty.value }],
  }));

  return (
    <GestureDetector gesture={Gesture.Race(dragGesture, tapGesture)}>
      <Animated.View
        accessible
        accessibilityRole="button"
        accessibilityLabel={label}
        onAccessibilityTap={onMinimize}
        style={[styles.minimizeButton, { top: baseTop }, animatedStyle]}
      >
        <View style={styles.minimizeLine} />
      </Animated.View>
    </GestureDetector>
  );
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
  const webRef = useRef<WebView<object>>(null);

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
        <MinimizeHandle
          key={active.slug}
          slug={active.slug}
          label={t('arcade.minimize')}
          onMinimize={minimize}
        />
      </View>

      {minimized && (
        <FloatingBubble
          storageKey={BUBBLE_POSITION_STORAGE_KEY}
          bottomGap={BUBBLE_BOTTOM_GAP}
          label={
            notify
              ? `${t('arcade.restore')}. ${t('arcade.hasNotification')}`
              : t('arcade.restore')
          }
          hint={t('arcade.restore')}
          notify={notify}
          onRestore={restore}
          onClose={close}
        >
          <CachedImage
            uri={active.iconUrl || undefined}
            showLoader
            loadingIndicatorColor="#ffffff"
            style={styles.bubbleIcon}
            resizeMode="cover"
          />
        </FloatingBubble>
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
    right: MINIMIZE_INSET,
    zIndex: 10,
    width: MINIMIZE_SIZE,
    height: MINIMIZE_SIZE,
    borderRadius: MINIMIZE_SIZE / 2,
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
  bubbleIcon: {
    width: FLOATING_BUBBLE_SIZE - 4,
    height: FLOATING_BUBBLE_SIZE - 4,
    borderRadius: (FLOATING_BUBBLE_SIZE - 4) / 2,
  },
});
