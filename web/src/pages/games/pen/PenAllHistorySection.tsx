import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { VipBadge } from '@components';
import { formatVnd } from '@lib';
import type { PenUserBrief } from '@app-types';
import { PEN_HISTORY_PAGE, usePenHistoryStore } from '@/store/penHistoryStore';
import { penAssets } from './penAssets';
import { toAllHistoryRow } from './penHistory';
import { PenHistoryTable } from './PenHistoryTable';

const ROW_GRID = 'grid items-center gap-1';
const GRID_COLS = '1.5fr 1.5fr 0.95fr 0.7fr';

function TrophyIcon({ className = 'h-3.5 w-3.5' }: { className?: string }) {
  return (
    <svg
      viewBox="0 0 24 24"
      className={className}
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M18 2H6v1H3a1 1 0 0 0-1 1v2a4 4 0 0 0 4 4h.27A6 6 0 0 0 11 13.91V16H8v3h8v-3h-3v-2.09A6 6 0 0 0 17.73 10H18a4 4 0 0 0 4-4V4a1 1 0 0 0-1-1h-3V2Zm0 3h2v1a2 2 0 0 1-2 2V5ZM4 6V5h2v3a2 2 0 0 1-2-2Z" />
    </svg>
  );
}

function PlayerCell({ user, won }: { user?: PenUserBrief; won: boolean }) {
  if (user == null) return <span className="text-[11px] text-white/35">—</span>;
  return (
    <span className="flex min-w-0 items-center gap-1">
      <VipBadge typeId={user.vipTypeId} className="h-5 w-5" />
      <span
        className={`truncate text-[11px] ${
          won ? 'font-bold text-[#46e06a]' : 'text-white/80'
        }`}
      >
        @{user.username}
      </span>
      {won && <TrophyIcon className="h-3.5 w-3.5 shrink-0 text-[#ffd23f]" />}
    </span>
  );
}

export function PenAllHistorySection() {
  const { t } = useTranslation();
  const state = usePenHistoryStore((s) => s.sections.all);
  const load = usePenHistoryStore((s) => s.load);

  useEffect(() => {
    void load('all', 0);
  }, [load]);

  const pageCount = Math.max(1, Math.ceil(state.total / PEN_HISTORY_PAGE));

  return (
    <PenHistoryTable
      rowGrid={ROW_GRID}
      gridCols={GRID_COLS}
      minWidthClass=""
      minHeight={340}
      header={
        <>
          <span>{t('penGame.hist.colShooter')}</span>
          <span>{t('penGame.hist.colCatcher')}</span>
          <span>{t('penGame.hist.colBet')}</span>
          <span className="text-center">{t('penGame.hist.colTime')}</span>
        </>
      }
      loading={state.loading}
      isEmpty={state.items.length === 0}
      emptyText={t('penGame.hist.emptyAll')}
      page={state.page}
      pageCount={pageCount}
      onPage={(p) => void load('all', p)}
    >
      <ul>
        {state.items.map((shot) => {
          const row = toAllHistoryRow(shot);
          return (
            <li
              key={row.id}
              className={`${ROW_GRID} border-b border-white/5 px-1.5 py-1.5`}
              style={{ gridTemplateColumns: GRID_COLS }}
            >
              <PlayerCell
                user={row.shooter}
                won={row.winnerId != null && row.winnerId === row.shooter?.id}
              />
              <PlayerCell
                user={row.keeper}
                won={row.winnerId != null && row.winnerId === row.keeper?.id}
              />
              <span className="flex items-center gap-1 whitespace-nowrap text-[11px] font-semibold text-[#ffd54f]">
                <img
                  src={penAssets.kenIcon}
                  alt=""
                  className="h-3.5 w-3.5 shrink-0"
                />
                {formatVnd(row.bet)}
              </span>
              <span className="flex flex-col items-center whitespace-nowrap text-center text-[9px] leading-tight text-white/55">
                <span>{row.date}</span>
                <span>{row.time}</span>
              </span>
            </li>
          );
        })}
      </ul>
    </PenHistoryTable>
  );
}
