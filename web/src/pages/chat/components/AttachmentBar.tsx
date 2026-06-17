import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import kulIcon from '@/assets/icons/chat/ic_kul.png';
import kulIconActive from '@/assets/icons/chat/ic_kul_selected.png';
import cameraIcon from '@/assets/icons/chat/ic_camera.png';
import cameraIconActive from '@/assets/icons/chat/ic_camera_selected.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import photoIconActive from '@/assets/icons/chat/ic_local_selected.png';
import voiceIcon from '@/assets/icons/chat/ic_voice.png';
import voiceIconActive from '@/assets/icons/chat/ic_voice_selected.png';
import moreIcon from '@/assets/icons/chat/ic_more.png';
import moreIconActive from '@/assets/icons/chat/ic_more_selected.png';
import type { ChatMessage } from '../types';

export type AttachTab = 'smiley' | 'kul' | 'camera' | 'photo' | 'voice' | 'more';

type SendPayload = Partial<ChatMessage> & Pick<ChatMessage, 'kind'>;

interface AttachmentBarProps {
  openTab: AttachTab | null;
  onToggleTab: (tab: AttachTab) => void;
  onPickEmoji: (emoji: string) => void;
  onPickImage: () => void;
  onSend: (payload: SendPayload) => void;
}

const TABS: Array<{ key: AttachTab; icon: string; iconActive: string }> = [
  { key: 'smiley', icon: smileyIcon, iconActive: smileyIconActive },
  { key: 'kul', icon: kulIcon, iconActive: kulIconActive },
  { key: 'camera', icon: cameraIcon, iconActive: cameraIconActive },
  { key: 'photo', icon: photoIcon, iconActive: photoIconActive },
  { key: 'voice', icon: voiceIcon, iconActive: voiceIconActive },
  { key: 'more', icon: moreIcon, iconActive: moreIconActive },
];

const EMOJIS = [
  '😀', '😁', '😂', '🤣', '😊', '😍', '😘', '😎',
  '😢', '😭', '😡', '👍', '👎', '👏', '🙏', '💪',
  '❤️', '💔', '🔥', '🎉', '🌹', '☀️', '🎧', '⚽',
];

const STICKERS = ['👍', '😂', '😍', '😎', '😭', '🥰', '🤗', '🙌', '🎉', '💯', '🔥', '🌸'];

function EmojiPanel({ onPick }: { onPick: (emoji: string) => void }) {
  return (
    <div className="grid grid-cols-8 gap-1 p-3">
      {EMOJIS.map((emoji) => (
        <button
          key={emoji}
          type="button"
          onClick={() => onPick(emoji)}
          className="flex h-9 items-center justify-center rounded text-2xl hover:bg-gray-100"
        >
          {emoji}
        </button>
      ))}
    </div>
  );
}

function StickerPanel({ onSend }: { onSend: (payload: SendPayload) => void }) {
  return (
    <div className="grid grid-cols-4 gap-2 p-3">
      {STICKERS.map((sticker) => (
        <button
          key={sticker}
          type="button"
          onClick={() => onSend({ kind: 'sticker', sticker })}
          className="flex h-16 items-center justify-center rounded-lg bg-ola-primary-light text-4xl hover:bg-ola-primary-light/70"
        >
          {sticker}
        </button>
      ))}
    </div>
  );
}

function PhotoPanel({ onPickImage }: { onPickImage: () => void }) {
  const { t } = useTranslation();
  return (
    <div className="grid grid-cols-4 gap-1 p-2">
      <button
        type="button"
        onClick={onPickImage}
        className="col-span-4 flex flex-col items-center gap-1 rounded py-6 text-sm text-black/54 hover:bg-gray-100"
      >
        <span className="flex h-12 w-12 items-center justify-center rounded-full bg-ola-primary-light text-2xl">
          🖼️
        </span>
        {t('chat.attachPickImage')}
      </button>
    </div>
  );
}

function ActionGrid({ items }: { items: Array<{ icon: string; label: string; onClick: () => void }> }) {
  return (
    <div className="grid grid-cols-4 gap-2 p-3">
      {items.map((item) => (
        <button
          key={item.label}
          type="button"
          onClick={item.onClick}
          className="flex flex-col items-center gap-1 rounded py-2 text-xs text-black/54 hover:bg-gray-100"
        >
          <span className="flex h-12 w-12 items-center justify-center rounded-full bg-ola-primary-light text-2xl">
            {item.icon}
          </span>
          {item.label}
        </button>
      ))}
    </div>
  );
}

export function AttachmentBar({ openTab, onToggleTab, onPickEmoji, onPickImage, onSend }: AttachmentBarProps) {
  const { t } = useTranslation();

  const tabLabels: Record<AttachTab, string> = {
    smiley: t('chat.attachTabSmiley'),
    kul: t('chat.attachTabKul'),
    camera: t('chat.attachTabCamera'),
    photo: t('chat.attachTabPhoto'),
    voice: t('chat.attachTabVoice'),
    more: t('chat.attachTabMore'),
  };

  return (
    <div className="shrink-0 border-t border-black/12 bg-white">
      <div className="flex">
        {TABS.map((tab) => {
          const isActive = tab.key === openTab;
          return (
            <button
              key={tab.key}
              type="button"
              aria-label={tabLabels[tab.key]}
              onClick={() => onToggleTab(tab.key)}
              className={`flex h-11 flex-1 items-center justify-center ${
                isActive ? 'opacity-100' : 'opacity-60'
              }`}
            >
              <img src={isActive ? tab.iconActive : tab.icon} alt="" className="h-6 w-6 object-contain" />
            </button>
          );
        })}
      </div>

      {openTab != null && (
        <div className="h-60 overflow-y-auto border-t border-black/12">
          {openTab === 'smiley' && <EmojiPanel onPick={onPickEmoji} />}
          {openTab === 'kul' && <StickerPanel onSend={onSend} />}
          {openTab === 'camera' && (
            <ActionGrid
              items={[
                { icon: '📷', label: t('chat.attachCameraCapture'), onClick: onPickImage },
                { icon: '🎥', label: t('chat.attachCameraRecord'), onClick: () => onSend({ kind: 'image', image: '🎬' }) },
              ]}
            />
          )}
          {openTab === 'photo' && <PhotoPanel onPickImage={onPickImage} />}
          {openTab === 'voice' && (
            <ActionGrid
              items={[
                { icon: '🎤', label: t('chat.attachTabVoice'), onClick: () => onSend({ kind: 'voice', voiceDuration: '0:08' }) },
              ]}
            />
          )}
          {openTab === 'more' && (
            <ActionGrid
              items={[
                { icon: '📍', label: t('chat.attachLocation'), onClick: () => onSend({ kind: 'location', address: t('chat.locationSample') }) },
                { icon: '▶️', label: t('chat.attachYoutube'), onClick: () => onSend({ kind: 'youtube', youtubeTitle: t('chat.youtubeSample'), youtubeDuration: '3:45' }) },
                { icon: '⏱️', label: t('chat.attachSnap'), onClick: () => onSend({ kind: 'snap' }) },
                { icon: '💰', label: t('chat.attachKen'), onClick: () => onSend({ kind: 'ken', kenAmount: 100 }) },
                { icon: '👑', label: t('chat.attachVip'), onClick: () => onSend({ kind: 'vip', vipDirection: 'sent' }) },
              ]}
            />
          )}
        </div>
      )}
    </div>
  );
}
