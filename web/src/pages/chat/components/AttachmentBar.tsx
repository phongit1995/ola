import { useTranslation } from 'react-i18next';
import textIcon from '@/assets/icons/chat/ic_chat_text.png';
import textIconActive from '@/assets/icons/chat/ic_chat_text_selected.png';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import cameraIcon from '@/assets/icons/chat/ic_camera.png';
import cameraIconActive from '@/assets/icons/chat/ic_camera_selected.png';
import voiceIcon from '@/assets/icons/chat/ic_voice.png';
import voiceIconActive from '@/assets/icons/chat/ic_voice_selected.png';
import moreIcon from '@/assets/icons/chat/ic_more.png';
import moreIconActive from '@/assets/icons/chat/ic_more_selected.png';

export type AttachTab = 'text' | 'smiley' | 'camera' | 'voice' | 'more';

interface AttachmentBarProps {
  activeTab: AttachTab;
  onTabChange: (tab: AttachTab) => void;
  onPickEmoji: (emoji: string) => void;
  onClose: () => void;
}

const TABS: Array<{ key: AttachTab; icon: string; iconActive: string }> = [
  { key: 'text', icon: textIcon, iconActive: textIconActive },
  { key: 'smiley', icon: smileyIcon, iconActive: smileyIconActive },
  { key: 'camera', icon: cameraIcon, iconActive: cameraIconActive },
  { key: 'voice', icon: voiceIcon, iconActive: voiceIconActive },
  { key: 'more', icon: moreIcon, iconActive: moreIconActive },
];

const EMOJIS = [
  '😀', '😁', '😂', '🤣', '😊', '😍', '😘', '😎',
  '😢', '😭', '😡', '👍', '👎', '👏', '🙏', '💪',
  '❤️', '💔', '🔥', '🎉', '🌹', '☀️', '🎧', '⚽',
];

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

function GridPanel({ items }: { items: Array<{ icon: string; label: string }> }) {
  return (
    <div className="grid grid-cols-4 gap-2 p-3">
      {items.map((item) => (
        <div
          key={item.label}
          className="flex flex-col items-center gap-1 rounded py-2 text-xs text-black/54"
        >
          <span className="flex h-12 w-12 items-center justify-center rounded-full bg-ola-primary-light text-2xl">
            {item.icon}
          </span>
          {item.label}
        </div>
      ))}
    </div>
  );
}

export function AttachmentBar({
  activeTab,
  onTabChange,
  onPickEmoji,
  onClose,
}: AttachmentBarProps) {
  const { t } = useTranslation();

  const tabLabels: Record<AttachTab, string> = {
    text: t('chat.attachTabText'),
    smiley: t('chat.attachTabSmiley'),
    camera: t('chat.attachTabCamera'),
    voice: t('chat.attachTabVoice'),
    more: t('chat.attachTabMore'),
  };

  function handleTab(tab: AttachTab) {
    if (tab === 'text') {
      onClose();
      return;
    }
    onTabChange(tab);
  }

  return (
    <div className="border-t border-black/12 bg-white">
      <div className="flex">
        {TABS.map((tab) => {
          const isActive = tab.key === activeTab;
          return (
            <button
              key={tab.key}
              type="button"
              aria-label={tabLabels[tab.key]}
              onClick={() => handleTab(tab.key)}
              className={`flex h-11 flex-1 items-center justify-center ${
                isActive ? 'opacity-100' : 'opacity-60'
              }`}
            >
              <img
                src={isActive ? tab.iconActive : tab.icon}
                alt=""
                className="h-6 w-6 object-contain"
              />
            </button>
          );
        })}
      </div>
      <div className="h-60 overflow-y-auto">
        {activeTab === 'smiley' && <EmojiPanel onPick={onPickEmoji} />}
        {activeTab === 'camera' && (
          <GridPanel
            items={[
              { icon: '📷', label: t('chat.attachCameraCapture') },
              { icon: '🎥', label: t('chat.attachCameraRecord') },
            ]}
          />
        )}
        {activeTab === 'voice' && (
          <div className="flex h-full items-center justify-center px-4 text-center text-sm text-black/54">
            {t('chat.attachVoiceHint')}
          </div>
        )}
        {activeTab === 'more' && (
          <GridPanel
            items={[
              { icon: '📍', label: t('chat.attachLocation') },
              { icon: '▶️', label: t('chat.attachYoutube') },
              { icon: '⏱️', label: t('chat.attachSnap') },
              { icon: '💰', label: t('chat.attachKen') },
              { icon: '👑', label: t('chat.attachVip') },
            ]}
          />
        )}
      </div>
    </div>
  );
}
