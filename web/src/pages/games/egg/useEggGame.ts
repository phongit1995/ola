import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { useEggGameStore } from '@/store/eggGameStore';
import {
  BIG_WIN_KEN,
  EGG_COST,
  FRAMES_HIT,
  FRAMES_MISS,
  HIT_HOLD_TICKS,
  HIT_LAST_FRAME,
  MISS_HOLD_TICKS,
  MISS_LAST_FRAME,
  expandFrames,
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
  const packs = useEggGameStore((s) => s.packs);
  const packsStatus = useEggGameStore((s) => s.packsStatus);
  const draw = useEggGameStore((s) => s.draw);
  const applyResult = useEggGameStore((s) => s.applyResult);
  const toggleMute = useEggGameStore((s) => s.toggleMute);

  const activePack = packs[0] ?? null;
  const cost = activePack?.kenCost ?? EGG_COST;

  const play = useCallback(async (): Promise<SmashOutcome | null> => {
    if (!activePack) {
      toast.info(t('eggGame.noPack'));
      return null;
    }
    const state = useEggGameStore.getState();
    if (state.drawing) return null;
    if (state.ken < activePack.kenCost) {
      toast.info(t('eggGame.outOfKen'));
      return null;
    }
    if (!state.muted) playSmashSound();

    const result = await draw(activePack.id, crypto.randomUUID());
    if (!result) {
      toast.error(t('eggGame.error'));
      return null;
    }

    const hit = result.isWin;
    const reveal = expandFrames(hit ? FRAMES_HIT : FRAMES_MISS);
    const lastFrame = hit ? HIT_LAST_FRAME : MISS_LAST_FRAME;
    const holdTicks = hit ? HIT_HOLD_TICKS : MISS_HOLD_TICKS;
    const frames = [...reveal, ...Array<string>(holdTicks).fill(lastFrame)];

    const finalize = () => {
      applyResult(result);
      if (!result.isWin) {
        toast.info(t('eggGame.miss'));
        return;
      }
      if (result.isSuperLucky) {
        toast.success(t('eggGame.superLucky', { reward: result.rewardLabel ?? '' }));
        return;
      }
      if (result.categoryType === 'ken' && result.kenAmount) {
        toast.success(
          t(result.kenAmount >= BIG_WIN_KEN ? 'eggGame.bigWin' : 'eggGame.win', {
            ken: result.kenAmount,
          })
        );
        return;
      }
      if (result.categoryType === 'vip_days' && result.vipDays) {
        toast.success(t('eggGame.wonVipDays', { days: result.vipDays }));
        return;
      }
      toast.success(t('eggGame.wonVip', { reward: result.rewardLabel ?? '' }));
    };

    return { hit, frames, revealAt: reveal.length - 1, finalize };
  }, [activePack, draw, applyResult, t]);

  return { ken, totalWin, cost, muted, packsStatus, play, toggleMute };
}
