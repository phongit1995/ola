import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';
import type { TFunction } from 'i18next';
import { useTranslation } from 'react-i18next';
import { Spinner, VipIcon } from '@components';
import { EGG_GIFT_FIXTURE, formatKen, portalRoot, vipName } from '@lib';
import { EggService } from '@services';
import type { EggCategoryKind, EggGiftReward, EggGiftSection } from '@app-types';
import { closeCircleButtonUrl, closeXIconUrl } from './eggAssets';
import kenCoinUrl from '@/assets/icons/apps/ken.png';
import vipDaysIconUrl from '@/assets/games/egg/day_vip.png';

interface EggGiftDialogProps {
  open: boolean;
  packId: string | null;
  onClose: () => void;
}

type SectionLabelKey =
  | 'eggGame.gifts.section.ken'
  | 'eggGame.gifts.section.vip_days'
  | 'eggGame.gifts.section.vip_icon';

interface SectionStyle {
  container: string;
  pill: string;
  text: string;
  labelKey: SectionLabelKey;
}

const SECTION_STYLES: Partial<Record<EggCategoryKind, SectionStyle>> = {
  ken: {
    container: 'border-[#f0dfb4] bg-[#fdf6e3]',
    pill: 'bg-[#d9a326]',
    text: 'text-[#4a4a4a]',
    labelKey: 'eggGame.gifts.section.ken',
  },
  vip_days: {
    container: 'border-[#cde8d2] bg-[#eef8f0]',
    pill: 'bg-[#2e9e4f]',
    text: 'text-[#2e9e4f]',
    labelKey: 'eggGame.gifts.section.vip_days',
  },
  vip_icon: {
    container: 'border-[#e3d5ca] bg-[#faf4ef]',
    pill: 'bg-[#7a5230]',
    text: 'text-[#4a4a4a]',
    labelKey: 'eggGame.gifts.section.vip_icon',
  },
};

function rewardText(type: EggCategoryKind, reward: EggGiftReward, t: TFunction): string {
  if (type === 'vip_icon' && reward.vipTypeId != null) return vipName(reward.vipTypeId);
  if (reward.label) return reward.label;
  if (type === 'ken' && reward.kenAmount) return `${formatKen(reward.kenAmount)} Ken`;
  if (type === 'vip_days' && reward.vipDays) {
    return t('eggGame.gifts.vipDaysLabel', { days: reward.vipDays });
  }
  return '';
}

function RewardIcon({ type, reward }: { type: EggCategoryKind; reward: EggGiftReward }) {
  if (type === 'ken') return <img src={kenCoinUrl} alt="" className="h-9 w-9 object-contain" />;
  if (type === 'vip_days') {
    return <img src={vipDaysIconUrl} alt="" className="h-9 w-9 object-contain" />;
  }
  if (reward.vipTypeId != null) return <VipIcon typeId={reward.vipTypeId} size={40} rounded />;
  return null;
}

