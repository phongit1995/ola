import { useId, type ReactNode } from 'react';
import { TyIcon } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';

export function BottomSheet({ title, onClose, children, tall }: { title: string; onClose: () => void; children: ReactNode; tall?: boolean }) {
  const titleId = useId();
  const ref = useDialogFocus<HTMLDivElement>({ onEscape: onClose });
  return (
    <div className="ty-sheet-layer">
      <div className="ty-sheet-scrim" aria-hidden="true" onClick={onClose} />
      <div ref={ref} className={`ty-sheet ${tall ? 'ty-sheet-tall' : ''}`} role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1}>
        <div className="ty-sheet-handle" aria-hidden="true" />
        <span id={titleId} className="ty-visually-hidden">
          {title}
        </span>
        <button type="button" className="ty-icon-btn ty-sheet-close" onClick={onClose} aria-label="Đóng" data-dialog-initial-focus>
          <TyIcon name="close" size={20} />
        </button>
        <div className="ty-sheet-body">{children}</div>
      </div>
    </div>
  );
}
