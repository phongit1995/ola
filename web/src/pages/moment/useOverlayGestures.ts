import {
  useRef,
  useState,
  type PointerEvent,
  type RefObject,
  type WheelEvent,
} from 'react';
import { clampMomentScale, settleMomentAngle, snapMomentPoint } from '@lib';
import type { MomentOverlay } from '@app-types';

interface Point {
  x: number;
  y: number;
}

type Gesture =
  | {
      kind: 'drag';
      id: string;
      start: Point;
      origin: Point;
      moved: boolean;
      wasSelected: boolean;
    }
  | {
      kind: 'pinch' | 'transform';
      id: string;
      center: Point | null;
      startDist: number;
      startAngle: number;
      scale: number;
      rotation: number;
    };

const TAP_SLOP_PX = 4;
const WHEEL_SCALE_STEP = 0.0015;
const TRASH_HIT_PADDING_PX = 16;

function distance(a: Point, b: Point): number {
  return Math.max(1, Math.hypot(b.x - a.x, b.y - a.y));
}

function angleDeg(a: Point, b: Point): number {
  return (Math.atan2(b.y - a.y, b.x - a.x) * 180) / Math.PI;
}

function pointOf(event: PointerEvent<HTMLElement>): Point {
  return { x: event.clientX, y: event.clientY };
}

interface OverlayGestureOptions {
  overlays: readonly MomentOverlay[];
  layerRef: RefObject<HTMLDivElement | null>;
  trashRef: RefObject<HTMLDivElement | null>;
  onUpdate: (id: string, patch: Partial<MomentOverlay>) => void;
  onRemove: (id: string) => void;
  onRaise: (id: string) => void;
  onTap: (id: string, wasSelected: boolean) => void;
}

