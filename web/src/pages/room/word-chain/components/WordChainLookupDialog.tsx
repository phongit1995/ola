import { useState, type FormEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, Spinner } from '@components';
import { WORD_CHAIN_LOOKUP_MAX_LENGTH } from '@constants';
import type { WordChainLookup, WordChainLookupResult } from '@app-types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';

interface WordChainLookupDialogProps {
  initialWord: string;
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
            {t('wordChain.lookupTranslations')}{' '}
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

function LookupResultView({
  result,
  showWord,
}: {
  result: WordChainLookup;
  showWord: boolean;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex max-h-[55vh] flex-col gap-3 overflow-y-auto">
      {showWord && (
        <p className="text-base font-semibold text-black/87">{result.word}</p>
      )}
      {result.found ? (
        result.results.map((item, index) => (
          <LookupResultBlock key={`${item.langCode}-${index}`} result={item} />
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
  );
}

function LookupSearchForm({ initialWord }: { initialWord: string }) {
  const { t } = useTranslation();
  const lookup = useWordChainStore((state) => state.lookup);
  const loading = useWordChainStore((state) => state.lookupLoading);
  const [word, setWord] = useState(initialWord);
  const query = word.trim();

  function submit(event: FormEvent) {
    event.preventDefault();
    if (query === '' || loading) return;
    void lookup(query);
  }

  return (
    <form onSubmit={submit} className="flex items-center gap-2">
      <input
        value={word}
        onChange={(event) => setWord(event.target.value)}
        aria-label={t('wordChain.lookupTitle')}
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
  );
}

export function WordChainLookupDialog({
  initialWord,
  onClose,
}: WordChainLookupDialogProps) {
  const { t } = useTranslation();
  const result = useWordChainStore((state) => state.lookupResult);
  const loading = useWordChainStore((state) => state.lookupLoading);
  const searchable = initialWord === '';

  return (
    <Dialog
      open
      onClose={onClose}
      title={searchable ? t('wordChain.lookupTitle') : initialWord}
      showClose
    >
      <div className="flex flex-col gap-3">
        {searchable && <LookupSearchForm initialWord={initialWord} />}
        {result != null ? (
          <LookupResultView result={result} showWord={searchable} />
        ) : searchable ? null : loading ? (
          <div className="flex justify-center py-6">
            <Spinner size={28} />
          </div>
        ) : (
          <p className="py-4 text-center text-sm text-black/54">
            {t('wordChain.lookupError')}
          </p>
        )}
      </div>
    </Dialog>
  );
}
