import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  cn,
  patchMomentOverlay,
  raiseMomentOverlay,
  removeMomentOverlay,
  resolveMomentBackground,
} from '@lib';
import type { MomentDraftSlide, MomentOverlay } from '@app-types';
import { momentBackgroundCss, overlayBoxStyle, selectionBarTop } from '../utils';
import { useOverlayGestures } from '../useOverlayGestures';
import { MomentCanvas, MomentOverlayLabel } from './MomentCanvas';
import { MomentBackgroundPicker } from './MomentComposerParts';
import { MomentTextPanel } from './MomentTextPanel';
import { MomentTrashIcon, MomentVideoIcon } from './MomentIcons';
import { MomentTextQuickBar } from './MomentTextTools';

interface MomentCanvasEditorProps {
  slide: MomentDraftSlide;
  editingId: string | null;
  onChange: (slide: MomentDraftSlide) => void;
  onEditingChange: (id: string | null) => void;
  onAddText: () => void;
}

export function MomentCanvasEditor({
  slide,
  editingId,
  onChange,
  onEditingChange,
  onAddText,
}: MomentCanvasEditorProps) {
  const { t } = useTranslation();
  const layerRef = useRef<HTMLDivElement>(null);
  const trashRef = useRef<HTMLDivElement>(null);
  const selectedRef = useRef<HTMLDivElement>(null);
  const [selectionBar, setSelectionBar] = useState<{ id: string; top: number } | null>(null);
  const [backgroundOpen, setBackgroundOpen] = useState(false);
  const canChangeBackground = slide.media == null;

  function updateOverlay(id: string, patch: Partial<MomentOverlay>) {
    onChange(patchMomentOverlay(slide, id, patch));
  }

  function removeOverlay(id: string) {
    onChange(removeMomentOverlay(slide, id));
  }

  const gestures = useOverlayGestures({
    overlays: slide.overlays,
    layerRef,
    trashRef,
    onUpdate: updateOverlay,
    onRemove: removeOverlay,
    onRaise: (id) => onChange(raiseMomentOverlay(slide, id)),
    onTap: (id, wasSelected) => {
      if (!wasSelected) return;
      setBackgroundOpen(false);
      onEditingChange(id);
    },
  });

  function startAddText() {
    setBackgroundOpen(false);
    onAddText();
  }

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
      onChange(removeMomentOverlay(slide, selectedId));
    };
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [selectedId, editingId, slide, onChange]);

  function finishEditing() {
    if (editing != null && editing.text.trim() === '') removeOverlay(editing.id);
    onEditingChange(null);
  }

  const showHandles = !gestures.dragging && editing == null;
  const selectedOverlay = showHandles ? (slide.overlays.find((overlay) => overlay.id === selectedId) ?? null) : null;

  useEffect(() => {
    if (selectedOverlay == null) return;
    const frame = requestAnimationFrame(() => {
      const box = selectedRef.current?.getBoundingClientRect();
      const canvas = layerRef.current?.getBoundingClientRect();
      if (box == null || canvas == null) return;
      setSelectionBar({ id: selectedOverlay.id, top: selectionBarTop(box, canvas) });
    });
    return () => cancelAnimationFrame(frame);
  }, [selectedOverlay]);

  return (
    <MomentCanvas
      fit
      background={slide.background}
      media={slide.media}
      videoMode="loop"
      overlays={[]}
    >
      <div
        ref={layerRef}
        className="absolute inset-0 touch-none"
        onPointerDownCapture={() => setBackgroundOpen(false)}
        {...gestures.layerHandlers()}
      />
      {slide.media?.playable === false && (
        <div className="pointer-events-none absolute inset-x-8 top-1/2 flex -translate-y-1/2 flex-col items-center gap-2 text-center text-sm text-white/85">
          <MomentVideoIcon className="h-8 w-8" />
          {t('moment.videoNoPreview')}
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
            ref={selected ? selectedRef : undefined}
            style={overlayBoxStyle(overlay)}
            className={cn(
              'cursor-move touch-none select-none',
              lifted && 'z-10',
              selected &&
                'rounded-sm outline-2 outline-offset-4 outline-white/90 outline-dashed'
            )}
            {...gestures.overlayHandlers(overlay)}
          >
            <MomentOverlayLabel overlay={overlay} />
            {selected && (
              <span
                role="button"
                aria-label={t('moment.resize')}
                title={t('moment.resize')}
                className="absolute -right-4 -bottom-4 h-6 w-6 cursor-nwse-resize touch-none rounded-full border-2 border-white bg-ola-primary shadow"
                {...gestures.resizeHandlers(overlay)}
              />
            )}
          </div>
        );
      })}

      {selectedOverlay != null && selectionBar?.id === selectedOverlay.id && (
        <div className="absolute inset-x-2 z-20 flex justify-center" style={{ top: selectionBar.top }}>
          <MomentTextQuickBar
            overlay={selectedOverlay}
            onChange={(patch) => updateOverlay(selectedOverlay.id, patch)}
          />
        </div>
      )}

      {showHandles && slide.media == null && slide.overlays.length === 0 && (
        <button
          type="button"
          onClick={startAddText}
          className="absolute inset-x-8 top-1/2 -translate-y-1/2 text-center text-2xl font-semibold text-white/85 drop-shadow"
        >
          {t('moment.tapToType')}
        </button>
      )}

      {showHandles && (
        <div className="pointer-events-none absolute inset-0 z-20 @container">
          {backgroundOpen && canChangeBackground && (
            <div className="absolute inset-x-2 top-2 bottom-16 flex flex-col justify-end">
              <div className="pointer-events-auto max-h-full overflow-y-auto overscroll-contain rounded-2xl bg-white/95 p-1.5 shadow-lg backdrop-blur-sm">
                <MomentBackgroundPicker
                  value={slide.background}
                  onChange={(background) => onChange({ ...slide, background })}
                />
              </div>
            </div>
          )}
          <div className="pointer-events-auto absolute right-3 bottom-3 flex items-center gap-2">
            {canChangeBackground && (
              <button
                type="button"
                aria-label={t('moment.background')}
                aria-expanded={backgroundOpen}
                title={t('moment.background')}
                onClick={() => setBackgroundOpen((open) => !open)}
                className={cn(
                  'h-10 w-10 shrink-0 rounded-full border-2 border-white shadow transition-transform',
                  backgroundOpen && 'scale-110'
                )}
                style={{ background: momentBackgroundCss(resolveMomentBackground(slide.background)) }}
              />
            )}
            <button
              type="button"
              aria-label={t('moment.addText')}
              title={t('moment.addText')}
              onClick={startAddText}
              className="flex h-10 shrink-0 items-center gap-1.5 rounded-full bg-black/45 px-3 text-sm font-semibold text-white hover:bg-black/60"
            >
              <span className="text-base">Aa</span>
              <span className="hidden @[13rem]:inline">{t('moment.addText')}</span>
            </button>
          </div>
        </div>
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
            <MomentTrashIcon />
          </div>
          <span className="rounded-full bg-black/40 px-2 py-0.5 text-xs text-white">
            {t('moment.dropToDelete')}
          </span>
        </div>
      )}

      {editing != null && (
        <MomentTextPanel
          overlay={editing}
          onChange={(patch) => updateOverlay(editing.id, patch)}
          onDone={finishEditing}
          onDelete={() => {
            removeOverlay(editing.id);
            onEditingChange(null);
          }}
        />
      )}
    </MomentCanvas>
  );
}
