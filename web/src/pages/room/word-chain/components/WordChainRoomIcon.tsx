import wordChainRoomIcon from '@/assets/icons/word-chain/room-02.png';

export function WordChainRoomIcon({ className }: { className: string }) {
  return (
    <svg
      viewBox="3 10 139 123"
      aria-hidden="true"
      focusable="false"
      className={`shrink-0 ${className}`}
    >
      <image href={wordChainRoomIcon} width="144" height="144" />
    </svg>
  );
}
