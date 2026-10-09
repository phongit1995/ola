import type { ReactNode } from 'react';
import lookupIcon from '@/assets/icons/word-chain/lookup.webp';
import leaderboardIcon from '@/assets/icons/word-chain/leaderboard.webp';
import rulesIcon from '@/assets/icons/word-chain/rules.webp';
import minimizeIcon from '@/assets/icons/word-chain/minimize.webp';

function AssetIcon({
  src,
  className,
}: {
  src: string;
  className: string;
}) {
  return (
    <img
      src={src}
      alt=""
      aria-hidden="true"
      draggable={false}
      className={`shrink-0 object-contain ${className}`}
    />
  );
}

function StrokeIcon({
  className,
  children,
}: {
  className: string;
  children: ReactNode;
}) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="none"
      stroke="currentColor"
      strokeWidth="2"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

export function LookupIcon({ className = 'h-7 w-7' }: { className?: string }) {
  return <AssetIcon src={lookupIcon} className={className} />;
}

export function TrophyIcon({ className = 'h-7 w-7' }: { className?: string }) {
  return <AssetIcon src={leaderboardIcon} className={className} />;
}

export function HelpIcon({ className = 'h-7 w-7' }: { className?: string }) {
  return <AssetIcon src={rulesIcon} className={className} />;
}

export function MinimizeIcon({
  className = 'h-8.5 w-8.5',
}: {
  className?: string;
}) {
  return <AssetIcon src={minimizeIcon} className={className} />;
}

export function InfoIcon({ className = 'h-5 w-5' }: { className?: string }) {
  return (
    <StrokeIcon className={className}>
      <circle cx="12" cy="12" r="10" />
      <path d="M12 11v5.5M12 7.5h.01" />
    </StrokeIcon>
  );
}