export function EggGiftDialog({ open, packId, onClose }: EggGiftDialogProps) {
  const { t } = useTranslation();
  const [sections, setSections] = useState<EggGiftSection[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);

  useEffect(() => {
    if (!open) return;
    function handleKey(event: KeyboardEvent) {
      if (event.key === 'Escape') onClose();
    }
    document.addEventListener('keydown', handleKey);
    return () => document.removeEventListener('keydown', handleKey);
  }, [open, onClose]);

  useEffect(() => {
    if (!open) return;
    let alive = true;
    const applyItems = (items: EggGiftSection[]) => {
      if (!alive) return;
      if (items.length === 0 && import.meta.env.DEV) {
        setSections(EGG_GIFT_FIXTURE);
        return;
      }
      setSections(items);
    };
    // eslint-disable-next-line react-hooks/set-state-in-effect -- mở dialog mới nạp danh sách quà; setState chạy sau await
    setError(false);
    if (!packId) {
      applyItems([]);
      return;
    }
    setLoading(true);
    EggService.listGifts(packId)
      .then((result) => applyItems(result?.items ?? []))
      .catch(() => {
        if (!alive) return;
        if (import.meta.env.DEV) {
          setSections(EGG_GIFT_FIXTURE);
        } else {
          setError(true);
        }
      })
      .finally(() => {
        if (alive) setLoading(false);
      });
    return () => {
      alive = false;
    };
  }, [open, packId]);

  if (!open) return null;

  return createPortal(
    <div
      role="presentation"
      onClick={(event) => {
        if (event.target === event.currentTarget) onClose();
      }}
      className="fixed inset-0 z-[110] grid place-items-center bg-black/60 p-4"
    >
      <div role="dialog" aria-modal="true" className="relative w-full max-w-md pt-[30px]">
        <div className="rounded-3xl bg-white px-3 pb-3 pt-10 shadow-[0_6px_24px_rgba(0,0,0,0.35)]">
          <div className="max-h-[68vh] overflow-y-auto pr-1 [scrollbar-color:#e3c98e_transparent] [scrollbar-width:thin] [&::-webkit-scrollbar]:w-1.5 [&::-webkit-scrollbar-track]:bg-transparent [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-thumb]:bg-[#e3c98e] hover:[&::-webkit-scrollbar-thumb]:bg-[#d9a326]">
            {error ? (
              <p className="py-8 text-center text-sm text-[#9a2b20]">{t('eggGame.error')}</p>
            ) : loading ? (
              <div className="flex h-32 items-center justify-center">
                <Spinner />
              </div>
            ) : sections.length === 0 ? (
              <p className="py-8 text-center text-sm text-[#8a8a8c]">
                {t('eggGame.gifts.empty')}
              </p>
            ) : (
              sections.map((section) => {
                const style = SECTION_STYLES[section.type];
                if (!style) return null;
                return (
                  <section
                    key={section.type}
                    className={`relative mb-2 mt-5 rounded-2xl border p-2.5 pt-5 ${style.container}`}
                  >
                    <span
                      className={`absolute -top-3.5 left-1/2 -translate-x-1/2 whitespace-nowrap rounded-full px-6 py-1 text-sm font-bold text-white ${style.pill}`}
                    >
                      {t(style.labelKey)}
                    </span>
                    <div className="grid grid-cols-3 gap-2">
                      {section.rewards.map((reward) => {
                        const label = rewardText(section.type, reward, t);
                        return (
                          <div
                            key={`${section.type}-${label}`}
                            className="flex flex-col items-center justify-center gap-1 rounded-xl border border-black/5 bg-white px-1 py-2.5"
                          >
                            <RewardIcon type={section.type} reward={reward} />
                            <span
                              className={`text-center text-xs font-semibold leading-tight ${style.text}`}
                            >
                              {label}
                            </span>
                          </div>
                        );
                      })}
                    </div>
                  </section>
                );
              })
            )}
          </div>
        </div>

        <div className="absolute left-1/2 top-0 z-10 w-[78%] -translate-x-1/2 rounded-2xl border-2 border-[#f2c14e] bg-[#6f4e2d] px-4 py-2 text-center shadow-[0_3px_10px_rgba(0,0,0,0.3)]">
          <h2 className="text-xl font-extrabold tracking-wide text-white">
            {t('eggGame.gifts.heading')}
          </h2>
          <p className="text-sm font-bold text-[#ffca28]">{t('eggGame.gifts.subtitle')}</p>
        </div>

        <button
          type="button"
          onClick={onClose}
          aria-label={t('dialog.close')}
          className="absolute -right-2 top-3 z-20 h-9 w-9 transition-transform hover:scale-105"
        >
          <img src={closeCircleButtonUrl} alt="" className="absolute inset-0 h-9 w-9" />
          <img
            src={closeXIconUrl}
            alt=""
            className="absolute left-1/2 top-1/2 h-4 w-4 -translate-x-1/2 -translate-y-1/2"
          />
        </button>
      </div>
    </div>,
    portalRoot()
  );
}
