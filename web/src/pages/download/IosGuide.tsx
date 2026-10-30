import { useTranslation } from 'react-i18next';
import { ANALYTICS_EVENT, APP_DOWNLOAD } from '@constants';
import { trackEvent } from '@config';
import { ActionLink, DownloadGuideBody } from './DownloadGuideBody';
import { CopyableValue } from './CopyableValue';
import { AppleIcon } from './platformIcons';

export function IosGuide({ isCurrentDevice }: { isCurrentDevice: boolean }) {
  const { t } = useTranslation();
  const steps = t('download.ios.steps', {
    returnObjects: true,
  }) as unknown as string[];

  return (
    <DownloadGuideBody
      channel={t('download.ios.channel')}
      isCurrentDevice={isCurrentDevice}
      chips={[
        t('download.ios.requirement', { version: APP_DOWNLOAD.iosMinVersion }),
      ]}
      steps={steps}
      footer={
        <div className="pt-1">
          <CopyableValue
            label={t('download.ios.storeLinkLabel')}
            value={APP_DOWNLOAD.appStoreUrl}
          />
        </div>
      }
    >
      <ActionLink
        href={APP_DOWNLOAD.appStoreUrl}
        onClick={() =>
          trackEvent(ANALYTICS_EVENT.storeClick, {
            store: 'ios',
            source: 'download_page',
          })
        }
        label={t('download.ios.action')}
        icon={<AppleIcon />}
      />
    </DownloadGuideBody>
  );
}
