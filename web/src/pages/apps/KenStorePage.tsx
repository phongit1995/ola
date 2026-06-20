import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast, formatKen } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';
import { useAuthStore } from '@/store/authStore';

function KenCoin({ className = 'h-[18px] w-[18px]' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} aria-hidden="true">
      <circle cx="12" cy="12" r="10" fill="#ffca28" stroke="#f9a825" strokeWidth="1.5" />
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
      <span className="mr-2.5 flex h-[18px] w-[18px] items-center justify-center">{icon}</span>
      {label}
    </button>
  );
}

export function KenStorePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);

  function comingSoon() {
    toast.info(t('ken.comingSoon'));
  }

  const balanceText = `${formatKen(user?.ken ?? 0)} KEN`;

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('ken.title')} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto bg-[#ececec] pb-4">
        <p className="m-2 rounded-sm border border-black/12 bg-white px-3 py-2.5 text-xs text-[#e34545]">
          {t('ken.lowWarning')}
        </p>

        <div className="mx-2 rounded-sm border border-black/12 bg-white p-2">
          <div className="flex items-center px-1 py-1.5">
            <span className="text-sm text-black/54">{t('ken.balance')}</span>
            <span className="ml-2 flex flex-1 items-center gap-1 text-lg font-bold text-ola-primary">
              <KenCoin />
              {balanceText}
            </span>
          </div>

          <RowAction icon={<KenCoin />} label={t('ken.purchase')} onClick={() => navigate(ROUTES.kenBuy)} />
          <div className="mx-2 h-px bg-black/12" />
          <RowAction icon={<KenCoin />} label={t('ken.transfer')} onClick={comingSoon} />
          <div className="mx-2 h-px bg-black/12" />
          <RowAction
            icon={
              <svg viewBox="0 0 24 24" className="h-[18px] w-[18px] text-black/54" fill="currentColor" aria-hidden="true">
                <path d="M13 3a9 9 0 0 0-9 9H1l4 4 4-4H6a7 7 0 1 1 7 7 6.9 6.9 0 0 1-4.9-2L6.7 18.4A9 9 0 1 0 13 3zm-1 5v5l4.3 2.5.7-1.2-3.5-2.1V8z" />
              </svg>
            }
            label={t('ken.history')}
            onClick={comingSoon}
          />
        </div>

        <button
          type="button"
          onClick={comingSoon}
          className="mx-2 mt-2 flex h-9 w-[calc(100%-1rem)] items-center justify-center rounded-sm border border-ola-primary-dark bg-[#9ccc65] text-sm text-white"
        >
          {t('ken.support')}
        </button>
      </div>
    </FullScreenOverlay>
  );
}
