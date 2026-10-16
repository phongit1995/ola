import { forwardRef, useImperativeHandle, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Keyboard, Pressable, Text, View } from 'react-native';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { DIVIDER } from '@constants';
import { useLastKeyboardHeight } from '@hooks/useKeyboardHeight';
import { useThemeColors } from '@hooks/useThemeColors';
import {
  SMILEY_PANEL_MIN_CONTENT_HEIGHT,
  SmileyKulPanel,
} from '@screens/room/components/SmileyKulPanel';
import { useStoryTextSize } from '../useStoryTextSize';

const smileyIcon = require('@assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('@assets/icons/chat/ic_smiley_selected.png');

const MUTED = 'rgba(0,0,0,0.54)';
const SEND_MIN_WIDTH = 64;
const SMILEY_ICON_SIZE = 24;
const SMILEY_PANEL_TAB_HEIGHT = 44;

export interface StoryCommentComposerHandle {
  focus: () => void;
  closePanel: () => void;
}

interface StoryCommentComposerProps {
  sending: boolean;
  replyingTo: string | null;
  unlockMinChars: number | null;
  onCancelReply: () => void;
  onSubmit: (text: string) => Promise<boolean>;
}

export const StoryCommentComposer = forwardRef<StoryCommentComposerHandle, StoryCommentComposerProps>(
  function StoryCommentComposerInner(
    { sending, replyingTo, unlockMinChars, onCancelReply, onSubmit },
    ref
  ) {
    const { t } = useTranslation();
    const colors = useThemeColors();
    const textSize = useStoryTextSize();
    const lastKeyboardHeight = useLastKeyboardHeight();
    const [draft, setDraft] = useState('');
    const [smileyOpen, setSmileyOpen] = useState(false);
    const composerRef = useRef<ChatComposerHandle>(null);
    const length = [...draft.trim()].length;
    const canSend = length > 0 && !sending;
    const unlockReached = unlockMinChars != null && length >= unlockMinChars;
    const panelContentHeight = Math.max(
      SMILEY_PANEL_MIN_CONTENT_HEIGHT,
      lastKeyboardHeight - SMILEY_PANEL_TAB_HEIGHT
    );

    useImperativeHandle(ref, () => ({
      focus: () => composerRef.current?.focus(),
      closePanel: () => setSmileyOpen(false),
    }));

    function toggleSmiley() {
      if (smileyOpen) {
        setSmileyOpen(false);
        return;
      }
      Keyboard.dismiss();
      setSmileyOpen(true);
    }

    async function submit() {
      if (!canSend) return;
      if (await onSubmit(draft)) {
        setDraft('');
        setSmileyOpen(false);
      }
    }

    return (
      <View className="bg-white" style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}>
        {replyingTo != null && (
          <View className="flex-row items-center gap-2 px-4 pt-2">
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1"
              style={[textSize(12, 16), { color: MUTED }]}
            >
              {t('story.commentReplyingTo', { name: replyingTo })}
            </Text>
            <Pressable accessibilityRole="button" onPress={onCancelReply} hitSlop={8}>
              <Text className="font-medium" style={[textSize(12, 16), { color: colors.primaryInk }]}>
                {t('story.commentCancelReply')}
              </Text>
            </Pressable>
          </View>
        )}
        {unlockMinChars != null && (
          <View className="flex-row items-start gap-2 px-4 pt-2">
            <Text className="min-w-0 flex-1" style={[textSize(12, 20), { color: MUTED }]}>
              {t('story.commentUnlockHint', { count: unlockMinChars })}
            </Text>
            <Text
              className={unlockReached ? 'font-semibold' : undefined}
              style={[
                textSize(12, 20),
                {
                  color: unlockReached ? colors.primaryInk : MUTED,
                  fontVariant: ['tabular-nums'],
                },
              ]}
            >
              {`${length}/${unlockMinChars}`}
            </Text>
          </View>
        )}
        <View className="flex-row items-end gap-2 px-3 py-2">
          <View className="flex-1 rounded-2xl" style={{ borderWidth: 1, borderColor: DIVIDER }}>
            <ChatComposer
              ref={composerRef}
              value={draft}
              onChange={setDraft}
              placeholder={t('story.commentPlaceholder')}
              onFocus={() => setSmileyOpen(false)}
            />
          </View>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('chat.attachTabSmiley')}
            onPress={toggleSmiley}
            className="h-10 w-9 items-center justify-center"
            style={{ opacity: smileyOpen ? 1 : 0.6 }}
          >
            <Image
              source={smileyOpen ? smileyIconActive : smileyIcon}
              style={{ width: SMILEY_ICON_SIZE, height: SMILEY_ICON_SIZE }}
              resizeMode="contain"
            />
          </Pressable>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('story.commentSend')}
            onPress={() => void submit()}
            disabled={!canSend}
            className="h-10 items-center justify-center rounded-full bg-ola-button px-4"
            style={{ minWidth: SEND_MIN_WIDTH, opacity: canSend ? 1 : 0.4 }}
          >
            {sending ? (
              <ActivityIndicator size="small" color={colors.onPrimary} />
            ) : (
              <Text className="font-medium" style={[textSize(14, 20), { color: colors.onPrimary }]}>
                {t('story.commentSend')}
              </Text>
            )}
          </Pressable>
        </View>
        {smileyOpen && (
          <SmileyKulPanel
            hideKul
            contentHeight={panelContentHeight}
            onPickEmoji={(code) => composerRef.current?.insertCode(code, true)}
            onBackspace={() => composerRef.current?.backspace()}
          />
        )}
      </View>
    );
  }
);
