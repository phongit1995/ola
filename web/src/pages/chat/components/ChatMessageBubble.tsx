import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { MESSAGE_STATUS, MESSAGE_TYPE } from '@constants';
import checkedIcon from '@/assets/icons/profile/ic_checked.png';
import snapIcon from '@/assets/icons/chat/icon_snap_pic.png';
import kenIcon from '@/assets/icons/chat/ic_ken_white.png';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import {
  bubbleCorners,
  bubbleSurface,
  callMessageView,
  kulImageForText,
  renderRichText,
  SmileyText,
} from '@lib';
import { PhoneIcon, VideoIcon } from '../../call/icons';
import type { ChatReplySnapshot } from '@app-types';
import type { ChatMessage } from '../interface';
import { chatQuoteExcerpt } from '../chatView';
import { VoiceBubble } from '@components/chat/voice/VoiceBubble';
import { useUploadPreviewLease } from '@hooks';

const noop = () => undefined;

interface ChatQuoteBlockProps {
  replyTo: ChatReplySnapshot;
  onPrimary: boolean;
  onQuoteClick?: (messageId: string) => void;
}

function ChatQuoteBlock({
  replyTo,
  onPrimary,
  onQuoteClick,
}: ChatQuoteBlockProps) {
  const { t } = useTranslation();
  const isImage = replyTo.type === MESSAGE_TYPE.image;
  const excerpt = chatQuoteExcerpt(t, replyTo);
  return (
    <button
      type="button"
      onClick={(event) => {
        event.stopPropagation();
        onQuoteClick?.(replyTo.messageId);
      }}
      className={`mb-1 block w-full rounded border-l-2 py-0.5 pl-2 pr-1 text-left ${
        onPrimary
          ? 'border-ola-on-primary/60 bg-white/15'
          : 'border-ola-primary bg-black/5'
      }`}
    >
      <span
        className={`block truncate text-xs font-semibold ${
          onPrimary ? 'text-ola-on-primary/90' : 'text-black/60'
        }`}
      >
        {replyTo.senderName != null && replyTo.senderName !== ''
          ? `@${replyTo.senderName}`
          : ''}
      </span>
      <span
        className={`flex items-center gap-1 text-xs ${
          onPrimary ? 'text-ola-on-primary/75' : 'text-black/45'
        }`}
      >
        {isImage && (
          <img
            src={photoIcon}
            alt=""
            className="h-3.5 w-3.5 shrink-0 object-contain"
          />
        )}
        <span className="line-clamp-2">
          <SmileyText text={excerpt} />
        </span>
      </span>
    </button>
  );
}

interface ChatMessageBubbleProps {
  message: ChatMessage;
  firstInGroup?: boolean;
  lastInGroup?: boolean;
  onMention?: (nick: string) => void;
  onQuoteClick?: (messageId: string) => void;
}

