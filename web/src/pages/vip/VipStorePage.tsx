import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { useAuthStore } from '@/store/authStore';

type VipState = 'inUse' | 'locked' | 'available';

interface VipIcon {
  id: string;
  name: string;
  color: string;
  state: VipState;
}

const MOCK_VIP_ICONS: VipIcon[] = [
  { id: 'gold', name: 'Gold', color: '#ffb300', state: 'available' },
  { id: 'diamond', name: 'Diamond', color: '#26c6da', state: 'available' },
  { id: 'ruby', name: 'Ruby', color: '#ef5350', state: 'locked' },
  { id: 'emerald', name: 'Emerald', color: '#66bb6a', state: 'available' },
];

function daysLeft(iso?: string | null): number {
  if (!iso) return 0;
  const end = new Date(iso).getTime();
  if (Number.isNaN(end)) return 0;
  return Math.max(0, Math.ceil((end - Date.now()) / 86_400_000));
}

function VipBadge({ color, size = 40 }: { color: string; size?: number }) {
  return (
    <span
      className="flex shrink-0 items-center justify-center rounded-full text-white"
      style={{ width: size, height: size, background: color }}
    >
      <svg viewBox="0 0 24 24" style={{ width: size * 0.55, height: size * 0.55 }} fill="currentColor">
        <path d="m12 17.27 6.18 3.73-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
      </svg>
    </span>
  );
}

interface VipItemProps {
  icon: VipIcon;
  onSelect: () => void;
}

function VipItem({ icon, onSelect }: VipItemProps) {
  const { t } = useTranslation();
  const stateKey =
    icon.state === 'inUse'
      ? 'vip.stateInUse'
      : icon.state === 'locked'
        ? 'vip.stateLocked'
        : 'vip.stateAvailable';
  return (
    <button
      type="button"
      onClick={onSelect}
      className="flex h-[72px] w-full flex-col bg-white/80 text-left active:bg-black/5"
    >
      <div className="flex flex-1 items-center px-4">
        <VipBadge color={icon.color} />
        <div className="ml-2 flex flex-col justify-center">
          <span className="text-base text-black/87">{icon.name}</span>
          <span className="mt-0.5 text-xs text-black/54">{t(stateKey)}</span>
        </div>
      </div>
      <div className="mx-4 h-px bg-black/12" />
    </button>
  );
}

export function VipStorePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);

  if (!user) return null;

  const remainingDays = daysLeft(user.vipEndTime);
  const hasVip = Boolean(user.vipUsed);
  const durationText = hasVip ? t('vip.daysLeft', { count: remainingDays }) : t('vip.noVip');

  function comingSoon() {
    window.alert(t('vip.comingSoon'));
  }

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={() => navigate(ROUTES.home)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">{t('vip.title')}</span>
      </header>

      <div className="flex-1 overflow-y-auto">
        <div className="bg-white/80">
          <div className="px-4 pt-4 text-xs text-black/54">{t('vip.usingIcon')}</div>
          <div className="mt-1 flex h-[72px] flex-col">
            <div className="flex flex-1 items-center px-4">
              <VipBadge color={hasVip ? '#ff4081' : '#b0bec5'} />
              <div className="ml-2 flex flex-col justify-center">
                <span className="text-base text-black/87">{user.vipUsed ?? t('vip.noVip')}</span>
                <span className="mt-0.5 text-xs text-black/54">
                  {hasVip ? t('vip.stateInUse') : t('vip.noVip')}
                </span>
              </div>
            </div>
          </div>

          <button
            type="button"
            onClick={comingSoon}
            className="flex min-h-12 w-full items-center px-4 text-left active:bg-black/5"
          >
            <span className="flex-1 text-base text-black/87">{t('vip.whoCanSee')}</span>
            <span className="mx-2 text-xs text-black/54">{t('vip.public')}</span>
            <svg viewBox="0 0 24 24" className="h-5 w-5 text-black/40" fill="currentColor" aria-hidden="true">
              <path d="M8.59 16.59 13.17 12 8.59 7.41 10 6l6 6-6 6z" />
            </svg>
          </button>
          <div className="mx-4 h-px bg-black/12" />

          <button
            type="button"
            onClick={comingSoon}
            className="flex min-h-12 w-full items-center px-4 text-left text-base text-black/87 active:bg-black/5"
          >
            {t('vip.buyVip')}
          </button>
          <div className="mx-4 h-px bg-black/12" />

          <button
            type="button"
            onClick={comingSoon}
            className="flex min-h-12 w-full items-center px-4 text-left text-base text-black/87 active:bg-black/5"
          >
            {t('vip.extendVip')}
          </button>

          <div className="flex h-9 items-center justify-center bg-[#d5d5d5] text-base text-white">
            {t('vip.collection')}
          </div>
        </div>

        {MOCK_VIP_ICONS.map((icon) => (
          <VipItem key={icon.id} icon={icon} onSelect={comingSoon} />
        ))}
      </div>

      <div className="flex h-12 shrink-0 items-center gap-2 border-t border-black/12 bg-white px-2">
        <span className="text-xs text-black/54">{t('vip.duration')}</span>
        <span className="flex-1 text-xl font-bold text-black/87">{durationText}</span>
        <button
          type="button"
          onClick={comingSoon}
          className="rounded border border-ola-primary-dark bg-[#9ccc65] px-4 py-1.5 text-sm font-medium text-white"
        >
          {t('vip.extendVip')}
        </button>
      </div>
    </div>
  );
}
