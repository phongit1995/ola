import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ItemGrantIcon, Spinner } from '@components';
import { DAILY_CHECKIN_BOX, DAILY_CHECKIN_ICONS } from '@constants';
import {
  cn,
  dailyCheckinMonthNumber,
  dailyCheckinNextGiftSlot,
  dailyCheckinNextMonthLabel,
  dailyCheckinTaskName,
  dailyCheckinTodayKind,
  dailyCheckinTodaySlot,
} from '@lib';
import type { DailyCheckinStatus } from '@app-types';
import { boxImageSrc } from '../utils';
import { DailyCheckinRewardList } from './DailyCheckinRewardList';

interface DailyCheckinTodayCardProps {
  status: DailyCheckinStatus;
  busy: boolean;
  onCheckIn: () => void;
  onOpen: () => void;
  onGoTask: () => void;
  framed?: boolean;
}

interface ActionButtonProps {
  tone: 'green' | 'orange';
  busy: boolean;
  onClick: () => void;
  children: ReactNode;
}

function ActionButton({ tone, busy, onClick, children }: ActionButtonProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      disabled={busy}
      className={cn(
        'mt-2.5 flex h-10 w-full items-center justify-center rounded-lg text-sm font-bold text-white shadow-sm active:opacity-85 disabled:opacity-60',
        tone === 'green' ? 'bg-ola-primary' : 'bg-ola-warning'
      )}
    >
      {busy ? <Spinner size={18} tone="light" /> : children}
    </button>
  );
}

function TaskRow({ name, done }: { name: string; done: boolean }) {
  const { t } = useTranslation();
  return (
    <div className={cn('mt-2.5 rounded-lg px-2.5 py-2', done ? 'bg-ola-primary-light' : 'bg-ola-warning-soft')}>
      <p className="text-[11px] font-semibold text-black/54">{t('dailyCheckin.today.taskSection')}</p>
      <div className="mt-1 flex items-center gap-2">
        <img src={DAILY_CHECKIN_ICONS.task} alt="" className="h-6 w-6 shrink-0 object-contain" />
        <div className="min-w-0 flex-1">
          <p className="truncate text-sm font-semibold text-black/87">{name}</p>
          <p className={cn('text-xs', done ? 'text-ola-primary-dark' : 'text-ola-warning-ink')}>
            {done ? t('dailyCheckin.today.taskCompleted') : t('dailyCheckin.today.taskPendingHint')}
          </p>
        </div>
        {done ? (
          <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-ola-primary text-sm font-bold text-white">✓</span>
        ) : (
          <span className="h-6 w-6 shrink-0 rounded-full border-2 border-black/20 bg-white" />
        )}
      </div>
    </div>
  );
}

