import { useMemo } from 'react';
import { PanResponder, type GestureResponderHandlers } from 'react-native';

interface TabSwipeOptions {
  onSwipeLeft?: () => void;
  onSwipeRight?: () => void;
}

const ACTIVE_OFFSET_X = 24;
const HORIZONTAL_RATIO = 2;
const SWIPE_DISTANCE = 60;
const FLING_VELOCITY = 0.6;

export function useTabSwipeGesture({ onSwipeLeft, onSwipeRight }: TabSwipeOptions): GestureResponderHandlers {
  return useMemo(
    () =>
      PanResponder.create({
        onMoveShouldSetPanResponderCapture: (_event, { dx, dy }) =>
          Math.abs(dx) > ACTIVE_OFFSET_X && Math.abs(dx) > Math.abs(dy) * HORIZONTAL_RATIO,
        onPanResponderTerminationRequest: () => false,
        // Blocking native responders makes GestureHandlerRootView on Android cancel the JS touch right after grant.
        onShouldBlockNativeResponder: () => false,
        onPanResponderRelease: (_event, { dx, vx }) => {
          if (dx <= -SWIPE_DISTANCE || (dx < 0 && vx <= -FLING_VELOCITY)) onSwipeLeft?.();
          else if (dx >= SWIPE_DISTANCE || (dx > 0 && vx >= FLING_VELOCITY)) onSwipeRight?.();
        },
      }).panHandlers,
    [onSwipeLeft, onSwipeRight],
  );
}
