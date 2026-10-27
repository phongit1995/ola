import { useCallback, useEffect, useMemo, useRef, useState, type ComponentRef } from 'react';
import type { View } from 'react-native';
import { Gesture } from 'react-native-gesture-handler';
import {
  clampMomentScale,
  isNearMomentCenter,
  settleMomentAngle,
  snapMomentPoint,
} from '@ola/shared/lib';
import type { MomentOverlay } from '@ola/shared/types';
import { hapticImpact, hapticTick } from '@lib/haptics';
import type { MomentCanvasSize } from './components/MomentCanvas';

const TAP_SLOP_PX = 4;
const TRASH_HIT_PADDING_PX = 16;

interface Rect {
  x: number;
  y: number;
  width: number;
  height: number;
}

interface Point {
  x: number;
  y: number;
}

interface DragState {
  id: string;
  origin: Point;
  slop: Point;
}

interface PanPoint {
  absoluteX: number;
  absoluteY: number;
  translationX: number;
  translationY: number;
}

interface DragFeedback {
  snapX: boolean;
  snapY: boolean;
  overTrash: boolean;
}

type TransformKind = 'pinch' | 'rotation';

interface TransformState {
  id: string;
  scale: number;
  rotation: number;
  pinch: number;
  turnDeg: number;
  active: Set<TransformKind>;
}

interface OverlayGestureOptions {
  overlays: readonly MomentOverlay[];
  canvas: MomentCanvasSize | null;
  onUpdate: (id: string, patch: Partial<MomentOverlay>) => void;
  onRemove: (id: string) => void;
  onRaise: (id: string) => void;
  onTap: (id: string) => void;
}

function useLatest<T>(value: T) {
  const ref = useRef(value);
  useEffect(() => {
    ref.current = value;
  }, [value]);
  return ref;
}

