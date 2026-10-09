import { useEffect, useRef, useState, type ReactNode } from 'react';
import { StyleSheet, useWindowDimensions } from 'react-native';
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
import { WARNING } from '@constants';
import { mmkvStorage } from '@platform/storage';
import {
  TRASH_TARGET_BOTTOM_GAP,
  TRASH_TARGET_SIZE,
  TRASH_TARGET_TOLERANCE,
  TrashTarget,
} from './TrashTarget';

interface BubblePosition {
  x: number;
  y: number;
}

export const FLOATING_BUBBLE_SIZE = 56;
const BUBBLE_EDGE_GAP = 8;
const BUBBLE_RIGHT = 16;
const DRAG_START_DISTANCE = 4;

function clamp(value: number, min: number, max: number): number {
  'worklet';
  if (min > max) return (min + max) / 2;
  return Math.min(Math.max(value, min), max);
}

function readBubblePosition(storageKey: string): BubblePosition {
  try {
    const raw = mmkvStorage.getItem(storageKey);
    if (!raw) return { x: 0, y: 0 };
    const parsed = JSON.parse(raw) as Partial<BubblePosition>;
    if (!Number.isFinite(parsed.x) || !Number.isFinite(parsed.y))
      return { x: 0, y: 0 };
    return { x: parsed.x as number, y: parsed.y as number };
  } catch {
    return { x: 0, y: 0 };
  }
}

function storeBubblePosition(storageKey: string, position: BubblePosition) {
  mmkvStorage.setItem(storageKey, JSON.stringify(position));
}

interface FloatingBubbleProps {
  storageKey: string;
  bottomGap: number;
  label: string;
  hint?: string;
  notify: boolean;
  overhangBottom?: number;
  onRestore: () => void;
  onClose: () => void;
  children: ReactNode;
}

