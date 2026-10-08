import { useCallback } from 'react';

const DRAG_THRESHOLD = 6;
const GRAB_CURSOR = 'grab';
const GRABBING_CURSOR = 'grabbing';

interface ScrollDrag {
  pointerId: number;
  startX: number;
  startY: number;
  scrollLeft: number;
  dragging: boolean;
}

function canScrollHorizontally(element: HTMLElement): boolean {
  return element.scrollWidth > element.clientWidth;
}

function bindHorizontalDragScroll(element: HTMLElement): () => void {
  let drag: ScrollDrag | null = null;
  let suppressClick = false;

  function updateCursor() {
    if (drag?.dragging) {
      element.style.cursor = GRABBING_CURSOR;
      return;
    }
    element.style.cursor = canScrollHorizontally(element) ? GRAB_CURSOR : '';
  }

  function stopDrag() {
    if (drag == null) return;
    const { pointerId } = drag;
    drag = null;
    window.removeEventListener('pointermove', onPointerMove);
    window.removeEventListener('pointerup', onPointerUp);
    window.removeEventListener('pointercancel', onPointerCancel);
    window.removeEventListener('blur', onBlur);
    if (element.hasPointerCapture(pointerId)) {
      element.releasePointerCapture(pointerId);
    }
    updateCursor();
  }

  function onPointerDown(event: PointerEvent) {
    stopDrag();
    suppressClick = false;
    if (
      event.pointerType !== 'mouse' ||
      event.button !== 0 ||
      !canScrollHorizontally(element)
    ) {
      return;
    }
    drag = {
      pointerId: event.pointerId,
      startX: event.clientX,
      startY: event.clientY,
      scrollLeft: element.scrollLeft,
      dragging: false,
    };
    window.addEventListener('pointermove', onPointerMove);
    window.addEventListener('pointerup', onPointerUp);
    window.addEventListener('pointercancel', onPointerCancel);
    window.addEventListener('blur', onBlur);
  }

  function onPointerMove(event: PointerEvent) {
    if (drag == null || event.pointerId !== drag.pointerId) return;
    if ((event.buttons & 1) === 0) {
      stopDrag();
      return;
    }
    const dx = event.clientX - drag.startX;
    const dy = event.clientY - drag.startY;
    if (!drag.dragging) {
      if (Math.max(Math.abs(dx), Math.abs(dy)) < DRAG_THRESHOLD) return;
      if (Math.abs(dy) >= Math.abs(dx)) {
        stopDrag();
        return;
      }
      drag.dragging = true;
      suppressClick = true;
      element.setPointerCapture(event.pointerId);
      updateCursor();
    }
    event.preventDefault();
    element.scrollLeft = drag.scrollLeft - dx;
  }

  function onPointerUp(event: PointerEvent) {
    if (event.pointerId === drag?.pointerId) stopDrag();
  }

  function cancelDrag() {
    suppressClick = false;
    stopDrag();
  }

  function onPointerCancel(event: PointerEvent) {
    if (event.pointerId === drag?.pointerId) cancelDrag();
  }

  function onBlur() {
    cancelDrag();
  }

  function onLostPointerCapture() {
    if (drag != null) cancelDrag();
  }

  function onClick(event: MouseEvent) {
    if (!suppressClick || event.detail === 0) return;
    event.preventDefault();
    event.stopPropagation();
    suppressClick = false;
  }

  function onDragStart(event: DragEvent) {
    event.preventDefault();
  }

  element.addEventListener('pointerenter', updateCursor);
  element.addEventListener('pointerdown', onPointerDown);
  element.addEventListener('lostpointercapture', onLostPointerCapture);
  element.addEventListener('click', onClick, true);
  element.addEventListener('dragstart', onDragStart);

  return () => {
    stopDrag();
    element.removeEventListener('pointerenter', updateCursor);
    element.removeEventListener('pointerdown', onPointerDown);
    element.removeEventListener('lostpointercapture', onLostPointerCapture);
    element.removeEventListener('click', onClick, true);
    element.removeEventListener('dragstart', onDragStart);
    element.style.cursor = '';
  };
}

export function useHorizontalDragScroll() {
  return useCallback((element: HTMLElement | null) => {
    if (element == null) return;
    return bindHorizontalDragScroll(element);
  }, []);
}
