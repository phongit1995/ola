import { useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import {
  formatKen,
  isSameWordChainTurn,
  lastSyllable,
  wordChainHintErrorText,
  wordChainMoveErrorText,
} from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useWordChainPrefsStore } from '@ola/shared/stores/word-chain/wordChainPrefsStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { WordChainKen } from './WordChainKen';
import { WORD_CHAIN_ICONS } from './wordChainAssets';
import { WORD_CHAIN_ROW_DIVIDER } from './WordChainList';

const KEN_PILL = { ken: <WordChainKen /> };
const SEND_BUTTON_WIDTH = 72;
const ERROR_COLOR = '#e34545';

export function WordChainHintDialog({
  onClose,
  onSend,
}: {
  onClose: () => void;
  onSend: (word: string) => Promise<unknown>;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const pushToast = useToastStore((store) => store.push);
  const state = useWordChainStore((store) => store.state);
  const price = useWordChainStore((store) => store.hintPrice);
  const hint = useWordChainStore((store) => store.hint);
  const buyHint = useWordChainStore((store) => store.buyHint);
  const ken = useAuthStore((store) => store.user?.ken);
  const autoSend = useWordChainPrefsStore((store) => store.hintAutoSend);
  const setAutoSend = useWordChainPrefsStore((store) => store.setHintAutoSend);
  const [boughtHere, setBoughtHere] = useState(false);
  const [buying, setBuying] = useState(false);
  const [sendingWord, setSendingWord] = useState<string | null>(null);
  const canAfford = ken == null || ken >= price;
  const current = isSameWordChainTurn(hint, state);

  async function send(word: string) {
    setSendingWord(word);
    try {
      await onSend(word);
      onClose();
    } catch (error) {
      pushToast('error', wordChainMoveErrorText(t, error));
      setSendingWord(null);
    }
  }

  async function buy() {
    setBuying(true);
    try {
      const result = await buyHint();
      setBoughtHere(true);
      if (autoSend) await send(result.hints[0]!);
    } catch (error) {
      pushToast('error', wordChainHintErrorText(t, error));
    } finally {
      setBuying(false);
    }
  }

  if (hint != null && (current || boughtHere)) {
    const stale = !current;
    return (
      <Dialog
        visible
        onClose={onClose}
        icon={WORD_CHAIN_ICONS.hint}
        title={t('wordChain.hintListTitle', { syllable: lastSyllable(hint.word) })}
        showClose
        avoidKeyboard={false}
      >
        <Text
          className="text-sm leading-relaxed"
          style={{ color: stale ? ERROR_COLOR : 'rgba(0,0,0,0.54)' }}
        >
          {stale ? (
            t('wordChain.hintStale')
          ) : (
            <Trans
              i18nKey={hint.charged ? 'wordChain.hintListHelp' : 'wordChain.hintListHelpFree'}
              values={{ price: formatKen(hint.price) }}
              components={KEN_PILL}
            />
          )}
        </Text>
        <ScrollView className="mt-1">
          {hint.hints.map((word, index) => (
            <View
              key={word}
              className="flex-row items-center gap-3 py-2"
              style={{ borderTopWidth: index === 0 ? 0 : 1, borderTopColor: WORD_CHAIN_ROW_DIVIDER }}
            >
              <Text
                numberOfLines={1}
                className="min-w-0 flex-1 text-base font-semibold"
                style={{ color: 'rgba(0,0,0,0.87)' }}
              >
                {word}
              </Text>
              <View style={{ width: SEND_BUTTON_WIDTH }}>
                <DialogButton
                  variant="green"
                  disabled={stale || sendingWord != null}
                  onPress={() => void send(word)}
                >
                  {sendingWord === word ? (
                    <ActivityIndicator color={colors.onPrimary} size="small" />
                  ) : (
                    t('wordChain.hintSend')
                  )}
                </DialogButton>
              </View>
            </View>
          ))}
        </ScrollView>
      </Dialog>
    );
  }

  return (
    <Dialog
      visible
      onClose={onClose}
      icon={WORD_CHAIN_ICONS.hint}
      title={t('wordChain.hintTitle')}
      showClose
      avoidKeyboard={false}
      footer={
        <>
          <DialogButton onPress={onClose}>{t('common.cancel')}</DialogButton>
          <DialogButton
            variant="green"
            disabled={buying || !canAfford || state?.requiredSyllable == null}
            onPress={() => void buy()}
          >
            {buying ? (
              <ActivityIndicator color={colors.onPrimary} size="small" />
            ) : (
              <Text className="text-sm" style={{ color: colors.onPrimary }}>
                <Trans
                  i18nKey="wordChain.hintBuy"
                  values={{ price: formatKen(price) }}
                  components={{ ken: <WordChainKen tone="plain" color={colors.onPrimary} /> }}
                />
              </Text>
            )}
          </DialogButton>
        </>
      }
    >
      <View style={{ gap: 8 }}>
        <Text className="text-sm leading-relaxed" style={{ color: 'rgba(0,0,0,0.8)' }}>
          <Trans
            i18nKey="wordChain.hintIntro"
            values={{ syllable: state?.requiredSyllable ?? '', price: formatKen(price) }}
            components={KEN_PILL}
          />
        </Text>
        <Text
          className="text-sm leading-relaxed"
          style={{ color: canAfford ? 'rgba(0,0,0,0.54)' : ERROR_COLOR }}
        >
          {canAfford ? (
            <Trans
              i18nKey="wordChain.hintBalance"
              values={{ value: formatKen(ken ?? 0) }}
              components={KEN_PILL}
            />
          ) : (
            t('wordChain.hintKenShort')
          )}
        </Text>
        <Pressable
          accessibilityRole="checkbox"
          accessibilityState={{ checked: autoSend }}
          onPress={() => setAutoSend(!autoSend)}
          className="flex-row items-start gap-2 rounded-md px-3 py-2"
          style={{ backgroundColor: 'rgba(0,0,0,0.05)' }}
        >
          <View
            className="mt-0.5 h-5 w-5 items-center justify-center rounded"
            style={{
              borderWidth: 2,
              borderColor: autoSend ? colors.primary : 'rgba(0,0,0,0.38)',
              backgroundColor: autoSend ? colors.primary : 'transparent',
            }}
          >
            {autoSend && <Text className="text-xs font-bold text-white">✓</Text>}
          </View>
          <View className="flex-1">
            <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
              {t('wordChain.hintAutoSend')}
            </Text>
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
              {t('wordChain.hintAutoSendHelp')}
            </Text>
          </View>
        </Pressable>
      </View>
    </Dialog>
  );
}
