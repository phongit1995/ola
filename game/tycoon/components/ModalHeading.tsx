import { TyIcon, type TyIconName } from './TyIcon';

interface ModalHeadingProps {
  eyebrow: string;
  title: string;
  icon: TyIconName;
  titleId?: string;
}

export function ModalHeading({ eyebrow, title, icon, titleId }: ModalHeadingProps) {
  return (
    <div className="ty-modal-heading">
      <span className="ty-modal-emblem">
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
