import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { DownloadGuideContent } from './DownloadGuideContent';

export function DownloadAppPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  function handleBack() {
    const historyIndex = (window.history.state as { idx?: number } | null)?.idx ?? 0;
    if (historyIndex > 0) navigate(-1);
    else navigate(ROUTES.home);
  }

  return (
    <div className="min-h-full bg-[#eef0f2] font-sans">
      <header className="bg-linear-to-br from-ola-primary-dark to-ola-primary pt-4 pb-6">
        <div className="mx-auto max-w-2xl px-4">
          <button type="button" onClick={handleBack} className="text-sm text-white/90">
            {t('download.back')}
          </button>
          <div className="mt-3 text-center">
            <img
              src="/favicon.png"
              alt="Ola"
              className="mx-auto mb-3 h-16 w-16 rounded-2xl shadow-lg"
            />
            <h1 className="text-xl font-bold tracking-wide text-white">{t('download.title')}</h1>
            <p className="mx-auto mt-1.5 max-w-md text-[13px] leading-relaxed text-white/85">
              {t('download.subtitle')}
            </p>
          </div>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 pt-5 pb-12">
        <DownloadGuideContent />

        <button
          type="button"
          onClick={() => navigate(ROUTES.home)}
          className="mt-4 h-11 w-full rounded-xl border border-black/15 bg-white text-sm font-semibold text-black/70"
        >
          {t('download.useWeb')}
        </button>
      </main>
    </div>
  );
}