export function useOverlayGestures({
  overlays,
  layerRef,
  trashRef,
  onUpdate,
  onRemove,
  onRaise,
  onTap,
}: OverlayGestureOptions) {
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [dragging, setDragging] = useState(false);
  const [overTrash, setOverTrash] = useState(false);
  const [verticalGuide, setVerticalGuide] = useState(false);
  const [horizontalGuide, setHorizontalGuide] = useState(false);
  const gestureRef = useRef<Gesture | null>(null);
  const pointersRef = useRef(new Map<number, Point>());

  function isOverTrash(point: Point): boolean {
    const rect = trashRef.current?.getBoundingClientRect();
    if (rect == null) return false;
    return (
      point.x >= rect.left - TRASH_HIT_PADDING_PX &&
      point.x <= rect.right + TRASH_HIT_PADDING_PX &&
      point.y >= rect.top - TRASH_HIT_PADDING_PX &&
      point.y <= rect.bottom + TRASH_HIT_PADDING_PX
    );
  }

  function resetDragState() {
    setDragging(false);
    setOverTrash(false);
    setVerticalGuide(false);
    setHorizontalGuide(false);
  }

  function rotateAndScale(id: string, from: Point, to: Point) {
    const gesture = gestureRef.current;
    if (gesture == null || gesture.kind === 'drag') return;
    onUpdate(id, {
      scale: clampMomentScale((gesture.scale * distance(from, to)) / gesture.startDist),
      rotation: settleMomentAngle(gesture.rotation + angleDeg(from, to) - gesture.startAngle),
    });
  }

  function beginPinch(overlay: MomentOverlay) {
    const [a, b] = [...pointersRef.current.values()];
    if (a == null || b == null) return;
    gestureRef.current = {
      kind: 'pinch',
      id: overlay.id,
      center: null,
      startDist: distance(a, b),
      startAngle: angleDeg(a, b),
      scale: overlay.scale,
      rotation: overlay.rotation,
    };
    resetDragState();
  }

  function movePinch() {
    const gesture = gestureRef.current;
    if (gesture?.kind !== 'pinch') return;
    const [a, b] = [...pointersRef.current.values()];
    if (a != null && b != null) rotateAndScale(gesture.id, a, b);
  }

  function endPinchWhenReleased() {
    const gesture = gestureRef.current;
    if (gesture?.kind !== 'pinch' || pointersRef.current.size > 0) return;
    gestureRef.current = null;
    onRaise(gesture.id);
  }

  function moveDrag(overlay: MomentOverlay, point: Point) {
    const gesture = gestureRef.current;
    if (gesture?.kind !== 'drag') return;
    const dx = point.x - gesture.start.x;
    const dy = point.y - gesture.start.y;
    if (!gesture.moved && Math.hypot(dx, dy) < TAP_SLOP_PX) return;
    const rect = layerRef.current?.getBoundingClientRect();
    if (rect == null) return;
    if (!gesture.moved) {
      gesture.moved = true;
      setDragging(true);
    }
    const snapped = snapMomentPoint(
      gesture.origin.x + dx / rect.width,
      gesture.origin.y + dy / rect.height
    );
    setVerticalGuide(snapped.snapX);
    setHorizontalGuide(snapped.snapY);
    setOverTrash(isOverTrash(point));
    onUpdate(overlay.id, { x: snapped.x, y: snapped.y });
  }

  function finish(event: PointerEvent<HTMLElement>, overlay: MomentOverlay, cancelled: boolean) {
    pointersRef.current.delete(event.pointerId);
    const gesture = gestureRef.current;
    if (gesture == null || gesture.id !== overlay.id) return;
    if (gesture.kind === 'pinch') {
      endPinchWhenReleased();
      return;
    }
    if (gesture.kind !== 'drag') return;
    gestureRef.current = null;
    resetDragState();
    if (cancelled) return;
    if (!gesture.moved) {
      onTap(overlay.id, gesture.wasSelected);
      return;
    }
    if (isOverTrash(pointOf(event))) {
      setSelectedId(null);
      onRemove(overlay.id);
      return;
    }
    onRaise(overlay.id);
  }

  function overlayHandlers(overlay: MomentOverlay) {
    return {
      onPointerDown: (event: PointerEvent<HTMLElement>) => {
        event.stopPropagation();
        event.currentTarget.setPointerCapture(event.pointerId);
        const point = pointOf(event);
        pointersRef.current.set(event.pointerId, point);
        if (pointersRef.current.size >= 2) {
          beginPinch(overlay);
          return;
        }
        gestureRef.current = {
          kind: 'drag',
          id: overlay.id,
          start: point,
          origin: { x: overlay.x, y: overlay.y },
          moved: false,
          wasSelected: selectedId === overlay.id,
        };
        setSelectedId(overlay.id);
      },
      onPointerMove: (event: PointerEvent<HTMLElement>) => {
        if (!pointersRef.current.has(event.pointerId)) return;
        const point = pointOf(event);
        pointersRef.current.set(event.pointerId, point);
        const gesture = gestureRef.current;
        if (gesture == null || gesture.id !== overlay.id) return;
        if (gesture.kind === 'pinch') {
          movePinch();
          return;
        }
        moveDrag(overlay, point);
      },
      onPointerUp: (event: PointerEvent<HTMLElement>) => finish(event, overlay, false),
      onPointerCancel: (event: PointerEvent<HTMLElement>) => finish(event, overlay, true),
      onWheel: (event: WheelEvent<HTMLElement>) => {
        if (selectedId !== overlay.id) return;
        onUpdate(overlay.id, {
          scale: clampMomentScale(overlay.scale * (1 - event.deltaY * WHEEL_SCALE_STEP)),
        });
      },
    };
  }

  function layerHandlers() {
    const release = (event: PointerEvent<HTMLElement>) => {
      pointersRef.current.delete(event.pointerId);
      endPinchWhenReleased();
    };
    return {
      onPointerDown: (event: PointerEvent<HTMLElement>) => {
        const gesture = gestureRef.current;
        const target =
          gesture?.kind === 'drag' ? overlays.find((overlay) => overlay.id === gesture.id) : undefined;
        if (target == null || pointersRef.current.size !== 1) {
          setSelectedId(null);
          return;
        }
        event.currentTarget.setPointerCapture(event.pointerId);
        pointersRef.current.set(event.pointerId, pointOf(event));
        beginPinch(target);
      },
      onPointerMove: (event: PointerEvent<HTMLElement>) => {
        if (!pointersRef.current.has(event.pointerId)) return;
        pointersRef.current.set(event.pointerId, pointOf(event));
        movePinch();
      },
      onPointerUp: release,
      onPointerCancel: release,
    };
  }

  function resizeHandlers(overlay: MomentOverlay) {
    return {
      onPointerDown: (event: PointerEvent<HTMLElement>) => {
        event.stopPropagation();
        event.currentTarget.setPointerCapture(event.pointerId);
        const rect = layerRef.current?.getBoundingClientRect();
        if (rect == null) return;
        const center = {
          x: rect.left + overlay.x * rect.width,
          y: rect.top + overlay.y * rect.height,
        };
        const point = pointOf(event);
        gestureRef.current = {
          kind: 'transform',
          id: overlay.id,
          center,
          startDist: distance(center, point),
          startAngle: angleDeg(center, point),
          scale: overlay.scale,
          rotation: overlay.rotation,
        };
      },
      onPointerMove: (event: PointerEvent<HTMLElement>) => {
        event.stopPropagation();
        const gesture = gestureRef.current;
        if (gesture?.kind !== 'transform' || gesture.center == null) return;
        rotateAndScale(overlay.id, gesture.center, pointOf(event));
      },
      onPointerUp: (event: PointerEvent<HTMLElement>) => {
        event.stopPropagation();
        if (gestureRef.current?.kind === 'transform') gestureRef.current = null;
      },
      onPointerCancel: (event: PointerEvent<HTMLElement>) => {
        event.stopPropagation();
        if (gestureRef.current?.kind === 'transform') gestureRef.current = null;
      },
    };
  }

  return {
    selectedId,
    setSelectedId,
    dragging,
    overTrash,
    verticalGuide,
    horizontalGuide,
    overlayHandlers,
    layerHandlers,
    resizeHandlers,
  };
}
