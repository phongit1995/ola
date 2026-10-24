import { useTranslation } from 'react-i18next';
import { View } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ReelTray } from './components/ReelTray';
import { useReelOverlays } from './useReelOverlays';

export function ReelGalleryScreen() {
  const { t } = useTranslation();
  const navigation = useNavigation();
  const reel = useReelOverlays();
  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader title={t('reel.trayTitle')} onBack={() => navigation.goBack()} />
      <ReelTray layout="grid" onOpenViewer={reel.openViewer} onAddReel={reel.openComposer} />
      {reel.overlays}
    </View>
  );
}
