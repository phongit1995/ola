import { useCallback } from 'react';
import { useTranslation } from 'react-i18next';
import { randomUuid } from '@ola/shared/lib';
import { EGG_COST } from '@ola/shared/lib';
import { useEggGameStore } from '@ola/shared/stores/eggGameStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { playSmashSound } from './eggSound';

export interface SmashOutcome {
  hit: boolean;
  superLucky: boolean;
  finalize: () => void;
}

export type SmashStarter = () => Promise<SmashOutcome | null> | null;

export function useEggGame() {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const ken = useEggGameStore((s) => s.ken);
  const totalWin = useEggGameStore((s) => s.totalWin);
  const muted = useEggGameStore((s) => s.muted);
  const packs = useEggGameStore((s) => s.packs);
  const packsStatus = useEggGameStore((s) => s.packsStatus);
  const draw = useEggGameStore((s) => s.draw);
  const applyResult = useEggGameStore((s) => s.applyResult);
  const showWin = useEggGameStore((s) => s.showWin);
  const toggleMute = useEggGameStore((s) => s.toggleMute);

  const activePack = packs[0] ?? null;
  const cost = activePack?.kenCost ?? EGG_COST;

  const play = useCallback<SmashStarter>(() => {
    if (!activePack) {
      push('info', t('eggGame.noPack'));
      return null;
    }
    const state = useEggGameStore.getState();
    if (state.winReward) return null;
    if (state.smashing || state.drawing) return null;
    if (state.ken < activePack.kenCost) {
      push('info', t('eggGame.outOfKen'));
      return null;
    }
    if (!state.muted && useSettingsStore.getState().settings.soundGame) playSmashSound();
    state.beginSmash();

    const packId = activePack.id;
    return (async (): Promise<SmashOutcome | null> => {
      const result = await draw(packId, randomUuid());
      if (!result) {
        useEggGameStore.getState().endSmash();
        push('error', t('eggGame.error'));
        return null;
      }

      const finalize = () => {
        useEggGameStore.getState().endSmash();
        applyResult(result);
        if (!result.isWin) {
          push('info', t('eggGame.miss'));
          return;
        }
        showWin(result);
      };

      return { hit: result.isWin, superLucky: result.isSuperLucky, finalize };
    })();
  }, [activePack, draw, applyResult, showWin, push, t]);

  return { ken, totalWin, cost, muted, packsStatus, play, toggleMute };
}
