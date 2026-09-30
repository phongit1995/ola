import { useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { DateSeparator, FullScreenOverlay, ScreenHeader } from '@components';
import { useChatWallpaperStyle, useStickyScroll } from '@hooks';
import { BUBBLE_WALLPAPER, buildWordChainFeed } from '@lib';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import {
  remainingGuesses,
  sessionMessages,
} from '@ola/shared/stores/word-chain/wordChainHelpers';
import { WordChainMessageRow } from './WordChainMessageRow';
import { WordChainComposer } from './WordChainComposer';
import { WordChainLeaderboardDialog } from './WordChainLeaderboardDialog';
import { WordChainLookupDialog } from './WordChainLookupDialog';
import { WordChainRulesDialog } from './WordChainRulesDialog';

const LOAD_MORE_AT_TOP_PX = 80;

type WordChainDialog = 'leaderboard' | 'lookup' | 'rules';

interface WordChainViewProps {
  visible: boolean;
  onClose: () => void;
}

function HeaderButton({
  label,
  onClick,
  children,
}: {
  label: string;
  onClick: () => void;
  children: ReactNode;
}) {
  return (
    <button
      type="button"
      aria-label={label}
      title={label}
      onClick={onClick}
      className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
    >
      <svg
        viewBox="0 0 24 24"
        className="h-5 w-5"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
        aria-hidden="true"
      >
        {children}
      </svg>
    </button>
  );
}

export function WordChainView({ visible, onClose }: WordChainViewProps) {
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

  const messages = useMemo(
    () => sessionMessages(allMessages, state?.sessionId),
    [allMessages, state?.sessionId]
  );
  const feed = useMemo(() => buildWordChainFeed(messages), [messages]);
  const remaining = remainingGuesses(state, guesses);
  const { scrollRef, handleScroll, pin } = useStickyScroll({
    count: messages.length,
    lastId: messages.at(-1)?.id ?? null,
    hasMore,
    loadingMore,
    onLoadMore: loadMoreMessages,
    enabled: visible,
    loadMoreAtTop: LOAD_MORE_AT_TOP_PX,
  });

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={t('wordChain.title')} onBack={onClose} align="center">
        <HeaderButton
          label={t('wordChain.lookupTitle')}
          onClick={() => setDialog('lookup')}
        >
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20V3H6.5A2.5 2.5 0 0 0 4 5.5z" />
          <path d="M4 19.5A2.5 2.5 0 0 0 6.5 22H20v-5" />
        </HeaderButton>
        <HeaderButton
          label={t('wordChain.leaderboardTitle')}
          onClick={() => setDialog('leaderboard')}
        >
          <path d="M8 21h8M12 17v4M7 4h10v5a5 5 0 0 1-10 0z" />
          <path d="M17 5h3v2a3 3 0 0 1-3 3M7 5H4v2a3 3 0 0 0 3 3" />
        </HeaderButton>
        <HeaderButton
          label={t('wordChain.rulesTitle')}
          onClick={() => setDialog('rules')}
        >
          <circle cx="12" cy="12" r="10" />
          <path d="M9.1 9a3 3 0 0 1 5.8 1c0 2-3 3-3 3M12 17h.01" />
        </HeaderButton>
      </ScreenHeader>

      <div className="flex shrink-0 items-center gap-3 border-b border-black/12 bg-white px-4 py-2">
        <span className="min-w-0 flex-1">
          <span className="block text-xs text-black/45">
            {t('wordChain.currentWord')}
          </span>
          <span className="block truncate text-lg font-semibold text-black/87">
            {state?.word ?? ''}
          </span>
        </span>
        <span className="flex shrink-0 flex-col items-end gap-1">
          <span className="rounded-full bg-ola-primary-light px-3 py-0.5 text-sm font-semibold text-ola-primary-ink tabular-nums">
            {t('wordChain.points', { value: points })}
          </span>
          <span
            className={`text-xs tabular-nums ${
              remaining === 0 ? 'font-medium text-ola-error' : 'text-black/45'
            }`}
          >
            {t('wordChain.guessesBadge', {
              value: remaining,
              limit: state?.guessLimit ?? 0,
            })}
          </span>
        </span>
      </div>

      <div
        ref={scrollRef}
        onScroll={handleScroll}
        style={wallpaperStyle}
        className={`flex flex-1 flex-col gap-3 overflow-y-auto p-3 ${BUBBLE_WALLPAPER}`}
      >
        {loadingMore && (
          <div className="shrink-0 py-1 text-center text-xs text-black/40">
            {t('common.loading')}
          </div>
        )}
        {feed.length === 0 && (
          <p className="py-6 text-center text-sm text-black/45">
            {t('wordChain.empty')}
          </p>
        )}
        {feed.map((item) =>
          item.kind === 'date' ? (
            <DateSeparator key={item.key} iso={item.createdAt} />
          ) : (
            <WordChainMessageRow
              key={item.key}
              item={item}
              isOwn={item.message.senderId === currentUserId}
            />
          )
        )}
      </div>

      <WordChainComposer
        syllable={state?.requiredSyllable}
        locked={remaining === 0}
        onBeforeSend={pin}
        onSend={sendMove}
      />

      <WordChainLeaderboardDialog
        open={dialog === 'leaderboard'}
        onClose={() => setDialog(null)}
      />
      {dialog === 'lookup' && (
        <WordChainLookupDialog open onClose={() => setDialog(null)} />
      )}
      <WordChainRulesDialog
        open={dialog === 'rules'}
        onClose={() => setDialog(null)}
      />
    </FullScreenOverlay>
  );
}
