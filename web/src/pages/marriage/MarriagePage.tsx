import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { FullScreenOverlay, ScreenHeader } from '@components';
import { useMarriageStore } from './marriageStore';
import { MarriageBoxView } from './MarriageBoxView';
import { MarriageLockedView } from './MarriageLockedView';
import { ProposeComposer } from './ProposeComposer';

export function MarriagePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const status = useMarriageStore((s) => s.status);
  const [composeOpen, setComposeOpen] = useState(false);

  return (
    <FullScreenOverlay>
      <div className="flex h-full w-full flex-col items-center bg-[#fff0f4]">
        <div className="flex h-full w-full max-w-[645px] flex-col overflow-hidden bg-white">
          <ScreenHeader
            title={t('marriage.title')}
            onBack={() => navigate(ROUTES.home)}
            align="center"
          />
          <main className="min-h-0 flex-1 overflow-y-auto">
            {status === 'married' ? (
              <MarriageBoxView />
            ) : (
              <MarriageLockedView onPropose={() => setComposeOpen(true)} />
            )}
          </main>
        </div>
      </div>
      {composeOpen && <ProposeComposer onClose={() => setComposeOpen(false)} />}
    </FullScreenOverlay>
  );
}
