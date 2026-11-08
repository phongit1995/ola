import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ANALYTICS_EVENT, APP_DOWNLOAD } from '@constants';
import { trackEvent } from '@config';
import { DESKTOP_OS_LIST, type DesktopOs } from '@hooks';
import { ActionLink, DownloadGuideBody } from './DownloadGuideBody';
import { DownloadIcon } from './platformIcons';

interface DesktopGuideProps {
  currentOs: DesktopOs | null;
  initialOs: DesktopOs;
}

export function DesktopGuide({ currentOs, initialOs }: DesktopGuideProps) {
  const { t } = useTranslation();
  const [os, setOs] = useState<DesktopOs>(initialOs);
  const steps = t(`download.desktop.${os}.steps`, {
    returnObjects: true,
  }) as unknown as string[];

  const downloads = {
    windows: [
      {
        href: APP_DOWNLOAD.windowsUrl,
        label: t('download.desktop.windows.action'),
      },
    ],
    mac: [
      { href: APP_DOWNLOAD.macUrl, label: t('download.desktop.mac.action') },
    ],
    linux: [
      {
        href: APP_DOWNLOAD.linuxAppImageUrl,
        label: t('download.desktop.linux.action'),
      },
      {
        href: APP_DOWNLOAD.linuxDebUrl,
        label: t('download.desktop.linux.debAction'),
      },
    ],
  }[os];

  return (
    <>
      <div className="flex gap-1.5 px-4 pt-4" role="tablist">
        {DESKTOP_OS_LIST.map((key) => (
          <button
            key={key}
            type="button"
            role="tab"
            aria-selected={os === key}
            onClick={() => setOs(key)}
            className={`h-8 flex-1 rounded-full text-xs font-semibold transition-colors ${
              os === key
                ? 'bg-ola-primary text-ola-on-primary'
                : 'bg-black/5 text-black/55'
            }`}
          >
            {t(`download.desktop.${key}.name`)}
          </button>
        ))}
      </div>
      <DownloadGuideBody
        key={os}
        channel={t('download.desktop.channel')}
        isCurrentDevice={currentOs === os}
        chips={
          os === 'mac'
            ? [
                t('download.desktop.mac.requirement', {
                  version: APP_DOWNLOAD.macMinVersion,
                }),
              ]
            : []
        }
        steps={steps}
        note={t(`download.desktop.${os}.note`)}
      >
        {downloads.map((download, index) => (
          <ActionLink
            key={download.href}
            href={download.href}
            tone={index === 0 ? 'primary' : 'outline'}
            onClick={() =>
              trackEvent(ANALYTICS_EVENT.storeClick, {
                store: os,
                source: 'download_page',
              })
            }
            label={download.label}
            icon={<DownloadIcon />}
          />
        ))}
      </DownloadGuideBody>
    </>
  );
}
