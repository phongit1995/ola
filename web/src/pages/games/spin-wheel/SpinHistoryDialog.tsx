import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner, VipIcon } from '@components';
import { createTimeFormatter, formatKen } from '@lib';
import { WheelService } from '@services';
import type { WheelSpinHistoryFilter, WheelSpinHistoryItem } from '@app-types';
import {
  historyCloseButtonUrl,
  historyCloseMarkUrl,
  historyFrameUrl,
  historyHeaderUrl,
  historyIconUrl,
  historyPageButtonUrl,
  historyPageNextUrl,
  historyPagePrevUrl,
  historyTabActiveUrl,
  historyTabInactiveUrl,
  rewardMissUrl,
  rewardVipDaysUrl,
  spinCoinUrl,
} from './spinWheelAssets';
import { formatRewardKen, isKenKind, isVipDaysKind } from './spinWheelReward';
import {
  HISTORY_LABEL_STYLE,
  HISTORY_TAB_INACTIVE_STYLE,
  HISTORY_TITLE_STYLE,
} from './spinWheelStyles';

const PAGE_SIZE = 10;
const FILTERS: WheelSpinHistoryFilter[] = ['all', 'win', 'miss'];

interface SpinHistoryDialogProps {
  open: boolean;
  onClose: () => void;
}

interface OutcomeView {
  text: string;
  win: boolean;
  vipTypeId?: number;
  iconUrl?: string;
}

function useOutcomeLabel() {
  const { t } = useTranslation();
  return useCallback(
    (item: WheelSpinHistoryItem): OutcomeView => {
      if (item.segmentKind === 'miss') {
        return { text: t('wheelGame.miss'), win: false, iconUrl: rewardMissUrl };
      }
      if (isKenKind(item.segmentKind)) {
        return {
          text: `${formatRewardKen(item.kenAmount ?? 0)} KEN`,
          win: true,
          iconUrl: spinCoinUrl,
        };
      }
      if (isVipDaysKind(item.segmentKind)) {
        return {
          text: t('wheelGame.vipDays', { n: item.vipDays ?? 0 }),
          win: true,
          iconUrl: rewardVipDaysUrl,
        };
      }
      return {
        text: item.rewardLabel ?? t('wheelGame.rewardTitle'),
        win: true,
        vipTypeId: item.vipTypeId,
      };
    },
    [t]
  );
}

