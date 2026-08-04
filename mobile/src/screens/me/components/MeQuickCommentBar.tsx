import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { OlaModal } from '@components/ui/OlaModal';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
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
      statusBarTranslucent
      navigationBarTranslucent
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
  const bottomBarInset = useBottomBarInset();

  return (
    <ChatKeyboardArea>
      <View className="flex-1 justify-end">
        <Pressable className="flex-1 bg-black/20" onPress={onClose} />
        <View style={{ paddingBottom: bottomBarInset }}>
          {contextLabel != null && (
            <View
              className="flex-row items-center gap-2 bg-white/95 px-3 py-1.5"
              style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
            >
              <Text className="text-xs text-ola-ink-soft">
                {t('me.commentingOn')}
              </Text>
              <Text
                numberOfLines={1}
                className="min-w-0 flex-1 text-xs text-ola-ink"
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
      </View>
    </ChatKeyboardArea>
  );
}
