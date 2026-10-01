import wordChainRoomIcon from '@/assets/icons/word-chain/room-02.webp';

export function WordChainRoomIcon({ className }: { className: string }) {
  return (
    <img
      src={wordChainRoomIcon}
      alt=""
      aria-hidden="true"
      draggable={false}
      className={`shrink-0 object-contain ${className}`}
    />
  );
}
