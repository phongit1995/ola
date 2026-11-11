import { useId, useState } from 'react';
import { useTycoon, type NoticeState, type NoticeTone } from '../store/useTycoon';
import { TyIcon, type TyIconName } from './TyIcon';
import { UiButton } from './Ui';
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
    <div className="ui-modal-layer" role="presentation">
      <div className="ui-scrim" aria-hidden="true" onClick={dismiss} />
      <div
        ref={modalRef}
        className={`ui-panel ui-modal ty-notice ty-notice-${tone}`}
        role={urgent ? 'alertdialog' : 'dialog'}
        aria-modal="true"
        aria-labelledby={titleId}
        aria-describedby={bodyId}
        tabIndex={-1}
      >
        <div className="ui-modal-head">
          <span className="ty-notice-icon" aria-hidden="true">
            <TyIcon name={TONE_ICON[tone]} size={18} />
          </span>
          <span>
            <span className="ui-kicker">{TONE_EYEBROW[tone]}</span>
            <h2 id={titleId} className="ui-title">
              {notice.title}
            </h2>
          </span>
        </div>
        <p className="ui-modal-body" id={bodyId}>
          {notice.body}
        </p>
        {notice.hint ? <p className="ty-notice-hint">{notice.hint}</p> : null}
        <div className="ui-actions">
          {cancelLabel ? (
            <UiButton onClick={cancel} disabled={pending} data-dialog-initial-focus={tone === 'danger' ? '' : undefined}>
              {cancelLabel}
            </UiButton>
          ) : null}
          <UiButton tone={tone === 'danger' || tone === 'error' ? 'red' : 'gold'} onClick={confirm} aria-busy={pending || undefined} aria-disabled={pending || undefined} data-dialog-initial-focus={tone === 'danger' && cancelLabel ? undefined : ''}>
            {notice.okLabel}
          </UiButton>
        </div>
      </div>
    </div>
  );
}
