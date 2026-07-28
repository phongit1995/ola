import { useRef, type MouseEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { useLongPress } from '@hooks';
import { reactionChips } from '@lib';
import sentIcon from '@/assets/icons/chat/ic_message_sent.png';
import resendIcon from '@/assets/icons/chat/btn_resend_d.png';
import type { ChatMessage } from '../interface';
import { ChatMessageBubble } from './ChatMessageBubble';

interface MessageRowProps {
  message: ChatMessage;
  prev?: ChatMessage;
  next?: ChatMessage;
  name: string;
  color: string;
  avatar?: string;
  isLastOwn: boolean;
  seen: boolean;
  highlighted?: boolean;
  onOpenActions: (message: ChatMessage, anchor: DOMRect | null) => void;
  onOpenProfile?: () => void;
  onMention?: (nick: string) => void;
  onQuoteClick?: (messageId: string) => void;
  onOpenImage: (url: string) => void;
  onResend: (id: string) => void;
}

export function MessageRow({
  message,
  prev,
  next,
  name,
  color,
  avatar,
  isLastOwn,
  seen,
  highlighted = false,
  onOpenActions,
  onOpenProfile,
  onMention,
  onQuoteClick,
  onOpenImage,
  onResend,
}: MessageRowProps) {
  const isOut = message.direction === 'out';
  const boundary = prev == null;
  const firstInGroup = boundary || prev.direction !== message.direction;
  const lastInGroup = next == null || next.direction !== message.direction;
  const showTime = lastInGroup || next.time !== message.time;
  const showAvatar = !isOut && firstInGroup;
  const canAct = message.status !== 'sending' && message.status !== 'failed';
  const chips = reactionChips(message.reactions);
  const suppressClick = useRef(false);

  const longPress = useLongPress((anchor) => {
    suppressClick.current = true;
    if (canAct) onOpenActions(message, anchor);
  });

  function handleBubbleClick(event: MouseEvent<HTMLDivElement>) {
    if (suppressClick.current) {
      suppressClick.current = false;
      return;
    }
    if (
      message.kind === 'image' &&
      message.image != null &&
      message.image !== ''
    ) {
      onOpenImage(message.image);
      return;
    }
    if (canAct)
      onOpenActions(message, event.currentTarget.getBoundingClientRect());
  }

  return (
    <div className={`flex flex-col ${firstInGroup && !boundary ? 'mt-2' : ''}`}>
      <div
        className={`flex items-end gap-1 ${isOut ? 'flex-row-reverse' : ''}`}
      >
        {!isOut &&
          (showAvatar ? (
            onOpenProfile != null ? (
              <button
                type="button"
                aria-label={name}
                onClick={onOpenProfile}
                className="shrink-0 self-start"
              >
                <Avatar name={name} color={color} src={avatar} size={32} />
              </button>
            ) : (
              <span className="shrink-0 self-start">
                <Avatar name={name} color={color} src={avatar} size={32} />
              </span>
            )
          ) : (
            <span className="w-8 shrink-0" />
          ))}
        <div
          className={`flex max-w-[78%] flex-col ${isOut ? 'items-end' : ''}`}
        >
          <div
            className={`flex items-center gap-2 ${isOut ? 'flex-row-reverse' : ''}`}
          >
            <div
              data-message-id={message.id}
              {...longPress}
              onPointerDown={(event) => {
                suppressClick.current = false;
                longPress.onPointerDown(event);
              }}
              onClick={handleBubbleClick}
              className={`touch-pan-y select-none ${highlighted ? 'rounded-2xl ring-2 ring-ola-primary/40' : ''}`}
            >
              <ChatMessageBubble
                message={message}
                firstInGroup={firstInGroup}
                lastInGroup={lastInGroup}
                onMention={onMention}
                onQuoteClick={onQuoteClick}
              />
            </div>
            {showTime && (
              <span className="shrink-0 text-[10px] text-black/38">
                {message.time}
              </span>
            )}
          </div>
          {chips.length > 0 && (
            <button
              type="button"
              onClick={(event) => {
                if (canAct)
                  onOpenActions(
                    message,
                    event.currentTarget.getBoundingClientRect()
                  );
              }}
              className={`relative z-10 -mt-2 flex flex-wrap gap-1 ${isOut ? 'justify-end self-end' : 'self-start'}`}
            >
              {chips.map((chip) => (
                <span
                  key={chip.type}
                  className="flex items-center gap-1 rounded-full bg-white py-0.5 pl-1 pr-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.12)] ring-1 ring-black/5"
                >
                  <img
                    src={chip.image}
                    alt={chip.type}
                    className="h-4 w-4 object-contain"
                  />
                  <span className="text-[11px] font-medium leading-none text-black/55 tabular-nums">
                    {chip.count}
                  </span>
                </span>
              ))}
            </button>
          )}
          {isOut &&
            isLastOwn &&
            message.status !== 'sending' &&
            message.status !== 'failed' && (
              <SeenIndicator
                seen={seen}
                name={name}
                color={color}
                avatar={avatar}
              />
            )}
        </div>
        {isOut && <InlineSendStatus message={message} onResend={onResend} />}
      </div>
    </div>
  );
}

function InlineSendStatus({
  message,
  onResend,
}: {
  message: ChatMessage;
  onResend: (id: string) => void;
}) {
  const { t } = useTranslation();

  if (message.status === 'sending') {
    return (
      <span className="h-4 w-4 shrink-0 self-center animate-spin rounded-full border-2 border-black/20 border-t-transparent" />
    );
  }
  if (message.status === 'failed') {
    return (
      <button
        type="button"
        onClick={() => onResend(message.id)}
        aria-label={t('chat.resend')}
        className="flex shrink-0 items-center gap-1 self-center text-xs text-ola-error active:scale-95"
      >
        <img
          src={resendIcon}
          alt={t('chat.resend')}
          className="h-5 w-5 object-contain"
        />
      </button>
    );
  }
  return null;
}

function SeenIndicator({
  seen,
  name,
  color,
  avatar,
}: {
  seen: boolean;
  name: string;
  color: string;
  avatar?: string;
}) {
  if (seen) {
    return (
      <span className="mt-1">
        <Avatar name={name} color={color} src={avatar} size={16} />
      </span>
    );
  }
  return (
    <img
      src={sentIcon}
      alt=""
      className="mt-1 h-4 w-4 object-contain opacity-60"
    />
  );
}
