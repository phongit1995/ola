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
        'mt-3 flex h-11 w-full items-center justify-center rounded-lg text-base font-bold text-white shadow-sm active:opacity-85 disabled:opacity-60',
        tone === 'green' ? 'bg-ola-primary' : 'bg-ola-warning'
      )}
    >
      {busy ? <Spinner size={18} tone="light" /> : children}
    </button>
  );
}

function Notice({ tone, title, hint }: { tone: 'orange' | 'green'; title: string; hint?: string }) {
  return (
    <div
      className={cn(
        'mt-3 flex gap-2 rounded-lg px-3 py-2 text-sm',
        tone === 'orange' ? 'bg-ola-warning-soft text-ola-warning-ink' : 'bg-ola-primary-light text-ola-primary-dark'
      )}
    >
      {tone === 'orange' ? (
        <img src={DAILY_CHECKIN_ICONS.task} alt="" className="mt-0.5 h-4 w-4 shrink-0 object-contain" />
      ) : (
        <span className="font-bold">✓</span>
      )}
      <span className="min-w-0">
        <span className="block font-semibold">{title}</span>
        {hint != null && <span className="block">{hint}</span>}
      </span>
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
      <p className="text-base font-bold text-black/87">{t('dailyCheckin.today.heading', { slot: status.slot })}</p>
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

  const checkedLine = <p className="text-sm text-ola-primary-dark">✓ {t('dailyCheckin.today.checkedIn')}</p>;

  function boxRow(title: string, lines: ReactNode, locked = false) {
    return (
      <div className="mt-3 flex items-center gap-3">
        <span className="relative flex h-16 w-16 shrink-0 items-center justify-center rounded-xl bg-ola-checkin-gold-soft">
          {hasBox ? (
            <img src={boxImageSrc(box)} alt="" className="h-12 w-12 object-contain" />
          ) : (
            <span className="text-2xl font-bold text-black/54">{status.slot}</span>
          )}
          {locked && <ItemGrantIcon kind="lock" className="absolute bottom-1 right-1 h-4 w-4 opacity-80" />}
        </span>
        <div className="min-w-0 text-left">
          <p className="text-base font-bold text-black/87">{title}</p>
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
          {boxRow(
            hasBox ? t('dailyCheckin.today.secretTitle') : t('dailyCheckin.today.noGiftTitle', { slot: status.slot }),
            <p className="text-sm text-black/54">
              {hasBox ? t('dailyCheckin.today.secretHint') : t('dailyCheckin.today.noGiftHint')}
            </p>
          )}
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
          <p className="text-sm text-black/54">
            {nextGift != null ? t('dailyCheckin.today.nextGift', { slot: nextGift }) : t('dailyCheckin.today.noMoreGift')}
          </p>
        </>
      );
      break;
    case 'task':
      body = (
        <>
          {boxRow(
            t('dailyCheckin.today.lockedTitle'),
            <>
              {checkedLine}
              <p className="text-sm text-black/54">{t('dailyCheckin.today.lockedHint')}</p>
            </>,
            true
          )}
          <Notice tone="orange" title={t('dailyCheckin.today.taskTitle', { task: taskName })} hint={t('dailyCheckin.today.taskHint')} />
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
          <Notice tone="green" title={t('dailyCheckin.today.taskDone', { task: taskName })} />
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
          <p className="mt-3 text-sm font-semibold text-black/70">{t('dailyCheckin.today.openedTitle')}</p>
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
