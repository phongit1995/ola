import { memo } from 'react';
import { useTranslation } from 'react-i18next';
import mentionIcon from '@/assets/icons/room/ic_notification_mention.png';
import { Avatar, VipIcon } from '@components';
import { colorForName, kulImageForText, renderRichText } from '@lib';
import type { BubblePosition, MessageGroup } from '../messageGroups';
import { OTHER_CORNERS, OWN_CORNERS } from '../constants';

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
          {group.messages.map((message) => {
            const kul = kulImageForText(message.content);
            return kul != null ? (
              <img key={message.id} src={kul} alt="" className="h-28 w-auto object-contain" />
            ) : (
              <div
                key={message.id}
                className={`w-fit max-w-full break-words bg-[#7cb342] px-3.5 py-2 text-base text-white ${OWN_CORNERS[message.position]}`}
              >
                {renderRichText(message.content, onMention)}
              </div>
            );
          })}
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
        className="ml-12 flex max-w-[85%] items-center gap-1 self-start text-sm text-black/54"
      >
        <span className="truncate hover:underline">{group.senderName}</span>
        <VipIcon typeId={group.senderVipTypeId} />
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
          {group.messages.map((message, index) => {
            const kul = kulImageForText(message.content);
            const body =
              kul != null ? (
                <img src={kul} alt="" className="h-28 w-auto object-contain" />
              ) : (
                <div className={bubbleClass(message.position)}>
                  {renderRichText(message.content, onMention)}
                </div>
              );
            return index === lastIndex ? (
              <div key={message.id} className="relative w-fit max-w-full self-start">
                {body}
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
              <div key={message.id} className="w-fit max-w-full self-start">
                {body}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export const RoomMessageGroup = memo(RoomMessageGroupComponent);
