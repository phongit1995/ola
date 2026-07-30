import { useTranslation } from 'react-i18next';
import { APP_DOWNLOAD } from '@constants';
import { ActionLink, DownloadGuideBody } from './DownloadGuideBody';
import { CopyableValue } from './CopyableValue';
import { DownloadIcon } from './platformIcons';

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
      chips={[t('download.android.size', { size: APP_DOWNLOAD.apkSize })]}
      steps={steps}
      note={t('download.android.note')}
      footer={
        <>
          <CopyableValue
            label={t('download.android.linkLabel')}
            value={APP_DOWNLOAD.apkUrl}
            hint={t('download.android.linkHint')}
          />
          <CopyableValue
            label={t('download.android.folderLinkLabel')}
            value={APP_DOWNLOAD.apkFolderUrl}
          />
        </>
      }
    >
      <ActionLink
        href={APP_DOWNLOAD.apkFolderUrl}
        label={t('download.android.action')}
        icon={<DownloadIcon />}
      />
    </DownloadGuideBody>
  );
}