export function ChatMessageBubble({
  message,
  firstInGroup = true,
  lastInGroup = true,
  onMention,
  onQuoteClick,
}: ChatMessageBubbleProps) {
  const { t } = useTranslation();
  useUploadPreviewLease(message.kind === 'image' ? message.image : undefined);
  const isOut = message.direction === 'out';
  const failed = isOut && message.status === MESSAGE_STATUS.failed;
  const surface = bubbleSurface(isOut, false);
  const groupCorners = bubbleCorners(isOut, firstInGroup, lastInGroup);
  const bubbleBg = bubbleSurface(isOut, failed);
  const onPrimary = isOut && !failed;

  const quotedWrap = (content: ReactNode) =>
    message.replyTo != null ? (
      <div
        className={`max-w-[300px] rounded-2xl px-3 py-2 ${groupCorners} ${bubbleBg}`}
      >
        <ChatQuoteBlock
          replyTo={message.replyTo}
          onPrimary={onPrimary}
          onQuoteClick={onQuoteClick}
        />
        {content}
      </div>
    ) : (
      content
    );

  if (message.kind === 'text') {
    const kulImage = kulImageForText(message.text);
    if (kulImage != null) {
      return quotedWrap(
        <img src={kulImage} alt="" className="h-30 w-auto object-contain" />
      );
    }
  }

  switch (message.kind) {
    case 'sticker':
      return (
        <span className="px-1 text-6xl leading-none">{message.sticker}</span>
      );

    case 'image':
      return quotedWrap(
        message.image != null && message.image !== '' ? (
          <img
            src={message.image}
            alt=""
            className="max-h-60 max-w-[220px] cursor-pointer rounded-lg object-cover shadow-sm"
          />
        ) : (
          <div className="flex h-44 w-44 items-center justify-center overflow-hidden rounded-lg bg-linear-to-br from-ola-primary-light to-ola-primary/30 text-6xl shadow-sm">
            🖼️
          </div>
        )
      );

    case 'voice':
      return quotedWrap(
        <VoiceBubble
          key={message.audioUrl}
          url={message.audioUrl}
          duration={message.voiceDuration}
          durationSec={message.audioDuration}
          waveform={message.audioWaveform}
          isOut={isOut}
        />
      );

    case 'location':
      return (
        <div className={`w-44 overflow-hidden rounded-lg ${surface}`}>
          <div className="flex h-28 items-center justify-center bg-linear-to-br from-[#A5D6A7] to-[#66BB6A] text-4xl">
            📍
          </div>
          <p className="px-2 py-1.5 text-xs">{message.address}</p>
        </div>
      );

    case 'snap':
      return (
        <div className="flex w-36 flex-col items-center gap-1 rounded-lg bg-white p-2 shadow-sm">
          <img src={snapIcon} alt="" className="h-16 w-16 object-contain" />
          <span className="h-1 w-full overflow-hidden rounded-full bg-black/10">
            <span className="block h-full w-2/3 bg-ola-primary" />
          </span>
          <span className="text-xs text-black/54">{t('chat.snapTip')}</span>
        </div>
      );

    case 'youtube':
      return (
        <div className="w-56 overflow-hidden rounded-lg bg-white shadow-sm">
          <div className="relative flex h-28 items-center justify-center bg-linear-to-br from-[#455A64] to-[#263238]">
            <span className="flex h-10 w-10 items-center justify-center rounded-full bg-[#FF0000] text-white">
              ▶
            </span>
          </div>
          <div className="px-2 py-1.5">
            <p className="truncate text-xs font-medium text-black/87">
              {message.youtubeTitle}
            </p>
            <p className="text-xs text-black/54">{message.youtubeDuration}</p>
          </div>
        </div>
      );

    case 'ken':
      return (
        <div
          className={`flex items-center gap-2 rounded-2xl px-3 py-2 ${
            isOut ? 'rounded-tr-sm' : 'rounded-tl-sm'
          } ${surface}`}
        >
          <span
            className={`flex h-8 w-8 items-center justify-center rounded-full ${
              onPrimary ? 'bg-white/20' : 'bg-ola-primary'
            }`}
          >
            <img src={kenIcon} alt="" className="h-4 w-4 object-contain icon-on-primary" />
          </span>
          <span
            className={`text-2xl font-bold ${
              onPrimary ? 'text-ola-on-primary' : 'text-ola-primary-darker'
            }`}
          >
            {message.kenAmount}
          </span>
          <span
            className={`text-sm ${
              onPrimary ? 'text-ola-on-primary/70' : 'text-black/54'
            }`}
          >
            {t('chat.kenLabel')}
          </span>
        </div>
      );

    case 'call': {
      const view = callMessageView(t, message.call ?? {});
      const CallIcon = view.isVideo ? VideoIcon : PhoneIcon;
      return (
        <div
          className={`flex items-center gap-2.5 rounded-2xl px-3 py-2 ${groupCorners} ${bubbleBg}`}
        >
          <span
            className={`flex h-9 w-9 items-center justify-center rounded-full ${
              onPrimary
                ? `bg-white/20 ${
                    view.missed ? 'text-[#ffcdd2]' : 'text-ola-on-primary'
                  }`
                : view.missed
                ? 'bg-[#e53935]/10 text-[#e53935]'
                : 'bg-ola-primary/15 text-ola-primary-darker'
            }`}
          >
            <CallIcon className="h-5 w-5" />
          </span>
          <span className="flex flex-col pr-1">
            <span className="text-sm font-medium">{view.title}</span>
            <span
              className={`text-xs ${
                onPrimary
                  ? view.missed
                    ? 'text-[#ffcdd2]'
                    : 'text-ola-on-primary/70'
                  : view.missed
                  ? 'text-[#e53935]'
                  : 'text-black/54'
              }`}
            >
              {view.detail}
            </span>
          </span>
        </div>
      );
    }

    case 'vip':
      return (
        <div
          className={`flex items-center gap-2 rounded-2xl px-3 py-2 ${
            isOut ? 'rounded-tr-sm' : 'rounded-tl-sm'
          } ${surface}`}
        >
          <span className="text-2xl">🎁</span>
          <span
            className={`text-sm font-medium ${
              onPrimary ? 'text-ola-on-primary' : 'text-ola-accent'
            }`}
          >
            {message.vipDirection === 'received'
              ? t('chat.vipReceived')
              : t('chat.vipSent')}
          </span>
        </div>
      );

    default:
      return (
        <div
          className={`max-w-[300px] rounded-2xl px-3 py-2 text-base break-words ${groupCorners} ${bubbleBg}`}
        >
          {message.replyTo != null && (
            <ChatQuoteBlock
              replyTo={message.replyTo}
              onPrimary={onPrimary}
              onQuoteClick={onQuoteClick}
            />
          )}
          {renderRichText(message.text ?? '', onMention ?? noop)}
        </div>
      );
  }
}

