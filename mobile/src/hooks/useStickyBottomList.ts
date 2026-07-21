import { useCallback, useRef } from 'react';
import type { LayoutChangeEvent, NativeScrollEvent, NativeSyntheticEvent } from 'react-native';
import type { FlashListRef } from '@shopify/flash-list';

const STICK_THRESHOLD = 80;

export function useStickyBottomList<T>() {
  const listRef = useRef<FlashListRef<T>>(null);
  const stickRef = useRef(true);
  const suspendRef = useRef(false);
  const draggingRef = useRef(false);
  const momentumRef = useRef(false);
  const forceNextRef = useRef(false);
  const viewportHeightRef = useRef(0);
  const contentHeightRef = useRef(0);

  const pin = useCallback(() => {
    listRef.current?.scrollToOffset({
      offset: Math.max(0, contentHeightRef.current - viewportHeightRef.current),
      animated: false,
    });
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
      contentHeightRef.current = height;
      if (forceNextRef.current) {
        forceNextRef.current = false;
        pin();
      }
    },
    [pin]
  );

  const onScroll = useCallback((event: NativeSyntheticEvent<NativeScrollEvent>) => {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    contentHeightRef.current = contentSize.height;
    viewportHeightRef.current = layoutMeasurement.height;
    const distanceFromBottom = contentSize.height - contentOffset.y - layoutMeasurement.height;
    stickRef.current = distanceFromBottom < STICK_THRESHOLD;
  }, []);

  const onScrollBeginDrag = useCallback(() => {
    draggingRef.current = true;
  }, []);

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
      stickRef.current =
        contentSize.height - contentOffset.y - layoutMeasurement.height < STICK_THRESHOLD;
    },
    []
  );

  const pinOnNextContent = useCallback(() => {
    forceNextRef.current = true;
    stickRef.current = true;
  }, []);

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
    unstick,
  };
}
