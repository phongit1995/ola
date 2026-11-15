import { useId, type ButtonHTMLAttributes, type CSSProperties, type ReactNode } from 'react';
import kenUrl from '../assets/lobby/ken.png';
import { formatKen, formatMoney } from '../helpers/format';
import { TyIcon, type TyIconName } from './TyIcon';
import { useDialogFocus } from './useDialogFocus';

export type UiTone = 'paper' | 'gold' | 'red' | 'green' | 'blue';

type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
  tone?: UiTone;
  size?: 'sm' | 'md' | 'lg';
  block?: boolean;
  icon?: TyIconName;
  price?: number;
  gain?: number;
};

export function UiButton({ tone = 'paper', size = 'md', block, icon, price, gain, className = '', children, type = 'button', ...rest }: ButtonProps) {
  const classes = ['ui-btn', tone === 'paper' ? '' : `ui-btn-${tone}`, size === 'md' ? '' : `ui-btn-${size}`, block ? 'ui-btn-block' : '', className].filter(Boolean).join(' ');
  return (
    <button type={type} className={classes} {...rest}>
      {icon ? <TyIcon name={icon} size={size === 'lg' ? 22 : size === 'sm' ? 16 : 18} className="ui-icon" /> : null}
      {children}
      {price != null ? <MoneyBadge amount={price} /> : null}
      {gain != null ? <MoneyBadge amount={gain} signed className="ui-money-gain" /> : null}
    </button>
  );
}

export function UiIconButton({ icon, label, tone = 'paper', size = 'md', className = '', ...rest }: Omit<ButtonProps, 'children' | 'price' | 'gain'> & { icon: TyIconName; label: string }) {
  return (
    <button type="button" className={['ui-btn', 'ui-btn-icon', tone === 'paper' ? '' : `ui-btn-${tone}`, size === 'sm' ? 'ui-btn-sm' : '', className].filter(Boolean).join(' ')} aria-label={label} {...rest}>
      <TyIcon name={icon} size={size === 'sm' ? 16 : 20} className="ui-icon" />
    </button>
  );
}

export function MoneyBadge({ amount, className = '', signed = false }: { amount: number; className?: string; signed?: boolean }) {
  const text = signed && amount > 0 ? `+${formatMoney(amount)}` : formatMoney(amount);
  return (
    <span className={`ui-money ${className}`}>
      <i className="ui-coin" aria-hidden="true" />
      {text}
    </span>
  );
}

export function KenBadge({ amount, className = '', signed = false }: { amount: number; className?: string; signed?: boolean }) {
  const sign = signed && amount > 0 ? '+' : amount < 0 ? '−' : '';
  const text = `${sign}${formatKen(Math.abs(amount))}`;
  return (
    <span className={`ui-money ui-ken ${className}`} aria-label={`${text} KEN`}>
      {text}
      <img src={kenUrl} alt="" draggable={false} />
    </span>
  );
}

export function UiAvatar({ src, size = 32, ring, className = '' }: { src?: string; size?: number; ring?: string; className?: string }) {
  return (
    <span className={`ui-avatar ${className}`} style={{ width: size, height: size, ...(ring ? { '--ring': ring } : {}) } as CSSProperties}>
      {src ? <img src={src} alt="" draggable={false} /> : null}
    </span>
  );
}

export function UiModal({
  title,
  kicker,
  icon,
  onClose,
  children,
  actions,
  tone,
  wide,
  closable,
}: {
  title: string;
  kicker?: ReactNode;
  icon?: ReactNode;
  onClose?: () => void;
  children?: ReactNode;
  actions?: ReactNode;
  tone?: UiTone;
  wide?: boolean;
  closable?: boolean;
}) {
  const titleId = useId();
  const ref = useDialogFocus<HTMLDivElement>({ onEscape: onClose });
  const classes = ['ui-panel', 'ui-modal', tone ? `ui-modal-${tone}` : '', wide ? 'ui-modal-wide' : '', closable && onClose ? 'ui-modal-closable' : ''].filter(Boolean).join(' ');
  return (
    <div className="ui-modal-layer">
      <div className="ui-scrim" aria-hidden="true" onClick={onClose} />
      <div ref={ref} className={classes} role="dialog" aria-modal="true" aria-labelledby={titleId} tabIndex={-1}>
        {closable && onClose ? <UiIconButton icon="close" label="Đóng" size="sm" className="ui-close" onClick={onClose} /> : null}
        <div className="ui-modal-head">
          {icon}
          <span>
            {kicker ? <span className="ui-kicker">{kicker}</span> : null}
            <h2 id={titleId} className="ui-title">
              {title}
            </h2>
          </span>
        </div>
        {children}
        {actions ? <div className="ui-actions">{actions}</div> : null}
      </div>
    </div>
  );
}

export function UiSheet({ title, onClose, children, footer, tall, accent }: { title: string; onClose: () => void; children: ReactNode; footer?: ReactNode; tall?: boolean; accent?: string }) {
  const titleId = useId();
  const ref = useDialogFocus<HTMLDivElement>({ onEscape: onClose });
  return (
    <div className="ui-sheet-layer">
      <div className="ui-scrim" aria-hidden="true" onClick={onClose} />
      <div
        ref={ref}
        className={`ui-panel ui-sheet ${tall ? 'ui-sheet-tall' : ''}`}
        style={accent ? ({ '--accent': accent } as CSSProperties) : undefined}
        role="dialog"
        aria-modal="true"
        aria-labelledby={titleId}
        tabIndex={-1}
      >
        <span id={titleId} className="ty-visually-hidden">
          {title}
        </span>
        <UiIconButton icon="close" label="Đóng" size="sm" className="ui-close" onClick={onClose} data-dialog-initial-focus />
        <div className="ui-sheet-body">{children}</div>
        {footer ? <div className="ui-sheet-foot">{footer}</div> : null}
      </div>
    </div>
  );
}
