import { useEffect, useState, type CSSProperties } from 'react';
import { useTranslation } from 'react-i18next';
import { usePenHistoryStore, type PenHistorySection as SectionRole } from '@/store/penHistoryStore';
import { penHistoryAssets, penShootAssets } from './penAssets';
import { PenHistorySection } from './PenHistorySection';
import { PenAllHistorySection } from './PenAllHistorySection';

const stretchBg: CSSProperties = { backgroundSize: '100% 100%' };

interface PenHistoryModalProps {
  userId?: string;
  onClose: () => void;
}

export function PenHistoryModal({ userId, onClose }: PenHistoryModalProps) {
  const { t } = useTranslation();
  const reset = usePenHistoryStore((s) => s.reset);
  const [tab, setTab] = useState<SectionRole>('shoot');

  useEffect(() => reset, [reset]);

  const tabs: { key: SectionRole; label: string }[] = [
    { key: 'shoot', label: t('penGame.hist.tabShot') },
    { key: 'catch', label: t('penGame.hist.tabCatch') },
    { key: 'all', label: t('penGame.hist.tabAll') },
  ];
  const opponentLabel = tab === 'shoot' ? t('penGame.hist.colCatcher') : t('penGame.hist.colShooter');

  return (
    <div
      onClick={onClose}
      className="absolute inset-0 z-40 flex items-center justify-center bg-black/55 px-2 @md:px-4"
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className="pen-panel relative flex max-h-[92%] w-full flex-col @md:w-[80%]"
      >
        <div className="flex shrink-0 items-center justify-center gap-2 px-12 pb-2 pt-4 text-white">
          <img src={penHistoryAssets.clock} alt="" className="h-7 w-7 object-contain" />
          <span className="text-3xl font-extrabold italic tracking-wider drop-shadow">
            {t('penGame.history')}
          </span>
        </div>

        <button
          type="button"
          aria-label={t('penGame.close')}
          onClick={onClose}
          style={{ ...stretchBg, backgroundImage: `url(${penShootAssets.closeBtn})` }}
          className="absolute right-[4%] top-[3.5%] flex h-9 w-9 items-center justify-center bg-no-repeat transition active:scale-95"
        >
          <img src={penShootAssets.closeIcon} alt="" className="h-4 w-4 object-contain" />
        </button>

        <div className="flex shrink-0 gap-2 px-3 pb-2 pt-2">
          {tabs.map((item) => {
            const active = item.key === tab;
            return (
              <button
                key={item.key}
                type="button"
                onClick={() => setTab(item.key)}
                style={{ ...stretchBg, backgroundImage: `url(${penHistoryAssets.tab})` }}
                className={`flex-1 whitespace-nowrap bg-no-repeat py-2.5 text-sm font-extrabold tracking-wide text-white transition active:scale-95 ${
                  active ? 'drop-shadow-[0_0_6px_rgba(58,160,255,0.6)]' : 'opacity-40 saturate-50'
                }`}
              >
                {item.label}
              </button>
            );
          })}
        </div>

        <div className="pen-scroll flex min-h-0 flex-1 flex-col overflow-y-auto px-2 pb-4 @md:px-3">
          {tab === 'all' ? (
            <PenAllHistorySection />
          ) : (
            <PenHistorySection section={tab} opponentLabel={opponentLabel} userId={userId} />
          )}
        </div>
      </div>
    </div>
  );
}
