import { Fragment } from 'react';
import type { RefObject, UIEvent } from 'react';
import { DateSeparator } from '@components';
import { isSameDay } from '@lib';
import type { ChatBotErrorCode, ChatBotMessage } from '@app-types';
import { BOT_WALLPAPER } from '../constants';
import { isoOf, type ChatBotViewer } from '../chatBotView';
import { BotMessageRow } from './BotMessageRow';
import { BotTypingRow } from './BotTypingRow';
import { ChatBotEmptyState } from './ChatBotEmptyState';
import { ChatBotErrorNotice } from './ChatBotErrorNotice';

interface ChatBotMessageListProps {
  scrollRef: RefObject<HTMLDivElement | null>;
  onScroll: (event: UIEvent<HTMLDivElement>) => void;
  messages: ChatBotMessage[];
  botName: string;
  viewer: ChatBotViewer;
  waiting: boolean;
  error: ChatBotErrorCode | null;
  onRetry: () => void;
}

export function ChatBotMessageList({
  scrollRef,
  onScroll,
  messages,
  botName,
  viewer,
  waiting,
  error,
  onRetry,
}: ChatBotMessageListProps) {
  const empty = messages.length === 0 && !waiting;

  return (
    <div
      ref={scrollRef}
      onScroll={onScroll}
      className={`flex flex-1 flex-col gap-0.5 overflow-x-hidden overflow-y-auto px-2 py-3 ${BOT_WALLPAPER}`}
    >
      {empty ? (
        <ChatBotEmptyState botName={botName} />
      ) : (
        <>
          {messages.map((message, index) => {
            const prev = messages[index - 1];
            const showDate = !isSameDay(
              isoOf(prev?.createdAt ?? 0),
              isoOf(message.createdAt)
            );
            return (
              <Fragment key={message.id}>
                {showDate && <DateSeparator iso={isoOf(message.createdAt)} />}
                <BotMessageRow
                  message={message}
                  prev={prev}
                  next={messages[index + 1]}
                  botName={botName}
                  viewer={viewer}
                />
              </Fragment>
            );
          })}
          {waiting && <BotTypingRow name={botName} />}
          {error != null && (
            <ChatBotErrorNotice code={error} onRetry={onRetry} />
          )}
        </>
      )}
    </div>
  );
}