export function FloatingBubble({
  storageKey,
  bottomGap,
  label,
  hint,
  notify,
  overhangBottom = 0,
  onRestore,
  onClose,
  children,
}: FloatingBubbleProps) {
  const insets = useSafeAreaInsets();
  const { width: windowWidth, height: windowHeight } = useWindowDimensions();
  const [initialPosition] = useState(() => readBubblePosition(storageKey));
  const positionRef = useRef(initialPosition);

  const baseLeft = windowWidth - BUBBLE_RIGHT - FLOATING_BUBBLE_SIZE;
  const baseTop =
    windowHeight - insets.bottom - bottomGap - FLOATING_BUBBLE_SIZE;
  const minTranslateX = BUBBLE_EDGE_GAP - baseLeft;
  const maxTranslateX =
    windowWidth - FLOATING_BUBBLE_SIZE - BUBBLE_EDGE_GAP - baseLeft;
  const minTranslateY = insets.top + BUBBLE_EDGE_GAP - baseTop;
  const maxTranslateY =
    windowHeight -
    insets.bottom -
    BUBBLE_EDGE_GAP -
    overhangBottom -
    FLOATING_BUBBLE_SIZE -
    baseTop;

  const tx = useSharedValue(
    clamp(initialPosition.x, minTranslateX, maxTranslateX),
  );
  const ty = useSharedValue(
    clamp(initialPosition.y, minTranslateY, maxTranslateY),
  );
  const startX = useSharedValue(0);
  const startY = useSharedValue(0);
  const notifyOpacity = useSharedValue(1);
  const overTarget = useSharedValue(0);
  const bubbleFade = useSharedValue(0);
  const [dragging, setDragging] = useState(false);
  const [overTrash, setOverTrash] = useState(false);

  useEffect(() => {
    const next = {
      x: clamp(positionRef.current.x, minTranslateX, maxTranslateX),
      y: clamp(positionRef.current.y, minTranslateY, maxTranslateY),
    };
    positionRef.current = next;
    tx.value = next.x;
    ty.value = next.y;
    storeBubblePosition(storageKey, next);
  }, [
    maxTranslateX,
    maxTranslateY,
    minTranslateX,
    minTranslateY,
    storageKey,
    tx,
    ty,
  ]);

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
    storeBubblePosition(storageKey, next);
  }

  function endBubbleDrag() {
    setDragging(false);
    setOverTrash(false);
  }

  const trashLeft = (windowWidth - TRASH_TARGET_SIZE) / 2;
  const trashTop =
    windowHeight - insets.bottom - TRASH_TARGET_BOTTOM_GAP - TRASH_TARGET_SIZE;

  function isBubbleInDropZone(x: number, y: number): boolean {
    'worklet';
    const centerX = baseLeft + x + FLOATING_BUBBLE_SIZE / 2;
    const centerY = baseTop + y + FLOATING_BUBBLE_SIZE / 2;
    return (
      centerX >= trashLeft - TRASH_TARGET_TOLERANCE &&
      centerX <= trashLeft + TRASH_TARGET_SIZE + TRASH_TARGET_TOLERANCE &&
      centerY >= trashTop - TRASH_TARGET_TOLERANCE
    );
  }

  const dragGesture = Gesture.Pan()
    .minDistance(DRAG_START_DISTANCE)
    .maxPointers(1)
    .onStart(() => {
      startX.value = tx.value;
      startY.value = ty.value;
      runOnJS(setDragging)(true);
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
      const hit = isBubbleInDropZone(tx.value, ty.value) ? 1 : 0;
      if (hit !== overTarget.value) {
        overTarget.value = hit;
        bubbleFade.value = withTiming(hit, { duration: 150 });
        runOnJS(setOverTrash)(hit === 1);
      }
    })
    .onFinalize(() => {
      const dropped = overTarget.value === 1;
      overTarget.value = 0;
      bubbleFade.value = 0;
      if (dropped) {
        tx.value = startX.value;
        ty.value = startY.value;
        runOnJS(onClose)();
      } else {
        runOnJS(commitBubblePosition)(tx.value, ty.value);
      }
      runOnJS(endBubbleDrag)();
    });

  const tapGesture = Gesture.Tap()
    .maxDistance(DRAG_START_DISTANCE)
    .onEnd((_event, success) => {
      if (success) runOnJS(onRestore)();
    });

  const bubbleAnimatedStyle = useAnimatedStyle(() => ({
    opacity: 1 - bubbleFade.value,
    transform: [
      { translateX: tx.value },
      { translateY: ty.value },
      { scale: 1 - bubbleFade.value * 0.25 },
    ],
  }));
  const notifyAnimatedStyle = useAnimatedStyle(() => ({
    opacity: notifyOpacity.value,
  }));

  return (
    <>
      <TrashTarget
        visible={dragging}
        active={overTrash}
        bottom={insets.bottom + TRASH_TARGET_BOTTOM_GAP}
      />
      <GestureDetector gesture={Gesture.Race(dragGesture, tapGesture)}>
        <Animated.View
          accessible
          accessibilityRole="button"
          accessibilityLabel={label}
          accessibilityHint={hint}
          onAccessibilityTap={onRestore}
          style={[
            styles.bubble,
            { bottom: insets.bottom + bottomGap },
            notify && styles.bubbleNotify,
            bubbleAnimatedStyle,
          ]}
        >
          {children}
          {notify && !overTrash && (
            <Animated.View
              pointerEvents="none"
              style={[styles.notifyDot, notifyAnimatedStyle]}
            />
          )}
        </Animated.View>
      </GestureDetector>
    </>
  );
}

const styles = StyleSheet.create({
  bubble: {
    position: 'absolute',
    right: BUBBLE_RIGHT,
    zIndex: 101,
    elevation: 101,
    width: FLOATING_BUBBLE_SIZE,
    height: FLOATING_BUBBLE_SIZE,
    borderRadius: FLOATING_BUBBLE_SIZE / 2,
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
