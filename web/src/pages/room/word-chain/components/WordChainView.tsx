import { useCallback, useMemo, useState, type ReactNode } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { DateSeparator, FullScreenOverlay, ScreenHeader } from '@components';
import { WORD_CHAIN_INPUT_LOCK_HINT_KEYS } from '@constants';
import { useChatWallpaperStyle, useStickyScroll } from '@hooks';
import {
  BUBBLE_WALLPAPER,
  buildWordChainFeed,
  colorForName,
  remainingGuesses,
  sessionMessages,
  wordChainInputLock,
} from '@lib';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainMessageRow } from './WordChainMessageRow';
import { WordChainRoomIcon } from './WordChainRoomIcon';
import { WordChainComposer } from './WordChainComposer';
import { WordChainHintDialog } from './WordChainHintDialog';
import { HelpIcon, LookupIcon, TrophyIcon } from './WordChainIcons';
import { WordChainLeaderboardDialog } from './WordChainLeaderboardDialog';
import { WordChainLookupDialog } from './WordChainLookupDialog';
import { WordChainRulesDialog } from './WordChainRulesDialog';
import { UserProfileView } from '../../../profile/UserProfileView';

const LOAD_MORE_AT_TOP_PX = 80;

const CURRENT_WORD_COMPONENTS = {
  word: <strong className="text-base font-semibold text-black/87" />,
};

type WordChainDialog = 'hint' | 'leaderboard' | 'lookup' | 'rules';

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
      {children}
    </button>
  );
}

export function WordChainView({ visible, onClose }: WordChainViewProps) {
  const { t } = useTranslation();
  const wallpaperStyle = useChatWallpaperStyle();
  const state = useWordChainStore((store) => store.state);
  const guesses = useWordChainStore((store) => store.guesses);
  const allMessages = useWordChainStore((store) => store.messages);
  const hasMore = useWordChainStore((store) => store.hasMore);
  const loadingMore = useWordChainStore((store) => store.loadingMore);
  const loadMoreMessages = useWordChainStore((store) => store.loadMoreMessages);
  const sendMove = useWordChainStore((store) => store.sendMove);
  const lookup = useWordChainStore((store) => store.lookup);
  const clearLookup = useWordChainStore((store) => store.clearLookup);
  const currentUserId = useAuthStore((store) => store.user?.id) ?? '';
  const [dialog, setDialog] = useState<WordChainDialog | null>(null);
  const [lookupWord, setLookupWord] = useState('');
  const [profileTarget, setProfileTarget] = useState<{
    username: string;
    color: string;
  } | null>(null);

  const openProfile = useCallback((username: string) => {
    setProfileTarget({ username, color: colorForName(username) });
  }, []);

  const openLookup = useCallback(
    (word: string) => {
      clearLookup();
      setLookupWord(word);
      setDialog('lookup');
      if (word !== '') void lookup(word);
    },
    [clearLookup, lookup]
  );

  const messages = useMemo(
    () => sessionMessages(allMessages, state?.sessionId),
    [allMessages, state?.sessionId]
  );
  const feed = useMemo(() => buildWordChainFeed(messages), [messages]);
  const remaining = remainingGuesses(state, guesses);
  const lock = wordChainInputLock(state, guesses, currentUserId);
  const { scrollRef, handleScroll, pin } = useStickyScroll({
    count: messages.length,
    lastId: messages.at(-1)?.id ?? null,
    hasMore,
    loadingMore,
    onLoadMore: loadMoreMessages,
    enabled: visible,
    loadMoreAtTop: LOAD_MORE_AT_TOP_PX,
  });

  const send = useCallback(
    (content: string) => {
      pin();
      return sendMove(content);
    },
    [pin, sendMove]
  );

  const closeDialog = () => setDialog(null);

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader
        title={t('wordChain.title')}
        onBack={onClose}
        align="center"
        left={<WordChainRoomIcon className="h-8 w-8" />}
      >
        <HeaderButton
          label={t('wordChain.lookupTitle')}
          onClick={() => openLookup('')}
        >
          <LookupIcon />
        </HeaderButton>
        <HeaderButton
          label={t('wordChain.leaderboardTitle')}
          onClick={() => setDialog('leaderboard')}
        >
          <TrophyIcon />
        </HeaderButton>
        <HeaderButton
          label={t('wordChain.rulesTitle')}
          onClick={() => setDialog('rules')}
        >
          <HelpIcon />
        </HeaderButton>
      </ScreenHeader>

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
          <div className="flex flex-col items-center gap-2 py-6 text-center">
            <WordChainRoomIcon className="h-16 w-16" />
            <p className="text-sm text-black/45">{t('wordChain.empty')}</p>
          </div>
        )}
        {feed.map((item) =>
          item.kind === 'date' ? (
            <DateSeparator key={item.key} iso={item.createdAt} />
          ) : (
            <WordChainMessageRow
              key={item.key}
              message={item.message}
              replyTo={item.replyTo}
              isOwn={item.message.senderId === currentUserId}
              onWordInfo={openLookup}
              onOpenProfile={openProfile}
            />
          )
        )}
      </div>

      <div className="flex shrink-0 items-baseline gap-3 border-t border-black/12 bg-white px-4 pt-2 text-sm">
        <span className="min-w-0 flex-1 truncate text-black/54">
          <Trans
            i18nKey="wordChain.currentWordLine"
            values={{ word: state?.word ?? '' }}
            components={CURRENT_WORD_COMPONENTS}
          />
        </span>
        <span
          className={`shrink-0 tabular-nums ${
            remaining === 0 ? 'font-medium text-ola-error' : 'text-black/54'
          }`}
        >
          {t('wordChain.guessesBadge', {
            value: remaining,
            limit: state?.guessLimit ?? 0,
          })}
        </span>
      </div>

      <WordChainComposer
        syllable={state?.requiredSyllable}
        lockedHint={
          lock != null ? t(WORD_CHAIN_INPUT_LOCK_HINT_KEYS[lock]) : undefined
        }
        onSend={send}
        onHint={() => setDialog('hint')}
      />

      {dialog === 'hint' && (
        <WordChainHintDialog onClose={closeDialog} onSend={send} />
      )}
      <WordChainLeaderboardDialog
        open={dialog === 'leaderboard'}
        onClose={closeDialog}
      />
      {dialog === 'lookup' && (
        <WordChainLookupDialog initialWord={lookupWord} onClose={closeDialog} />
      )}
      <WordChainRulesDialog open={dialog === 'rules'} onClose={closeDialog} />

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) =>
            setProfileTarget({ username: friend.name, color: friend.color })
          }
        />
      )}
    </FullScreenOverlay>
  );
}
