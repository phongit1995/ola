import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { useEggGameStore } from '@/store/eggGameStore';
import {
  BIG_WIN_KEN,
  EGG_COST,
  EGG_HIT_RATE,
  FRAMES_HIT,
  FRAMES_MISS,
  HIT_HOLD_TICKS,
  HIT_LAST_FRAME,
  MISS_HOLD_TICKS,
  MISS_LAST_FRAME,
  expandFrames,
  rollPrize,
} from './eggGame.constants';
import { smashSoundUrl } from './eggAssets';

const smashAudio = new Audio(smashSoundUrl);
smashAudio.preload = 'auto';

function playSmashSound() {
  try {
    const clone = smashAudio.cloneNode() as HTMLAudioElement;
    void clone.play().catch(() => {});
  } catch {
    return;
  }
}

export interface SmashOutcome {
  hit: boolean;
  frames: string[];
  revealAt: number;
  finalize: () => void;
}

export function useEggGame() {
  const { t } = useTranslation();
  const ken = useEggGameStore((s) => s.ken);
  const totalWin = useEggGameStore((s) => s.totalWin);
  const muted = useEggGameStore((s) => s.muted);
  const spend = useEggGameStore((s) => s.spend);
  const addWin = useEggGameStore((s) => s.addWin);
  const topup = useEggGameStore((s) => s.topup);
  const toggleMute = useEggGameStore((s) => s.toggleMute);

  const play = useCallback((): SmashOutcome | null => {
    if (!spend(EGG_COST)) {
      toast.info(t('eggGame.outOfKen'));
      return null;
    }
    if (!useEggGameStore.getState().muted) playSmashSound();

    const hit = Math.random() < EGG_HIT_RATE;
    const reveal = expandFrames(hit ? FRAMES_HIT : FRAMES_MISS);
    const lastFrame = hit ? HIT_LAST_FRAME : MISS_LAST_FRAME;
    const holdTicks = hit ? HIT_HOLD_TICKS : MISS_HOLD_TICKS;
    const frames = [...reveal, ...Array<string>(holdTicks).fill(lastFrame)];
    const prize = hit ? rollPrize() : null;

    const finalize = () => {
      if (prize) {
        addWin(prize.ken);
        toast.success(
          t(prize.ken >= BIG_WIN_KEN ? 'eggGame.bigWin' : 'eggGame.win', { ken: prize.ken })
        );
      } else {
        toast.info(t('eggGame.miss'));
      }
    };

    return { hit, frames, revealAt: reveal.length - 1, finalize };
  }, [spend, addWin, t]);

  return { ken, totalWin, cost: EGG_COST, muted, play, topup, toggleMute };
}
