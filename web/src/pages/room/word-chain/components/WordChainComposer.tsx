import { useRef, useState, type FormEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import { WORD_CHAIN_MOVE_MAX_LENGTH } from '@constants';
import { toast, wordChainMoveErrorText } from '@lib';
import { WordChainHintIcon } from './WordChainHintIcon';

interface WordChainComposerProps {
  syllable?: string;
  lockedHint?: string;
  onSend: (content: string) => Promise<unknown>;
  onHint: () => void;
}

export function WordChainComposer({
  syllable,
  lockedHint,
  onSend,
  onHint,
}: WordChainComposerProps) {
  const { t } = useTranslation();
  const inputRef = useRef<HTMLInputElement>(null);
  const [text, setText] = useState('');
  const [sending, setSending] = useState(false);
  const content = text.trim();
  const locked = lockedHint != null;

  async function submit(event: FormEvent) {
    event.preventDefault();
    if (content === '' || sending || locked) return;
    setSending(true);
    try {
      await onSend(content);
      setText((current) => (current.trim() === content ? '' : current));
    } catch (error) {
      toast.error(wordChainMoveErrorText(t, error));
    } finally {
      setSending(false);
      inputRef.current?.focus();
    }
  }

  return (
    <form
      onSubmit={submit}
      className="flex shrink-0 items-center gap-2 bg-white px-3 py-2"
    >
      <input
        ref={inputRef}
        value={text}
        aria-label={t('wordChain.inputLabel')}
        onChange={(event) => setText(event.target.value)}
        maxLength={WORD_CHAIN_MOVE_MAX_LENGTH}
        disabled={locked}
        placeholder={
          lockedHint ??
          (syllable != null && syllable !== ''
            ? t('wordChain.inputHint', { syllable })
            : t('wordChain.inputHintEmpty'))
        }
        autoComplete="off"
        autoCapitalize="off"
        spellCheck={false}
        enterKeyHint="send"
        className="min-w-0 flex-1 rounded-full bg-black/5 px-4 py-2 text-base text-black/87 outline-none placeholder:text-black/35 focus:ring-2 focus:ring-ola-primary/40 disabled:opacity-60"
      />
      <button
        type="button"
        aria-label={t('wordChain.hint')}
        title={t('wordChain.hint')}
        onClick={onHint}
        disabled={sending || locked}
        className="-my-0.5 flex h-11 w-11 shrink-0 items-center justify-center transition-transform hover:scale-105 active:scale-95 disabled:opacity-50 disabled:hover:scale-100"
      >
        <WordChainHintIcon className="h-11 w-11" />
      </button>
      <button
        type="submit"
        disabled={content === '' || sending || locked}
        className="flex h-10 min-w-16 items-center justify-center rounded-full bg-ola-primary px-4 text-sm font-medium text-ola-on-primary disabled:opacity-50"
      >
        {sending ? <Spinner size={18} /> : t('wordChain.send')}
      </button>
    </form>
  );
}
