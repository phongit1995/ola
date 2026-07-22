import { useCallback, useEffect, useRef } from 'react';
import type { LayoutChangeEvent, NativeScrollEvent, NativeSyntheticEvent } from 'react-native';
import type { FlashListRef } from '@shopify/flash-list';

const STICK_THRESHOLD = 80;
const SETTLE_STEPS = [60, 150, 300, 500, 800, 1200];

export function useStickyBottomList<T>() {
  const listRef = useRef<FlashListRef<T>>(null);
  const stickRef = useRef(true);
  const suspendRef = useRef(false);
  const draggingRef = useRef(false);
  const momentumRef = useRef(false);
  const forceNextRef = useRef(false);
  const settlingRef = useRef(false);
  const settleTimersRef = useRef<Array<ReturnType<typeof setTimeout>>>([]);
  const viewportHeightRef = useRef(0);
  const contentHeightRef = useRef(0);

  const clearSettle = useCallback(() => {
    settlingRef.current = false;
    settleTimersRef.current.forEach(clearTimeout);
    settleTimersRef.current = [];
  }, []);

  useEffect(() => clearSettle, [clearSettle]);

  const pin = useCallback(() => {
    if (contentHeightRef.current <= 0) {
      forceNextRef.current = true;
      return;
    }
    listRef.current?.scrollToEnd({ animated: false });
  }, []);

  const shouldPin = useCallback(
    () => stickRef.current && !suspendRef.current && !draggingRef.current,
    []
  );

  const onListLayout = useCallback(
    (event: LayoutChangeEvent) => {
      viewportHeightRef.current = event.nativeEvent.layout.height;
      if (shouldPin()) pin();
    },
    [pin, shouldPin]
  );

  const onContentSizeChange = useCallback(
    (_width: number, height: number) => {
      const changed = height !== contentHeightRef.current;
      contentHeightRef.current = height;
      if (forceNextRef.current) {
        forceNextRef.current = false;
        pin();
        return;
      }
      if (changed && shouldPin()) pin();
    },
    [pin, shouldPin]
  );

  const onScroll = useCallback((event: NativeSyntheticEvent<NativeScrollEvent>) => {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    if (layoutMeasurement.height <= 0) return;
    contentHeightRef.current = contentSize.height;
    viewportHeightRef.current = layoutMeasurement.height;
    if (settlingRef.current) return;
    const distanceFromBottom = contentSize.height - contentOffset.y - layoutMeasurement.height;
    stickRef.current = distanceFromBottom < STICK_THRESHOLD;
  }, []);

  const onScrollBeginDrag = useCallback(() => {
    draggingRef.current = true;
    clearSettle();
  }, [clearSettle]);

  const onScrollEndDrag = useCallback(() => {
    draggingRef.current = false;
  }, []);

  const onMomentumScrollBegin = useCallback(() => {
    momentumRef.current = true;
  }, []);

  const onMomentumScrollEnd = useCallback(
    (event: NativeSyntheticEvent<NativeScrollEvent>) => {
      momentumRef.current = false;
      const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
      if (layoutMeasurement.height <= 0) return;
      stickRef.current =
        contentSize.height - contentOffset.y - layoutMeasurement.height < STICK_THRESHOLD;
    },
    []
  );

  const pinOnNextContent = useCallback(() => {
    forceNextRef.current = true;
    stickRef.current = true;
  }, []);

  const requestScrollToBottom = useCallback(() => {
    stickRef.current = true;
    settlingRef.current = true;
    pin();
    settleTimersRef.current.forEach(clearTimeout);
    settleTimersRef.current = SETTLE_STEPS.map((ms) =>
      setTimeout(() => {
        if (stickRef.current && !draggingRef.current) {
          listRef.current?.scrollToEnd({ animated: false });
        }
        if (ms === SETTLE_STEPS[SETTLE_STEPS.length - 1]) settlingRef.current = false;
      }, ms)
    );
  }, [pin]);

  const unstick = useCallback(() => {
    stickRef.current = false;
  }, []);

  return {
    listRef,
    suspendRef,
    onListLayout,
    onContentSizeChange,
    onScroll,
    onScrollBeginDrag,
    onScrollEndDrag,
    onMomentumScrollBegin,
    onMomentumScrollEnd,
    pinOnNextContent,
    requestScrollToBottom,
    unstick,
  };
}
