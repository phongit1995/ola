import { useEffect, useState, type CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { ConfirmDialog, Spinner, VipBadge } from '@components';
import { formatVnd, toApiError, toast } from '@lib';
import { PenService } from '@services';
import type { PenSide } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { PEN_HISTORY_PAGE, usePenHistoryStore } from '@/store/penHistoryStore';
import type { PenHistorySection as SectionRole } from '@/store/penHistoryStore';
import { penAssets, penHistoryAssets } from './penAssets';
import { toHistoryRow, type PenHistoryOutcome, type PenHistoryRowView } from './penHistory';

const ROW_GRID = 'grid items-center gap-1.5';
const GRID_COLS = '1.6fr 0.9fr 0.8fr 1.85fr';
const stretchBg: CSSProperties = { backgroundSize: '100% 100%' };

function BanIcon({ className = 'h-4 w-4' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" aria-hidden="true">
      <circle cx="12" cy="12" r="9" />
      <path d="M5.6 5.6l12.8 12.8" />
    </svg>
  );
}

function DirectionLabel({ verb, side }: { verb: 'shoot' | 'catch'; side: PenSide }) {
  const { t } = useTranslation();
  const left = side === 'left';
  const label =
    verb === 'catch'
      ? left
        ? t('penGame.hist.catchLeft')
        : t('penGame.hist.catchRight')
      : left
        ? t('penGame.hist.shootLeft')
        : t('penGame.hist.shootRight');
  return (
    <span className={`flex items-center gap-0.5 text-[10px] font-semibold ${left ? 'text-[#46e06a]' : 'text-[#3aa0ff]'}`}>
      {label} {left ? '←' : '→'}
    </span>
  );
}

function ResultCell({ outcome, amount, onCancel }: { outcome: PenHistoryOutcome; amount: number; onCancel?: () => void }) {
  const { t } = useTranslation();
  if (outcome === 'pending') {
    if (onCancel == null) return null;
    return (
      <span className="flex items-center justify-end">
        <button
          type="button"
          onClick={onCancel}
          className="rounded-md border border-[#ff5b5b]/70 bg-[#ff5b5b]/15 px-2.5 py-1 text-[11px] font-bold text-[#ff7a7a] transition active:scale-95"
        >
          {t('penGame.hist.cancel')}
        </button>
      </span>
    );
  }
  if (outcome === 'cancelled') {
    return (
      <span className="flex items-center justify-end gap-1 text-[11px] font-semibold text-white/45">
        <BanIcon className="h-4 w-4" />
        {t('penGame.hist.cancelledTag')}
      </span>
    );
  }
  const win = outcome === 'win';
  return (
    <span className="flex items-center justify-end gap-1">
      <img
        src={win ? penHistoryAssets.resultWin : penHistoryAssets.resultLose}
        alt=""
        className="h-6 w-6 shrink-0 object-contain"
      />
      <span className={`whitespace-nowrap text-[11px] font-bold ${win ? 'text-[#46e06a]' : 'text-[#ff5b5b]'}`}>
        {win ? '+' : '-'}
        {formatVnd(Math.abs(amount))} {t('penGame.hist.ken')}
      </span>
    </span>
  );
}

function PenHistoryRow({
  row,
  verb,
  onCancel,
}: {
  row: PenHistoryRowView;
  verb: 'shoot' | 'catch';
  onCancel: (id: string) => void;
}) {
  const { t } = useTranslation();
  return (
    <li className={`${ROW_GRID} border-b border-white/5 px-2 py-1.5`} style={{ gridTemplateColumns: GRID_COLS }}>
      <span className="flex min-w-0 items-center gap-1.5">
        {row.opponent != null ? (
          <>
            <VipBadge typeId={row.opponent.vipTypeId} className="h-7 w-7" />
            <span className="flex min-w-0 flex-col leading-tight">
              <span className="truncate text-xs text-white/90">@{row.opponent.username}</span>
              {row.side != null && <DirectionLabel verb={verb} side={row.side} />}
            </span>
          </>
        ) : row.outcome === 'pending' ? (
          <span className="flex items-center gap-1 text-[11px] font-semibold text-[#ffd23f]">
            <img src={penHistoryAssets.clockYellow} alt="" className="h-4 w-4 object-contain" />
            {t('penGame.hist.pending')}
          </span>
        ) : (
          <span className="text-[11px] text-white/35">—</span>
        )}
      </span>

      <span className="flex items-center gap-1 text-[11px] font-semibold text-[#ffd54f]">
        <img src={penAssets.kenIcon} alt="" className="h-3.5 w-3.5 shrink-0" />
        {formatVnd(row.bet)}
      </span>

      <span className="flex flex-col items-center text-center text-[9px] leading-tight text-white/55">
        <span>{row.date}</span>
        <span>{row.time}</span>
      </span>

      <span className="flex items-center justify-end">
        <ResultCell
          outcome={row.outcome}
          amount={row.amount}
          onCancel={row.outcome === 'pending' ? () => onCancel(row.id) : undefined}
        />
      </span>
    </li>
  );
}

function PageNav({ dir, disabled, onClick }: { dir: 'prev' | 'next'; disabled: boolean; onClick: () => void }) {
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      aria-label={dir}
      style={{ ...stretchBg, backgroundImage: `url(${penHistoryAssets.pageNext})` }}
      className="flex h-9 w-9 items-center justify-center bg-no-repeat text-white transition active:scale-95 disabled:opacity-30"
    >
      <svg viewBox="0 0 24 24" className={`h-3.5 w-3.5 ${dir === 'prev' ? 'rotate-180' : ''}`} fill="currentColor" aria-hidden="true">
        <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
      </svg>
    </button>
  );
}

