import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ScreenHeader } from '@components';
import { useMarriageStore } from './marriageStore';
import { MarriageBoxView } from './MarriageBoxView';
import { MarriageLockedView } from './MarriageLockedView';
import { ProposeComposer } from './ProposeComposer';

interface MarriageViewProps {
  onBack: () => void;
}

export function MarriageView({ onBack }: MarriageViewProps) {
  const { t } = useTranslation();
  const status = useMarriageStore((s) => s.status);
  const loading = useMarriageStore((s) => s.loading);
  const loaded = useMarriageStore((s) => s.loaded);
  const load = useMarriageStore((s) => s.load);
  const [composeOpen, setComposeOpen] = useState(false);

  useEffect(() => {
    void load().catch(() => undefined);
  }, [load]);

  if (composeOpen) {
    return <ProposeComposer onClose={() => setComposeOpen(false)} />;
  }

  return (
    <div className="flex h-full w-full flex-col items-center bg-[#fff0f4]">
      <div className="flex h-full w-full max-w-[645px] flex-col overflow-hidden bg-white">
        <ScreenHeader title={t('marriage.title')} onBack={onBack} align="center" />
        <main className="min-h-0 flex-1 overflow-y-auto">
          {!loaded && loading ? (
            <div className="flex h-full items-center justify-center text-sm text-black/50">
              {t('common.loading')}
            </div>
          ) : status === 'married' ? (
            <MarriageBoxView />
          ) : (
            <MarriageLockedView onPropose={() => setComposeOpen(true)} />
          )}
        </main>
      </div>
    </div>
  );
}
