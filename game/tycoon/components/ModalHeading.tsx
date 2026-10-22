import { TyIcon, type TyIconName } from './TyIcon';

interface ModalHeadingProps {
  eyebrow: string;
  title: string;
  icon: TyIconName;
  titleId?: string;
  tone?: string;
}

export function ModalHeading({ eyebrow, title, icon, titleId, tone }: ModalHeadingProps) {
  return (
    <div className="ty-modal-heading">
      <span className={tone ? `ty-modal-emblem ty-modal-emblem-${tone}` : 'ty-modal-emblem'}>
        <TyIcon name={icon} size={22} />
      </span>
      <span className="ty-modal-heading-copy">
        <span className="ty-modal-kicker">{eyebrow}</span>
        <h2 className="ty-modal-title" id={titleId}>
          {title}
        </h2>
      </span>
    </div>
  );
}