export function PenPagination({
  page,
  pageCount,
  loading,
  onPage,
}: {
  page: number;
  pageCount: number;
  loading: boolean;
  onPage: (page: number) => void;
}) {
  return (
    <div className="mt-2 flex items-center justify-center gap-2">
      <PageNav dir="prev" disabled={loading || page <= 0} onClick={() => onPage(page - 1)} />
      <span
        style={{ ...stretchBg, backgroundImage: `url(${penHistoryAssets.pageCurrent})` }}
        className="flex h-9 min-w-16 items-center justify-center bg-no-repeat px-3 text-sm font-extrabold text-white"
      >
        {page + 1}
      </span>
      <PageNav dir="next" disabled={loading || page >= pageCount - 1} onClick={() => onPage(page + 1)} />
    </div>
  );
}

interface PenHistorySectionProps {
  section: SectionRole;
  opponentLabel: string;
  userId?: string;
}

export function PenHistorySection({ section, opponentLabel, userId }: PenHistorySectionProps) {
  const { t } = useTranslation();
  const state = usePenHistoryStore((s) => s.sections[section]);
  const load = usePenHistoryStore((s) => s.load);
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const [cancelId, setCancelId] = useState<string | null>(null);
  const [cancelling, setCancelling] = useState(false);

  useEffect(() => {
    void load(section, 0);
  }, [load, section]);

  const verb = section === 'shoot' ? 'catch' : 'shoot';
  const pageCount = Math.max(1, Math.ceil(state.total / PEN_HISTORY_PAGE));
  const emptyText = section === 'shoot' ? t('penGame.hist.emptyShot') : t('penGame.hist.emptyCatch');

  const handleCancel = async () => {
    if (cancelId == null || cancelling) return;
    setCancelling(true);
    try {
      const res = await PenService.cancelShot(cancelId);
      if (user) setUser({ ...user, ken: res.kenBalance });
      setCancelId(null);
      toast.success(t('penGame.hist.cancelled'));
      void load(section, state.page);
    } catch (e) {
      toast.error(toApiError(e).message);
    } finally {
      setCancelling(false);
    }
  };

  return (
    <section className="rounded-2xl border border-[#1e6fe0]/40 bg-[#001026]/50 p-2">
      <div className="pen-scroll overflow-x-auto">
        <div className="min-w-[440px]">
          <div
            className={`${ROW_GRID} border-b border-white/10 px-2 pb-1.5 text-[9px] font-semibold uppercase tracking-wide text-[#5aa0e0]`}
            style={{ gridTemplateColumns: GRID_COLS }}
          >
            <span>{opponentLabel}</span>
            <span>{t('penGame.hist.colBet')}</span>
            <span className="text-center">{t('penGame.hist.colTime')}</span>
            <span className="text-right">{t('penGame.hist.colResult')}</span>
          </div>

          <div className="min-h-[420px]">
            {state.loading ? (
              <div className="flex h-[420px] items-center justify-center">
                <Spinner />
              </div>
            ) : state.items.length === 0 ? (
              <div className="flex h-[420px] items-center justify-center text-xs text-white/50">
                {emptyText}
              </div>
            ) : (
              <ul>
                {state.items.map((shot) => (
                  <PenHistoryRow
                    key={shot.id}
                    row={toHistoryRow(shot, section, userId)}
                    verb={verb}
                    onCancel={setCancelId}
                  />
                ))}
              </ul>
            )}
          </div>
        </div>
      </div>

      <PenPagination
        page={state.page}
        pageCount={pageCount}
        loading={state.loading}
        onPage={(p) => void load(section, p)}
      />

      <ConfirmDialog
        open={cancelId != null}
        title={t('penGame.hist.cancelTitle')}
        message={t('penGame.hist.cancelMessage')}
        confirmLabel={t('penGame.hist.cancelConfirm')}
        cancelLabel={t('penGame.hist.cancelDismiss')}
        danger
        onConfirm={handleCancel}
        onCancel={() => setCancelId(null)}
      />
    </section>
  );
}
