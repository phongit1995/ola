import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { DateSeparator, FullScreenOverlay, Spinner } from '@components';
import { useChatWallpaperStyle, useStickyScroll } from '@hooks';
import { buildWordChainFeed } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { remainingGuesses, sessionMessages } from '@ola/shared/stores/word-chain/wordChainHelpers';
import { WordChainMessageRow } from './WordChainMessageRow';
import { WordChainComposer } from './WordChainComposer';
import { WordChainLeaderboardDialog } from './WordChainLeaderboardDialog';
import { WordChainLookupDialog } from './WordChainLookupDialog';
import { WordChainRulesDialog } from './WordChainRulesDialog';
import { WordChainBoard } from './WordChainBoard';
import { WordChainIcon } from './WordChainIcon';

const TOOLS = [
  { id: 'lookup', icon: 'book', label: 'wordChain.lookupTitle' },
  { id: 'leaderboard', icon: 'trophy', label: 'wordChain.leaderboardTitle' },
  { id: 'rules', icon: 'help', label: 'wordChain.rulesTitle' },
] as const;
type WordChainDialog = (typeof TOOLS)[number]['id'];

export function WordChainView({ visible, onClose }: { visible: boolean; onClose: () => void }) {
  const { t } = useTranslation();
  const wallpaperStyle = useChatWallpaperStyle();
  const state = useWordChainStore((store) => store.state);
  const points = useWordChainStore((store) => store.points);
  const guesses = useWordChainStore((store) => store.guesses);
  const allMessages = useWordChainStore((store) => store.messages);
  const hasMore = useWordChainStore((store) => store.hasMore);
  const loadingMore = useWordChainStore((store) => store.loadingMore);
  const loadMoreMessages = useWordChainStore((store) => store.loadMoreMessages);
  const sendMove = useWordChainStore((store) => store.sendMove);
  const currentUserId = useAuthStore((store) => store.user?.id) ?? '';
  const [dialog, setDialog] = useState<WordChainDialog | null>(null);
  const [pinned, setPinned] = useState(true);
  const messages = useMemo(() => sessionMessages(allMessages, state?.sessionId), [allMessages, state?.sessionId]);
  const feed = useMemo(() => buildWordChainFeed(messages), [messages]);
  const remaining = remainingGuesses(state, guesses);
  const { scrollRef, handleScroll, pin } = useStickyScroll({ count: messages.length, lastId: messages.at(-1)?.id ?? null, hasMore, loadingMore, onLoadMore: loadMoreMessages, enabled: visible, loadMoreAtTop: 80, onStickyChange: setPinned });

  function jumpToLatest() {
    pin();
    const element = scrollRef.current;
    if (element != null) element.scrollTop = element.scrollHeight;
  }

  return (
    <FullScreenOverlay position="absolute" className="bg-[#f7f8f5]">
      <header className="flex shrink-0 items-center gap-2 bg-white px-3 pt-3 pb-1">
        <button type="button" aria-label={t('chat.back')} onClick={onClose} className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl border border-black/8 text-black/65 hover:bg-black/5 focus-visible:outline-2 focus-visible:outline-ola-primary"><WordChainIcon name="back" /></button>
        <div className="min-w-0 flex-1 pl-1">
          <h1 className="font-game text-2xl leading-none text-ola-primary-darker">{t('wordChain.title')}</h1>
          <p className="mt-1 text-[11px] text-black/50">{t('wordChain.roomSubtitle')}</p>
        </div>
        <button type="button" onClick={() => setDialog('leaderboard')} aria-label={`${t('wordChain.leaderboardTitle')}, ${t('wordChain.points', { value: points })}`} className="flex shrink-0 items-center gap-1.5 rounded-xl bg-amber-50 px-2.5 py-2 text-sm font-semibold text-amber-800 ring-1 ring-amber-200/60 hover:bg-amber-100">
          <WordChainIcon name="trophy" className="h-4 w-4" /><span className="tabular-nums">{t('wordChain.points', { value: points })}</span>
        </button>
      </header>
      <nav aria-label={t('wordChain.tools')} className="grid shrink-0 grid-cols-3 gap-1 bg-white px-4 py-2">
        {TOOLS.map((tool) => <button key={tool.id} type="button" onClick={() => setDialog(tool.id)} className="flex min-h-10 items-center justify-center gap-1.5 rounded-xl px-1 text-xs font-medium text-black/60 hover:bg-ola-primary-light hover:text-ola-primary-darker focus-visible:outline-2 focus-visible:outline-ola-primary"><WordChainIcon name={tool.icon} className="h-4 w-4 shrink-0" />{t(tool.label)}</button>)}
      </nav>
      <WordChainBoard state={state} remaining={remaining} onLookup={() => setDialog('lookup')} />
      <div className="relative flex min-h-0 flex-1 flex-col">
        <div ref={scrollRef} onScroll={handleScroll} style={wallpaperStyle} aria-label={t('wordChain.history')} className="flex min-h-0 flex-1 flex-col gap-3 overflow-y-auto overscroll-contain px-4 py-4">
          {hasMore && <button type="button" disabled={loadingMore} onClick={() => void loadMoreMessages()} className="mx-auto flex shrink-0 items-center gap-2 rounded-full bg-white px-3 py-1.5 text-xs text-black/55 ring-1 ring-black/5 disabled:opacity-60">{loadingMore && <Spinner size={12} />}{t(loadingMore ? 'common.loading' : 'wordChain.loadEarlier')}</button>}
          {feed.length === 0 && <div className="m-auto max-w-60 py-6 text-center"><WordChainIcon name="link" className="mx-auto mb-3 h-9 w-9 text-ola-primary-dark" /><p className="font-game text-xl text-ola-primary-darker">{t('wordChain.emptyTitle')}</p><p className="mt-1 text-sm leading-relaxed text-black/50">{t('wordChain.emptyHint')}</p></div>}
          {feed.map((item) => item.kind === 'date' ? <DateSeparator key={item.key} iso={item.createdAt} /> : <WordChainMessageRow key={item.key} item={item} isOwn={item.message.senderId === currentUserId} />)}
        </div>
        {!pinned && <button type="button" onClick={jumpToLatest} className="absolute right-4 bottom-3 flex items-center gap-1.5 rounded-full border border-ola-primary/20 bg-white px-3 py-2 text-xs font-medium text-ola-primary-darker shadow-md">{t('wordChain.latest')}<WordChainIcon name="down" className="h-4 w-4" /></button>}
      </div>
      <WordChainComposer syllable={state?.requiredSyllable} locked={remaining === 0} onBeforeSend={pin} onSend={sendMove} />
      <WordChainLeaderboardDialog open={visible && dialog === 'leaderboard'} onClose={() => setDialog(null)} />
      {visible && dialog === 'lookup' && <WordChainLookupDialog open initialWord={state?.word} onClose={() => setDialog(null)} />}
      <WordChainRulesDialog open={visible && dialog === 'rules'} onClose={() => setDialog(null)} />
    </FullScreenOverlay>
  );
}