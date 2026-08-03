import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { toast } from '@lib';
import { AnimatedKen, FullScreenOverlay, Spinner } from '@components';
import { SocketService } from '@services';
import { useAuthStore } from '@/store/authStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { useSpinWheelStore } from './spinWheelStore';
import { SpinWheel } from './SpinWheel';
import { SpinResultDialog } from './SpinResultDialog';
import { SpinHistoryDialog } from './SpinHistoryDialog';
import { GiftListDialog } from './GiftListDialog';
import { WheelActionButton } from './WheelActionButton';
import { playSpinSound, stopSpinSound } from './spinWheelSound';
import { SPIN_START_KEN } from './spinWheel.constants';
import {
  CHIP_TEXT_STYLE,
  SPIN_TEXT_STYLE,
  TEXT_SHADOW,
  TITLE_STYLE,
} from './spinWheelStyles';
import {
  backgroundUrl,
  closeButtonUrl,
  coinUrl,
  giftBoxUrl,
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

interface SpinWheelGamePageProps {
  onClose: () => void;
}

export function SpinWheelGamePage({ onClose }: SpinWheelGamePageProps) {
  const { t } = useTranslation();
  const userKen = useAuthStore((s) => s.user?.ken);
  const openApp = useAppOverlayStore((s) => s.push);
  const ken = useSpinWheelStore((s) => s.ken);
  const muted = useSpinWheelStore((s) => s.muted);
  const rotation = useSpinWheelStore((s) => s.rotation);
  const spinning = useSpinWheelStore((s) => s.spinning);
  const result = useSpinWheelStore((s) => s.result);
  const config = useSpinWheelStore((s) => s.config);
  const configStatus = useSpinWheelStore((s) => s.configStatus);
  const loadConfig = useSpinWheelStore((s) => s.loadConfig);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [giftListOpen, setGiftListOpen] = useState(false);

  useEffect(() => {
    void loadConfig();
  }, [loadConfig]);

  useEffect(() => {
    useSpinWheelStore.getState().syncKen(userKen ?? SPIN_START_KEN);
  }, [userKen]);

  useEffect(() => {
    useSpinWheelStore.setState({
      spinning: false,
      suppressKenSync: false,
      pendingResult: null,
    });
    const off = SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken === 'number')
        useSpinWheelStore.getState().syncKen(data.ken);
    });
    return () => {
      off();
      stopSpinSound();
      useSpinWheelStore.setState({ spinning: false, suppressKenSync: false });
    };
  }, []);

  const kenCost = config?.kenCost ?? 0;
  const freeAvailable = config?.freeAvailable ?? false;
  const ready = configStatus === 'ready' && config != null;
  const affordable = freeAvailable || ken >= kenCost;
  const canSpin = ready && !spinning && affordable;

  const handleSpin = async () => {
    const state = useSpinWheelStore.getState();
    if (state.spinning || !ready) return;
    if (!freeAvailable && ken < kenCost) {
      toast.info(t('wheelGame.outOfKen'));
      return;
    }
    const ok = await state.spin();
    if (!ok) {
      toast.error(t('wheelGame.error'));
      return;
    }
    if (!useSpinWheelStore.getState().muted) playSpinSound();
  };

  return (
    <FullScreenOverlay z={60}>
      <div
        className="font-game flex h-full w-full flex-col overflow-x-hidden bg-cover bg-center"
        style={{ backgroundImage: `url(${backgroundUrl})` }}
      >
        <header
          className="relative flex w-full shrink-0 items-center justify-center"
          style={{
            backgroundImage: `url(${titleBannerUrl})`,
            backgroundSize: '100% 100%',
            aspectRatio: '1906 / 360',
          }}
        >
          <span
            className="px-14 text-center text-2xl font-extrabold text-white"
            style={TITLE_STYLE}
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
        </header>

        <div className="flex min-h-0 flex-1 flex-col items-center justify-evenly overflow-y-auto px-4 py-4">
          <div
            className="flex w-65 max-w-full items-center gap-2 px-2.5"
            style={{
              backgroundImage: `url(${kenBarUrl})`,
              backgroundSize: '100% 100%',
              aspectRatio: '2014 / 521',
            }}
          >
            <img src={coinUrl} alt="" className="h-11 w-11 shrink-0" />
            <AnimatedKen
              value={ken}
              showIcon={false}
              className="min-w-0 flex-1 justify-center"
              numberClassName="truncate text-xl font-extrabold"
              numberStyle={CHIP_TEXT_STYLE}
            />
            <button
              type="button"
              onClick={() => openApp('ken')}
              aria-label={t('wheelGame.buyKen')}
              className="flex h-11 w-11 shrink-0 items-center justify-center bg-size-[100%_100%] bg-center bg-no-repeat active:scale-95"
              style={{ backgroundImage: `url(${plusFrameUrl})` }}
            >
              <img src={plusIconUrl} alt="" className="h-5 w-5" />
            </button>
          </div>

          {ready ? (
            <SpinWheel
              segments={config.segments}
              rotation={rotation}
              spinning={spinning}
              onSettle={() => {
                stopSpinSound();
                useSpinWheelStore.getState().settle();
              }}
            />
          ) : (
            <div
              className="flex items-center justify-center"
              style={{ width: 'min(84vw, 360px)', aspectRatio: '1 / 1' }}
            >
              {configStatus === 'error' ? (
                <span
                  className="text-sm font-bold text-white"
                  style={TEXT_SHADOW}
                >
                  {t('wheelGame.error')}
                </span>
              ) : (
                <Spinner />
              )}
            </div>
          )}

          <button
            type="button"
            disabled={!canSpin}
            onClick={() => void handleSpin()}
            className="relative w-65 max-w-full active:scale-95 disabled:opacity-60"
          >
            <img src={spinButtonUrl} alt="" className="w-full" />
            <span
              className="absolute inset-0 flex items-center justify-center text-3xl font-extrabold uppercase"
              style={SPIN_TEXT_STYLE}
            >
              {t('wheelGame.spin')}
            </span>
          </button>

          <div className="flex items-center justify-center gap-1.5">
            <img
              src={spinCountNoteUrl}
              alt=""
              className="h-6 w-auto shrink-0"
            />
            <span className="text-sm font-bold text-white" style={TEXT_SHADOW}>
              {freeAvailable
                ? t('wheelGame.freeToday')
                : t('wheelGame.spinCost', { n: kenCost })}
            </span>
          </div>

          <div className="flex w-full max-w-90 gap-3">
            <WheelActionButton
              icon={muted ? soundOffUrl : soundOnUrl}
              label={t('wheelGame.sound')}
              onClick={() => {
                useSpinWheelStore.getState().toggleMute();
                if (useSpinWheelStore.getState().muted) stopSpinSound();
              }}
            />
            <WheelActionButton
              icon={historyIconUrl}
              label={t('wheelGame.history')}
              onClick={() => setHistoryOpen(true)}
            />
            <WheelActionButton
              icon={giftBoxUrl}
              label={t('wheelGame.gifts')}
              onClick={() => setGiftListOpen(true)}
            />
          </div>
        </div>
      </div>

      {result != null && (
        <SpinResultDialog
          result={result}
          onClose={() => useSpinWheelStore.getState().closeResult()}
        />
      )}
      {historyOpen && (
        <SpinHistoryDialog
          open={historyOpen}
          onClose={() => setHistoryOpen(false)}
        />
      )}
      {giftListOpen && ready && (
        <GiftListDialog
          segments={config.segments}
          onClose={() => setGiftListOpen(false)}
        />
      )}
    </FullScreenOverlay>
  );
}
