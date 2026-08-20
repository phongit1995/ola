import clubIcon from '../assets/icons/suit-club.svg';
import diamondIcon from '../assets/icons/suit-diamond.svg';
import heartIcon from '../assets/icons/suit-heart.svg';
import spadeIcon from '../assets/icons/suit-spade.svg';

export function BrandMark({ className = '' }: { className?: string }) {
  return (
    <div className={`tl-logo ${className}`.trim()} role="heading" aria-level={1} aria-label="Tiến Lên Miền Nam">
      <div className="tl-logo-main" aria-hidden="true">
        TIẾN LÊN
      </div>
      <div className="tl-logo-sub" aria-hidden="true">
        <span className="tl-logo-suits">
          <img src={clubIcon} alt="" />
          <img src={diamondIcon} alt="" />
        </span>
        <span>MIỀN NAM</span>
        <span className="tl-logo-suits">
          <img src={heartIcon} alt="" />
          <img src={spadeIcon} alt="" />
        </span>
      </div>
    </div>
  );
}
