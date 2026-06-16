import { useTranslation } from 'react-i18next';
import mentionIcon from '@/assets/icons/room/ic_notification_mention.png';
import { Avatar } from '@components';
import { renderRichText } from '../../me/richText';
import { colorForName } from '@lib';
import type { BubblePosition, MessageGroup } from '../messageGroups';

const OWN_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl rounded-br-md',
  first: 'rounded-2xl rounded-br-md',
  middle: 'rounded-2xl rounded-tr-md rounded-br-md',
  last: 'rounded-2xl rounded-tr-md',
};

const OTHER_CORNERS: Record<BubblePosition, string> = {
  single: 'rounded-2xl rounded-bl-md',
  first: 'rounded-2xl rounded-bl-md',
  middle: 'rounded-2xl rounded-tl-md rounded-bl-md',
  last: 'rounded-2xl rounded-tl-md',
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

export function RoomMessageGroup({ group, onOpenProfile, onQuickMention }: RoomMessageGroupProps) {
  const { t } = useTranslation();
  const onMention = (nick: string) => onOpenProfile?.(nick, colorForName(nick));

  if (group.isOwn) {
    const last = group.messages[group.messages.length - 1];
    return (
      <div className="flex flex-col items-end gap-1 self-end" style={{ maxWidth: '80%' }}>
        <span className="max-w-full truncate px-1 text-sm font-medium text-black/87">
          {group.senderName}
        </span>
        <div className="flex w-fit flex-col items-end gap-0.5">
          {group.messages.map((message) => (
            <div
              key={message.id}
              className={`w-fit max-w-full break-words bg-[#dcedc8] px-3.5 py-2 text-base text-black/87 ${OWN_CORNERS[message.position]}`}
            >
              {renderRichText(message.content, onMention)}
            </div>
          ))}
          <span className="self-end px-1 text-[11px] text-black/38">{clock(last.createdAt)}</span>
        </div>
      </div>
    );
  }

  const last = group.messages[group.messages.length - 1];
  const senderColor = colorForName(group.senderName);
  const openSender = () => onOpenProfile?.(group.senderName, senderColor);
  return (
    <div className="flex min-w-0 flex-col gap-1 self-start" style={{ maxWidth: '85%' }}>
      <div className="flex min-w-0 items-center gap-2">
        <button type="button" onClick={openSender} className="shrink-0">
          {group.senderAvatar != null && group.senderAvatar !== '' ? (
            <img src={group.senderAvatar} alt="" className="h-8 w-8 rounded-full object-cover" />
          ) : (
            <Avatar name={group.senderName} color={senderColor} size={32} />
          )}
        </button>
        <button
          type="button"
          onClick={openSender}
          className="truncate text-sm font-medium text-black/87 hover:underline"
        >
          {group.senderName}
        </button>
      </div>
      <div className="flex items-center gap-0 pl-10">
        <div className="flex w-fit min-w-0 flex-col gap-0.5">
          {group.messages.map((message) => (
            <div
              key={message.id}
              className={`w-fit max-w-full break-words bg-white px-3.5 py-2 text-base text-black/87 shadow-sm ${OTHER_CORNERS[message.position]}`}
            >
              {renderRichText(message.content, onMention)}
            </div>
          ))}
          <span className="self-start px-1 text-[11px] text-black/38">{clock(last.createdAt)}</span>
        </div>
        <button
          type="button"
          aria-label={t('room.mentionUser', { name: group.senderName })}
          title={t('room.mentionUser', { name: group.senderName })}
          onClick={() => onQuickMention?.(group.senderName)}
          className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full hover:bg-black/5 active:bg-black/10"
        >
          <img src={mentionIcon} alt="" className="h-6 w-6" />
        </button>
      </div>
    </div>
  );
}
