import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, TextInput, View } from 'react-native';
import { WORD_CHAIN_MOVE_MAX_LENGTH } from '@ola/shared/constants';
import { wordChainMoveErrorText } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER, DIVIDER } from '@constants';
import { WordChainImage } from './WordChainIcons';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const BUTTON_SIZE = 40;
const LOOKUP_ICON_SIZE = 32;
const HINT_ICON_SIZE = 40;

interface WordChainComposerProps {
  syllable?: string;
  lockedHint?: string;
  onSend: (content: string) => Promise<unknown>;
  onHint: () => void;
  onLookup: () => void;
}

export function WordChainComposer({
  syllable,
  lockedHint,
  onSend,
  onHint,
  onLookup,
}: WordChainComposerProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const pushToast = useToastStore((state) => state.push);
  const inputRef = useRef<TextInput>(null);
  const [text, setText] = useState('');
  const [sending, setSending] = useState(false);
  const content = text.trim();
  const locked = lockedHint != null;
  const canSend = content !== '' && !sending && !locked;

  async function submit() {
    if (!canSend) return;
    setSending(true);
    try {
      await onSend(content);
      setText((current) => (current.trim() === content ? '' : current));
    } catch (error) {
      pushToast('error', wordChainMoveErrorText(t, error));
    } finally {
      setSending(false);
      inputRef.current?.focus();
    }
  }

  return (
    <View
      className="flex-row items-center gap-2 bg-white px-3 py-2"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
    >
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('wordChain.lookupTitle')}
        onPress={onLookup}
        className="items-center justify-center active:opacity-70"
        style={{ width: BUTTON_SIZE, height: BUTTON_SIZE }}
      >
        <WordChainImage source={WORD_CHAIN_ICONS.lookup} size={LOOKUP_ICON_SIZE} />
      </Pressable>
      <TextInput
        ref={inputRef}
        value={text}
        onChangeText={setText}
        accessibilityLabel={t('wordChain.inputLabel')}
        maxLength={WORD_CHAIN_MOVE_MAX_LENGTH}
        editable={!locked}
        placeholder={
          lockedHint ??
          (syllable != null && syllable !== ''
            ? t('wordChain.inputHint', { syllable })
            : t('wordChain.inputHintEmpty'))
        }
        placeholderTextColor="rgba(0,0,0,0.35)"
        autoCapitalize="none"
        autoCorrect={false}
        spellCheck={false}
        returnKeyType="send"
        submitBehavior="submit"
        onSubmitEditing={() => void submit()}
        maxFontSizeMultiplier={CHAT_MAX_FONT_SIZE_MULTIPLIER}
        className="min-w-0 flex-1 rounded-full px-4 text-base"
        style={{
          height: BUTTON_SIZE,
          paddingVertical: 0,
          color: 'rgba(0,0,0,0.87)',
          backgroundColor: 'rgba(0,0,0,0.05)',
          opacity: locked ? 0.6 : 1,
        }}
      />
      <Pressable
        accessibilityRole="button"
        accessibilityLabel={t('wordChain.hint')}
        onPress={onHint}
        disabled={sending || locked}
        className="items-center justify-center active:opacity-70"
        style={{ width: BUTTON_SIZE, height: BUTTON_SIZE, opacity: sending || locked ? 0.5 : 1 }}
      >
        <WordChainImage source={WORD_CHAIN_ICONS.hint} size={HINT_ICON_SIZE} />
      </Pressable>
      <Pressable
        accessibilityRole="button"
        onPress={() => void submit()}
        disabled={!canSend}
        className="items-center justify-center rounded-full px-4 active:opacity-90"
        style={{
          height: BUTTON_SIZE,
          minWidth: 64,
          backgroundColor: colors.primary,
          opacity: canSend ? 1 : 0.5,
        }}
      >
        {sending ? (
          <ActivityIndicator color={colors.onPrimary} size="small" />
        ) : (
          <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
            {t('wordChain.send')}
          </Text>
        )}
      </Pressable>
    </View>
  );
}
