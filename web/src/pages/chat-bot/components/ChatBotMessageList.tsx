import { Fragment } from 'react';
import type { RefObject, UIEvent } from 'react';
import { DateSeparator } from '@components';
import { useChatWallpaperStyle } from '@hooks';
import { BUBBLE_WALLPAPER, isSameDay } from '@lib';
import type { ChatBotErrorCode, ChatBotMessage, ChatBotType } from '@app-types';
import { isoOf } from '../chatBotView';
import type { ChatBotViewer } from '../interface';
import { BotMessageRow } from './BotMessageRow';
import { BotTypingRow } from './BotTypingRow';
import { ChatBotEmptyState } from './ChatBotEmptyState';
import { ChatBotErrorNotice } from './ChatBotErrorNotice';

interface ChatBotMessageListProps {
  scrollRef: RefObject<HTMLDivElement | null>;
  onScroll: (event: UIEvent<HTMLDivElement>) => void;
  messages: ChatBotMessage[];
  bot: ChatBotType;
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
  bot,
  botName,
  viewer,
  waiting,
  error,
  onRetry,
}: ChatBotMessageListProps) {
  const empty = messages.length === 0 && !waiting;
  const wallpaperStyle = useChatWallpaperStyle();

  return (
    <div
      ref={scrollRef}
      onScroll={onScroll}
      style={wallpaperStyle}
      className={`flex flex-1 flex-col gap-0.5 overflow-x-hidden overflow-y-auto px-2 py-3 ${BUBBLE_WALLPAPER}`}
    >
      {empty ? (
        <ChatBotEmptyState bot={bot} botName={botName} />
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
                  bot={bot}
                  botName={botName}
                  viewer={viewer}
                />
              </Fragment>
            );
          })}
          {waiting && <BotTypingRow bot={bot} name={botName} />}
          {error != null && (
            <ChatBotErrorNotice bot={bot} code={error} onRetry={onRetry} />
          )}
        </>
      )}
    </div>
  );
}
