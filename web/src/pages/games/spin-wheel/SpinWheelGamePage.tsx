import { useEffect, useState, type CSSProperties } from 'react';
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

const TITLE_STYLE: CSSProperties = {
  color: '#ffffff',
  WebkitTextStroke: '3px #6b4a1c',
  paintOrder: 'stroke fill',
  textShadow: '0 3px 4px rgba(0,0,0,0.35)',
  letterSpacing: '0.02em',
};

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
        className="h-full w-full overflow-x-hidden overflow-y-auto bg-cover bg-center"
        style={{ backgroundImage: `url(${backgroundUrl})` }}
      >
        <header
          className="relative flex w-full items-center justify-center"
          style={{
            backgroundImage: `url(${titleBannerUrl})`,
            backgroundSize: '100% 100%',
            aspectRatio: '1906 / 360',
          }}
        >
          <span className="px-14 text-center text-2xl font-extrabold text-white" style={TITLE_STYLE}>
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
        </header>

        <div className="flex flex-col items-center px-4 pb-8">
            <div
              className="relative mt-4 flex w-[240px] max-w-full items-center gap-1.5 pl-3 pr-12"
              style={{
                backgroundImage: `url(${kenBarUrl})`,
                backgroundSize: '100% 100%',
                aspectRatio: '2014 / 521',
              }}
            >
              <img src={coinUrl} alt="" className="h-6 w-6 shrink-0" />
              <span className="truncate text-sm font-extrabold text-white" style={TEXT_SHADOW}>
                {formatKen(ken)} KEN
              </span>
              <button
                type="button"
                onClick={() => openApp('ken')}
                aria-label={t('wheelGame.buyKen')}
                className="absolute right-1 top-1/2 h-9 w-9 -translate-y-1/2 active:scale-95"
              >
                <img src={plusFrameUrl} alt="" className="absolute inset-0 h-full w-full" />
                <img
                  src={plusIconUrl}
                  alt=""
                  className="absolute left-1/2 top-1/2 h-4 w-4 -translate-x-1/2 -translate-y-1/2"
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
              className="relative mt-6 w-[260px] max-w-full active:scale-95 disabled:opacity-60"
            >
              <img src={spinButtonUrl} alt="" className="w-full" />
              <span
                className="absolute inset-0 flex items-center justify-center text-2xl font-extrabold uppercase text-white"
                style={TEXT_SHADOW}
              >
                {t('wheelGame.spin')}
              </span>
            </button>

            <div className="relative mt-3 w-[250px] max-w-full">
              <img src={spinCountNoteUrl} alt="" className="w-full" />
              <span
                className="absolute inset-0 flex items-center justify-center pl-6 pr-4 text-center text-xs font-semibold text-white"
                style={TEXT_SHADOW}
              >
                {t('wheelGame.spinsLeft', { n: turnsLeft })}
              </span>
            </div>

            <div className="mt-4 flex w-full max-w-[300px] gap-3">
              <button
                type="button"
                onClick={() => useSpinWheelStore.getState().toggleMute()}
                className="relative h-11 flex-1 active:scale-95"
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
                className="relative h-11 flex-1 active:scale-95"
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
