import { useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { cn, patchReelOverlay, raiseReelOverlay, removeReelOverlay } from '@lib';
import type { ReelDraftSlide, ReelOverlay } from '@app-types';
import { overlayBoxStyle } from '../utils';
import { useOverlayGestures } from '../useOverlayGestures';
import { ReelCanvas, ReelOverlayLabel } from './ReelCanvas';
import { ReelTextPanel } from './ReelTextPanel';
import { ReelTrashIcon, ReelVideoIcon } from './ReelIcons';

interface ReelCanvasEditorProps {
  slide: ReelDraftSlide;
  editingId: string | null;
  onChange: (slide: ReelDraftSlide) => void;
  onEditingChange: (id: string | null) => void;
  onAddText: () => void;
}

export function ReelCanvasEditor({
  slide,
  editingId,
  onChange,
  onEditingChange,
  onAddText,
}: ReelCanvasEditorProps) {
  const { t } = useTranslation();
  const layerRef = useRef<HTMLDivElement>(null);
  const trashRef = useRef<HTMLDivElement>(null);

  function updateOverlay(id: string, patch: Partial<ReelOverlay>) {
    onChange(patchReelOverlay(slide, id, patch));
  }

  function removeOverlay(id: string) {
    onChange(removeReelOverlay(slide, id));
  }

  const gestures = useOverlayGestures({
    overlays: slide.overlays,
    layerRef,
    trashRef,
    onUpdate: updateOverlay,
    onRemove: removeOverlay,
    onRaise: (id) => onChange(raiseReelOverlay(slide, id)),
    onTap: (id, wasSelected) => {
      if (wasSelected) onEditingChange(id);
    },
  });

  const editing = slide.overlays.find((overlay) => overlay.id === editingId) ?? null;
  const selectedId = gestures.selectedId;

  useEffect(() => {
    if (selectedId == null || editingId != null) return;
    const onKey = (event: KeyboardEvent) => {
      if (event.key !== 'Delete' && event.key !== 'Backspace') return;
      if (
        event.target instanceof HTMLInputElement ||
        event.target instanceof HTMLTextAreaElement
      )
        return;
      onChange(removeReelOverlay(slide, selectedId));
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [selectedId, editingId, slide, onChange]);

  function finishEditing() {
    if (editing != null && editing.text.trim() === '') removeOverlay(editing.id);
    onEditingChange(null);
  }

  const showHandles = !gestures.dragging && editing == null;

  return (
    <ReelCanvas
      fit
      background={slide.background}
      media={slide.media}
      videoMode="loop"
      overlays={[]}
    >
      <div
        ref={layerRef}
        className="absolute inset-0 touch-none"
        {...gestures.layerHandlers()}
      />
      {slide.media?.playable === false && (
        <div className="pointer-events-none absolute inset-x-8 top-1/2 flex -translate-y-1/2 flex-col items-center gap-2 text-center text-sm text-white/85">
          <ReelVideoIcon className="h-8 w-8" />
          {t('reel.videoNoPreview')}
        </div>
      )}
      {gestures.verticalGuide && (
        <div className="pointer-events-none absolute inset-y-0 left-1/2 w-px bg-white/80" />
      )}
      {gestures.horizontalGuide && (
        <div className="pointer-events-none absolute inset-x-0 top-1/2 h-px bg-white/80" />
      )}
      {slide.overlays.map((overlay) => {
        if (overlay.id === editingId) return null;
        const selected = showHandles && selectedId === overlay.id;
        const lifted = gestures.dragging && selectedId === overlay.id;
        return (
          <div
            key={overlay.id}
            style={overlayBoxStyle(overlay)}
            className={cn(
              'cursor-move touch-none select-none',
              lifted && 'z-10',
              selected &&
                'rounded-sm outline-2 outline-offset-4 outline-white/90 outline-dashed'
            )}
            {...gestures.overlayHandlers(overlay)}
          >
            <ReelOverlayLabel overlay={overlay} />
            {selected && (
              <span
                role="button"
                aria-label={t('reel.resize')}
                title={t('reel.resize')}
                className="absolute -right-4 -bottom-4 h-6 w-6 cursor-nwse-resize touch-none rounded-full border-2 border-white bg-ola-primary shadow"
                {...gestures.resizeHandlers(overlay)}
              />
            )}
          </div>
        );
      })}

      {showHandles && (
        <button
          type="button"
          onClick={onAddText}
          className="absolute top-3 right-3 flex h-10 items-center gap-1.5 rounded-full bg-black/45 px-3 text-sm font-semibold text-white hover:bg-black/60"
        >
          <span className="text-base">Aa</span>
          {t('reel.addText')}
        </button>
      )}

      {gestures.dragging && (
        <div className="pointer-events-none absolute inset-x-0 bottom-5 flex flex-col items-center gap-1.5">
          <div
            ref={trashRef}
            className={cn(
              'flex h-12 w-12 items-center justify-center rounded-full border-2 text-white transition',
              gestures.overTrash
                ? 'scale-125 border-ola-error bg-ola-error'
                : 'border-white/70 bg-black/40'
            )}
          >
            <ReelTrashIcon />
          </div>
          <span className="rounded-full bg-black/40 px-2 py-0.5 text-xs text-white">
            {t('reel.dropToDelete')}
          </span>
        </div>
      )}

      {editing != null && (
        <ReelTextPanel
          overlay={editing}
          onChange={(patch) => updateOverlay(editing.id, patch)}
          onDone={finishEditing}
        />
      )}
    </ReelCanvas>
  );
}
