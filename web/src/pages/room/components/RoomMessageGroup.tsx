import { memo, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import mentionIcon from '@/assets/icons/room/ic_tag_people.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import resendIcon from '@/assets/icons/chat/btn_resend_d.png';
import { Spinner, VipAvatar } from '@components';
import { useLongPress } from '@hooks';
import {
  colorForName,
  formatClockHM,
  kulImageForText,
  reactionChips,
  renderRichText,
  SmileyText,
} from '@lib';
import { useMediaViewerStore } from '@/store/mediaViewerStore';
import type { RoomReplySnapshot } from '@app-types';
import type { BubblePosition, GroupedMessage, MessageGroup } from '../messageGroups';
import { OTHER_CORNERS, OWN_CORNERS } from '../constants';

interface RoomMessageGroupProps {
  group: MessageGroup;
  highlightedId?: string | null;
  onOpenProfile?: (nick: string, color: string) => void;
  onQuickMention?: (name: string) => void;
  onLongPressMessage?: (id: string, anchor: DOMRect | null) => void;
  onQuoteClick?: (messageId: string) => void;
  onShowReactions?: (id: string) => void;
  onResendImage?: (id: string) => void;
}

interface QuoteBlockProps {
  replyTo: RoomReplySnapshot;
  isOwn: boolean;
  onQuoteClick?: (messageId: string) => void;
}

function QuoteBlock({ replyTo, isOwn, onQuoteClick }: QuoteBlockProps) {
  const { t } = useTranslation();
  const isImage = replyTo.type === 'image';
  const excerpt = isImage
    ? t('room.replyImage')
    : kulImageForText(replyTo.excerpt) != null
      ? t('room.replySticker')
      : replyTo.excerpt;
  return (
    <button
      type="button"
      onClick={(event) => {
        event.stopPropagation();
        onQuoteClick?.(replyTo.messageId);
      }}
      className={`mb-1 block w-full rounded border-l-2 py-0.5 pl-2 pr-1 text-left ${
        isOwn ? 'border-white/60 bg-white/15' : 'border-[#7cb342] bg-black/5'
      }`}
    >
      <span
        className={`block truncate text-xs font-semibold ${
          isOwn ? 'text-white/90' : 'text-black/60'
        }`}
      >
        {replyTo.senderName != null && replyTo.senderName !== '' ? `@${replyTo.senderName}` : ''}
      </span>
      <span
        className={`flex items-center gap-1 text-xs ${isOwn ? 'text-white/75' : 'text-black/45'}`}
      >
        {isImage && <img src={photoIcon} alt="" className="h-3.5 w-3.5 shrink-0 object-contain" />}
        <span className="line-clamp-2">
          <SmileyText text={excerpt} />
        </span>
      </span>
    </button>
  );
}

interface RoomBubbleProps {
  message: GroupedMessage;
  isOwn: boolean;
  position: BubblePosition;
  highlighted: boolean;
  onMention: (nick: string) => void;
  onLongPressMessage?: (id: string, anchor: DOMRect | null) => void;
  onQuoteClick?: (messageId: string) => void;
  onResendImage?: (id: string) => void;
}

function RoomBubble({
  message,
  isOwn,
  position,
  highlighted,
  onMention,
  onLongPressMessage,
  onQuoteClick,
  onResendImage,
}: RoomBubbleProps) {
  const { t } = useTranslation();
  const uploading = message.status === 'uploading';
  const failed = message.status === 'failed';
  const suppressClick = useRef(false);
  const longPress = useLongPress((anchor) => {
    if (uploading || failed) return;
    suppressClick.current = true;
    onLongPressMessage?.(message.id, anchor);
  });

  const openViewer = useMediaViewerStore((state) => state.openViewer);
  const kul = kulImageForText(message.content);
  const isImage = message.type === 'image' && message.imageUrl != null && message.imageUrl !== '';
  const corners = isOwn ? OWN_CORNERS[position] : OTHER_CORNERS[position];
  const bubbleClass = isOwn
    ? `w-fit max-w-full break-words bg-[#7cb342] px-3.5 py-2 text-base text-white ${corners}`
    : `w-fit max-w-full break-words bg-[#f1f8e9] px-3.5 py-2 text-base text-black/87 ${corners}`;

  const content = isImage ? (
    <span className="relative block">
      <img
        src={message.imageUrl}
        alt=""
        className={`max-h-44 w-auto max-w-52 rounded-lg object-cover ${uploading || failed ? 'opacity-60' : ''}`}
      />
      {uploading && (
        <span className="absolute inset-0 flex items-center justify-center">
          <Spinner size={22} />
        </span>
      )}
      {failed && (
        <button
          type="button"
          aria-label={t('chat.resend')}
          title={t('chat.resend')}
          onClick={(event) => {
            event.stopPropagation();
            onResendImage?.(message.id);
          }}
          className="absolute inset-0 flex items-center justify-center rounded-lg bg-black/40"
        >
          <img src={resendIcon} alt="" className="h-7 w-7 object-contain" />
        </button>
      )}
    </span>
  ) : kul != null ? (
    <img src={kul} alt="" className="h-28 w-auto object-contain" />
  ) : (
    renderRichText(message.content, onMention)
  );
  const bare = (isImage || kul != null) && message.replyTo == null;
  const body = bare ? (
    content
  ) : (
    <div className={bubbleClass}>
      {message.replyTo != null && (
        <QuoteBlock replyTo={message.replyTo} isOwn={isOwn} onQuoteClick={onQuoteClick} />
      )}
      {content}
    </div>
  );

  return (
    <div
      data-message-id={message.id}
      {...longPress}
      onPointerDown={(event) => {
        suppressClick.current = false;
        longPress.onPointerDown(event);
      }}
      onClick={() => {
        if (suppressClick.current) {
          suppressClick.current = false;
          return;
        }
        if (isImage && !uploading && !failed) openViewer([message.imageUrl!]);
      }}
      className={`w-fit max-w-full touch-pan-y select-none ${
        highlighted ? 'rounded-2xl ring-2 ring-ola-primary/40' : ''
      }`}
    >
      {body}
    </div>
  );
}

function ReactionChipsRow({
  message,
  isOwn,
  onShowReactions,
}: {
  message: GroupedMessage;
  isOwn: boolean;
  onShowReactions?: (id: string) => void;
}) {
  const chips = reactionChips(message.reactions);
  if (chips.length === 0) return null;
  return (
    <button
      type="button"
      onClick={() => onShowReactions?.(message.id)}
      className={`relative z-10 -mt-2 flex flex-wrap gap-1 ${isOwn ? 'justify-end self-end' : 'self-start'}`}
    >
      {chips.map((chip) => (
        <span
          key={chip.type}
          className="flex items-center gap-1 rounded-full bg-white py-0.5 pl-1 pr-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.12)] ring-1 ring-black/5"
        >
          <img src={chip.image} alt={chip.type} className="h-4 w-4 object-contain" />
          <span className="text-[11px] font-medium leading-none text-black/55 tabular-nums">
            {chip.count}
          </span>
        </span>
      ))}
    </button>
  );
}

function RoomMessageGroupComponent({
  group,
  highlightedId,
  onOpenProfile,
  onQuickMention,
  onLongPressMessage,
  onQuoteClick,
  onShowReactions,
  onResendImage,
}: RoomMessageGroupProps) {
  const { t } = useTranslation();
  const { isOwn, senderName } = group;
  const onMention = (nick: string) => onOpenProfile?.(nick, colorForName(nick));
  const time = formatClockHM(group.messages[0]!.createdAt);
  const openSender = () => onOpenProfile?.(senderName, colorForName(senderName));
  const lastIndex = group.messages.length - 1;

  return (
    <div className="flex w-full flex-col gap-0.5">
      {group.showTime && <span className="text-center text-xs text-black/26">{time}</span>}
      {isOwn ? (
        <span className="mr-12 flex max-w-[80%] items-center gap-1 self-end text-sm text-black/54">
          <span className="truncate">{senderName}</span>
        </span>
      ) : (
        <button
          type="button"
          onClick={openSender}
          className="ml-12 flex max-w-[85%] items-center gap-1 self-start text-sm text-black/54"
        >
          <span className="truncate hover:underline">{senderName}</span>
        </button>
      )}
      <div
        className={`flex items-start gap-2 ${
          isOwn ? 'max-w-[80%] flex-row-reverse self-end' : 'max-w-[85%] self-start'
        }`}
      >
        {isOwn ? (
          <span className="shrink-0">
            <VipAvatar typeId={group.senderVipTypeId} className="h-8 w-8" />
          </span>
        ) : (
          <button type="button" onClick={openSender} className="shrink-0">
            <VipAvatar typeId={group.senderVipTypeId} className="h-8 w-8" />
          </button>
        )}
        <div className={`flex w-fit min-w-0 flex-col gap-0.5 ${isOwn ? 'items-end' : ''}`}>
          {group.messages.map((message, index) => {
            const bubble = (
              <RoomBubble
                message={message}
                isOwn={isOwn}
                position={message.position}
                highlighted={highlightedId === message.id}
                onMention={onMention}
                onLongPressMessage={onLongPressMessage}
                onQuoteClick={onQuoteClick}
                onResendImage={onResendImage}
              />
            );
            const withQuickMention = !isOwn && index === lastIndex;
            return (
              <div
                key={message.key}
                className={`flex w-fit max-w-full flex-col gap-0.5 ${
                  isOwn ? 'items-end' : 'self-start'
                }`}
              >
                {withQuickMention ? (
                  <div className="relative w-fit max-w-full">
                    {bubble}
                    <button
                      type="button"
                      aria-label={t('room.mentionUser', { name: senderName })}
                      title={t('room.mentionUser', { name: senderName })}
                      onClick={() => onQuickMention?.(senderName)}
                      className="absolute bottom-0 left-full ml-1 flex h-7 w-7 items-center justify-center rounded-full hover:bg-black/5 active:bg-black/10"
                    >
                      <img src={mentionIcon} alt="" className="h-6 w-6" />
                    </button>
                  </div>
                ) : (
                  bubble
                )}
                <ReactionChipsRow message={message} isOwn={isOwn} onShowReactions={onShowReactions} />
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export const RoomMessageGroup = memo(RoomMessageGroupComponent);
