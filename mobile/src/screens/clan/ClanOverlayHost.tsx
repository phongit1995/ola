import { useTranslation } from 'react-i18next';
import { View } from 'react-native';
import { OlaModal } from '../../components/OlaModal';
import { ScreenHeader } from '../../components/ScreenHeader';
import { ScreenPlaceholder } from '../../components/ScreenPlaceholder';
import { useClanOverlayStore, type ClanOverlayEntry } from '../../store/clanOverlayStore';
import { ClanHomeScreen } from './ClanHomeScreen';

function ClanEntryScreen({ entry }: { entry: ClanOverlayEntry }) {
  const { t } = useTranslation();
  const back = useClanOverlayStore((s) => s.back);
  const push = useClanOverlayStore((s) => s.push);

  switch (entry.kind) {
    case 'home':
      return (
        <ClanHomeScreen onClose={back} onOpenClan={(handle) => push({ kind: 'clan', handle })} />
      );
    default:
      return (
        <View className="flex-1 bg-white">
          <ScreenHeader
            title={entry.kind === 'clan' ? `#${entry.handle ?? ''}` : t('clan.title')}
            onBack={back}
          />
          <ScreenPlaceholder title={t('me.comingSoon')} />
        </View>
      );
  }
}

export function ClanOverlayHost() {
  const stack = useClanOverlayStore((s) => s.stack);
  const back = useClanOverlayStore((s) => s.back);

  const top = stack[stack.length - 1];
  if (top == null) return null;

  return (
    <OlaModal visible transparent animationType="slide" onRequestClose={back}>
      <ClanEntryScreen key={stack.length} entry={top} />
    </OlaModal>
  );
}
