import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { AnimatedKen, FullScreenOverlay } from '@components';
import { formatKen, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenSide, PenShotView } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { PEN_SHOTS_PAGE, PEN_SHOTS_PAGE_MOBILE, usePenStore } from '@/store/penStore';
import { PenButton } from './PenButton';
import { PenShotList } from './PenShotList';
import { PenShootModal } from './PenShootModal';
import { PenCatchModal } from './PenCatchModal';
import { PenHistoryModal } from './PenHistoryModal';
import { PenWinBurst } from './PenWinBurst';
import { penAssets } from './penAssets';
import { PEN_START_KEN } from './penConstants';

const DEFAULT_BET = 1000;
import './pen.css';

const KICK_RESULT_MS = 600;

interface PenGamePageProps {
  onClose: () => void;
}

export function PenGamePage({ onClose }: PenGamePageProps) {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const ken = user?.ken ?? PEN_START_KEN;

  const shots = usePenStore((s) => s.shots);
  const loadingShots = usePenStore((s) => s.loading);
  const shotsPage = usePenStore((s) => s.page);
  const shotsTotal = usePenStore((s) => s.total);
  const shotsPageSize = usePenStore((s) => s.pageSize);
  const loadShots = usePenStore((s) => s.loadShots);
  const setPageSize = usePenStore((s) => s.setPageSize);
  const shotsPageCount = Math.max(1, Math.ceil(shotsTotal / (shotsPageSize || PEN_SHOTS_PAGE)));

  const [kickId, setKickId] = useState(0);
  const [kicking, setKicking] = useState(false);
  const [shootOpen, setShootOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [catchShot, setCatchShot] = useState<PenShotView | null>(null);
  const [catching, setCatching] = useState(false);
  const [winFx, setWinFx] = useState<{ id: number; amount: number } | null>(null);
  const winFxTimer = useRef<number | null>(null);

  useEffect(() => {
    const mq = window.matchMedia('(min-width: 448px)');
    const apply = () => setPageSize(mq.matches ? PEN_SHOTS_PAGE : PEN_SHOTS_PAGE_MOBILE);
    apply();
    mq.addEventListener('change', apply);
    return () => mq.removeEventListener('change', apply);
  }, [setPageSize]);

  const closeCatch = useCallback(() => setCatchShot(null), []);

  useEffect(
    () => () => {
      if (winFxTimer.current != null) window.clearTimeout(winFxTimer.current);
    },
    [],
  );

  const playKick = () => {
    setKickId((n) => n + 1);
    setKicking(true);
    window.setTimeout(() => setKicking(false), KICK_RESULT_MS);
  };

  const triggerWinFx = (amount: number) => {
    setWinFx((prev) => ({ id: (prev?.id ?? 0) + 1, amount }));
    if (winFxTimer.current != null) window.clearTimeout(winFxTimer.current);
    winFxTimer.current = window.setTimeout(() => setWinFx(null), 1600);
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

  const handleCatch = async (side: PenSide) => {
    if (catching || catchShot == null) return;
    setCatching(true);
    try {
      const res = await PenService.catchShot(catchShot.id, { side });
      if (user) setUser({ ...user, ken: res.kenBalance });
      setCatchShot(null);
      playKick();
      if (res.win) {
        triggerWinFx(Math.max(0, res.payout - res.betAmount));
        toast.success(t('penGame.catchWin', { payout: formatKen(res.payout) }));
      } else {
        toast.error(t('penGame.catchLose'));
      }
      void loadShots();
    } catch (e) {
      toast.error(toApiError(e).message);
    } finally {
      setCatching(false);
    }
  };

  const handleRefresh = () => {
    void loadShots();
    toast.info(t('penGame.refreshed'));
  };

  return (
    <FullScreenOverlay className="pen-screen bg-[#011d42]">
      <div className="flex h-full w-full flex-col items-center">
        <div className="@container relative flex w-full max-w-[645px] flex-1 flex-col overflow-hidden bg-[#011d42]">
          <img
            src={penAssets.scene}
            alt=""
            className="pointer-events-none absolute inset-x-0 top-0 w-full"
          />

          <header className="absolute inset-x-0 top-0 z-20 flex w-full items-center gap-2 px-3 py-2 text-white @md:aspect-[1024/118] @md:py-0">
            <div className="flex flex-1 justify-start">
              <PenButton
                bg={penAssets.backBtn}
                icon={penAssets.backIcon}
                ariaLabel={t('chat.back')}
                onClick={onClose}
                className="h-9 w-9 shrink-0 @md:h-11 @md:w-11"
                iconClassName="h-5 w-5 @md:h-7 @md:w-7"
              />
            </div>
            <span className="pointer-events-none flex shrink-0 items-center gap-1.5">
              <span className="text-2xl font-extrabold italic tracking-wider drop-shadow @md:text-4xl">
                {t('penGame.title')}
              </span>
              <img
                src={penAssets.ballTrail}
                alt=""
                className="h-6 w-auto object-contain @md:h-10"
              />
            </span>
            <div className="flex flex-1 items-center justify-end gap-1.5 @md:gap-2">
              <span className="inline-flex items-center gap-0.5 whitespace-nowrap rounded-full bg-black/35 px-1.5 py-0.5 text-xs font-bold @md:gap-1 @md:px-2 @md:py-1 @md:text-sm">
                <img
                  src={penAssets.kenIcon}
                  alt="KEN"
                  className="h-3.5 w-3.5 shrink-0 @md:h-4 @md:w-4"
                />
                <AnimatedKen value={ken} showIcon={false} numberClassName="leading-none" />
              </span>
              <PenButton
                bg={penAssets.plusBtn}
                icon={penAssets.plusIcon}
                ariaLabel={t('penGame.topUp')}
                onClick={() => navigate(ROUTES.kenBuy)}
                className="h-8 w-8 shrink-0 @md:h-11 @md:w-11"
                iconClassName="h-4 w-4 @md:h-5 @md:w-5"
              />
              <PenButton
                bg={penAssets.helpBtn}
                icon={penAssets.helpIcon}
                ariaLabel={t('penGame.help')}
                onClick={() => toast.info(t('penGame.help'))}
                className="h-8 w-8 shrink-0 @md:h-11 @md:w-11"
                iconClassName="h-4 w-4 @md:h-5 @md:w-5"
              />
            </div>
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
            page={shotsPage}
            pageCount={shotsPageCount}
            onPage={(p) => void loadShots(p)}
            onSelect={(shot) => setCatchShot(shot)}
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
              onClick={() => setHistoryOpen(true)}
              className="h-12 flex-1 text-sm"
            />
          </footer>

          {winFx && <PenWinBurst key={winFx.id} amount={winFx.amount} />}

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

          {catchShot != null && (
            <PenCatchModal
              ken={ken}
              betAmount={catchShot.betAmount}
              submitting={catching}
              onTopUp={() => navigate(ROUTES.kenBuy)}
              onConfirm={handleCatch}
              onClose={closeCatch}
            />
          )}

          {historyOpen && (
            <PenHistoryModal userId={user?.id} onClose={() => setHistoryOpen(false)} />
          )}
        </div>
      </div>
    </FullScreenOverlay>
  );
}
