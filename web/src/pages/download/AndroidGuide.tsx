import { useTranslation } from 'react-i18next';
import { ANALYTICS_EVENT, APP_DOWNLOAD } from '@constants';
import { trackEvent } from '@config';
import { ActionLink, DownloadGuideBody } from './DownloadGuideBody';
import { CopyableValue } from './CopyableValue';
import { GooglePlayIcon } from './platformIcons';

export function AndroidGuide({
  isCurrentDevice,
}: {
  isCurrentDevice: boolean;
}) {
  const { t } = useTranslation();
  const steps = t('download.android.steps', {
    returnObjects: true,
  }) as unknown as string[];

  return (
    <DownloadGuideBody
      channel={t('download.android.channel')}
      isCurrentDevice={isCurrentDevice}
      steps={steps}
      footer={
        <div className="pt-1">
          <CopyableValue
            label={t('download.android.playLinkLabel')}
            value={APP_DOWNLOAD.playStoreUrl}
          />
        </div>
      }
    >
      <ActionLink
        href={APP_DOWNLOAD.playStoreUrl}
        onClick={() =>
          trackEvent(ANALYTICS_EVENT.storeClick, {
            store: 'android',
            source: 'download_page',
          })
        }
        label={t('download.android.action')}
        icon={<GooglePlayIcon />}
      />
    </DownloadGuideBody>
  );
}
