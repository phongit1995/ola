import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import { useDevicePlatform } from '@hooks';
import { AndroidGuide } from './AndroidGuide';
import { IosGuide } from './IosGuide';
import { DownloadFaq } from './DownloadFaq';
import { PlatformTabs, type GuidePlatform } from './PlatformTabs';
import { copyToClipboard } from './copyToClipboard';
import { CopyIcon, PhoneIcon, ShieldIcon, WarningIcon } from './platformIcons';

export function DownloadGuideContent() {
  const { t } = useTranslation();
  const { platform, isInAppBrowser } = useDevicePlatform();
  const detected: GuidePlatform | null =
    platform === 'desktop' ? null : platform;
  const [activeTab, setActiveTab] = useState<GuidePlatform>(
    detected ?? 'android'
  );
  const pageUrl = `${window.location.origin}${ROUTES.downloadApp}`;

  async function handleCopyPageUrl() {
    const copied = await copyToClipboard(pageUrl);
    if (copied) toast.success(t('download.copied'));
    else toast.error(t('common.error'));
  }

  return (
    <div className="space-y-4">
      {isInAppBrowser && (
        <section className="rounded-2xl border border-[#ffd54f] bg-[#fff8e1] px-4 py-3.5">
          <div className="flex items-center gap-2 text-[#6d4c00]">
            <WarningIcon className="h-5 w-5 shrink-0" />
            <h2 className="text-sm font-bold">{t('download.inAppTitle')}</h2>
          </div>
          <p className="mt-1.5 text-xs leading-relaxed text-[#6d4c00]">
            {t('download.inAppMessage')}
          </p>
          <button
            type="button"
            onClick={handleCopyPageUrl}
            className="mt-2.5 flex h-9 items-center gap-1.5 rounded-lg bg-[#6d4c00] px-3 text-xs font-semibold text-white"
          >
            <CopyIcon className="h-3.5 w-3.5" />
            {t('download.copyLink')}
          </button>
        </section>
      )}

      <section className="overflow-hidden rounded-2xl bg-white shadow-sm ring-1 ring-black/5">
        <PlatformTabs
          active={activeTab}
          detected={detected}
          onChange={setActiveTab}
        />
        {activeTab === 'android' ? (
          <AndroidGuide isCurrentDevice={detected === 'android'} />
        ) : (
          <IosGuide isCurrentDevice={detected === 'ios'} />
        )}
      </section>

      {platform === 'desktop' && (
        <section className="rounded-2xl bg-white px-4 py-4 shadow-sm ring-1 ring-black/5">
          <div className="flex items-center gap-2 text-black/85">
            <PhoneIcon className="h-5 w-5 shrink-0 text-ola-primary-ink" />
            <h2 className="text-sm font-bold">{t('download.openOnPhone')}</h2>
          </div>
          <p className="mt-1.5 text-xs leading-relaxed text-black/55">
            {t('download.openOnPhoneHint')}
          </p>
          <div className="mt-2.5 flex items-center gap-2">
            <p className="min-w-0 flex-1 truncate rounded-lg bg-black/4 px-3 py-2 text-[13px] text-black/70">
              {pageUrl}
            </p>
            <button
              type="button"
              onClick={handleCopyPageUrl}
              className="flex h-9 shrink-0 items-center gap-1.5 rounded-lg border border-black/15 px-3 text-xs font-semibold text-black/70"
            >
              <CopyIcon className="h-3.5 w-3.5" />
              {t('common.copy')}
            </button>
          </div>
        </section>
      )}

      <DownloadFaq />

      <section className="rounded-2xl bg-white px-4 py-4 shadow-sm ring-1 ring-black/5">
        <div className="flex items-center gap-2 text-black/85">
          <ShieldIcon className="h-5 w-5 shrink-0 text-ola-primary-ink" />
          <h2 className="text-sm font-bold">{t('download.safetyTitle')}</h2>
        </div>
        <p className="mt-1.5 text-xs leading-relaxed text-black/55">
          {t('download.safety')}
        </p>
      </section>
    </div>
  );
}
