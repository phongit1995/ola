import { useTranslation } from 'react-i18next';
import { Spinner, VipBadge } from '@components';
import { createTimeFormatter, formatKen } from '@lib';
import type { PenShotView } from '@app-types';
import { PenButton } from './PenButton';
import { PenPagination } from './PenPagination';
import { penAssets } from './penAssets';

interface PenShotListProps {
  shots: PenShotView[];
  loading?: boolean;
  page: number;
  pageCount: number;
  onPage: (page: number) => void;
  onSelect: (shot: PenShotView) => void;
  className?: string;
}

const ROW_GRID = 'grid items-center gap-1.5';
const GRID_COLS = '1.9fr 1fr 1.2fr 0.95fr';

function PeopleIcon() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-3.5 w-3.5"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M16 11a3 3 0 1 0-3-3 3 3 0 0 0 3 3Zm-8 0a3 3 0 1 0-3-3 3 3 0 0 0 3 3Zm0 2c-2.7 0-5 1.3-5 3.5V19h6v-2.5c0-.9.4-1.7 1-2.4A8 8 0 0 0 8 13Zm8 0c-.5 0-1 .05-1.4.13C16 14.1 17 15.4 17 16.5V19h6v-2.5c0-2.2-2.3-3.5-5-3.5Z" />
    </svg>
  );
}

export function PenShotList({
  shots,
  loading,
  page,
  pageCount,
  onPage,
  onSelect,
  className = '',
}: PenShotListProps) {
  const { t, i18n } = useTranslation();
  const formatTime = createTimeFormatter(i18n.language);

  return (
    <section
      className={`flex min-h-0 flex-col overflow-hidden rounded-2xl border border-white/12 bg-[#001833]/40 ${className}`}
    >
      <header className="flex items-center px-3 py-1.5 text-white">
        <span className="flex items-center gap-1.5 text-[11px] font-bold tracking-wide">
          <PeopleIcon />
          {t('penGame.waitingTitle')}
        </span>
      </header>

      <div className="pen-scroll min-h-0 flex-1 overflow-x-hidden overflow-y-auto">
        <div
          className={`${ROW_GRID} sticky top-0 z-10 border-y border-white/10 bg-[#001c3e] px-3 py-1 text-[10px] font-semibold uppercase tracking-wide text-white/45`}
          style={{ gridTemplateColumns: GRID_COLS }}
        >
          <span>{t('penGame.columns.shooter')}</span>
          <span>{t('penGame.columns.bet')}</span>
          <span className="text-right">{t('penGame.columns.time')}</span>
          <span />
        </div>

        {loading ? (
          <div className="flex items-center justify-center py-8">
            <Spinner />
          </div>
        ) : shots.length === 0 ? (
          <div className="px-4 py-8 text-center text-xs text-white/55">
            {t('penGame.emptyShots')}
          </div>
        ) : (
          <ul>
            {shots.map((shot) => {
              const username = shot.shooter?.username ?? '';
              return (
                <li
                  key={shot.id}
                  className={`${ROW_GRID} border-b border-white/5 px-3 py-1`}
                  style={{ gridTemplateColumns: GRID_COLS }}
                >
                  <span className="flex min-w-0 items-center gap-1.5">
                    <VipBadge typeId={shot.shooter?.vipTypeId} />
                    <span className="truncate text-sm text-white/85">@{username}</span>
                  </span>
                  <span className="flex items-center gap-1 text-[11px] font-semibold text-[#ffd54f]">
                    <img
                      src={penAssets.kenIcon}
                      alt=""
                      className="h-3.5 w-3.5 shrink-0"
                    />
                    {formatKen(shot.betAmount)}
                  </span>
                  <span className="whitespace-nowrap text-right text-[10px] text-white/55">
                    {formatTime(shot.createdAt)}
                  </span>
                  <PenButton
                    bg={penAssets.selectBtn}
                    icon={penAssets.gloveIcon}
                    iconClassName="h-4 w-4"
                    gapClassName="gap-1"
                    label={t('penGame.select')}
                    onClick={() => onSelect(shot)}
                    className="pen-cur-glove h-7 w-full px-1 text-[10px]"
                  />
                </li>
              );
            })}
          </ul>
        )}
      </div>

      <div className="shrink-0 py-1">
        <PenPagination page={page} pageCount={pageCount} loading={loading ?? false} onPage={onPage} className="" />
      </div>
    </section>
  );
}
