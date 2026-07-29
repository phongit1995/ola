import { useEffect, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { toast, formatKen } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import {
  selectTopupEnabled,
  useTopupConfigStore,
} from '@/store/topupConfigStore';
import { TransferKenDialog } from '@/pages/chat/components/TransferKenDialog';
import { KenHistorySection } from './KenHistorySection';
import { KEN_LOW_THRESHOLD } from './constants';

function KenCoin({ className = 'h-[18px] w-[18px]' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} aria-hidden="true">
      <circle
        cx="12"
        cy="12"
        r="10"
        fill="#ffca28"
        stroke="#f9a825"
        strokeWidth="1.5"
      />
      <text
        x="12"
        y="16"
        textAnchor="middle"
        fontSize="10"
        fontWeight="700"
        fill="#f57f17"
        fontFamily="Roboto, sans-serif"
      >
        K
      </text>
    </svg>
  );
}

interface RowActionProps {
  icon: ReactNode;
  label: string;
  onClick: () => void;
}

function RowAction({ icon, label, onClick }: RowActionProps) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex h-9 w-full items-center px-2 text-left text-sm text-black/87 active:bg-black/5"
    >
      <span className="mr-2.5 flex h-[18px] w-[18px] items-center justify-center">
        {icon}
      </span>
      {label}
    </button>
  );
}

export function KenStorePage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const pushOverlay = useAppOverlayStore((s) => s.push);
  const user = useAuthStore((s) => s.user);
  const topupEnabled = useTopupConfigStore(selectTopupEnabled);
  const loadTopupConfig = useTopupConfigStore((s) => s.load);
  const [transferOpen, setTransferOpen] = useState(false);

  useEffect(() => {
    void loadTopupConfig();
  }, [loadTopupConfig]);

  function comingSoon() {
    toast.info(t('ken.comingSoon'));
  }

  const ken = user?.ken ?? 0;
  const showLowKenWarning = ken > 0 && ken < KEN_LOW_THRESHOLD;
  const balanceText = `${formatKen(ken)} KEN`;

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('ken.title')} onBack={onClose} />

      <div className="flex-1 overflow-y-auto bg-[#ececec] pt-2 pb-4">
        {showLowKenWarning && (
          <p className="mx-2 mb-2 rounded-sm border border-black/12 bg-white px-3 py-2.5 text-xs text-[#e34545]">
            {t('ken.lowWarning')}
          </p>
        )}

        <div className="mx-2 rounded-sm border border-black/12 bg-white p-2">
          <div className="flex items-center px-1 py-1.5">
            <span className="text-sm text-black/54">{t('ken.balance')}</span>
            <span className="ml-2 flex flex-1 items-center gap-1 text-lg font-bold text-ola-primary">
              <KenCoin />
              {balanceText}
            </span>
          </div>

          {topupEnabled && (
            <>
              <RowAction
                icon={<KenCoin />}
                label={t('ken.purchase')}
                onClick={() => pushOverlay('kenBuy')}
              />
              <div className="mx-2 h-px bg-black/12" />
            </>
          )}
          <RowAction
            icon={<KenCoin />}
            label={t('ken.transfer')}
            onClick={() => setTransferOpen(true)}
          />
        </div>

        <KenHistorySection />
      </div>

      <div className="border-t border-black/12 bg-white p-2">
        <button
          type="button"
          onClick={comingSoon}
          className="flex h-9 w-full items-center justify-center rounded-sm border border-ola-primary-dark bg-[#9ccc65] text-sm text-white"
        >
          {t('ken.support')}
        </button>
      </div>

      {transferOpen && (
        <TransferKenDialog open onClose={() => setTransferOpen(false)} />
      )}
    </FullScreenOverlay>
  );
}
