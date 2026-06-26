import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { FullScreenOverlay } from '@components';
import { formatKen, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenSide } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { usePenStore } from '@/store/penStore';
import { PenButton } from './PenButton';
import { PenShotList } from './PenShotList';
import { PenShootModal } from './PenShootModal';
import { penAssets } from './penAssets';
import { PEN_START_KEN } from './penMock';

const DEFAULT_BET = 1000;
import './pen.css';

const KICK_RESULT_MS = 600;

export function PenGamePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const ken = user?.ken ?? PEN_START_KEN;

  const shots = usePenStore((s) => s.shots);
  const loadingShots = usePenStore((s) => s.loading);
  const loadShots = usePenStore((s) => s.loadShots);

  const [kickId, setKickId] = useState(0);
  const [kicking, setKicking] = useState(false);
  const [shootOpen, setShootOpen] = useState(false);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    void loadShots();
  }, [loadShots]);

  const playKick = () => {
    setKickId((n) => n + 1);
    setKicking(true);
    window.setTimeout(() => setKicking(false), KICK_RESULT_MS);
  };

  const handleCreateShot = async ({ side, betAmount }: { side: PenSide; betAmount: number }) => {
    if (submitting) return;
    setSubmitting(true);
    try {
      const res = await PenService.createShot({ side, betAmount });
      if (user) setUser({ ...user, ken: res.kenBalance });
      setShootOpen(false);
      playKick();
      toast.success(t('penGame.shotCreated'));
    } catch (e) {
      toast.error(toApiError(e).message);
    } finally {
      setSubmitting(false);
    }
  };

  const handleRefresh = () => {
    void loadShots();
    toast.info(t('penGame.refreshed'));
  };

  return (
    <FullScreenOverlay className="pen-screen bg-[#011d42]">
      <div className="flex h-full w-full flex-col items-center">
        <div className="relative flex w-full max-w-[645px] flex-1 flex-col overflow-hidden bg-[#011d42]">
          <img
            src={penAssets.scene}
            alt=""
            className="pointer-events-none absolute inset-x-0 top-0 w-full"
          />

          <header
            className="absolute inset-x-0 top-0 z-20 flex w-full items-center justify-between px-3 text-white"
            style={{ aspectRatio: '1024 / 118' }}
          >
            <PenButton
              bg={penAssets.backBtn}
              icon={penAssets.backIcon}
              ariaLabel={t('chat.back')}
              onClick={() => navigate(ROUTES.home)}
              className="h-11 w-11 shrink-0"
              iconClassName="h-7 w-7"
            />
            <span className="pointer-events-none absolute left-1/2 top-1/2 flex -translate-x-1/2 -translate-y-1/2 items-center gap-1.5">
              <span className="text-4xl font-extrabold italic tracking-wider drop-shadow">
                {t('penGame.title')}
              </span>
              <img
                src={penAssets.ballTrail}
                alt=""
                className="h-10 w-auto object-contain"
              />
            </span>
            <span className="flex items-center gap-2">
              <span className="inline-flex items-center gap-1 rounded-full bg-black/35 px-2 py-1 text-sm font-bold">
                <img
                  src={penAssets.kenIcon}
                  alt="KEN"
                  className="h-4 w-4 shrink-0"
                />
                {formatKen(ken)}
              </span>
              <PenButton
                bg={penAssets.plusBtn}
                icon={penAssets.plusIcon}
                ariaLabel={t('penGame.topUp')}
                onClick={() => navigate(ROUTES.kenBuy)}
                className="h-9 w-9"
                iconClassName="h-4 w-4"
              />
              <PenButton
                bg={penAssets.helpBtn}
                icon={penAssets.helpIcon}
                ariaLabel={t('penGame.help')}
                onClick={() => toast.info(t('penGame.help'))}
                className="h-9 w-9"
                iconClassName="h-4 w-4"
              />
            </span>
          </header>

          <div
            className="relative z-10 flex w-full shrink-0 items-end justify-end pb-2 pl-4 pr-8"
            style={{ aspectRatio: '1024 / 650' }}
          >
            {kickId > 0 && (
              <img
                key={kickId}
                src={penAssets.ballTrail}
                alt=""
                className="pointer-events-none absolute bottom-[26%] left-1/2 h-14 w-auto pen-kick object-contain"
              />
            )}
            <PenButton
              bg={penAssets.shootBtn}
              icon={penAssets.ball}
              label={t('penGame.shoot')}
              onClick={() => setShootOpen(true)}
              disabled={kicking}
              className="pen-cur-ball h-16 w-[40%] max-w-44 text-2xl tracking-wider"
              iconClassName="h-11 w-11 pen-shake"
              gapClassName="gap-3"
            />
          </div>

          <PenShotList
            shots={shots}
            loading={loadingShots}
            page={1}
            onSelect={(shot) =>
              toast.success(t('penGame.selected', { code: shot.shooter?.username ?? '' }))
            }
            className="relative z-10 mx-4 mb-1 min-h-0 flex-1"
          />

          <footer className="relative z-20 flex shrink-0 items-center gap-3 px-4 py-3">
            <PenButton
              bg={penAssets.refreshBtn}
              icon={penAssets.refreshIcon}
              label={t('penGame.refresh')}
              onClick={handleRefresh}
              className="h-12 flex-1 text-sm"
            />
            <PenButton
              bg={penAssets.historyBtn}
              icon={penAssets.historyIcon}
              label={t('penGame.history')}
              onClick={() => toast.info(t('penGame.historyEmpty'))}
              className="h-12 flex-1 text-sm"
            />
          </footer>

          {shootOpen && (
            <PenShootModal
              ken={ken}
              amount={DEFAULT_BET}
              submitting={submitting}
              onTopUp={() => navigate(ROUTES.kenBuy)}
              onConfirm={handleCreateShot}
              onClose={() => setShootOpen(false)}
            />
          )}
        </div>
      </div>
    </FullScreenOverlay>
  );
}
