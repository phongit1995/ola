import { memo, type ReactNode } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { VipAvatar } from '@components';
import { WORD_CHAIN_MESSAGE_TYPE, WORD_CHAIN_SENDER_TYPE } from '@constants';
import wordChainBotIcon from '@/assets/icons/word-chain/bot-06.webp';
import {
  bubbleSurface,
  formatClockHM,
  lastSyllable,
  wordChainGuessesText,
  wordChainMoveStatus,
  wordChainWrongReason,
} from '@lib';
import type { WordChainMessage, WordChainMoveStatus } from '@app-types';
import { InfoIcon } from './WordChainIcons';
import { WordChainStatusIcon } from './WordChainStatusIcon';

interface WordChainMessageRowProps {
  message: WordChainMessage;
  replyTo?: WordChainMessage;
  isOwn: boolean;
  onWordInfo: (word: string) => void;
  onOpenProfile: (username: string) => void;
}

const WORD_LINE_COMPONENTS = {
  word: <strong className="text-base text-black/87" />,
};

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
      <InfoIcon className="h-full w-full" />
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

function NoticeCard({
  message,
  onWordInfo,
}: {
  message: WordChainMessage;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  const isSession = message.type === WORD_CHAIN_MESSAGE_TYPE.sessionStarted;
  return (
    <div className="mx-auto flex w-fit max-w-[85%] flex-col items-center gap-0.5 rounded-xl bg-white/90 px-4 py-2 text-center shadow-sm ring-1 ring-black/5">
      <span className="text-sm font-semibold text-ola-primary-ink">
        {isSession ? t('wordChain.sessionStarted') : t('wordChain.gameStarted')}
      </span>
      <span className="flex items-center gap-1.5 text-sm text-black/70">
        <span>
          <Trans
            i18nKey={
              isSession
                ? 'wordChain.startWordLine'
                : 'wordChain.currentWordLine'
            }
            values={{ word: message.word ?? '' }}
            components={WORD_LINE_COMPONENTS}
          />
        </span>
        {message.word != null && message.word !== '' && (
          <WordInfoButton word={message.word} onWordInfo={onWordInfo} />
        )}
      </span>
    </div>
  );
}

function BotMessage({
  message,
  replyTo,
  onWordInfo,
}: {
  message: WordChainMessage;
  replyTo?: WordChainMessage;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  const time = formatClockHM(message.createdAt);

  if (message.type === WORD_CHAIN_MESSAGE_TYPE.wrongAnswer) {
    return (
      <BotReply
        replyTo={replyTo}
        status={wordChainMoveStatus(message) ?? 'error'}
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

  return <NoticeCard message={message} onWordInfo={onWordInfo} />;
}

function MoveBubble({
  message,
  isOwn,
  onWordInfo,
  onOpenProfile,
}: {
  message: WordChainMessage;
  isOwn: boolean;
  onWordInfo: (word: string) => void;
  onOpenProfile: (username: string) => void;
}) {
  const status = wordChainMoveStatus(message);
  const isValidWord = status === 'correct' || status === 'win';
  const senderName = message.senderName ?? '';
  const canOpenProfile = !isOwn && senderName !== '';
  const openSender = () => onOpenProfile(senderName);
  const avatar = (
    <VipAvatar typeId={message.senderVipTypeId} className="h-8 w-8" />
  );

  return (
    <div
      className={`flex w-full flex-col gap-0.5 ${
        isOwn ? 'items-end' : 'items-start'
      } ${status != null ? 'pb-3' : ''}`}
    >
      <span
        className={`flex max-w-[80%] items-baseline gap-1.5 text-sm font-semibold text-black/72 ${
          isOwn ? 'mr-10 flex-row-reverse' : 'ml-10'
        }`}
      >
        {canOpenProfile ? (
          <button
            type="button"
            onClick={openSender}
            className="min-w-0 truncate hover:underline"
          >
            {senderName}
          </button>
        ) : (
          <span className="truncate">{senderName}</span>
        )}
        <span className="shrink-0 text-xs font-normal text-black/35">
          {formatClockHM(message.createdAt)}
        </span>
      </span>
      <div
        className={`flex max-w-[80%] items-start gap-2 ${
          isOwn ? 'flex-row-reverse' : ''
        }`}
      >
        {canOpenProfile ? (
          <button
            type="button"
            onClick={openSender}
            aria-label={senderName}
            className="shrink-0"
          >
            {avatar}
          </button>
        ) : (
          <span className="shrink-0">{avatar}</span>
        )}
        <div className="relative">
          <div
            className={`w-fit max-w-full rounded-2xl px-3.5 py-2 text-base break-words ${bubbleSurface(
              isOwn,
              false
            )}`}
          >
            {message.content}
          </div>
          {status != null && (
            <span
              className={`absolute -bottom-3 flex h-7 w-7 items-center justify-center ${
                isOwn ? '-left-2' : '-right-2'
              }`}
            >
              <WordChainStatusIcon status={status} />
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
  message,
  replyTo,
  isOwn,
  onWordInfo,
  onOpenProfile,
}: WordChainMessageRowProps) {
  if (message.senderType === WORD_CHAIN_SENDER_TYPE.bot) {
    return (
      <BotMessage message={message} replyTo={replyTo} onWordInfo={onWordInfo} />
    );
  }
  return (
    <MoveBubble
      message={message}
      isOwn={isOwn}
      onWordInfo={onWordInfo}
      onOpenProfile={onOpenProfile}
    />
  );
}

export const WordChainMessageRow = memo(WordChainMessageRowComponent);
