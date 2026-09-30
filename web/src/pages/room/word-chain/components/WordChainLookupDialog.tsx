import { useState, type FormEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, Spinner } from '@components';
import { WORD_CHAIN_LOOKUP_MAX_LENGTH } from '@constants';
import { toast, wordChainLookupErrorText } from '@lib';
import type { WordChainLookup, WordChainLookupResult } from '@app-types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';

interface WordChainLookupDialogProps {
  open: boolean;
  initialWord?: string;
  onClose: () => void;
}

function LookupResultBlock({ result }: { result: WordChainLookupResult }) {
  const { t } = useTranslation();
  return (
    <section className="flex flex-col gap-2">
      <h3 className="text-xs font-semibold tracking-wide text-black/45 uppercase">
        {result.langName}
      </h3>
      {result.meanings.length > 0 && (
        <ol className="flex list-decimal flex-col gap-1.5 pl-5 text-sm text-black/80">
          {result.meanings.map((meaning, index) => (
            <li key={`${meaning.definition}-${index}`}>
              {meaning.pos != null && meaning.pos !== '' && (
                <span className="mr-1 text-xs font-medium text-ola-primary-ink">
                  {meaning.subPos != null && meaning.subPos !== ''
                    ? `${meaning.pos} · ${meaning.subPos}`
                    : meaning.pos}
                </span>
              )}
              {meaning.definition}
              {meaning.example != null && meaning.example !== '' && (
                <span className="mt-0.5 block text-xs text-black/45 italic">
                  {meaning.example}
                </span>
              )}
            </li>
          ))}
        </ol>
      )}
      {result.translations.length > 0 && (
        <div className="text-sm text-black/70">
          <span className="font-medium text-black/54">
            {t('wordChain.lookupTranslations')}:{' '}
          </span>
          {result.translations
            .map((item) => `${item.translation} (${item.langName})`)
            .join(', ')}
        </div>
      )}
      {result.relations.length > 0 && (
        <div className="flex flex-col gap-1">
          <span className="text-sm font-medium text-black/54">
            {t('wordChain.lookupRelations')}
          </span>
          <div className="flex flex-wrap gap-1">
            {result.relations.map((relation) => (
              <span
                key={`${relation.type}-${relation.word}`}
                title={relation.type}
                className="rounded-full bg-ola-primary-light px-2 py-0.5 text-xs text-black/70"
              >
                {relation.word}
              </span>
            ))}
          </div>
        </div>
      )}
    </section>
  );
}

export function WordChainLookupDialog({
  open,
  initialWord = '',
  onClose,
}: WordChainLookupDialogProps) {
  const { t } = useTranslation();
  const lookup = useWordChainStore((state) => state.lookup);
  const [word, setWord] = useState(initialWord);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<WordChainLookup | null>(null);
  const query = word.trim();

  async function submit(event: FormEvent) {
    event.preventDefault();
    if (query === '' || loading) return;
    setLoading(true);
    try {
      setResult(await lookup(query));
    } catch (error) {
      toast.error(wordChainLookupErrorText(t, error));
    } finally {
      setLoading(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wordChain.lookupTitle')}
      showClose
    >
      <div className="flex flex-col gap-3">
        <form onSubmit={submit} className="flex items-center gap-2">
          <input
            value={word}
            onChange={(event) => setWord(event.target.value)}
            maxLength={WORD_CHAIN_LOOKUP_MAX_LENGTH}
            placeholder={t('wordChain.lookupHint')}
            autoComplete="off"
            autoFocus
            className="min-w-0 flex-1 rounded border border-black/15 px-3 py-2 text-base text-black/87 outline-none focus:border-ola-primary"
          />
          <button
            type="submit"
            disabled={query === '' || loading}
            className="flex h-10 min-w-16 items-center justify-center rounded bg-ola-primary px-3 text-sm font-medium text-ola-on-primary disabled:opacity-50"
          >
            {loading ? <Spinner size={18} /> : t('wordChain.lookupAction')}
          </button>
        </form>
        {result != null && (
          <div className="flex max-h-[55vh] flex-col gap-3 overflow-y-auto">
            <p className="text-base font-semibold text-black/87">
              {result.word}
            </p>
            {result.found ? (
              result.results.map((item, index) => (
                <LookupResultBlock
                  key={`${item.langCode}-${index}`}
                  result={item}
                />
              ))
            ) : (
              <p className="text-sm text-black/54">
                {t('wordChain.lookupNotFound', { word: result.word })}
              </p>
            )}
            <p className="text-right text-xs text-black/35">
              {t('wordChain.lookupSource', { source: result.source })}
            </p>
          </div>
        )}
      </div>
    </Dialog>
  );
}
