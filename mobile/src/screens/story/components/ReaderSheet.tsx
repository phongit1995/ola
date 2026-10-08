import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { OlaModal } from '@components/ui/OlaModal';
import type { ReaderPalette } from '../interface';
import { useStoryTextSize } from '../typography';

const SHEET_MAX_HEIGHT = '75%';

interface ReaderSheetProps {
  title: string;
  palette: ReaderPalette;
  onClose: () => void;
  children: ReactNode;
}

export function ReaderSheet(props: ReaderSheetProps) {
  return (
    <OlaModal
      visible
      transparent
      statusBarTranslucent
      navigationBarTranslucent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <ReaderSheetBody {...props} />
    </OlaModal>
  );
}

function ReaderSheetBody({ title, palette, onClose, children }: ReaderSheetProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const textSize = useStoryTextSize();
  return (
    <View className="flex-1 justify-end">
      <Pressable
        accessibilityLabel={t('story.close')}
        onPress={onClose}
        style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0 }}
        className="bg-black/40"
      />
      <View
        accessibilityViewIsModal
        className="rounded-t-2xl"
        style={{
          maxHeight: SHEET_MAX_HEIGHT,
          backgroundColor: palette.panel,
          paddingBottom: insets.bottom,
          shadowColor: '#000',
          shadowOpacity: 0.2,
          shadowRadius: 8,
          shadowOffset: { width: 0, height: -4 },
          elevation: 12,
        }}
      >
        <View className="flex-row items-center justify-between px-4 pb-2 pt-3">
          <Text className="font-bold" style={[textSize(16, 24), { color: palette.text }]}>
            {title}
          </Text>
          <Pressable onPress={onClose} className="rounded-full px-2 py-1">
            <Text style={[textSize(14, 20), { color: palette.muted }]}>{t('story.close')}</Text>
          </Pressable>
        </View>
        {children}
      </View>
    </View>
  );
}
