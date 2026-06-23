import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { formatKen } from '@lib';
import { FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';
import { useEggGameStore } from '@/store/eggGameStore';
import { useEggGame } from './useEggGame';
import { EggStage } from './EggStage';
import { EggHistoryDialog } from './EggHistoryDialog';
import { historyIconUrl } from './eggAssets';
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
  const loadPacks = useEggGameStore((s) => s.loadPacks);
  const { ken, totalWin, cost, packsStatus, play } = useEggGame();
  const [historyOpen, setHistoryOpen] = useState(false);

  useEffect(() => {
    init(userKen ?? EGG_START_KEN);
  }, [init, userKen]);

  useEffect(() => {
    void loadPacks();
  }, [loadPacks]);

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
              onClick={() => setHistoryOpen(true)}
              className="flex items-center gap-1.5 rounded-full bg-white/15 px-3 py-1.5 text-sm font-semibold hover:bg-white/25"
            >
              <img src={historyIconUrl} alt="" className="h-4 w-4" />
              {t('eggGame.history.title')}
            </button>
          </div>

          <main className="relative min-h-0 flex-1 bg-[#2c1f12]">
            {packsStatus === 'error' ? (
              <div className="flex h-full w-full items-center justify-center px-8 text-center text-sm text-white/85">
                {t('eggGame.contactAdmin')}
              </div>
            ) : packsStatus === 'ready' ? (
              <EggStage hint={t('eggGame.hint', { cost })} play={play} />
            ) : (
              <div className="flex h-full w-full items-center justify-center text-sm text-white/80">
                {t('eggGame.loading')}
              </div>
            )}
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
      <EggHistoryDialog open={historyOpen} onClose={() => setHistoryOpen(false)} />
    </FullScreenOverlay>
  );
}
