import { useTranslation } from 'react-i18next';
import type { WordChainState } from '@app-types';
import { WordChainIcon } from './WordChainIcon';

export function WordChainBoard({ state, remaining, onLookup }: { state: WordChainState | null; remaining: number; onLookup: () => void }) {
  const { t } = useTranslation();
  const syllables = state?.word?.split(' ') ?? [];
  const limit = state?.guessLimit ?? 3;
  return (
    <section aria-label={t('wordChain.currentWord')} className="shrink-0 border-b border-ola-primary/15 bg-white px-4 pb-3">
      <div className="rounded-2xl border border-ola-primary/20 bg-ola-primary-light px-4 pt-3 pb-2.5">
        <div className="flex items-center justify-between gap-2">
          <p className="text-[11px] font-semibold tracking-[0.12em] text-ola-primary-darker uppercase">{t('wordChain.currentWord')}</p>
          <button type="button" onClick={onLookup} aria-label={t('wordChain.lookupCurrentWord')} className="-mr-1 rounded-lg p-1.5 text-ola-primary-dark hover:bg-ola-primary/10 focus-visible:outline-2 focus-visible:outline-ola-primary"><WordChainIcon name="book" className="h-4 w-4" /></button>
        </div>
        <p aria-live="polite" aria-atomic="true" className="my-1 flex flex-wrap items-center justify-center gap-2 font-game text-4xl leading-tight text-ola-primary-darker">
          {syllables.map((syllable, index) => <span key={`${index}-${syllable}`} className={index === syllables.length - 1 ? 'rounded-xl bg-white px-3 py-1 shadow-[0_3px_0_var(--color-ola-primary)]' : 'px-1 py-1'}>{syllable}</span>)}
        </p>
        <div className="mt-3 flex flex-wrap items-center justify-between gap-x-3 gap-y-1.5 border-t border-ola-primary/15 pt-2.5 text-xs">
          <span className="flex items-center gap-1.5 text-black/60"><WordChainIcon name="arrow" className="h-3.5 w-3.5 text-ola-primary-dark" />{t('wordChain.startWith')} <strong className="text-ola-primary-darker">{state?.requiredSyllable}</strong></span>
          <span aria-live="polite" className={`flex items-center gap-1.5 ${remaining === 0 ? 'text-ola-error' : 'text-black/60'}`}>
            <span aria-hidden="true" className="flex gap-1">{Array.from({ length: limit }, (_, index) => <span key={index} className={`h-1.5 w-1.5 rounded-full ${index < remaining ? 'bg-ola-primary-dark' : 'bg-black/15'}`} />)}</span>
            {t('wordChain.guessesBadge', { value: remaining, limit })}
          </span>
        </div>
      </div>
    </section>
  );
}