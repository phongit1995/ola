import { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner, VipIcon } from '@components';
import {
  cn,
  createTimeFormatter,
  formatDateDMY,
  formatKen,
  isVipDayTransferSource,
  vipName,
  VIP_HISTORY_TABS,
  vipHistoryIconTypeId,
  vipHistorySourceKey,
} from '@lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useVipHistory } from '@ola/shared/stores/vip/useVipHistory';

interface VipHistoryDialogProps {
  open: boolean;
  onClose: () => void;
}

export function VipHistoryDialog({ open, onClose }: VipHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const myId = useAuthStore((s) => s.user?.id);
  const {
    tab,
    setTab,
    purchases,
    transfers,
    items,
    loading,
    error,
    hasMore,
    loadMore,
  } = useVipHistory(open);

  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('vip.historyDialog.title')}
      footer={
        <DialogButton onClick={onClose}>
          {t('vip.historyDialog.close')}
        </DialogButton>
      }
    >
      <div className="mb-2 flex gap-1.5">
        {VIP_HISTORY_TABS.map((key) => (
          <button
            key={key}
            type="button"
            onClick={() => setTab(key)}
            className={cn(
              'rounded-full px-3 py-1 text-xs font-medium transition-colors',
              tab === key
                ? 'bg-ola-primary text-ola-on-primary'
                : 'bg-[#efefef] text-[#5a5a5a] hover:bg-[#e4e4e4]'
            )}
          >
            {t(
              key === 'purchases'
                ? 'vip.historyDialog.tabPurchases'
                : 'vip.historyDialog.tabTransfers'
            )}
          </button>
        ))}
      </div>
      <div className="max-h-[60vh] min-h-30 overflow-y-auto">
        {error ? (
          <p className="py-6 text-center text-[#9a2b20]">{t('common.error')}</p>
        ) : items.length === 0 && loading ? (
          <div className="flex h-30 items-center justify-center">
            <Spinner />
          </div>
        ) : items.length === 0 ? (
          <p className="py-6 text-center text-[#8a8a8c]">
            {t('vip.historyDialog.empty')}
          </p>
        ) : tab === 'purchases' ? (
          <ul className="divide-y divide-[#eceaea]">
            {purchases.map((item) => {
              const iconTypeId = vipHistoryIconTypeId(item.packageName);
              return (
                <li
                  key={item.id}
                  className="flex items-center justify-between gap-3 py-2"
                >
                  <div className="flex min-w-0 items-center gap-2">
                    {iconTypeId != null && (
                      <VipIcon
                        typeId={iconTypeId}
                        className="h-8 w-8"
                        rounded
                      />
                    )}
                    <div className="min-w-0">
                      <p className="truncate font-medium text-black/87">
                        {iconTypeId != null
                          ? vipName(iconTypeId)
                          : item.packageName}
                      </p>
                      <p className="truncate text-xs text-black/54">
                        {t(
                          `vip.historyDialog.source.${vipHistorySourceKey(item.source)}`
                        )}
                        {item.days > 0 &&
                          !isVipDayTransferSource(item.source) &&
                          ` ·${t('vip.historyDialog.until', {
                            date: formatDateDMY(item.vipEndTime),
                          })}`}
                      </p>
                    </div>
                  </div>
                  <div className="shrink-0 text-right">
                    {item.days > 0 && (
                      <p className="text-sm font-semibold text-ola-credit">
                        {t('vip.historyDialog.days', { count: item.days })}
                      </p>
                    )}
                    {item.days < 0 && (
                      <p className="text-sm font-semibold text-ola-debit">
                        {t('vip.historyDialog.daysLost', {
                          count: -item.days,
                        })}
                      </p>
                    )}
                    <p className="text-xs text-[#9a9a9c]">
                      {formatTime(item.createdAt)}
                    </p>
                    {!isVipDayTransferSource(item.source) && (
                      <p className="text-xs text-ola-debit">
                        {item.kenPrice > 0
                          ? `-${formatKen(item.kenPrice)} KEN`
                          : t('vip.historyDialog.free')}
                      </p>
                    )}
                  </div>
                </li>
              );
            })}
          </ul>
        ) : (
          <ul className="divide-y divide-[#eceaea]">
            {transfers.map((item) => {
              const sent = item.fromUserId === myId;
              return (
                <li
                  key={item.id}
                  className="flex items-center justify-between gap-3 py-2"
                >
                  <div className="flex min-w-0 items-center gap-2">
                    <VipIcon
                      typeId={item.vipIconId}
                      className="h-8 w-8"
                      rounded
                    />
                    <div className="min-w-0">
                      <p className="truncate font-medium text-black/87">
                        {vipName(item.vipIconId)}
                      </p>
                      <p
                        className={cn(
                          'truncate text-xs',
                          sent ? 'text-[#c0392b]' : 'text-[#1f8a3b]'
                        )}
                      >
                        {sent
                          ? t('vip.historyDialog.sentTo', {
                              name: item.toUsername,
                            })
                          : t('vip.historyDialog.receivedFrom', {
                              name: item.fromUsername,
                            })}
                      </p>
                    </div>
                  </div>
                  <p className="shrink-0 text-xs text-[#9a9a9c]">
                    {formatTime(item.createdAt)}
                  </p>
                </li>
              );
            })}
          </ul>
        )}

        {hasMore && !error && (
          <button
            type="button"
            onClick={loadMore}
            disabled={loading}
            className="mt-2 w-full rounded-[3px] border border-[#d1cece] bg-[#f6f6f6] py-1.5 text-sm text-[#3a3839] hover:bg-[#efefef] disabled:opacity-50"
          >
            {loading ? t('common.loading') : t('vip.historyDialog.loadMore')}
          </button>
        )}
      </div>
    </Dialog>
  );
}
