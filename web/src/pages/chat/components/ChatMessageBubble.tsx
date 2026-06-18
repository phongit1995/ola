import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import checkedIcon from '@/assets/icons/profile/ic_checked.png';
import playIcon from '@/assets/icons/chat/ic_play_media.png';
import snapIcon from '@/assets/icons/chat/icon_snap_pic.png';
import kenIcon from '@/assets/icons/chat/ic_ken_white.png';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import { kulImageForText } from '../kul';
import type { ChatMessage } from '../types';

const VOICE_BARS = [6, 10, 14, 8, 12, 16, 9, 13, 7, 11, 15, 8, 12, 6];

interface ChatMessageBubbleProps {
  message: ChatMessage;
  firstInGroup?: boolean;
  lastInGroup?: boolean;
}

export function ChatMessageBubble({
  message,
  firstInGroup = true,
  lastInGroup = true,
}: ChatMessageBubbleProps) {
  const { t } = useTranslation();
  const isOut = message.direction === 'out';
  const failed = isOut && message.status === 'failed';
  const surface = isOut ? 'bg-[#dcedc8]' : 'bg-white shadow-sm';
  const groupCorners = isOut
    ? `${firstInGroup ? '' : 'rounded-tr-sm'} ${lastInGroup ? '' : 'rounded-br-sm'}`
    : `${firstInGroup ? '' : 'rounded-tl-sm'} ${lastInGroup ? '' : 'rounded-bl-sm'}`;
  const bubbleBg = failed ? 'bg-[#f8d7d7]' : isOut ? 'bg-[#dcedc8]' : 'bg-white shadow-sm';

  if (message.kind === 'text') {
    const kulImage = kulImageForText(message.text);
    if (kulImage != null) {
      return <img src={kulImage} alt="" className="h-30 w-auto object-contain" />;
    }
  }

  switch (message.kind) {
    case 'sticker':
      return <span className="px-1 text-6xl leading-none">{message.sticker}</span>;

    case 'image':
      return message.image != null && message.image !== '' ? (
        <img
          src={message.image}
          alt=""
          className="max-h-60 max-w-[220px] cursor-pointer rounded-lg object-cover shadow-sm"
        />
      ) : (
        <div className="flex h-44 w-44 items-center justify-center overflow-hidden rounded-lg bg-linear-to-br from-ola-primary-light to-ola-primary/30 text-6xl shadow-sm">
          🖼️
        </div>
      );

    case 'voice':
      return (
        <div
          className={`flex items-center gap-2 rounded-2xl px-3 py-2 ${
            isOut ? 'rounded-tr-sm' : 'rounded-tl-sm'
          } ${surface}`}
        >
          <img src={playIcon} alt="" className="h-5 w-5 object-contain" />
          <span className="flex h-6 items-center gap-0.5">
            {VOICE_BARS.map((height, index) => (
              <span
                key={index}
                className="w-0.5 rounded-full bg-ola-primary/70"
                style={{ height }}
              />
            ))}
          </span>
          <span className="text-xs text-black/54">{message.voiceDuration}</span>
        </div>
      );

    case 'location':
      return (
        <div className={`w-44 overflow-hidden rounded-lg ${surface}`}>
          <div className="flex h-28 items-center justify-center bg-linear-to-br from-[#A5D6A7] to-[#66BB6A] text-4xl">
            📍
          </div>
          <p className="px-2 py-1.5 text-xs text-black/87">{message.address}</p>
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
            <span className="flex h-10 w-10 items-center justify-center rounded-full bg-[#FF0000] text-white">▶</span>
          </div>
          <div className="px-2 py-1.5">
            <p className="truncate text-xs font-medium text-black/87">{message.youtubeTitle}</p>
            <p className="text-xs text-black/54">{message.youtubeDuration}</p>
          </div>
        </div>
      );

    case 'ken':
      return (
        <div className={`flex items-center gap-2 rounded-2xl px-3 py-2 ${
          isOut ? 'rounded-tr-sm' : 'rounded-tl-sm'
        } ${surface}`}>
          <span className="flex h-8 w-8 items-center justify-center rounded-full bg-ola-primary">
            <img src={kenIcon} alt="" className="h-4 w-4 object-contain" />
          </span>
          <span className="text-2xl font-bold text-ola-primary-darker">{message.kenAmount}</span>
          <span className="text-sm text-black/54">{t('chat.kenLabel')}</span>
        </div>
      );

    case 'vip':
      return (
        <div className={`flex items-center gap-2 rounded-2xl px-3 py-2 ${
          isOut ? 'rounded-tr-sm' : 'rounded-tl-sm'
        } ${surface}`}>
          <span className="text-2xl">🎁</span>
          <span className="text-sm font-medium text-ola-accent">
            {message.vipDirection === 'received' ? t('chat.vipReceived') : t('chat.vipSent')}
          </span>
        </div>
      );

    default:
      return (
        <div
          className={`max-w-[300px] rounded-2xl px-3 py-2 text-base break-words text-black/87 ${groupCorners} ${bubbleBg}`}
        >
          {message.text}
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

export function StrangerCardBubble({ message, onClose, onBlock, onAddFriend }: StrangerCardBubbleProps) {
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
              <span className="truncate text-base font-medium text-black/87">{card.name}</span>
              {card.verified && <img src={checkedIcon} alt="" className="h-4 w-4 object-contain" />}
            </div>
            <p className="text-xs text-black/54">{t('chat.strangerAge', { age: card.age })}</p>
            <p className="text-xs text-black/54">{t('chat.strangerJoin', { year: card.joinYear })}</p>
            <p className="text-xs text-black/54">{t('chat.strangerFans', { count: card.fans })}</p>
          </div>
        </div>
      </div>

      <p className="px-3 pt-2 text-sm text-black/87">{card.status}</p>

      <div className="flex items-center justify-end gap-2 p-2">
        <button type="button" onClick={onClose} className="px-3 py-1 text-sm text-black/54">
          {t('chat.strangerClose')}
        </button>
        <button type="button" onClick={onBlock} className="px-3 py-1 text-sm text-black/54">
          {t('chat.menuBlock')}
        </button>
        <button
          type="button"
          onClick={onAddFriend}
          className="flex items-center gap-1 rounded bg-ola-primary px-3 py-1 text-sm font-medium text-white"
        >
          <img src={addFriendIcon} alt="" className="h-4 w-4 object-contain" />
          {t('chat.menuMakeFriend')}
        </button>
      </div>
    </div>
  );
}
