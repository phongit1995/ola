import { XqIcon, type XqIconName } from './XqIcon';

interface ModalHeadingProps {
  eyebrow: string;
  title: string;
  icon: XqIconName;
  titleId?: string;
}

export function ModalHeading({ eyebrow, title, icon, titleId }: ModalHeadingProps) {
  return (
    <div className="xq-modal-heading">
      <span className="xq-modal-emblem">
        <XqIcon name={icon} size={22} />
      </span>
      <span className="xq-modal-heading-copy">
        <span className="xq-modal-kicker">{eyebrow}</span>
        <h2 className="xq-modal-title" id={titleId}>
          {title}
        </h2>
      </span>
    </div>
  );
}
