import { useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { ActivityIndicator, Text, View } from 'react-native';
import {
  formatKen,
  isSameWordChainTurn,
  remainingGuesses,
  wordChainGuessErrorText,
} from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { WordChainKen } from './WordChainKen';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const KEN_PILL = { ken: <WordChainKen /> };
const ERROR_COLOR = '#e34545';

export function WordChainGuessDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const pushToast = useToastStore((store) => store.push);
  const state = useWordChainStore((store) => store.state);
  const guesses = useWordChainStore((store) => store.guesses);
  const price = useWordChainStore((store) => store.guessPrice);
  const count = useWordChainStore((store) => store.guessPackSize);
  const buyGuesses = useWordChainStore((store) => store.buyGuesses);
  const ken = useAuthStore((store) => store.user?.ken);
  const [target] = useState(state);
  const [buying, setBuying] = useState(false);
  const stale = !isSameWordChainTurn(target, state);
  const settled = !buying && (stale || remainingGuesses(state, guesses) > 0);
  const canAfford = ken == null || ken >= price;
  const word = target?.word ?? '';

  async function buy() {
    if (target?.sessionId == null) return;
    setBuying(true);
    try {
      await buyGuesses({ sessionId: target.sessionId, turn: target.turn, price });
      pushToast('success', t('wordChain.guessBought', { count, word }));
      onClose();
    } catch (error) {
      pushToast('error', wordChainGuessErrorText(t, error));
      setBuying(false);
    }
  }

  if (settled) {
    return (
      <Dialog
        visible
        onClose={onClose}
        icon={WORD_CHAIN_ICONS.ken}
        title={t('wordChain.guessTitle')}
        avoidKeyboard={false}
        footer={
          <DialogButton variant="green" onPress={onClose}>
            {t('wordChain.guessGotIt')}
          </DialogButton>
        }
      >
        <Text className="text-sm leading-relaxed" style={{ color: 'rgba(0,0,0,0.8)' }}>
          {stale ? t('wordChain.guessStale') : t('wordChain.guessStillLeft')}
        </Text>
      </Dialog>
    );
  }

  return (
    <Dialog
      visible
      onClose={onClose}
      icon={WORD_CHAIN_ICONS.ken}
      title={t('wordChain.guessTitle')}
      showClose
      avoidKeyboard={false}
      footer={
        <>
          <DialogButton onPress={onClose}>{t('common.cancel')}</DialogButton>
          <DialogButton
            variant="green"
            disabled={buying || !canAfford}
            onPress={() => void buy()}
          >
            {buying ? (
              <ActivityIndicator color={colors.onPrimary} size="small" />
            ) : (
              <Text className="text-sm" style={{ color: colors.onPrimary }}>
                <Trans
                  i18nKey="wordChain.guessBuy"
                  values={{ count, price: formatKen(price) }}
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
            i18nKey="wordChain.guessIntro"
            values={{ word, count, price: formatKen(price) }}
            components={KEN_PILL}
          />
        </Text>
        <Text className="text-sm leading-relaxed" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('wordChain.guessOnlyThisWord')}
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
            t('wordChain.guessKenShort')
          )}
        </Text>
      </View>
    </Dialog>
  );
}
