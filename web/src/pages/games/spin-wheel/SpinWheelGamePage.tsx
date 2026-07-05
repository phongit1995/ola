import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { formatKen } from '@lib';
import { FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useSpinWheelStore } from './spinWheelStore';
import { SpinWheel } from './SpinWheel';
import { SpinResultDialog } from './SpinResultDialog';
import { SpinHistoryDialog } from './SpinHistoryDialog';
import { SPIN_START_KEN, SPIN_START_TURNS } from './spinWheel.constants';
import {
  backgroundUrl,
  bottomButtonFrameUrl,
  closeButtonUrl,
  coinUrl,
  historyIconUrl,
  kenBarUrl,
  plusFrameUrl,
  plusIconUrl,
  soundOffUrl,
  soundOnUrl,
  spinButtonUrl,
  spinCountNoteUrl,
  titleBannerUrl,
} from './spinWheelAssets';

const TEXT_SHADOW = { textShadow: '0 2px 4px rgba(0,0,0,0.45)' };

interface SpinWheelGamePageProps {
  onClose: () => void;
}

export function SpinWheelGamePage({ onClose }: SpinWheelGamePageProps) {
  const { t } = useTranslation();
  const userKen = useAuthStore((s) => s.user?.ken);
  const openApp = useAppOverlayStore((s) => s.push);
  const ken = useSpinWheelStore((s) => s.ken);
  const turnsLeft = useSpinWheelStore((s) => s.turnsLeft);
  const muted = useSpinWheelStore((s) => s.muted);
  const rotation = useSpinWheelStore((s) => s.rotation);
  const spinning = useSpinWheelStore((s) => s.spinning);
  const result = useSpinWheelStore((s) => s.result);
  const history = useSpinWheelStore((s) => s.history);
  const [historyOpen, setHistoryOpen] = useState(false);

  useEffect(() => {
    useSpinWheelStore
      .getState()
      .reset(useAuthStore.getState().user?.ken ?? SPIN_START_KEN, SPIN_START_TURNS);
  }, []);

  useEffect(() => {
    const state = useSpinWheelStore.getState();
    if (typeof userKen === 'number' && !state.spinning && state.history.length === 0) {
      state.syncKen(userKen);
    }
  }, [userKen]);

  const canSpin = !spinning && turnsLeft > 0;

  return (
    <FullScreenOverlay z={60}>
      <div
        className="h-full w-full overflow-y-auto bg-cover bg-center"
        style={{ backgroundImage: `url(${backgroundUrl})` }}
      >
        <div className="mx-auto w-full max-w-[480px] pb-8">
          <header className="relative w-full">
            <img src={titleBannerUrl} alt="" className="block w-full" />
            <div className="absolute inset-x-0 top-0 bottom-[16%] flex items-center justify-center">
              <span
                className="px-14 text-center text-xl font-extrabold text-white"
                style={TEXT_SHADOW}
              >
                {t('wheelGame.title')}
              </span>
              <button
                type="button"
                onClick={onClose}
                aria-label={t('wheelGame.close')}
                className="absolute right-4 top-1/2 h-8 w-8 -translate-y-1/2 active:scale-95"
              >
                <img src={closeButtonUrl} alt="" className="h-full w-full" />
              </button>
            </div>
          </header>

          <div className="flex flex-col items-center px-4">
            <div className="mt-4 flex items-center">
              <div className="relative w-[220px]">
                <img src={kenBarUrl} alt="" className="w-full" />
                <div className="absolute inset-0 flex items-center gap-1.5 pl-3">
                  <img src={coinUrl} alt="" className="h-6 w-6 shrink-0" />
                  <span className="text-sm font-extrabold text-white" style={TEXT_SHADOW}>
                    {formatKen(ken)} KEN
                  </span>
                </div>
              </div>
              <button
                type="button"
                onClick={() => openApp('ken')}
                aria-label={t('wheelGame.buyKen')}
                className="relative -ml-3 h-11 w-11 active:scale-95"
              >
                <img src={plusFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
                <img
                  src={plusIconUrl}
                  alt=""
                  className="absolute left-1/2 top-1/2 h-5 w-5 -translate-x-1/2 -translate-y-1/2"
                />
              </button>
            </div>

            <div className="mt-5">
              <SpinWheel
                rotation={rotation}
                spinning={spinning}
                onSettle={() => useSpinWheelStore.getState().settle()}
              />
            </div>

            <button
              type="button"
              disabled={!canSpin}
              onClick={() => useSpinWheelStore.getState().spin()}
              className="relative mt-6 w-[260px] active:scale-95 disabled:opacity-60"
            >
              <img src={spinButtonUrl} alt="" className="w-full" />
              <span
                className="absolute inset-0 flex items-center justify-center text-2xl font-extrabold uppercase text-white"
                style={TEXT_SHADOW}
              >
                {t('wheelGame.spin')}
              </span>
            </button>

            <div className="relative mt-3 w-[250px]">
              <img src={spinCountNoteUrl} alt="" className="w-full" />
              <span
                className="absolute inset-0 flex items-center justify-center pl-6 pr-4 text-center text-xs font-semibold text-white"
                style={TEXT_SHADOW}
              >
                {t('wheelGame.spinsLeft', { n: turnsLeft })}
              </span>
            </div>

            <div className="mt-4 flex gap-3">
              <button
                type="button"
                onClick={() => useSpinWheelStore.getState().toggleMute()}
                className="relative h-11 w-[135px] active:scale-95"
              >
                <img src={bottomButtonFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
                <span
                  className="absolute inset-0 flex items-center justify-center gap-1.5 text-sm font-bold text-white"
                  style={TEXT_SHADOW}
                >
                  <img src={muted ? soundOffUrl : soundOnUrl} alt="" className="h-5 w-5" />
                  {t('wheelGame.sound')}
                </span>
              </button>
              <button
                type="button"
                onClick={() => setHistoryOpen(true)}
                className="relative h-11 w-[135px] active:scale-95"
              >
                <img src={bottomButtonFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
                <span
                  className="absolute inset-0 flex items-center justify-center gap-1.5 text-sm font-bold text-white"
                  style={TEXT_SHADOW}
                >
                  <img src={historyIconUrl} alt="" className="h-5 w-5" />
                  {t('wheelGame.history')}
                </span>
              </button>
            </div>
          </div>
        </div>
      </div>

      {result != null && (
        <SpinResultDialog
          segment={result}
          onClose={() => useSpinWheelStore.getState().closeResult()}
        />
      )}
      {historyOpen && (
        <SpinHistoryDialog history={history} onClose={() => setHistoryOpen(false)} />
      )}
    </FullScreenOverlay>
  );
}
