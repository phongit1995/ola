import { useEffect, useLayoutEffect, useRef, type ReactNode } from 'react';
import backIcon from '../../assets/icons/ic-back.svg';
import cardsEmptyIcon from '../../assets/icons/ic-cards-empty.svg';
import refreshIcon from '../../assets/icons/ic-refresh.svg';
import warningIcon from '../../assets/icons/ic-warning.svg';
import { handleModalKeyDown } from '../../components/modalKeyboard';

export function RecordScreen({
  title,
  titleId,
  onClose,
  children,
}: {
  title: string;
  titleId: string;
  onClose: () => void;
  children: ReactNode;
}) {
  const backRef = useRef<HTMLButtonElement>(null);
  const openerRef = useRef<HTMLElement | null>(null);
  useLayoutEffect(() => {
    openerRef.current = document.activeElement instanceof HTMLElement ? document.activeElement : null;
    backRef.current?.focus();
  }, []);
  useEffect(() => () => openerRef.current?.focus(), []);

  return (
    <div
      className="tl-screen tl-records"
      role="dialog"
      aria-modal="true"
      aria-labelledby={titleId}
      onKeyDown={(event) => handleModalKeyDown(event, onClose)}
    >
      <div className="tl-records-head">
        <button ref={backRef} type="button" className="tl-icon-btn" onClick={onClose} aria-label="Quay lại sảnh">
          <img src={backIcon} alt="" />
        </button>
        <h1 id={titleId} className="tl-records-title">
          {title}
        </h1>
        <span className="tl-topbar-spacer" />
      </div>
      {children}
    </div>
  );
}

export function RecordStatus({
  loading,
  error,
  empty,
  errorTitle,
  emptyText,
  onRetry,
}: {
  loading: boolean;
  error: string | null;
  empty: boolean;
  errorTitle: string;
  emptyText: string;
  onRetry: () => void;
}) {
  if (loading) {
    return (
      <div className="tl-records-status" role="status" aria-live="polite">
        <span className="tl-loading-dots" aria-hidden="true">
          <i />
          <i />
          <i />
        </span>
        <span>Đang tải...</span>
      </div>
    );
  }
  if (error) {
    return (
      <div className="tl-records-status error" role="alert">
        <img src={warningIcon} alt="" />
        <strong>{errorTitle}</strong>
        <span>{error}</span>
        <button type="button" className="tl-btn tl-btn-gold tl-records-retry" onClick={onRetry}>
          <img src={refreshIcon} alt="" />
          Thử lại
        </button>
      </div>
    );
  }
  if (empty) {
    return (
      <div className="tl-records-status">
        <img src={cardsEmptyIcon} alt="" />
        <span>{emptyText}</span>
      </div>
    );
  }
  return null;
}