export function SpinHistoryDialog({ open, onClose }: SpinHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const [items, setItems] = useState<WheelSpinHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);
  const [filter, setFilter] = useState<WheelSpinHistoryFilter>('all');
  const [page, setPage] = useState(0);

  const outcomeLabel = useOutcomeLabel();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const loadPage = useCallback(async (pageIndex: number, outcome: WheelSpinHistoryFilter) => {
    setLoading(true);
    setError(false);
    try {
      const result = await WheelService.listSpins(PAGE_SIZE, pageIndex * PAGE_SIZE, outcome);
      setTotal(result.total);
      setItems(result.items);
    } catch {
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    if (!open) return;
    // eslint-disable-next-line react-hooks/set-state-in-effect -- mở dialog/đổi trang/đổi filter mới nạp; phần lớn setState chạy sau await
    void loadPage(page, filter);
  }, [open, page, filter, loadPage]);

  const selectFilter = (next: WheelSpinHistoryFilter) => {
    setFilter(next);
    setPage(0);
  };

  const totalPages = Math.max(1, Math.ceil(total / PAGE_SIZE));
  const canPrev = page > 0 && !loading;
  const canNext = page < totalPages - 1 && !loading;
  const placeholders = Math.max(0, PAGE_SIZE - items.length);

  return (
    <div
      className="font-game fixed inset-0 z-70 flex items-center justify-center bg-black/55 px-3"
      onClick={onClose}
    >
      <div
        className="relative"
        style={{ aspectRatio: '1043 / 1458', width: 'min(90vw, calc(62vh * 1043 / 1458))' }}
        onClick={(event) => event.stopPropagation()}
      >
        <div className="absolute inset-[3.5%] rounded-[24px] bg-[#fff4f1]" />
        <img src={historyFrameUrl} alt="" className="pointer-events-none absolute inset-0 h-full w-full" />

        <div className="absolute inset-0 flex flex-col px-[9%] pt-[15%] pb-[8%]">
          <div className="-mb-1 flex shrink-0 gap-0.5 px-2">
            {FILTERS.map((f) => {
              const activeTab = filter === f;
              return (
                <button
                  key={f}
                  type="button"
                  onClick={() => selectFilter(f)}
                  className="relative flex-1 active:scale-95"
                  style={{ aspectRatio: '1254 / 425' }}
                >
                  <img
                    src={activeTab ? historyTabActiveUrl : historyTabInactiveUrl}
                    alt=""
                    className="absolute inset-0 h-full w-full"
                  />
                  <span
                    className="absolute inset-0 flex items-center justify-center text-sm font-extrabold"
                    style={activeTab ? HISTORY_LABEL_STYLE : HISTORY_TAB_INACTIVE_STYLE}
                  >
                    {t(`wheelGame.historyFilter.${f}`)}
                  </span>
                </button>
              );
            })}
          </div>

          <div
            className="min-h-0 flex-1 overflow-hidden rounded-2xl border-2 border-[#ff8fa3]/55 px-3 py-1.5"
            style={{
              background: 'linear-gradient(180deg, #ffffff 0%, #fff1ee 100%)',
              boxShadow: 'inset 0 0 0 2px rgba(255,236,239,0.45)',
            }}
          >
            {error ? (
              <div className="flex h-full items-center justify-center">
                <p className="text-sm font-bold text-[#c0392b]">{t('wheelGame.error')}</p>
              </div>
            ) : loading ? (
              <div className="flex h-full items-center justify-center">
                <Spinner />
              </div>
            ) : items.length === 0 ? (
              <div className="flex h-full items-center justify-center">
                <p className="text-sm font-bold text-[#b98a97]">{t('wheelGame.historyEmpty')}</p>
              </div>
            ) : (
              <ul className="flex h-full flex-col">
                {items.map((item) => {
                  const outcome = outcomeLabel(item);
                  return (
                    <li
                      key={item.id}
                      className="flex flex-1 items-center justify-between gap-2 overflow-hidden border-b border-[#f6cfcb]/70"
                    >
                      <div className="flex min-w-0 items-center gap-2">
                        <div className="flex w-10 shrink-0 justify-center">
                          {outcome.vipTypeId != null ? (
                            <VipIcon typeId={outcome.vipTypeId} className="h-9 w-9" rounded />
                          ) : outcome.iconUrl ? (
                            <img
                              src={outcome.iconUrl}
                              alt=""
                              className="h-9 w-9 object-contain"
                            />
                          ) : null}
                        </div>
                        <span
                          className={`truncate text-base font-extrabold ${
                            outcome.win ? 'text-[#0b8f32]' : 'text-[#2b1717]'
                          }`}
                        >
                          {outcome.text}
                        </span>
                      </div>
                      <div className="shrink-0 text-right leading-tight">
                        <p className="text-xs font-medium text-[#8a8a8a]">
                          {formatTime(item.createdAt)}
                        </p>
                        <p className="text-xs font-bold text-[#ff1e1e]">
                          {item.isFree ? t('wheelGame.freeToday') : `-${formatKen(item.kenCost)} KEN`}
                        </p>
                      </div>
                    </li>
                  );
                })}
                {Array.from({ length: placeholders }).map((_, index) => (
                  <li key={`empty-${index}`} className="flex-1 border-b border-[#f6cfcb]/70 last:border-0" />
                ))}
              </ul>
            )}
          </div>

          <div className="mt-2 flex shrink-0 items-center justify-center gap-4">
            <button
              type="button"
              onClick={() => setPage((p) => Math.max(0, p - 1))}
              disabled={!canPrev}
              aria-label={t('wheelGame.historyFilter.all')}
              className="relative w-[18%] active:scale-95 disabled:opacity-40"
              style={{ aspectRatio: '2008 / 1519' }}
            >
              <img src={historyPageButtonUrl} alt="" className="absolute inset-0 h-full w-full" />
              <img
                src={historyPagePrevUrl}
                alt=""
                className="absolute left-1/2 top-1/2 h-[52%] w-auto -translate-x-1/2 -translate-y-1/2"
              />
            </button>
            <span className="text-lg font-extrabold" style={HISTORY_LABEL_STYLE}>
              {t('wheelGame.historyPage', { n: page + 1 })}
            </span>
            <button
              type="button"
              onClick={() => setPage((p) => Math.min(totalPages - 1, p + 1))}
              disabled={!canNext}
              aria-label={t('wheelGame.historyFilter.all')}
              className="relative w-[18%] active:scale-95 disabled:opacity-40"
              style={{ aspectRatio: '2008 / 1519' }}
            >
              <img src={historyPageButtonUrl} alt="" className="absolute inset-0 h-full w-full" />
              <img
                src={historyPageNextUrl}
                alt=""
                className="absolute left-1/2 top-1/2 h-[52%] w-auto -translate-x-1/2 -translate-y-1/2"
              />
            </button>
          </div>
        </div>

        <div
          className="absolute left-1/2 top-0 flex w-[74%] -translate-x-1/2 -translate-y-1/2 items-center justify-center gap-2"
          style={{ backgroundImage: `url(${historyHeaderUrl})`, backgroundSize: '100% 100%', aspectRatio: '1935 / 576' }}
        >
          <img src={historyIconUrl} alt="" className="h-[38%] w-auto drop-shadow" />
          <span className="text-xl font-extrabold" style={HISTORY_TITLE_STYLE}>
            {t('wheelGame.historyTitle')}
          </span>
        </div>

        <button
          type="button"
          onClick={onClose}
          aria-label={t('wheelGame.close')}
          className="absolute right-[-1%] top-[-2%] w-[14%] active:scale-95"
          style={{ aspectRatio: '813 / 831' }}
        >
          <img src={historyCloseButtonUrl} alt="" className="absolute inset-0 h-full w-full" />
          <img
            src={historyCloseMarkUrl}
            alt=""
            className="absolute left-1/2 top-1/2 w-[46%] -translate-x-1/2 -translate-y-1/2"
          />
        </button>
      </div>
    </div>
  );
}
