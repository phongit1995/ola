import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { colorForName, formatKen } from '@lib';
import { PenButton } from './PenButton';
import { penAssets } from './penAssets';
import type { PenShot } from './penMock';

interface PenShotListProps {
  shots: PenShot[];
  page: number;
  onSelect: (code: string) => void;
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

function ChevronRight() {
  return (
    <svg
      viewBox="0 0 24 24"
      className="h-3.5 w-3.5"
      fill="currentColor"
      aria-hidden="true"
    >
      <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
    </svg>
  );
}

export function PenShotList({
  shots,
  page,
  onSelect,
  className = '',
}: PenShotListProps) {
  const { t } = useTranslation();

  return (
    <section
      className={`flex min-h-0 flex-col overflow-hidden rounded-2xl border border-white/12 bg-[#001833]/40 ${className}`}
    >
      <header className="flex items-center justify-between px-3 py-2 text-white">
        <span className="flex items-center gap-1.5 text-[11px] font-bold tracking-wide">
          <PeopleIcon />
          {t('penGame.waitingTitle')}
        </span>
        <button
          type="button"
          className="flex items-center gap-0.5 text-[11px] text-white/70"
        >
          {t('penGame.page', { page })}
          <ChevronRight />
        </button>
      </header>

      <div className="pen-scroll min-h-0 flex-1 overflow-x-hidden overflow-y-auto">
        <div
          className={`${ROW_GRID} sticky top-0 z-10 border-y border-white/10 bg-[#001c3e] px-3 py-1.5 text-[10px] font-semibold uppercase tracking-wide text-white/45`}
          style={{ gridTemplateColumns: GRID_COLS }}
        >
          <span>{t('penGame.columns.shooter')}</span>
          <span>{t('penGame.columns.bet')}</span>
          <span className="text-right">{t('penGame.columns.time')}</span>
          <span />
        </div>

        <ul>
          {shots.map((shot) => (
            <li
              key={shot.id}
              className={`${ROW_GRID} border-b border-white/5 px-3 py-1.5`}
              style={{ gridTemplateColumns: GRID_COLS }}
            >
              <span className="flex min-w-0 items-center gap-1.5">
                <Avatar
                  name={shot.shooter}
                  color={colorForName(shot.shooter)}
                  size={22}
                />
                <span className="truncate text-sm text-white/85">
                  @{shot.shooter}
                </span>
              </span>
              <span className="flex items-center gap-1 text-[11px] font-semibold text-[#ffd54f]">
                <img
                  src={penAssets.kenIcon}
                  alt=""
                  className="h-3.5 w-3.5 shrink-0"
                />
                {formatKen(shot.bet)}
              </span>
              <span className="whitespace-nowrap text-right text-[10px] text-white/55">
                {t('penGame.minutesAgo', { m: shot.minutesAgo })}
              </span>
              <PenButton
                bg={penAssets.selectBtn}
                icon={penAssets.gloveIcon}
                iconClassName="h-4 w-4"
                gapClassName="gap-1"
                label={t('penGame.select')}
                onClick={() => onSelect(shot.code)}
                className="pen-cur-glove h-7 w-full px-1 text-[10px]"
              />
            </li>
          ))}
        </ul>
      </div>
    </section>
  );
}
