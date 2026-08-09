import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { formatKen } from '@lib';
import { Spinner } from '@components';
import type { KenTxType } from '@app-types';
import {
  KEN_HISTORY_PAGE,
  useKenHistoryStore,
} from '@/store/kenHistoryStore';
import type { KenHistoryRow, KenHistoryTab } from '@ola/shared/types';

const KEN_TX_META = {
  VIP_PACKAGE: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_PACKAGE' },
  VIP_ICON: { icon: '👑', labelKey: 'ken.historyScreen.types.VIP_ICON' },
  ADMIN_GRANT: { icon: '➕', labelKey: 'ken.historyScreen.types.ADMIN_GRANT' },
  ADMIN_DEDUCT: {
    icon: '➖',
    labelKey: 'ken.historyScreen.types.ADMIN_DEDUCT',
  },
  REWARD: { icon: '🏆', labelKey: 'ken.historyScreen.types.REWARD' },
  EGG_OPEN: { icon: '🥚', labelKey: 'ken.historyScreen.types.EGG_OPEN' },
  TOPUP: { icon: '💰', labelKey: 'ken.historyScreen.types.TOPUP' },
  REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.REFUND' },
  GIFT_SENT: { icon: '🎁', labelKey: 'ken.historyScreen.types.GIFT_SENT' },
  GIFT_RECEIVED: {
    icon: '🎁',
    labelKey: 'ken.historyScreen.types.GIFT_RECEIVED',
  },
  TRANSFER_IN: { icon: '📥', labelKey: 'ken.historyScreen.types.TRANSFER_IN' },
  TRANSFER_OUT: {
    icon: '📤',
    labelKey: 'ken.historyScreen.types.TRANSFER_OUT',
  },
  PEN_SHOOT: { icon: '⚽', labelKey: 'ken.historyScreen.types.PEN_SHOOT' },
  PEN_CATCH: { icon: '🧤', labelKey: 'ken.historyScreen.types.PEN_CATCH' },
  PEN_WIN: { icon: '🏆', labelKey: 'ken.historyScreen.types.PEN_WIN' },
  PEN_REFUND: { icon: '↩️', labelKey: 'ken.historyScreen.types.PEN_REFUND' },
  KEN_CHEST: { icon: '🧰', labelKey: 'ken.historyScreen.types.KEN_CHEST' },
  CLAN_CREATE: { icon: '🛡️', labelKey: 'ken.historyScreen.types.CLAN_CREATE' },
} as const satisfies Record<KenTxType, { icon: string; labelKey: string }>;

const KEN_TX_META_FALLBACK = {
  icon: '🪙',
  labelKey: 'ken.historyScreen.types.UNKNOWN',
} as const;

const TABS: {
  key: KenHistoryTab;
  labelKey:
    | 'ken.historyScreen.tabAll'
    | 'ken.historyScreen.tabCredit'
    | 'ken.historyScreen.tabDebit';
}[] = [
  { key: 'all', labelKey: 'ken.historyScreen.tabAll' },
  { key: 'credit', labelKey: 'ken.historyScreen.tabCredit' },
  { key: 'debit', labelKey: 'ken.historyScreen.tabDebit' },
];

function TransactionRow({ row }: { row: KenHistoryRow }) {
  const { t } = useTranslation();
  const meta = KEN_TX_META[row.type] ?? KEN_TX_META_FALLBACK;
  const credit = row.direction === 'credit';
  const subtitle =
    row.counterpartyName != null && row.counterpartyName !== ''
      ? t(credit ? 'ken.historyScreen.fromUser' : 'ken.historyScreen.toUser', {
          name: row.counterpartyName,
        })
      : row.description;
  return (
    <div className="flex items-center gap-3 px-3 py-2.5">
      <span className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-black/[0.04] text-lg">
        {meta.icon}
      </span>
      <div className="min-w-0 flex-1">
        <div className="truncate text-sm text-black/87">{t(meta.labelKey)}</div>
        {subtitle != null && subtitle !== '' && (
          <div className="truncate text-xs text-black/45">{subtitle}</div>
        )}
      </div>
      <div className="shrink-0 text-right">
        <div
          className={`text-sm font-semibold ${
            credit ? 'text-[#2e7d32]' : 'text-ola-error'
          }`}
        >
          {credit ? '+' : '−'}
          {formatKen(row.amount)}
        </div>
        <div className="text-xs text-black/40">{row.timeText}</div>
      </div>
    </div>
  );
}

