import { useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, TextInput, View } from 'react-native';
import { WORD_CHAIN_MOVE_MAX_LENGTH } from '@ola/shared/constants';
import { wordChainMoveErrorText } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { useWordChainViewStore } from '@store/wordChainViewStore';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER, DIVIDER } from '@constants';
import { WordChainImage } from './WordChainIcons';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const BUTTON_SIZE = 40;
const LOOKUP_ICON_SIZE = 32;
const HINT_ICON_SIZE = 40;
const BUY_ICON_WIDTH = 32;
const BUY_ICON_HEIGHT = 20;

interface WordChainComposerProps {
  syllable?: string;
  lockedHint?: string;
  onSend: (content: string) => Promise<unknown>;
  onHint: () => void;
  onLookup: () => void;
  onBuyGuesses?: () => void;
}

export function WordChainComposer({
  syllable,
  lockedHint,
  onSend,
  onHint,
  onLookup,
  onBuyGuesses,
}: WordChainComposerProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const pushToast = useToastStore((state) => state.push);
  const inputRef = useRef<TextInput>(null);
  const text = useWordChainViewStore((state) => state.draft);
  const setText = useWordChainViewStore((state) => state.setDraft);
  const sending = useWordChainViewStore((state) => state.sending);
  const sendDraft = useWordChainViewStore((state) => state.sendDraft);
  const content = text.trim();
  const locked = lockedHint != null;
  const canSend = content !== '' && !sending && !locked;

  async function submit() {
    if (!canSend) return;
    try {
      await sendDraft(onSend);
    } catch (error) {
      pushToast('error', wordChainMoveErrorText(t, error));
    } finally {
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
      {onBuyGuesses != null ? (
        <Pressable
          accessibilityRole="button"
          onPress={onBuyGuesses}
          className="flex-row items-center justify-center rounded-full px-3 active:opacity-90"
          style={{
            height: BUTTON_SIZE,
            minWidth: 64,
            gap: 4,
            backgroundColor: colors.primary,
          }}
        >
          <Image
            source={WORD_CHAIN_ICONS.buyGuesses}
            style={{ width: BUY_ICON_WIDTH, height: BUY_ICON_HEIGHT }}
            resizeMode="contain"
            accessibilityElementsHidden
            importantForAccessibility="no"
          />
          <Text className="text-sm font-medium" style={{ color: colors.onPrimary }}>
            {t('wordChain.buyGuesses')}
          </Text>
        </Pressable>
      ) : (
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
      )}
    </View>
  );
}
