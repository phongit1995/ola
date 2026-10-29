import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Keyboard, Pressable, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { MOMENT_COMMENT_MAX_CHARS } from '@ola/shared/constants';
import { isMomentCommentTooLong, withAlpha } from '@ola/shared/lib';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { KeyboardView } from '@components/KeyboardView';
import { OlaModal } from '@components/ui/OlaModal';
import { ToastHost } from '@components/ui/ToastHost';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useLastKeyboardHeight } from '@hooks/useKeyboardHeight';
import { useThemeColors } from '@hooks/useThemeColors';
import { SmileyKulPanel, SMILEY_PANEL_MIN_CONTENT_HEIGHT } from '@screens/room/components/SmileyKulPanel';
import { MomentSendIcon } from './MomentIcons';

const smileyIcon = require('@assets/icons/chat/ic_smiley.png');

const INPUT_HEIGHT = 44;
const SELECTION_ALPHA = 0.6;
const GRADIENT = ['rgba(0,0,0,0)', 'rgba(0,0,0,0.9)', '#000000'];

interface MomentCommentSheetProps {
  momentId: string;
  onClose: () => void;
}

export function MomentCommentSheet({ momentId, onClose }: MomentCommentSheetProps) {
  return (
    <OlaModal
      visible
      transparent
      statusBarTranslucent
      navigationBarTranslucent
      animationType="fade"
      onRequestClose={onClose}
    >
      <MomentCommentSheetBody momentId={momentId} onClose={onClose} />
      <ToastHost />
    </OlaModal>
  );
}

function MomentCommentSheetBody({ momentId, onClose }: MomentCommentSheetProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomBarInset = useBottomBarInset();
  const lastKeyboardHeight = useLastKeyboardHeight();
  const comment = useMomentStore((s) => s.comment);
  const push = useToastStore((s) => s.push);
  const [draft, setDraft] = useState('');
  const [sending, setSending] = useState(false);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<ChatComposerHandle>(null);
  const openRef = useRef(true);
  const canSend = draft.trim() !== '' && !sending;
  const panelContentHeight = Math.max(SMILEY_PANEL_MIN_CONTENT_HEIGHT, lastKeyboardHeight - 44);

  useEffect(() => {
    openRef.current = true;
    requestAnimationFrame(() => inputRef.current?.focus());
    return () => {
      openRef.current = false;
    };
  }, []);

  function toggleSmiley() {
    if (smileyOpen) {
      setSmileyOpen(false);
      inputRef.current?.focus();
      return;
    }
    Keyboard.dismiss();
    setSmileyOpen(true);
  }

  async function submit() {
    if (!canSend) return;
    if (isMomentCommentTooLong(draft)) {
      push('error', t('moment.commentTooLong', { max: MOMENT_COMMENT_MAX_CHARS }));
      return;
    }
    setSending(true);
    try {
      const created = await comment(momentId, draft);
      if (!created) push('info', t('moment.commentAlready'));
      if (openRef.current) onClose();
    } catch {
      push('error', t('moment.commentFailed'));
    } finally {
      setSending(false);
    }
  }

  return (
    <KeyboardView className="flex-1" style={{ backgroundColor: 'rgba(0,0,0,0.6)' }}>
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('dialog.close')}
        onPress={onClose}
        style={{ flex: 1 }}
      />
      <LinearGradient
        colors={GRADIENT}
        style={{ paddingTop: 40, paddingHorizontal: 12, paddingBottom: 12 + bottomBarInset }}
      >
        <Text className="px-1 pb-2 text-xs" style={{ color: 'rgba(255,255,255,0.7)' }}>
          {t('moment.commentOnce')}
        </Text>
        <View className="flex-row items-end gap-2">
          <View
            className="min-w-0 flex-1 flex-row items-end rounded-3xl pl-1 pr-1"
            style={{ borderWidth: 1, borderColor: 'rgba(255,255,255,0.4)', backgroundColor: 'rgba(255,255,255,0.1)' }}
          >
            <ChatComposer
              ref={inputRef}
              value={draft}
              onChange={setDraft}
              onFocus={() => setSmileyOpen(false)}
              placeholder={t('moment.commentPlaceholder')}
              minHeight={INPUT_HEIGHT - 2}
              paddingV={10}
              textColor="#ffffff"
              placeholderTextColor="rgba(255,255,255,0.6)"
              selectionColor={withAlpha(colors.primary, SELECTION_ALPHA)}
            />
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('chat.attachTabSmiley')}
              accessibilityState={{ selected: smileyOpen }}
              onPress={toggleSmiley}
              className="items-center justify-center"
              style={{ width: 40, height: INPUT_HEIGHT - 2 }}
            >
              <Image
                source={smileyIcon}
                resizeMode="contain"
                style={{ width: 24, height: 24, tintColor: '#ffffff', opacity: smileyOpen ? 1 : 0.85 }}
              />
            </Pressable>
          </View>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('me.commentSend')}
            onPress={() => void submit()}
            disabled={!canSend}
            className="items-center justify-center rounded-full"
            style={{
              width: INPUT_HEIGHT,
              height: INPUT_HEIGHT,
              backgroundColor: colors.primary,
              opacity: canSend ? 1 : 0.4,
            }}
          >
            <MomentSendIcon size={20} color={colors.onPrimary} />
          </Pressable>
        </View>
        {smileyOpen && (
          <View className="mt-2 overflow-hidden rounded-2xl bg-white">
            <SmileyKulPanel
              hideKul
              contentHeight={panelContentHeight}
              onPickEmoji={(code) => inputRef.current?.insertCode(code, true)}
              onBackspace={() => inputRef.current?.backspace()}
            />
          </View>
        )}
      </LinearGradient>
    </KeyboardView>
  );
}
