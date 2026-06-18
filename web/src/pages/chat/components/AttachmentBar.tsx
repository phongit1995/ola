import { useState } from 'react';
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
import backspaceIcon from '@/assets/icons/chat/ic_backspace_selected.png';
import openGridIcon from '@/assets/icons/chat/ic_open_grid_view.png';
import localPhotoIcon from '@/assets/icons/chat/ic_local_photo_storage.png';
import cloudPhotoIcon from '@/assets/icons/chat/ic_cloud_photo_storage.png';
import switchCameraIcon from '@/assets/icons/chat/ic_action_switch_camera.png';
import snapTimerIcon from '@/assets/icons/chat/ic_snap_timer.png';
import expandCameraIcon from '@/assets/icons/chat/ic_action_expand_selected.png';
import type { ChatMessage } from '../types';

export type AttachTab = 'smiley' | 'kul' | 'camera' | 'photo' | 'voice' | 'more';

type SendPayload = Partial<ChatMessage> & Pick<ChatMessage, 'kind'>;

interface AttachmentBarProps {
  openTab: AttachTab | null;
  onToggleTab: (tab: AttachTab) => void;
  onPickEmoji: (emoji: string) => void;
  onBackspace: () => void;
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

const smileyFiles = import.meta.glob('../../../assets/icons/chat/smiley/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

const SMILEY_CODES = [
  ':-)', ':-P', '>:D<', ':-))', ':">', 'B-)', ':-X', ':-*', ':-|', ':-D',
  ';-)', '|-)', '(:|', ':-/', ':-<', ':-&', ':-(', ':-B', ':-O', ':-h',
  ':-S', ':-?', ':-((', '=((', '=;', ':-W', 'X-(', '>:)', ';))', '>:P',
  '/:)', '<3', '(*)', '@;-', '(y)', '(n)', '^_^', ':v', ':3', '=))',
  '@@', '@)', ':’(', 'O:)', '>:O',
];

const SMILEYS: Array<{ image: string; code: string }> = Object.keys(smileyFiles)
  .sort()
  .map((path, index) => ({ image: smileyFiles[path]!, code: SMILEY_CODES[index] ?? '' }));

const kulFiles = import.meta.glob('../../../assets/icons/chat/kul/*.png', {
  eager: true,
  import: 'default',
}) as Record<string, string>;

const KULS: string[] = Object.keys(kulFiles)
  .sort()
  .map((path) => kulFiles[path]!);

function SmileyPanel({ onPick, onBackspace }: { onPick: (code: string) => void; onBackspace: () => void }) {
  return (
    <div className="flex h-full flex-col">
      <div className="grid flex-1 grid-cols-8 gap-1 overflow-y-auto p-2">
        {SMILEYS.map((smiley) => (
          <button
            key={smiley.code}
            type="button"
            aria-label={smiley.code}
            onClick={() => onPick(smiley.code)}
            className="flex aspect-square items-center justify-center rounded hover:bg-gray-100"
          >
            <img src={smiley.image} alt="" className="h-7 w-7 object-contain" />
          </button>
        ))}
      </div>
      <div className="flex h-8 shrink-0 items-center justify-end gap-1 border-t border-black/12 bg-black/[0.08] px-2">
        <span className="mr-1 h-4 w-px bg-black/12" />
        <button
          type="button"
          onClick={onBackspace}
          aria-label="backspace"
          className="flex h-full w-12 items-center justify-center"
        >
          <img src={backspaceIcon} alt="" className="h-5 w-5 object-contain" />
        </button>
      </div>
    </div>
  );
}

function KulPanel({ onSend }: { onSend: (payload: SendPayload) => void }) {
  return (
    <div className="grid grid-cols-6 gap-1 p-2">
      {KULS.map((image, index) => (
        <button
          key={index}
          type="button"
          onClick={() => onSend({ kind: 'sticker', sticker: image })}
          className="flex aspect-square items-center justify-center rounded-lg hover:bg-gray-100"
        >
          <img src={image} alt="" className="max-h-full max-w-full object-contain" />
        </button>
      ))}
    </div>
  );
}

function CameraPanel({ onCapture }: { onCapture: () => void }) {
  const { t } = useTranslation();
  return (
    <div className="relative h-full bg-black">
      <div className="absolute top-2 right-2 flex h-12 w-12 items-center justify-center">
        <img src={snapTimerIcon} alt="" className="h-7 w-7 object-contain" />
      </div>
      <span className="absolute inset-x-0 top-1/2 -translate-y-1/2 text-center text-sm text-white/80">
        {t('chat.attachCameraOpening')}
      </span>
      <div className="absolute bottom-2 left-2 flex flex-col items-center gap-1">
        <span className="max-w-18 text-center text-[9px] leading-tight text-white/70">
          {t('chat.attachHoldForCam')}
        </span>
        <img src={expandCameraIcon} alt="" className="h-6 w-6 object-contain" />
      </div>
      <button
        type="button"
        onClick={onCapture}
        aria-label={t('chat.attachCameraCapture')}
        className="absolute bottom-2 left-1/2 flex h-16 w-16 -translate-x-1/2 items-center justify-center rounded-full border-4 border-white text-sm font-medium text-white active:scale-95"
      >
        {t('chat.send')}
      </button>
      <div className="absolute right-2 bottom-2 flex h-12 w-12 items-center justify-center">
        <img src={switchCameraIcon} alt="" className="h-7 w-7 object-contain" />
      </div>
    </div>
  );
}

function PhotoPanel({ onPickImage }: { onPickImage: () => void }) {
  const { t } = useTranslation();
  const [cloud, setCloud] = useState(false);
  return (
    <div className="relative h-full bg-[#d5d5d5]">
      <button
        type="button"
        onClick={onPickImage}
        className="flex h-full w-full flex-col items-center justify-center gap-2 text-sm text-black/54"
      >
        <img src={localPhotoIcon} alt="" className="h-10 w-10 object-contain opacity-60" />
        {t('chat.attachPickImage')}
      </button>
      <button
        type="button"
        onClick={onPickImage}
        aria-label={t('chat.attachPhotoOpenGrid')}
        className="absolute bottom-2 left-2 flex h-12 w-12 items-center justify-center rounded-full bg-black/45"
      >
        <img src={openGridIcon} alt="" className="h-6 w-6 object-contain" />
      </button>
      <button
        type="button"
        onClick={() => setCloud((value) => !value)}
        aria-label="cloud-local"
        className="absolute right-2 bottom-2 flex h-12 w-12 items-center justify-center rounded-full bg-black/45"
      >
        <img src={cloud ? cloudPhotoIcon : localPhotoIcon} alt="" className="h-6 w-6 object-contain" />
      </button>
    </div>
  );
}

function VoicePanel({ onRecord }: { onRecord: () => void }) {
  const { t } = useTranslation();
  return (
    <div className="flex h-full flex-col items-center justify-between bg-[#d5d5d5] py-4">
      <span className="text-sm text-black/54">0:00</span>
      <button
        type="button"
        onClick={onRecord}
        className="flex h-24 w-24 items-center justify-center rounded-full bg-ola-accent text-base font-medium text-white shadow-md active:scale-95"
      >
        {t('chat.attachRecord')}
      </button>
      <span className="text-xs text-black/54">{t('chat.attachRecordCancelTip')}</span>
    </div>
  );
}

function MorePanel({ onSend }: { onSend: (payload: SendPayload) => void }) {
  const { t } = useTranslation();
  const buttons: Array<{ key: string; label: string; onClick: () => void }> = [
    {
      key: 'location',
      label: t('chat.attachSendLocation'),
      onClick: () => onSend({ kind: 'location', address: t('chat.locationSample') }),
    },
    {
      key: 'transfer-ken',
      label: t('chat.attachTransferKen'),
      onClick: () => onSend({ kind: 'ken', kenAmount: 100 }),
    },
    {
      key: 'trading-vip',
      label: t('chat.attachTradingVip'),
      onClick: () => onSend({ kind: 'vip', vipDirection: 'sent' }),
    },
    {
      key: 'send-vip-days',
      label: t('chat.attachSendVipDays'),
      onClick: () => onSend({ kind: 'vip', vipDirection: 'sent' }),
    },
  ];
  return (
    <div className="flex flex-col gap-2 px-4 py-2">
      {buttons.map((button) => (
        <button
          key={button.key}
          type="button"
          onClick={button.onClick}
          className="h-10 w-full rounded border border-black/15 bg-white text-sm font-medium text-black/87 shadow-sm hover:bg-gray-50"
        >
          {button.label}
        </button>
      ))}
    </div>
  );
}

export function AttachmentBar({
  openTab,
  onToggleTab,
  onPickEmoji,
  onBackspace,
  onPickImage,
  onSend,
}: AttachmentBarProps) {
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
        <div className="h-52 overflow-y-auto border-t border-black/12">
          {openTab === 'smiley' && <SmileyPanel onPick={onPickEmoji} onBackspace={onBackspace} />}
          {openTab === 'kul' && <KulPanel onSend={onSend} />}
          {openTab === 'camera' && <CameraPanel onCapture={onPickImage} />}
          {openTab === 'photo' && <PhotoPanel onPickImage={onPickImage} />}
          {openTab === 'voice' && <VoicePanel onRecord={() => onSend({ kind: 'voice', voiceDuration: '0:08' })} />}
          {openTab === 'more' && <MorePanel onSend={onSend} />}
        </div>
      )}
    </div>
  );
}