export function useOverlayGestures({
  overlays,
  canvas,
  onUpdate,
  onRemove,
  onRaise,
  onTap,
}: OverlayGestureOptions) {
  const [dragging, setDragging] = useState(false);
  const [overTrash, setOverTrash] = useState(false);
  const [verticalGuide, setVerticalGuide] = useState(false);
  const [horizontalGuide, setHorizontalGuide] = useState(false);
  const overlaysRef = useLatest(overlays);
  const canvasRef = useLatest(canvas);
  const callbacksRef = useLatest({ onUpdate, onRemove, onRaise, onTap });
  const trashRef = useRef<ComponentRef<typeof View>>(null);
  const trashRectRef = useRef<Rect | null>(null);
  const dragRef = useRef<DragState | null>(null);
  const touchDownRef = useRef<(Point & { id: string }) | null>(null);
  const feedbackRef = useRef<DragFeedback>({ snapX: false, snapY: false, overTrash: false });
  const transformRef = useRef<TransformState | null>(null);
  const targetRef = useRef<string | null>(null);

  const findOverlay = useCallback(
    (id: string | null) => overlaysRef.current.find((overlay) => overlay.id === id),
    [overlaysRef]
  );

  const isOverTrash = useCallback((x: number, y: number) => {
    const rect = trashRectRef.current;
    if (rect == null) return false;
    return (
      x >= rect.x - TRASH_HIT_PADDING_PX &&
      x <= rect.x + rect.width + TRASH_HIT_PADDING_PX &&
      y >= rect.y - TRASH_HIT_PADDING_PX &&
      y <= rect.y + rect.height + TRASH_HIT_PADDING_PX
    );
  }, []);

  const measureTrash = useCallback(() => {
    trashRef.current?.measureInWindow((x, y, width, height) => {
      trashRectRef.current = { x, y, width, height };
    });
  }, []);

  const resetDrag = useCallback(() => {
    dragRef.current = null;
    trashRectRef.current = null;
    setDragging(false);
    setOverTrash(false);
    setVerticalGuide(false);
    setHorizontalGuide(false);
  }, []);

  const beginDrag = useCallback(
    (id: string, event: PanPoint) => {
      const overlay = findOverlay(id);
      if (overlay == null) return;
      const touchDown = touchDownRef.current?.id === id ? touchDownRef.current : null;
      targetRef.current = id;
      dragRef.current = {
        id,
        origin: { x: overlay.x, y: overlay.y },
        slop:
          touchDown == null
            ? { x: 0, y: 0 }
            : {
                x: event.absoluteX - touchDown.x - event.translationX,
                y: event.absoluteY - touchDown.y - event.translationY,
              },
      };
      feedbackRef.current = {
        snapX: isNearMomentCenter(overlay.x),
        snapY: isNearMomentCenter(overlay.y),
        overTrash: false,
      };
      setDragging(true);
    },
    [findOverlay]
  );

  const moveDrag = useCallback(
    (id: string, event: PanPoint) => {
      const drag = dragRef.current;
      const size = canvasRef.current;
      if (drag == null || drag.id !== id || size == null) return;
      const point = snapMomentPoint(
        drag.origin.x + (event.translationX + drag.slop.x) / size.width,
        drag.origin.y + (event.translationY + drag.slop.y) / size.height
      );
      const overTrashNow = isOverTrash(event.absoluteX, event.absoluteY);
      const feedback = feedbackRef.current;
      if ((point.snapX && !feedback.snapX) || (point.snapY && !feedback.snapY)) hapticTick();
      if (overTrashNow && !feedback.overTrash) hapticImpact();
      feedbackRef.current = { snapX: point.snapX, snapY: point.snapY, overTrash: overTrashNow };
      setVerticalGuide(point.snapX);
      setHorizontalGuide(point.snapY);
      setOverTrash(overTrashNow);
      callbacksRef.current.onUpdate(id, { x: point.x, y: point.y });
    },
    [canvasRef, callbacksRef, isOverTrash]
  );

  const endDrag = useCallback(
    (id: string, absoluteX: number, absoluteY: number) => {
      if (dragRef.current?.id === id) {
        if (isOverTrash(absoluteX, absoluteY)) callbacksRef.current.onRemove(id);
        else callbacksRef.current.onRaise(id);
      }
      resetDrag();
    },
    [callbacksRef, isOverTrash, resetDrag]
  );

  const beginTransform = useCallback((kind: TransformKind) => {
    if (transformRef.current != null) {
      transformRef.current.active.add(kind);
      return;
    }
    const target =
      findOverlay(targetRef.current) ?? overlaysRef.current[overlaysRef.current.length - 1];
    if (target == null) return;
    transformRef.current = {
      id: target.id,
      scale: target.scale,
      rotation: target.rotation,
      pinch: 1,
      turnDeg: 0,
      active: new Set([kind]),
    };
  }, [findOverlay, overlaysRef]);

  const applyTransform = useCallback(
    (patch: { pinch?: number; turnDeg?: number }) => {
      const transform = transformRef.current;
      if (transform == null) return;
      if (patch.pinch != null) transform.pinch = patch.pinch;
      if (patch.turnDeg != null) transform.turnDeg = patch.turnDeg;
      callbacksRef.current.onUpdate(transform.id, {
        scale: clampMomentScale(transform.scale * transform.pinch),
        rotation: settleMomentAngle(transform.rotation + transform.turnDeg),
      });
    },
    [callbacksRef]
  );

  const endTransform = useCallback((kind: TransformKind) => {
    const transform = transformRef.current;
    if (transform == null || !transform.active.delete(kind)) return;
    if (transform.active.size > 0) return;
    transformRef.current = null;
    callbacksRef.current.onRaise(transform.id);
  }, [callbacksRef]);

  const canvasGesture = useMemo(() => {
    const pinch = Gesture.Pinch()
      .runOnJS(true)
      .onStart(() => beginTransform('pinch'))
      .onUpdate((event) => applyTransform({ pinch: event.scale }))
      .onFinalize(() => endTransform('pinch'));
    const rotation = Gesture.Rotation()
      .runOnJS(true)
      .onStart(() => beginTransform('rotation'))
      .onUpdate((event) => applyTransform({ turnDeg: (event.rotation * 180) / Math.PI }))
      .onFinalize(() => endTransform('rotation'));
    return { pinch, rotation, composed: Gesture.Simultaneous(pinch, rotation) };
  }, [beginTransform, applyTransform, endTransform]);

  const overlayGesture = useCallback(
    (id: string) => {
      const pan = Gesture.Pan()
        .runOnJS(true)
        .minDistance(TAP_SLOP_PX)
        .averageTouches(true)
        .simultaneousWithExternalGesture(canvasGesture.pinch, canvasGesture.rotation)
        .onBegin((event) => {
          if (touchDownRef.current != null && touchDownRef.current.id !== id) return;
          touchDownRef.current = { id, x: event.absoluteX, y: event.absoluteY };
          targetRef.current = id;
        })
        .onStart((event) => beginDrag(id, event))
        .onUpdate((event) => moveDrag(id, event))
        .onEnd((event) => endDrag(id, event.absoluteX, event.absoluteY))
        .onFinalize(() => {
          if (touchDownRef.current?.id === id) touchDownRef.current = null;
          if (dragRef.current?.id === id) resetDrag();
        });
      const tap = Gesture.Tap()
        .runOnJS(true)
        .onEnd((_event, success) => {
          if (!success) return;
          targetRef.current = id;
          callbacksRef.current.onTap(id);
        });
      return Gesture.Race(pan, tap);
    },
    [canvasGesture, beginDrag, moveDrag, endDrag, resetDrag, callbacksRef]
  );

  return {
    dragging,
    overTrash,
    verticalGuide,
    horizontalGuide,
    trashRef,
    measureTrash,
    canvasGesture: canvasGesture.composed,
    overlayGesture,
  };
}