interface StrangerCardBubbleProps {
  message: ChatMessage;
  onClose: () => void;
  onBlock: () => void;
  onAddFriend: () => void;
}

export function StrangerCardBubble({
  message,
  onClose,
  onBlock,
  onAddFriend,
}: StrangerCardBubbleProps) {
  const { t } = useTranslation();
  const card = message.stranger;
  if (card == null) return null;

  return (
    <div className="my-2 overflow-hidden rounded-lg border-y border-black/12 bg-white shadow-sm">
      <div className="relative h-24 bg-linear-to-br from-ola-primary to-ola-primary-darker">
        <div className="absolute inset-x-0 bottom-0 flex items-end gap-2 bg-white/60 p-2">
          <Avatar name={card.name} color={card.color} size={56} />
          <div className="min-w-0 flex-1 pb-0.5">
            <div className="flex items-center gap-1">
              <span className="truncate text-base font-medium text-black/87">
                {card.name}
              </span>
              {card.verified && (
                <img
                  src={checkedIcon}
                  alt=""
                  className="h-4 w-4 object-contain"
                />
              )}
            </div>
            <p className="text-xs text-black/54">
              {t('chat.strangerAge', { age: card.age })}
            </p>
            <p className="text-xs text-black/54">
              {t('chat.strangerJoin', { year: card.joinYear })}
            </p>
            <p className="text-xs text-black/54">
              {t('chat.strangerFans', { count: card.fans })}
            </p>
          </div>
        </div>
      </div>

      <p className="px-3 pt-2 text-sm text-black/87">{card.status}</p>

      <div className="flex items-center justify-end gap-2 p-2">
        <button
          type="button"
          onClick={onClose}
          className="px-3 py-1 text-sm text-black/54"
        >
          {t('chat.strangerClose')}
        </button>
        <button
          type="button"
          onClick={onBlock}
          className="px-3 py-1 text-sm text-black/54"
        >
          {t('chat.menuBlock')}
        </button>
        <button
          type="button"
          onClick={onAddFriend}
          className="flex items-center gap-1 rounded bg-ola-primary px-3 py-1 text-sm font-medium text-ola-on-primary"
        >
          <img src={addFriendIcon} alt="" className="h-4 w-4 object-contain" />
          {t('chat.menuMakeFriend')}
        </button>
      </div>
    </div>
  );
}
