import { memo, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { VipAvatar } from '@components';
import { WORD_CHAIN_MESSAGE_TYPE, WORD_CHAIN_SENDER_TYPE } from '@constants';
import {
  bubbleSurface,
  formatClockHM,
  lastSyllable,
  wordChainGuessesText,
  wordChainWrongReason,
} from '@lib';
import type { WordChainFeedMessage, WordChainMessage } from '@app-types';

interface WordChainMessageRowProps {
  item: WordChainFeedMessage;
  isOwn: boolean;
}

function CurrentWordLine({ word }: { word?: string }) {
  const { t } = useTranslation();
  if (word == null || word === '') return null;
  return (
    <span className="text-sm text-black/80">
      {t('wordChain.currentWord')}:{' '}
      <strong className="text-base text-black/87">{word}</strong>
    </span>
  );
}

function BotReply({
  replyTo,
  accent,
  time,
  children,
  footer,
}: {
  replyTo?: WordChainMessage;
  accent: string;
  time: string;
  children: ReactNode;
  footer?: ReactNode;
}) {
  const { t } = useTranslation();
  return (
    <div className="flex w-full max-w-[90%] flex-col gap-1 self-start">
      {replyTo != null && (
        <span className="ml-10 flex min-w-0 items-center gap-1 text-xs text-black/45">
          <span aria-hidden="true">↳</span>
          <span className="shrink-0 font-semibold text-black/60">
            @{replyTo.senderName}
          </span>
          <span className="truncate">{replyTo.content}</span>
        </span>
      )}
      <div className="flex items-start gap-2">
        <span className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full bg-ola-primary-light text-lg">
          🤖
        </span>
        <div className="flex min-w-0 flex-col gap-1">
          <span className="flex items-center gap-1.5 text-sm font-semibold text-ola-primary-ink">
            {t('wordChain.bot')}
            <span className="text-xs font-normal text-black/35">{time}</span>
          </span>
          <div
            className={`rounded-md border-l-4 bg-white px-3 py-2 text-sm text-black/80 shadow-sm ${accent}`}
          >
            {children}
          </div>
          {footer}
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
        accent="border-amber-400"
        time={time}
        footer={<CurrentWordLine word={message.word} />}
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
      <BotReply replyTo={replyTo} accent="border-ola-primary" time={time}>
        <strong className="text-black/87">
          🏆{' '}
          {winner != null && winner !== ''
            ? t('wordChain.winTitle', { name: winner })
            : t('wordChain.winTitleUnknown')}
        </strong>{' '}
        {t('wordChain.winBody', { syllable: lastSyllable(message.word) })}
      </BotReply>
    );
  }

  return <NoticeCard message={message} />;
}

function MoveBubble({
  message,
  isOwn,
}: {
  message: WordChainMessage;
  isOwn: boolean;
}) {
  return (
    <div
      className={`flex w-full flex-col gap-0.5 ${
        isOwn ? 'items-end' : 'items-start'
      }`}
    >
      <span
        className={`flex max-w-[80%] items-center gap-1.5 text-sm font-semibold text-black/72 ${
          isOwn ? 'mr-10' : 'ml-10'
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
          {message.reaction != null && message.reaction !== '' && (
            <span
              className={`absolute -bottom-2 flex h-6 w-6 items-center justify-center rounded-full bg-white text-sm shadow-[0_1px_3px_rgba(0,0,0,0.15)] ${
                isOwn ? '-left-2' : '-right-2'
              }`}
            >
              {message.reaction}
            </span>
          )}
        </div>
      </div>
    </div>
  );
}

function WordChainMessageRowComponent({ item, isOwn }: WordChainMessageRowProps) {
  if (item.message.senderType === WORD_CHAIN_SENDER_TYPE.bot) {
    return <BotMessage message={item.message} replyTo={item.replyTo} />;
  }
  return <MoveBubble message={item.message} isOwn={isOwn} />;
}

export const WordChainMessageRow = memo(WordChainMessageRowComponent);
