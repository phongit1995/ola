import { memo } from 'react';
import { Avatar } from '@components';
import type { ChatBotMessage, ChatBotType } from '@app-types';
import { groupingOf } from '../chatBotView';
import type { ChatBotViewer } from '../interface';
import { BotAvatar } from './BotAvatar';
import { BotMarkdown } from './BotMarkdown';

interface BotMessageRowProps {
  message: ChatBotMessage;
  prev?: ChatBotMessage;
  next?: ChatBotMessage;
  bot: ChatBotType;
  botName: string;
  viewer: ChatBotViewer;
}

function BotMessageRowComponent({
  message,
  prev,
  next,
  bot,
  botName,
  viewer,
}: BotMessageRowProps) {
  const group = groupingOf(message, prev, next);

  return (
    <div className={`flex flex-col ${group.spaced ? 'mt-2' : ''}`}>
      <div
        className={`flex items-end gap-1 ${group.isOut ? 'flex-row-reverse' : ''}`}
      >
        {group.firstInGroup ? (
          <span className="shrink-0 self-start">
            {group.isOut ? (
              <Avatar
                name={viewer.name}
                color={viewer.color}
                src={viewer.avatar}
                size={32}
              />
            ) : (
              <BotAvatar bot={bot} name={botName} />
            )}
          </span>
        ) : (
          <span className="w-8 shrink-0" />
        )}
        <div
          className={`flex max-w-[78%] flex-col ${group.isOut ? 'items-end' : ''}`}
        >
          <div
            className={`flex items-center gap-2 ${group.isOut ? 'flex-row-reverse' : ''}`}
          >
            <div
              className={`rounded-2xl px-3 py-2 text-sm ${group.corners} ${group.surface}`}
            >
              {group.isOut ? (
                <span className="break-words whitespace-pre-wrap">
                  {message.content}
                </span>
              ) : (
                <BotMarkdown content={message.content} />
              )}
            </div>
            {group.showTime && (
              <span className="shrink-0 text-[10px] text-black/38">
                {group.time}
              </span>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export const BotMessageRow = memo(BotMessageRowComponent);
