import { useTranslation } from 'react-i18next';
import { APP_DOWNLOAD } from '@constants';
import { ActionLink, DownloadGuideBody } from './DownloadGuideBody';
import { CopyableValue } from './CopyableValue';
import { GuideScreenshots } from './GuideScreenshots';
import { SendIcon } from './platformIcons';
import shot1 from '@/assets/images/download/ios-testflight-1.webp';
import shot2 from '@/assets/images/download/ios-testflight-2.webp';
import shot3 from '@/assets/images/download/ios-testflight-3.webp';
import shot4 from '@/assets/images/download/ios-testflight-4.webp';
import shot5 from '@/assets/images/download/ios-testflight-5.webp';
import shot6 from '@/assets/images/download/ios-testflight-6.webp';

const STEP_SHOTS = [shot1, shot2, shot3, shot4, shot5, shot6];

export function IosGuide({ isCurrentDevice }: { isCurrentDevice: boolean }) {
  const { t } = useTranslation();
  const steps = t('download.ios.steps', { returnObjects: true }) as unknown as string[];
  const shots = STEP_SHOTS.map((src, index) => ({
    src,
    label: t('download.stepLabel', { index: index + 1 }),
  }));

  return (
    <DownloadGuideBody
      channel={t('download.ios.channel')}
      isCurrentDevice={isCurrentDevice}
      steps={steps}
      note={t('download.ios.note')}
      illustrations={<GuideScreenshots shots={shots} />}
      footer={
        <>
          <CopyableValue
            label={t('download.ios.codeLabel')}
            value={APP_DOWNLOAD.testflightCode}
            hint={t('download.ios.codeHint')}
            emphasize
          />
          <CopyableValue
            label={t('download.ios.linkLabel')}
            value={APP_DOWNLOAD.testflightUrl}
          />
        </>
      }
    >
      <ActionLink
        href={APP_DOWNLOAD.testflightUrl}
        label={t('download.ios.action')}
        icon={<SendIcon />}
      />
      <ActionLink
        href={APP_DOWNLOAD.testflightAppStoreUrl}
        label={t('download.ios.installTestflight')}
        tone="outline"
      />
    </DownloadGuideBody>
  );
}
