import { memo, type ReactNode } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { VipAvatar } from '@components';
import { WORD_CHAIN_MESSAGE_TYPE, WORD_CHAIN_SENDER_TYPE } from '@constants';
import wordChainBotIcon from '@/assets/icons/word-chain/bot-06.png';
import {
  bubbleSurface,
  formatClockHM,
  lastSyllable,
  wordChainGuessesText,
  wordChainWrongReason,
} from '@lib';
import type { WordChainFeedMessage, WordChainMessage } from '@app-types';
import { WordChainStatusIcon } from './WordChainStatusIcon';
import {
  resolveWordChainStatus,
  type WordChainMoveStatus,
} from './wordChainStatus';

interface WordChainMessageRowProps {
  item: WordChainFeedMessage;
  isOwn: boolean;
  onWordInfo: (word: string) => void;
}

function WordInfoButton({
  word,
  onWordInfo,
}: {
  word: string;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  const label = t('wordChain.wordInfo', { word });
  return (
    <button
      type="button"
      aria-label={label}
      title={label}
      onClick={() => onWordInfo(word)}
      className="relative -mx-0.5 flex h-5 w-5 shrink-0 items-center justify-center self-center rounded-full text-black/45 transition-colors after:absolute after:-inset-2 after:content-[''] hover:text-ola-primary-ink"
    >
      <svg
        viewBox="0 0 24 24"
        className="h-full w-full"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        aria-hidden="true"
      >
        <circle cx="12" cy="12" r="10" />
        <path d="M12 11v5.5M12 7.5h.01" />
      </svg>
    </button>
  );
}

function ReplyQuote({ message }: { message: WordChainMessage }) {
  return (
    <span className="mb-1.5 block w-full rounded border-l-2 border-ola-primary bg-black/5 py-0.5 pl-2 pr-1">
      <span className="block truncate text-xs font-semibold text-black/60">
        @{message.senderName}
      </span>
      <span className="line-clamp-2 text-xs text-black/45">
        {message.content}
      </span>
    </span>
  );
}

function BotReply({
  replyTo,
  status,
  time,
  children,
}: {
  replyTo?: WordChainMessage;
  status: WordChainMoveStatus;
  time: string;
  children: ReactNode;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex w-full flex-col gap-0.5 self-start">
      <span className="ml-10 flex max-w-[85%] items-baseline gap-1.5 text-sm font-semibold text-ola-primary-ink">
        <span className="truncate">{t('wordChain.bot')}</span>
        <span className="shrink-0 text-xs font-normal text-black/35">
          {time}
        </span>
      </span>
      <div className="flex max-w-[85%] items-start gap-2">
        <img
          src={wordChainBotIcon}
          alt=""
          className="h-8 w-8 shrink-0 object-contain"
        />
        <div
          className={`w-fit max-w-full break-words rounded-2xl px-3.5 py-2 text-sm ${bubbleSurface(
            false,
            false
          )}`}
        >
          {replyTo != null && <ReplyQuote message={replyTo} />}
          <span className="flex items-start gap-1.5 text-black/80">
            <WordChainStatusIcon
              status={status}
              className="h-5 w-5"
              decorative
            />
            <span className="min-w-0">{children}</span>
          </span>
        </div>
      </div>
    </div>
  );
}

function NoticeCard({ message }: { message: WordChainMessage }) {
  const { t } = useTranslation();
  const isSession = message.type === WORD_CHAIN_MESSAGE_TYPE.sessionStarted;
  return (
    <div className="mx-auto flex w-fit max-w-[85%] flex-col items-center gap-0.5 rounded-xl bg-white/90 px-4 py-2 text-center shadow-sm ring-1 ring-black/5">
      <span className="text-sm font-semibold text-ola-primary-ink">
        {isSession ? t('wordChain.sessionStarted') : t('wordChain.gameStarted')}
      </span>
      <span className="text-sm text-black/70">
        {isSession
          ? t('wordChain.startWord')
          : `${t('wordChain.currentWord')}:`}{' '}
        <strong className="text-base text-black/87">{message.word}</strong>
      </span>
    </div>
  );
}

function BotMessage({
  message,
  replyTo,
}: {
  message: WordChainMessage;
  replyTo?: WordChainMessage;
}) {
  const { t } = useTranslation();
  const time = formatClockHM(message.createdAt);

  if (message.type === WORD_CHAIN_MESSAGE_TYPE.wrongAnswer) {
    return (
      <BotReply
        replyTo={replyTo}
        status={resolveWordChainStatus(message) ?? 'error'}
        time={time}
      >
        <strong className="text-black/87">
          {wordChainWrongReason(t, message)}
        </strong>{' '}
        {wordChainGuessesText(t, message.remainingGuesses ?? 0)}
      </BotReply>
    );
  }

  if (message.type === WORD_CHAIN_MESSAGE_TYPE.win) {
    const winner = replyTo?.senderName;
    return (
      <BotReply replyTo={replyTo} status="win" time={time}>
        {winner != null && winner !== '' ? (
          <Trans
            i18nKey="wordChain.winTitle"
            values={{ name: winner }}
            components={{ mention: <strong className="text-black/87" /> }}
          />
        ) : (
          t('wordChain.winTitleUnknown')
        )}{' '}
        {t('wordChain.winBody', { syllable: lastSyllable(message.word) })}
      </BotReply>
    );
  }

  return <NoticeCard message={message} />;
}

function MoveBubble({
  message,
  isOwn,
  onWordInfo,
}: {
  message: WordChainMessage;
  isOwn: boolean;
  onWordInfo: (word: string) => void;
}) {
  const status = resolveWordChainStatus(message);
  const hasReaction = status != null || Boolean(message.reaction);
  const isValidWord = status === 'correct' || status === 'win';

  return (
    <div
      className={`flex w-full flex-col gap-0.5 ${
        isOwn ? 'items-end' : 'items-start'
      } ${hasReaction ? 'pb-3' : ''}`}
    >
      <span
        className={`flex max-w-[80%] items-baseline gap-1.5 text-sm font-semibold text-black/72 ${
          isOwn ? 'mr-10 flex-row-reverse' : 'ml-10'
        }`}
      >
        <span className="truncate">{message.senderName}</span>
        <span className="shrink-0 text-xs font-normal text-black/35">
          {formatClockHM(message.createdAt)}
        </span>
      </span>
      <div
        className={`flex max-w-[80%] items-start gap-2 ${
          isOwn ? 'flex-row-reverse' : ''
        }`}
      >
        <VipAvatar typeId={message.senderVipTypeId} className="h-8 w-8" />
        <div className="relative">
          <div
            className={`w-fit max-w-full rounded-2xl px-3.5 py-2 text-base break-words ${bubbleSurface(
              isOwn,
              false
            )}`}
          >
            {message.content}
          </div>
          {hasReaction && (
            <span
              className={`absolute -bottom-3 flex h-7 min-w-7 items-center justify-center ${
                isOwn ? '-left-2' : '-right-2'
              } ${
                status == null
                  ? 'rounded-full bg-white px-1 text-sm shadow-[0_1px_3px_rgba(0,0,0,0.15)]'
                  : ''
              }`}
            >
              {status != null ? (
                <WordChainStatusIcon status={status} />
              ) : (
                message.reaction
              )}
            </span>
          )}
        </div>
        {isValidWord && (
          <WordInfoButton
            word={message.word || message.content}
            onWordInfo={onWordInfo}
          />
        )}
      </div>
    </div>
  );
}

function WordChainMessageRowComponent({
  item,
  isOwn,
  onWordInfo,
}: WordChainMessageRowProps) {
  if (item.message.senderType === WORD_CHAIN_SENDER_TYPE.bot) {
    return <BotMessage message={item.message} replyTo={item.replyTo} />;
  }
  return (
    <MoveBubble message={item.message} isOwn={isOwn} onWordInfo={onWordInfo} />
  );
}

export const WordChainMessageRow = memo(WordChainMessageRowComponent);
