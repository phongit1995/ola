import { useEffect, useState, type CSSProperties } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import type { WordChainMessage } from '@app-types';
import winIcon from '@/assets/icons/word-chain/status/win.webp';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainConfetti } from './WordChainConfetti';
import '../wordChain.css';

const WIN_CELEBRATION_MS = 3600;
const WIN_CELEBRATION_OUT_MS = 300;

const RAYS_STYLE: CSSProperties = {
  background:
    'repeating-conic-gradient(from 0deg, rgb(255 213 79 / 0.6) 0deg 12deg, transparent 12deg 24deg)',
  maskImage: 'radial-gradient(circle, black 30%, transparent 70%)',
};

const TITLE_COMPONENTS = {
  name: <strong className="text-ola-primary-dark" />,
};

interface WordChainWinCelebrationProps {
  winner: WordChainMessage;
  isOwn: boolean;
}

export function WordChainWinCelebration({
  winner,
  isOwn,
}: WordChainWinCelebrationProps) {
  const { t } = useTranslation();
  const dismiss = useWordChainStore((store) => store.dismissCelebration);
  const [leaving, setLeaving] = useState(false);
  const word = winner.word || winner.content;

  useEffect(() => {
    const timer = leaving
      ? window.setTimeout(() => dismiss(winner.id), WIN_CELEBRATION_OUT_MS)
      : window.setTimeout(() => setLeaving(true), WIN_CELEBRATION_MS);
    return () => window.clearTimeout(timer);
  }, [dismiss, leaving, winner.id]);

  return (
    <div
      role="status"
      className="pointer-events-none absolute inset-0 z-30 flex items-center justify-center overflow-hidden px-6"
    >
      <WordChainConfetti />
      <button
        type="button"
        onClick={() => setLeaving(true)}
        className={`pointer-events-auto relative mt-10 flex w-full max-w-[300px] flex-col items-center rounded-3xl bg-white px-6 pb-5 text-center shadow-[0_18px_50px_rgb(0_0_0/0.25)] ring-1 ring-amber-200 ${
          leaving
            ? 'word-chain-win-out'
            : 'word-chain-win-in'
        }`}
      >
        <span className="relative -mt-14 flex h-28 w-28 items-center justify-center">
          <span
            aria-hidden="true"
            style={RAYS_STYLE}
            className="word-chain-rays absolute -inset-6 rounded-full"
          />
          <img
            src={winIcon}
            alt=""
            draggable={false}
            className="word-chain-trophy relative h-20 w-20 object-contain drop-shadow-[0_6px_10px_rgb(180_83_9/0.35)]"
          />
        </span>
        <span className="text-base font-semibold text-black/80">
          {isOwn ? (
            t('wordChain.winCelebrationTitleMine')
          ) : (
            <Trans
              i18nKey="wordChain.winCelebrationTitle"
              values={{ name: winner.senderName ?? '' }}
              components={TITLE_COMPONENTS}
            />
          )}
        </span>
        <span className="word-chain-shine mt-1 bg-[linear-gradient(90deg,#f59e0b,#fde047,#f59e0b)] bg-[length:200%_100%] bg-clip-text font-game text-3xl leading-tight text-transparent drop-shadow-[0_1px_0_rgb(146_64_14/0.35)]">
          {word}
        </span>
        <span className="mt-3 rounded-full bg-amber-100 px-3 py-0.5 text-sm font-semibold text-amber-700">
          {t('wordChain.winCelebrationReward')}
        </span>
      </button>
    </div>
  );
}
