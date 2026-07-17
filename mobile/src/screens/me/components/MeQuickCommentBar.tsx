import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { KeyboardView } from '@components/KeyboardView';
import { OlaModal } from '@components/ui/OlaModal';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { MeCommentComposer } from './MeCommentComposer';

interface MeQuickCommentBarProps {
  contextLabel?: string;
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  onClose: () => void;
}

export function MeQuickCommentBar(props: MeQuickCommentBarProps) {
  return (
    <OlaModal
      visible
      transparent
      animationType="fade"
      onRequestClose={props.onClose}
    >
      <MeQuickCommentBody {...props} />
    </OlaModal>
  );
}

function MeQuickCommentBody({
  contextLabel,
  submitting,
  onSubmit,
  onClose,
}: MeQuickCommentBarProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  return (
    <KeyboardView className="flex-1 justify-end">
      <Pressable className="flex-1 bg-black/20" onPress={onClose} />
      <View style={{ paddingBottom: insets.bottom }}>
        {contextLabel != null && (
          <View
            className="flex-row items-center gap-2 bg-white/95 px-3 py-1.5"
            style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
          >
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('me.commentingOn')}
            </Text>
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1 text-xs"
              style={{ color: 'rgba(0,0,0,0.87)' }}
            >
              {contextLabel}
            </Text>
          </View>
        )}
        <MeCommentComposer
          submitting={submitting}
          onSubmit={onSubmit}
          autoFocus
        />
      </View>
    </KeyboardView>
  );
}
