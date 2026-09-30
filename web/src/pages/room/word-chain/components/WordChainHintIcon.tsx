import hintStarIcon from '@/assets/icons/word-chain/hint-star.png';

export function WordChainHintIcon({ className }: { className: string }) {
  return (
    <img
      src={hintStarIcon}
      alt=""
      aria-hidden="true"
      draggable={false}
      className={`shrink-0 object-contain ${className}`}
    />
  );
}
