import { useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Dialog, DialogButton, Spinner } from '@components';
import {
  formatKen,
  lastSyllable,
  toast,
  wordChainHintErrorText,
  wordChainMoveErrorText,
} from '@lib';
import type { WordChainHint } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useWordChainPrefsStore } from '@ola/shared/stores/word-chain/wordChainPrefsStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainHintIcon } from './WordChainHintIcon';
import { WordChainKen } from './WordChainKen';

interface WordChainHintDialogProps {
  onClose: () => void;
  onSend: (word: string) => Promise<unknown>;
}

const HINT_DIALOG_ICON = (
  <WordChainHintIcon className="h-6 w-6 text-amber-500" />
);

const KEN_PILL = { ken: <WordChainKen /> };

const KEN_PLAIN = { ken: <WordChainKen tone="plain" /> };

export function WordChainHintDialog({
  onClose,
  onSend,
}: WordChainHintDialogProps) {
  const { t } = useTranslation();
  const state = useWordChainStore((store) => store.state);
  const price = useWordChainStore((store) => store.hintPrice);
  const buyHint = useWordChainStore((store) => store.buyHint);
  const ken = useAuthStore((store) => store.user?.ken);
  const autoSend = useWordChainPrefsStore((store) => store.hintAutoSend);
  const setAutoSend = useWordChainPrefsStore((store) => store.setHintAutoSend);
  const [hint, setHint] = useState<WordChainHint | null>(null);
  const [buying, setBuying] = useState(false);
  const [sendingWord, setSendingWord] = useState<string | null>(null);
  const canAfford = ken == null || ken >= price;

  async function send(word: string) {
    setSendingWord(word);
    try {
      await onSend(word);
      onClose();
    } catch (error) {
      toast.error(wordChainMoveErrorText(t, error));
      setSendingWord(null);
    }
  }

  async function buy() {
    setBuying(true);
    try {
      const result = await buyHint();
      setHint(result);
      if (autoSend) await send(result.hints[0]!);
    } catch (error) {
      toast.error(wordChainHintErrorText(t, error));
    } finally {
      setBuying(false);
    }
  }

  if (hint != null) {
    const stale =
      state == null ||
      state.sessionId !== hint.sessionId ||
      state.turn !== hint.turn;
    return (
      <Dialog
        open
        onClose={onClose}
        icon={HINT_DIALOG_ICON}
        title={t('wordChain.hintListTitle', {
          syllable: lastSyllable(hint.word),
        })}
        showClose
      >
        <p className={stale ? 'text-ola-error' : 'text-black/54'}>
          {stale ? (
            t('wordChain.hintStale')
          ) : (
            <Trans
              i18nKey="wordChain.hintListHelp"
              values={{ price: formatKen(hint.price) }}
              components={KEN_PILL}
            />
          )}
        </p>
        <ul className="mt-1 flex flex-col divide-y divide-black/8">
          {hint.hints.map((word) => (
            <li key={word} className="flex items-center gap-3 py-2">
              <span className="min-w-0 flex-1 truncate text-base font-semibold text-black/87">
                {word}
              </span>
              <DialogButton
                variant="green"
                className="flex flex-none items-center justify-center px-4"
                disabled={stale || sendingWord != null}
                onClick={() => void send(word)}
              >
                {sendingWord === word ? (
                  <Spinner size={16} />
                ) : (
                  t('wordChain.hintSend')
                )}
              </DialogButton>
            </li>
          ))}
        </ul>
      </Dialog>
    );
  }

  return (
    <Dialog
      open
      onClose={onClose}
      icon={HINT_DIALOG_ICON}
      title={t('wordChain.hintTitle')}
      showClose
      footer={
        <>
          <DialogButton onClick={onClose}>{t('common.cancel')}</DialogButton>
          <DialogButton
            variant="green"
            className="flex items-center justify-center"
            disabled={buying || !canAfford || state?.requiredSyllable == null}
            onClick={() => void buy()}
          >
            {buying ? (
              <Spinner size={16} />
            ) : (
              <Trans
                i18nKey="wordChain.hintBuy"
                values={{ price: formatKen(price) }}
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
            i18nKey="wordChain.hintIntro"
            values={{
              syllable: state?.requiredSyllable ?? '',
              price: formatKen(price),
            }}
            components={KEN_PILL}
          />
        </p>
        <p className={canAfford ? 'text-black/54' : 'text-ola-error'}>
          {canAfford ? (
            <Trans
              i18nKey="wordChain.hintBalance"
              values={{ value: formatKen(ken ?? 0) }}
              components={KEN_PILL}
            />
          ) : (
            t('wordChain.hintKenShort')
          )}
        </p>
        <label className="flex cursor-pointer items-start gap-2 rounded-md bg-black/5 px-3 py-2">
          <input
            type="checkbox"
            checked={autoSend}
            onChange={(event) => setAutoSend(event.target.checked)}
            className="mt-1 h-4 w-4 shrink-0 accent-ola-primary"
          />
          <span className="flex flex-col">
            <span className="font-medium text-black/87">
              {t('wordChain.hintAutoSend')}
            </span>
            <span className="text-xs text-black/54">
              {t('wordChain.hintAutoSendHelp')}
            </span>
          </span>
        </label>
      </div>
    </Dialog>
  );
}
