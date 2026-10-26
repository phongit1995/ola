import { useTranslation } from 'react-i18next';
import { Platform, ScrollView, TextInput } from 'react-native';
import { withAlpha } from '@ola/shared/lib';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { ChatText } from '@components/ui/ChatText';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';

const TEXT_MAX_HEIGHT = 320;
const TEXT_STYLE = { fontSize: 16, lineHeight: 22, color: 'rgba(0,0,0,0.87)' } as const;

interface SelectTextDialogProps {
  text: string | null;
  onCopyAll: (text: string) => void;
  onClose: () => void;
}

export function SelectTextDialog({ text, onCopyAll, onClose }: SelectTextDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const content = text ?? '';

  return (
    <Dialog
      visible={text != null}
      onClose={onClose}
      title={t('chat.actionSelectText')}
      showClose
      avoidKeyboard={false}
      footer={
        <>
          <DialogButton
            variant="green"
            onPress={() => {
              onCopyAll(content);
              onClose();
            }}
          >
            {t('chat.copyAll')}
          </DialogButton>
          <DialogButton onPress={onClose}>{t('dialog.close')}</DialogButton>
        </>
      }
    >
      {Platform.OS === 'ios' ? (
        <TextInput
          value={content}
          editable={false}
          multiline
          selectionColor={colors.primary}
          maxFontSizeMultiplier={CHAT_MAX_FONT_SIZE_MULTIPLIER}
          style={[TEXT_STYLE, { maxHeight: TEXT_MAX_HEIGHT, padding: 0 }]}
        />
      ) : (
        <ScrollView style={{ maxHeight: TEXT_MAX_HEIGHT }}>
          <ChatText
            selectable
            selectionColor={withAlpha(colors.primary, 0.35)}
            style={TEXT_STYLE}
          >
            {content}
          </ChatText>
        </ScrollView>
      )}
    </Dialog>
  );
}