export function KenHistorySection() {
  const { t } = useTranslation();
  const [tab, setTab] = useState<KenHistoryTab>('all');
  const section = useKenHistoryStore((s) => s.sections[tab]);
  const load = useKenHistoryStore((s) => s.load);

  useEffect(() => {
    load(tab, 0);
  }, [tab, load]);

  const pageCount = Math.max(1, Math.ceil(section.total / KEN_HISTORY_PAGE));
  const isEmpty = !section.loading && section.groups.length === 0;

  return (
    <section className="mt-3">
      <div className="mb-1 px-3 text-xs font-medium text-black/45">
        {t('ken.history')}
      </div>

      <div className="mx-2 flex gap-0.5 rounded-sm border border-black/12 bg-white p-0.5 text-sm">
        {TABS.map((item) => (
          <button
            key={item.key}
            type="button"
            onClick={() => setTab(item.key)}
            className={`flex-1 rounded-sm py-1.5 ${
              tab === item.key
                ? 'bg-ola-primary/10 font-semibold text-ola-primary-ink'
                : 'text-black/54'
            }`}
          >
            {t(item.labelKey)}
          </button>
        ))}
      </div>

      {section.loading && section.groups.length === 0 ? (
        <div className="flex justify-center py-8">
          <Spinner size={28} />
        </div>
      ) : isEmpty ? (
        <p className="py-10 text-center text-sm text-black/45">
          {t('ken.historyScreen.empty')}
        </p>
      ) : (
        <>
          {section.groups.map((group) => (
            <div key={group.key} className="mt-3">
              <div className="mb-1 px-3 text-xs font-medium text-black/45">
                {group.dayLabel === 'today'
                  ? t('ken.historyScreen.today')
                  : group.dayLabel === 'yesterday'
                  ? t('ken.historyScreen.yesterday')
                  : group.dateText}
              </div>
              <div className="mx-2 overflow-hidden rounded-sm border border-black/12 bg-white">
                {group.rows.map((row, index) => (
                  <div key={row.id}>
                    {index > 0 && <div className="mx-3 h-px bg-black/12" />}
                    <TransactionRow row={row} />
                  </div>
                ))}
              </div>
            </div>
          ))}

          {pageCount > 1 && (
            <div className="mt-3 flex items-center justify-center gap-3">
              <button
                type="button"
                aria-label="prev"
                disabled={section.loading || section.page <= 0}
                onClick={() => load(tab, section.page - 1)}
                className="flex h-8 w-8 items-center justify-center rounded-sm border border-black/12 bg-white text-black/70 disabled:opacity-40"
              >
                <svg
                  viewBox="0 0 24 24"
                  className="h-4 w-4 rotate-180"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
                </svg>
              </button>
              <span className="text-sm text-black/54">
                {section.page + 1}/{pageCount}
              </span>
              <button
                type="button"
                aria-label="next"
                disabled={section.loading || section.page >= pageCount - 1}
                onClick={() => load(tab, section.page + 1)}
                className="flex h-8 w-8 items-center justify-center rounded-sm border border-black/12 bg-white text-black/70 disabled:opacity-40"
              >
                <svg
                  viewBox="0 0 24 24"
                  className="h-4 w-4"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
                </svg>
              </button>
            </div>
          )}
        </>
      )}
    </section>
  );
}
