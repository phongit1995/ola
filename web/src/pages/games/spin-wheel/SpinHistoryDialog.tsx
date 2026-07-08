import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, VipIcon } from '@components';
import { cn, createTimeFormatter, formatKen } from '@lib';
import { WheelService } from '@services';
import type { WheelSpinHistoryFilter, WheelSpinHistoryItem } from '@app-types';
import { historyIconUrl, rewardVipDaysUrl, spinCoinUrl } from './spinWheelAssets';
import { isKenKind, isVipDaysKind } from './spinWheelReward';

const PAGE_SIZE = 20;
const FILTERS: WheelSpinHistoryFilter[] = ['all', 'win', 'miss'];

interface SpinHistoryDialogProps {
  open: boolean;
  onClose: () => void;
}

interface OutcomeView {
  text: string;
  tone: 'win' | 'miss';
  vipTypeId?: number;
  iconUrl?: string;
}

function useOutcomeLabel() {
  const { t } = useTranslation();
  return useCallback(
    (item: WheelSpinHistoryItem): OutcomeView => {
      if (item.segmentKind === 'miss') {
        return { text: t('wheelGame.miss'), tone: 'miss' };
      }
      if (isKenKind(item.segmentKind)) {
        return {
          text: `${formatKen(item.kenAmount ?? 0)} KEN`,
          tone: 'win',
          iconUrl: spinCoinUrl,
        };
      }
      if (isVipDaysKind(item.segmentKind)) {
        return {
          text: t('wheelGame.vipDays', { n: item.vipDays ?? 0 }),
          tone: 'win',
          iconUrl: rewardVipDaysUrl,
        };
      }
      return {
        text: item.rewardLabel ?? t('wheelGame.rewardTitle'),
        tone: 'win',
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

  const outcomeLabel = useOutcomeLabel();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const loadPage = useCallback(async (offset: number, outcome: WheelSpinHistoryFilter) => {
    setLoading(true);
    setError(false);
    if (offset === 0) {
      setItems([]);
      setTotal(0);
    }
    try {
      const result = await WheelService.listSpins(PAGE_SIZE, offset, outcome);
      setTotal(result.total);
      setItems((prev) => (offset === 0 ? result.items : [...prev, ...result.items]));
    } catch {
      setError(true);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    if (!open) return;
    // eslint-disable-next-line react-hooks/set-state-in-effect -- mở dialog/đổi filter mới nạp lịch sử; phần lớn setState chạy sau await
    void loadPage(0, filter);
  }, [open, filter, loadPage]);

  const hasMore = items.length < total;

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wheelGame.historyTitle')}
      icon={<img src={historyIconUrl} alt="" className="h-5 w-5 opacity-60 filter-[invert(1)]" />}
      footer={<DialogButton onClick={onClose}>{t('wheelGame.close')}</DialogButton>}
    >
      <div className="mb-2 flex gap-1.5">
        {FILTERS.map((f) => (
          <button
            key={f}
            type="button"
            onClick={() => setFilter(f)}
            className={cn(
              'rounded-full px-3 py-1 text-xs font-medium transition-colors',
              filter === f
                ? 'bg-[#5e3c20] text-white'
                : 'bg-[#efefef] text-[#5a5a5a] hover:bg-[#e4e4e4]'
            )}
          >
            {t(`wheelGame.historyFilter.${f}`)}
          </button>
        ))}
      </div>
      <div className="max-h-[60vh] min-h-30 overflow-y-auto">
        {error ? (
          <p className="py-6 text-center text-[#9a2b20]">{t('wheelGame.error')}</p>
        ) : items.length === 0 && loading ? (
          <div className="flex h-30 items-center justify-center">
            <Spinner />
          </div>
        ) : items.length === 0 ? (
          <p className="py-6 text-center text-[#8a8a8c]">{t('wheelGame.historyEmpty')}</p>
        ) : (
          <ul className="divide-y divide-[#eceaea]">
            {items.map((item) => {
              const outcome = outcomeLabel(item);
              return (
                <li key={item.id} className="flex items-center justify-between gap-3 py-2">
                  <div className="flex min-w-0 items-center gap-1.5">
                    {outcome.vipTypeId != null ? (
                      <VipIcon typeId={outcome.vipTypeId} className="h-5 w-5" rounded />
                    ) : outcome.iconUrl ? (
                      <img src={outcome.iconUrl} alt="" className="h-5 w-5 shrink-0 object-contain" />
                    ) : null}
                    <p
                      className={
                        outcome.tone === 'win'
                          ? 'truncate font-semibold text-[#1f8a3b]'
                          : 'truncate font-medium text-[#8a8a8c]'
                      }
                    >
                      {outcome.text}
                    </p>
                  </div>
                  <div className="shrink-0 text-right">
                    <p className="text-xs text-[#9a9a9c]">{formatTime(item.createdAt)}</p>
                    <p className="text-xs text-[#c0392b]">
                      {item.isFree ? t('wheelGame.freeToday') : `-${formatKen(item.kenCost)} KEN`}
                    </p>
                  </div>
                </li>
              );
            })}
          </ul>
        )}

        {hasMore && !error && (
          <button
            type="button"
            onClick={() => void loadPage(items.length, filter)}
            disabled={loading}
            className="mt-2 w-full rounded-[3px] border border-[#d1cece] bg-[#f6f6f6] py-1.5 text-sm text-[#3a3839] hover:bg-[#efefef] disabled:opacity-50"
          >
            {loading ? t('wheelGame.loading') : t('wheelGame.historyLoadMore')}
          </button>
        )}
      </div>
    </Dialog>
  );
}
