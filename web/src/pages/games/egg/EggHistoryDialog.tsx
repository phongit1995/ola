import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, VipIcon } from '@components';
import { cn, createTimeFormatter } from '@lib';
import { EggService } from '@services';
import type { EggDrawHistoryFilter, EggDrawHistoryItem } from '@app-types';
import { historyIconUrl } from './eggAssets';
import kenCoinUrl from '@/assets/icons/apps/ken.png';
import vipBadgeUrl from '@/assets/icons/apps/vip.png';

const PAGE_SIZE = 20;
const FILTERS: EggDrawHistoryFilter[] = ['all', 'win', 'miss'];

interface EggHistoryDialogProps {
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
    (item: EggDrawHistoryItem): OutcomeView => {
      if (item.categoryType === 'nothing') {
        return { text: t('eggGame.history.miss'), tone: 'miss' };
      }
      if (item.isSuperLucky) {
        return {
          text: t('eggGame.history.superLucky', { reward: item.rewardLabel ?? '' }),
          tone: 'win',
          vipTypeId: item.vipTypeId,
        };
      }
      if (item.categoryType === 'ken' && item.kenAmount) {
        return {
          text: t('eggGame.history.ken', { ken: item.kenAmount }),
          tone: 'win',
          iconUrl: kenCoinUrl,
        };
      }
      if (item.categoryType === 'vip_days' && item.vipDays) {
        return {
          text: t('eggGame.history.vipDays', { days: item.vipDays }),
          tone: 'win',
          iconUrl: vipBadgeUrl,
        };
      }
      return {
        text: item.rewardLabel ?? t('eggGame.history.win'),
        tone: 'win',
        vipTypeId: item.vipTypeId,
      };
    },
    [t]
  );
}

export function EggHistoryDialog({ open, onClose }: EggHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const [items, setItems] = useState<EggDrawHistoryItem[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);
  const [filter, setFilter] = useState<EggDrawHistoryFilter>('all');

  const outcomeLabel = useOutcomeLabel();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const loadPage = useCallback(async (offset: number, outcome: EggDrawHistoryFilter) => {
    setLoading(true);
    setError(false);
    if (offset === 0) {
      setItems([]);
      setTotal(0);
    }
    try {
      const result = await EggService.listDraws(PAGE_SIZE, offset, outcome);
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
      title={t('eggGame.history.title')}
      icon={<img src={historyIconUrl} alt="" className="h-5 w-5 opacity-60 filter-[invert(1)]" />}
      footer={<DialogButton onClick={onClose}>{t('eggGame.history.close')}</DialogButton>}
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
            {t(`eggGame.history.filter.${f}`)}
          </button>
        ))}
      </div>
      <div className="max-h-[60vh] min-h-30 overflow-y-auto">
        {error ? (
          <p className="py-6 text-center text-[#9a2b20]">{t('eggGame.error')}</p>
        ) : items.length === 0 && loading ? (
          <div className="flex h-30 items-center justify-center">
            <Spinner />
          </div>
        ) : items.length === 0 ? (
          <p className="py-6 text-center text-[#8a8a8c]">{t('eggGame.history.empty')}</p>
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
                      <img
                        src={outcome.iconUrl}
                        alt=""
                        className="h-5 w-5 shrink-0 object-contain"
                      />
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
                    <p className="text-xs text-[#c0392b]">-{item.kenCost} KEN</p>
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
            {loading ? t('eggGame.loading') : t('eggGame.history.loadMore')}
          </button>
        )}
      </div>
    </Dialog>
  );
}
