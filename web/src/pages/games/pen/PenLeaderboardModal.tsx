import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import type { PenLeaderboardPeriod } from '@app-types';
import { PEN_LEADERBOARD_PAGE, usePenLeaderboardStore } from '@/store/penLeaderboardStore';
import { penLeaderboardAssets, penShootAssets } from './penAssets';
import { bgImage } from './penUi';
import { PenPagination } from './PenPagination';
import { PenLeaderboardRow } from './PenLeaderboardRow';

const GRID_COLS = '0.7fr 2fr 1.3fr';

interface PenLeaderboardModalProps {
  onClose: () => void;
}

export function PenLeaderboardModal({ onClose }: PenLeaderboardModalProps) {
  const { t } = useTranslation();
  const period = usePenLeaderboardStore((s) => s.period);
  const page = usePenLeaderboardStore((s) => s.page);
  const loading = usePenLeaderboardStore((s) => s.loading);
  const items = usePenLeaderboardStore((s) => s.cache[s.period]);
  const setPeriod = usePenLeaderboardStore((s) => s.setPeriod);
  const setPage = usePenLeaderboardStore((s) => s.setPage);
  const load = usePenLeaderboardStore((s) => s.load);
  const reset = usePenLeaderboardStore((s) => s.reset);

  useEffect(() => {
    void load('day');
    return reset;
  }, [load, reset]);

  const rows = items ?? [];
  const pageCount = Math.max(1, Math.ceil(rows.length / PEN_LEADERBOARD_PAGE));
  const paged = rows.slice(page * PEN_LEADERBOARD_PAGE, (page + 1) * PEN_LEADERBOARD_PAGE);

  const tabs: { key: PenLeaderboardPeriod; label: string }[] = [
    { key: 'day', label: t('penGame.leaderboard.topDay') },
    { key: 'week', label: t('penGame.leaderboard.topWeek') },
  ];

  return (
    <div
      onClick={onClose}
      className="absolute inset-0 z-40 flex items-center justify-center bg-black/55 px-2 @md:px-4"
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="pen-panel relative flex max-h-[92%] w-full flex-col @md:w-[80%]"
      >
        <div className="flex shrink-0 items-center gap-2 px-3 pb-4 pt-5 text-white">
          <span className="h-9 w-9 shrink-0" />
          <span className="flex min-w-0 flex-1 items-center justify-center gap-2">
            <img src={penLeaderboardAssets.cup} alt="" className="h-8 w-auto shrink-0 object-contain" />
            <span className="whitespace-nowrap text-xl font-extrabold italic tracking-wider drop-shadow @md:text-2xl">
              {t('penGame.leaderboard.title')}
            </span>
          </span>
          <button
            type="button"
            aria-label={t('penGame.close')}
            onClick={onClose}
            style={bgImage(penShootAssets.closeBtn)}
            className="flex h-9 w-9 shrink-0 items-center justify-center bg-no-repeat transition active:scale-95"
          >
            <img src={penShootAssets.closeIcon} alt="" className="h-4 w-4 object-contain" />
          </button>
        </div>

        <div className="flex shrink-0 gap-2 px-3 pb-2 pt-2">
          {tabs.map((item) => {
            const active = item.key === period;
            return (
              <button
                key={item.key}
                type="button"
                onClick={() => setPeriod(item.key)}
                style={bgImage(penLeaderboardAssets.tab)}
                className={`flex-1 whitespace-nowrap bg-no-repeat py-3 text-sm font-extrabold tracking-wide text-white transition active:scale-95 ${
                  active ? 'drop-shadow-[0_0_6px_rgba(58,160,255,0.6)]' : 'opacity-40 saturate-50'
                }`}
              >
                {item.label}
              </button>
            );
          })}
        </div>

        <div
          className="grid shrink-0 items-center gap-2 border-y border-white/10 px-3 py-1.5 text-[11px] font-semibold uppercase tracking-wide text-[#7cc4ff]"
          style={{ gridTemplateColumns: GRID_COLS }}
        >
          <span className="text-center">{t('penGame.leaderboard.colRank')}</span>
          <span>{t('penGame.leaderboard.colPlayer')}</span>
          <span className="text-right">{t('penGame.leaderboard.colKenWon')}</span>
        </div>

        <div className="pen-scroll flex h-112.5 flex-col overflow-y-auto">
          {loading && rows.length === 0 ? (
            <div className="flex flex-1 items-center justify-center py-10">
              <Spinner />
            </div>
          ) : rows.length === 0 ? (
            <div className="px-4 py-10 text-center text-sm text-white/55">
              {t('penGame.leaderboard.empty')}
            </div>
          ) : (
            <ul>
              {paged.map((entry) => (
                <PenLeaderboardRow key={entry.user.id} entry={entry} />
              ))}
            </ul>
          )}
        </div>

        <div className="shrink-0 py-3">
          <PenPagination
            page={page}
            pageCount={pageCount}
            loading={loading}
            onPage={setPage}
            className=""
          />
        </div>
      </div>
    </div>
  );
}
