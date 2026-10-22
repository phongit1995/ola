import { useId, useState } from 'react';
import { useTycoon, type NoticeState, type NoticeTone } from '../store/useTycoon';
import { ModalHeading } from './ModalHeading';
import type { TyIconName } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';

const TONE_EYEBROW: Record<NoticeTone, string> = {
  default: 'Xác nhận',
  danger: 'Hành động quan trọng',
  info: 'Thông báo',
  success: 'Thành công',
  warning: 'Lưu ý',
  error: 'Có lỗi',
};

const TONE_ICON: Record<NoticeTone, TyIconName> = {
  default: 'check',
  danger: 'warning',
  info: 'info',
  success: 'check',
  warning: 'warning',
  error: 'warning',
};

export function NoticeModal({ notice }: { notice: NoticeState }) {
  const closeNotice = useTycoon((s) => s.closeNotice);
  const [pending, setPending] = useState(false);
  const titleId = useId();
  const bodyId = useId();
  const tone = notice.tone ?? (notice.kind === 'confirm' ? 'default' : 'info');
  const cancelLabel = notice.cancelLabel ?? (notice.kind === 'confirm' ? 'Hủy' : undefined);
  const urgent = tone === 'danger' || tone === 'error';

  const cancel = () => {
    if (pending) return;
    notice.onCancel?.();
    closeNotice(notice);
  };

  const dismiss = () => {
    if (notice.dismissible !== false) cancel();
  };

  const confirm = async () => {
    if (pending) return;
    const result = notice.onOk?.();
    if (result instanceof Promise) {
      setPending(true);
      try {
        await result;
      } catch {
        setPending(false);
        return;
      }
    }
    closeNotice(notice);
  };

  const modalRef = useDialogFocus<HTMLDivElement>({ onEscape: dismiss });

  return (
    <div className="ty-backdrop" role="presentation" onClick={dismiss}>
      <div
        ref={modalRef}
        className={`ty-modal ty-notice-modal ty-notice-${tone}`}
        role={urgent ? 'alertdialog' : 'dialog'}
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        tabIndex={-1}
        onClick={(event) => event.stopPropagation()}
      >
        <ModalHeading eyebrow={TONE_EYEBROW[tone]} title={notice.title} icon={notice.icon ?? TONE_ICON[tone]} titleId={titleId} tone={tone} />
        <p className="ty-modal-body" id={bodyId}>
          {notice.body}
        </p>
        {notice.hint ? <p className="ty-modal-hint">{notice.hint}</p> : null}
        <div className="ty-modal-actions">
          {cancelLabel ? (
            <button type="button" className="ty-btn ty-btn-paper" onClick={cancel} disabled={pending} data-dialog-initial-focus={tone === 'danger' ? '' : undefined}>
              {cancelLabel}
            </button>
          ) : null}
          <button
            type="button"
            className={`ty-btn ${tone === 'danger' ? 'ty-btn-danger' : 'ty-btn-gold'}`}
            onClick={confirm}
            aria-busy={pending || undefined}
            aria-disabled={pending || undefined}
            data-dialog-initial-focus={tone === 'danger' && cancelLabel ? undefined : ''}
          >
            {notice.okLabel}
          </button>
        </div>
      </div>
    </div>
  );
}
