import { memo } from 'react';
import { useTranslation } from 'react-i18next';
import mentionIcon from '@/assets/icons/room/ic_notification_mention.png';
import { Avatar } from '@components';
import { colorForName, renderRichText } from '@lib';
import type { BubblePosition, MessageGroup } from '../messageGroups';

const OWN_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl',
  first: 'rounded-2xl rounded-br-none',
  middle: 'rounded-2xl rounded-tr-none rounded-br-none',
  last: 'rounded-2xl rounded-tr-none',
};

const OTHER_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl',
  first: 'rounded-2xl rounded-bl-none',
  middle: 'rounded-2xl rounded-tl-none rounded-bl-none',
  last: 'rounded-2xl rounded-tl-none',
};

function clock(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
}

interface RoomMessageGroupProps {
  group: MessageGroup;
  onOpenProfile?: (nick: string, color: string) => void;
  onQuickMention?: (name: string) => void;
}

function RoomMessageGroupComponent({ group, onOpenProfile, onQuickMention }: RoomMessageGroupProps) {
  const { t } = useTranslation();
  const onMention = (nick: string) => onOpenProfile?.(nick, colorForName(nick));
  const time = clock(group.messages[0]!.createdAt);

  if (group.isOwn) {
    return (
      <div className="flex w-full flex-col gap-0.5">
        <span className="text-center text-xs text-black/26">{time}</span>
        <div className="flex max-w-[80%] flex-col items-end gap-0.5 self-end">
          {group.messages.map((message) => (
            <div
              key={message.id}
              className={`w-fit max-w-full break-words bg-[#7cb342] px-3.5 py-2 text-base text-white ${OWN_CORNERS[message.position]}`}
            >
              {renderRichText(message.content, onMention)}
            </div>
          ))}
        </div>
      </div>
    );
  }

  const lastIndex = group.messages.length - 1;
  const senderColor = colorForName(group.senderName);
  const openSender = () => onOpenProfile?.(group.senderName, senderColor);
  const bubbleClass = (position: BubblePosition) =>
    `w-fit max-w-full break-words bg-[#f1f8e9] px-3.5 py-2 text-base text-black/87 ${OTHER_CORNERS[position]}`;
  return (
    <div className="flex w-full flex-col gap-0.5">
      <span className="text-center text-xs text-black/26">{time}</span>
      <button
        type="button"
        onClick={openSender}
        className="ml-12 max-w-[85%] self-start truncate text-sm text-black/54 hover:underline"
      >
        {group.senderName}
      </button>
      <div className="flex max-w-[85%] items-start gap-2 self-start">
        <button type="button" onClick={openSender} className="shrink-0">
          {group.senderAvatar != null && group.senderAvatar !== '' ? (
            <img src={group.senderAvatar} alt="" className="h-8 w-8 rounded-full object-cover" />
          ) : (
            <Avatar name={group.senderName} color={senderColor} size={32} />
          )}
        </button>
        <div className="flex w-fit min-w-0 flex-col gap-0.5">
          {group.messages.map((message, index) =>
            index === lastIndex ? (
              <div key={message.id} className="relative w-fit max-w-full self-start">
                <div className={bubbleClass(message.position)}>
                  {renderRichText(message.content, onMention)}
                </div>
                <button
                  type="button"
                  aria-label={t('room.mentionUser', { name: group.senderName })}
                  title={t('room.mentionUser', { name: group.senderName })}
                  onClick={() => onQuickMention?.(group.senderName)}
                  className="absolute -bottom-2 left-full -ml-2 flex h-7 w-7 items-center justify-center rounded-full hover:bg-black/5 active:bg-black/10"
                >
                  <img src={mentionIcon} alt="" className="h-6 w-6" />
                </button>
              </div>
            ) : (
              <div key={message.id} className={bubbleClass(message.position)}>
                {renderRichText(message.content, onMention)}
              </div>
            )
          )}
        </div>
      </div>
    </div>
  );
}

export const RoomMessageGroup = memo(RoomMessageGroupComponent);
