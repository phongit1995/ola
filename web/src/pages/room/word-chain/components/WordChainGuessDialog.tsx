import { useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner } from '@components';
import {
  formatKen,
  isSameWordChainTurn,
  remainingGuesses,
  toast,
  wordChainGuessErrorText,
} from '@lib';
import kenIcon from '@/assets/icons/apps/ken.png';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainKen } from './WordChainKen';

const GUESS_DIALOG_ICON = (
  <img src={kenIcon} alt="" className="h-6 w-6 object-contain" />
);

const KEN_PILL = { ken: <WordChainKen /> };

const KEN_PLAIN = { ken: <WordChainKen tone="plain" /> };

export function WordChainGuessDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
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
      toast.success(t('wordChain.guessBought', { count, word }));
      onClose();
    } catch (error) {
      toast.error(wordChainGuessErrorText(t, error));
      setBuying(false);
    }
  }

  if (settled) {
    return (
      <Dialog
        open
        onClose={onClose}
        icon={GUESS_DIALOG_ICON}
        title={t('wordChain.guessTitle')}
        footer={
          <DialogButton variant="green" onClick={onClose}>
            {t('wordChain.guessGotIt')}
          </DialogButton>
        }
      >
        <p className="text-black/80">
          {stale ? t('wordChain.guessStale') : t('wordChain.guessStillLeft')}
        </p>
      </Dialog>
    );
  }

  return (
    <Dialog
      open
      onClose={onClose}
      icon={GUESS_DIALOG_ICON}
      title={t('wordChain.guessTitle')}
      showClose
      footer={
        <>
          <DialogButton onClick={onClose}>{t('common.cancel')}</DialogButton>
          <DialogButton
            variant="green"
            className="flex items-center justify-center"
            disabled={buying || !canAfford}
            onClick={() => void buy()}
          >
            {buying ? (
              <Spinner size={16} />
            ) : (
              <Trans
                i18nKey="wordChain.guessBuy"
                values={{ count, price: formatKen(price) }}
                components={KEN_PLAIN}
              />
            )}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col gap-2">
        <p className="text-black/80">
          <Trans
            i18nKey="wordChain.guessIntro"
            values={{ word, count, price: formatKen(price) }}
            components={KEN_PILL}
          />
        </p>
        <p className="text-black/54">{t('wordChain.guessOnlyThisWord')}</p>
        <p className={canAfford ? 'text-black/54' : 'text-ola-error'}>
          {canAfford ? (
            <Trans
              i18nKey="wordChain.hintBalance"
              values={{ value: formatKen(ken ?? 0) }}
              components={KEN_PILL}
            />
          ) : (
            t('wordChain.guessKenShort')
          )}
        </p>
      </div>
    </Dialog>
  );
}
