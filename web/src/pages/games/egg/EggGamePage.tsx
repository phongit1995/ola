import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { formatKen } from '@lib';
import { FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';
import { useEggGameStore } from '@/store/eggGameStore';
import { useEggGame } from './useEggGame';
import { EggStage } from './EggStage';
import { EGG_START_KEN } from './eggGame.constants';

function BackIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
      <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
    </svg>
  );
}

export function EggGamePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const userKen = useAuthStore((s) => s.user?.ken);
  const init = useEggGameStore((s) => s.init);
  const { ken, totalWin, cost, muted, play, topup, toggleMute } = useEggGame();

  useEffect(() => {
    init(userKen ?? EGG_START_KEN);
  }, [init, userKen]);

  return (
    <FullScreenOverlay>
      <div className="flex h-full w-full flex-col items-center bg-white">
        <div className="flex h-full w-full max-w-[645px] flex-col overflow-hidden">
          <div className="flex shrink-0 items-center gap-2 bg-[#5e3c20] px-2 py-2 text-white">
            <button
              type="button"
              onClick={() => navigate(ROUTES.home)}
              className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
              aria-label={t('chat.back')}
            >
              <BackIcon />
            </button>
            <span className="flex items-baseline gap-2">
              <span className="text-xs text-white/70">KEN</span>
              <b className="min-w-[3ch] text-right text-xl text-[#ffca28]">{formatKen(ken)}</b>
            </span>
            <span className="flex-1" />
            <button
              type="button"
              onClick={toggleMute}
              className="flex h-9 w-9 items-center justify-center rounded-full text-lg hover:bg-white/15"
              aria-label="mute"
            >
              {muted ? '🔇' : '🔊'}
            </button>
            <button
              type="button"
              onClick={topup}
              className="rounded-full bg-[#ffca28] px-3 py-1.5 text-sm font-bold text-[#5b3b00] shadow-[0_2px_0_#c79400] active:translate-y-0.5 active:shadow-none"
            >
              + {t('ken.purchase')}
            </button>
          </div>

          <main className="relative min-h-0 flex-1 bg-[#2c1f12]">
            <EggStage play={play} />
            <p className="pointer-events-none absolute inset-x-0 top-2 text-center text-xs text-white/80 drop-shadow">
              {t('eggGame.hint', { cost })}
            </p>
          </main>

          <footer className="flex shrink-0 items-center justify-between bg-[#3e2a18] px-4 py-2.5 text-sm text-white/90">
            <span>
              {t('eggGame.cost')}: <b className="text-[#ffca28]">{cost}</b> KEN
            </span>
            <span>
              {t('eggGame.totalWin')}: <b className="text-[#ffca28]">{formatKen(totalWin)}</b> KEN
            </span>
          </footer>
        </div>
      </div>
    </FullScreenOverlay>
  );
}