export function DailyCheckinTodayCard({
  status,
  busy,
  onCheckIn,
  onOpen,
  onGoTask,
  framed = true,
}: DailyCheckinTodayCardProps) {
  const { t } = useTranslation();
  const kind = dailyCheckinTodayKind(status);
  const slot = dailyCheckinTodaySlot(status);
  const month = dailyCheckinMonthNumber(status);
  const box = slot?.box ?? DAILY_CHECKIN_BOX.none;
  const hasBox = box !== DAILY_CHECKIN_BOX.none;
  const taskName = dailyCheckinTaskName(t, status.todayTask?.code);
  const nextGift = dailyCheckinNextGiftSlot(status);
  const vipHint = slot?.requireVip ? t('dailyCheckin.today.vipHint') : undefined;

  if (kind === 'completed') {
    return (
      <section className={cn('text-center', framed && 'rounded-xl bg-white p-4 shadow-sm')}>
        <p className="text-base font-bold text-ola-primary-dark">
          {t('dailyCheckin.today.completedTitle', { count: status.count, total: status.slotCount, month })}
        </p>
        <p className="mt-1 text-sm text-black/54">
          {t('dailyCheckin.today.completedHint', { date: dailyCheckinNextMonthLabel(status) })}
        </p>
        {status.todayResult != null && status.todayResult.length > 0 && (
          <div className="mt-3">
            <DailyCheckinRewardList items={status.todayResult} />
          </div>
        )}
      </section>
    );
  }

  const heading = (
    <div className="flex items-center gap-2">
      <p className="text-[15px] font-bold text-black/87">{t('dailyCheckin.today.heading', { slot: status.slot })}</p>
      {box === DAILY_CHECKIN_BOX.big && (
        <span className="rounded-full bg-ola-checkin-gold-soft px-2 py-0.5 text-[11px] font-bold text-ola-checkin-gold-ink">
          {t('dailyCheckin.today.bigBadge')}
        </span>
      )}
      {slot?.requireVip && (
        <span className="inline-flex items-center gap-1 rounded-full bg-ola-checkin-gold-soft px-2 py-0.5 text-[11px] font-bold text-ola-checkin-gold-ink">
          <img src={DAILY_CHECKIN_ICONS.vipBadge} alt="" className="h-3 w-3 object-contain" />
          {t('dailyCheckin.today.vipBadge')}
        </span>
      )}
    </div>
  );

  const checkedLine = <p className="text-xs text-ola-primary-dark">✓ {t('dailyCheckin.today.checkedIn')}</p>;

  function boxRow(title: string, lines: ReactNode, locked = false) {
    return (
      <div className="mt-2.5 flex items-center gap-2.5">
        <span className="relative flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-ola-checkin-gold-soft">
          {hasBox ? (
            <img src={boxImageSrc(box)} alt="" className="h-9 w-9 object-contain" />
          ) : (
            <span className="text-xl font-bold text-black/54">{status.slot}</span>
          )}
          {locked && <ItemGrantIcon kind="lock" className="absolute bottom-0.5 right-0.5 h-3.5 w-3.5 opacity-80" />}
        </span>
        <div className="min-w-0 text-left">
          <p className="text-sm font-bold text-black/87">{title}</p>
          {lines}
        </div>
      </div>
    );
  }

  let body: ReactNode;
  switch (kind) {
    case 'checkin':
      body = (
        <>
          {hasBox && boxRow(t('dailyCheckin.today.secretTitle'), <p className="text-xs text-black/54">{t('dailyCheckin.today.secretHint')}</p>)}
          <ActionButton tone="green" busy={busy} onClick={onCheckIn}>
            {t('dailyCheckin.actions.checkIn')}
          </ActionButton>
        </>
      );
      break;
    case 'noGift':
      body = boxRow(
        t('dailyCheckin.today.noGiftTitle', { slot: status.slot }),
        <>
          {checkedLine}
          <p className="text-xs text-black/54">
            {nextGift != null ? t('dailyCheckin.today.nextGift', { slot: nextGift }) : t('dailyCheckin.today.noMoreGift')}
          </p>
        </>
      );
      break;
    case 'task':
      body = (
        <>
          {boxRow(t('dailyCheckin.today.lockedTitle'), checkedLine, true)}
          <TaskRow name={taskName} done={false} />
          {vipHint != null && <p className="mt-2 text-xs text-ola-checkin-gold-ink">{vipHint}</p>}
          <ActionButton tone="orange" busy={false} onClick={onGoTask}>
            {t('dailyCheckin.actions.goTask')}
          </ActionButton>
        </>
      );
      break;
    case 'open':
      body = (
        <>
          {boxRow(t('dailyCheckin.today.readyTitle'), checkedLine)}
          <TaskRow name={taskName} done />
          {vipHint != null && <p className="mt-2 text-xs text-ola-checkin-gold-ink">{vipHint}</p>}
          <ActionButton tone="green" busy={busy} onClick={onOpen}>
            {t('dailyCheckin.actions.open')}
          </ActionButton>
        </>
      );
      break;
    default:
      body = (
        <>
          {status.todayTask != null && <TaskRow name={taskName} done />}
          <p className="mt-2.5 text-sm font-semibold text-black/70">{t('dailyCheckin.today.openedTitle')}</p>
          <div className="mt-2">
            <DailyCheckinRewardList items={status.todayResult ?? slot?.items ?? []} />
          </div>
          {status.slot < status.slotCount && (
            <p className="mt-3 text-center text-xs text-black/54">
              {t('dailyCheckin.today.comeBack', { slot: status.slot + 1 })}
            </p>
          )}
        </>
      );
  }

  return (
    <section className={cn(framed && 'rounded-xl bg-white p-4 shadow-sm')}>
      {heading}
      {body}
    </section>
  );
}
