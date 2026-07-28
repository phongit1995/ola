import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import emojiIcon from '@/assets/icons/emoji/10_smiley_colon_dash_D.png';
import kulIcon from '@/assets/icons/chat/ic_kul.png';
import kulIconActive from '@/assets/icons/chat/ic_kul_selected.png';
import smileyTabIcon from '@/assets/icons/chat/ic_tab_smiley.png';
import emojiTabIcon from '@/assets/icons/chat/ic_tab_emoji.png';
import kulTabIcon from '@/assets/icons/chat/ic_tab_kul.png';
import cameraIcon from '@/assets/icons/chat/ic_camera.png';
import cameraIconActive from '@/assets/icons/chat/ic_camera_selected.png';
import photoIcon from '@/assets/icons/chat/ic_local.png';
import photoIconActive from '@/assets/icons/chat/ic_local_selected.png';
import voiceIcon from '@/assets/icons/chat/ic_voice.png';
import voiceIconActive from '@/assets/icons/chat/ic_voice_selected.png';
import moreIcon from '@/assets/icons/chat/ic_more.png';
import moreIconActive from '@/assets/icons/chat/ic_more_selected.png';
import openGridIcon from '@/assets/icons/chat/ic_open_grid_view.png';
import localPhotoIcon from '@/assets/icons/chat/ic_local_photo_storage.png';
import cloudPhotoIcon from '@/assets/icons/chat/ic_cloud_photo_storage.png';
import switchCameraIcon from '@/assets/icons/chat/ic_action_switch_camera.png';
import snapTimerIcon from '@/assets/icons/chat/ic_snap_timer.png';
import expandCameraIcon from '@/assets/icons/chat/ic_action_expand_selected.png';
import { useLongPress } from '@hooks';
import {
  EmojiPanel,
  KulPanel,
  SmileyGroupPanel,
  SmileyPanel,
} from './SmileyGroupPanel';

export type AttachTab =
  | 'smiley'
  | 'emoji'
  | 'kul'
  | 'camera'
  | 'photo'
  | 'voice'
  | 'more';

export type AttachPanelTab = Exclude<AttachTab, 'voice'>;

export type AttachBarVariant = 'full' | 'compact';

export interface AttachSendPayload {
  kind: 'location' | 'ken' | 'vip' | 'vipDays';
  address?: string;
  kenAmount?: number;
  vipDirection?: 'sent' | 'received';
}

const ALL_TABS: AttachTab[] = [
  'smiley',
  'emoji',
  'kul',
  'camera',
  'photo',
  'voice',
  'more',
];

const ATTACH_TAB_ICONS: Record<
  AttachTab,
  { icon: string; iconActive: string }
> = {
  smiley: { icon: smileyIcon, iconActive: smileyIconActive },
  emoji: { icon: emojiIcon, iconActive: emojiIcon },
  kul: { icon: kulIcon, iconActive: kulIconActive },
  camera: { icon: cameraIcon, iconActive: cameraIconActive },
  photo: { icon: photoIcon, iconActive: photoIconActive },
  voice: { icon: voiceIcon, iconActive: voiceIconActive },
  more: { icon: moreIcon, iconActive: moreIconActive },
};

const COMPACT_TAB_ICONS: Partial<Record<AttachTab, string>> = {
  smiley: smileyTabIcon,
  emoji: emojiTabIcon,
  kul: kulTabIcon,
};

interface AttachmentBarProps {
  openTab: AttachPanelTab | null;
  onToggleTab: (tab: AttachPanelTab) => void;
  onStartVoice: () => void;
  onPickEmoji: (emoji: string) => void;
  onBackspace?: () => void;
  onPickImage: () => void;
  onSendKul: (index: number) => void;
  onSend: (payload: AttachSendPayload) => void;
  tabs?: AttachTab[];
  showTabBar?: boolean;
  variant?: AttachBarVariant;
  groupSmileyTabs?: boolean;
  voiceDisabled?: boolean;
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
        <img
          src={localPhotoIcon}
          alt=""
          className="h-10 w-10 object-contain opacity-60"
        />
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
        <img
          src={cloud ? cloudPhotoIcon : localPhotoIcon}
          alt=""
          className="h-6 w-6 object-contain"
        />
      </button>
    </div>
  );
}

function MorePanel({
  onSend,
}: {
  onSend: (payload: AttachSendPayload) => void;
}) {
  const { t } = useTranslation();
  const buttons: Array<{ key: string; label: string; onClick: () => void }> = [
    {
      key: 'location',
      label: t('chat.attachSendLocation'),
      onClick: () =>
        onSend({ kind: 'location', address: t('chat.locationSample') }),
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
      onClick: () => onSend({ kind: 'vipDays' }),
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
  onStartVoice,
  onPickEmoji,
  onBackspace,
  onPickImage,
  onSendKul,
  onSend,
  tabs = ALL_TABS,
  showTabBar = true,
  variant = 'full',
  groupSmileyTabs = false,
  voiceDisabled = false,
}: AttachmentBarProps) {
  const { t } = useTranslation();
  const isCompact = variant === 'compact';
  const suppressPhotoClick = useRef(false);
  const photoLongPress = useLongPress(() => {
    suppressPhotoClick.current = true;
    onPickImage();
  });

  const tabLabels: Record<AttachTab, string> = {
    smiley: t('chat.attachTabSmiley'),
    emoji: t('chat.attachTabEmoji'),
    kul: t('chat.attachTabKul'),
    camera: t('chat.attachTabCamera'),
    photo: t('chat.attachTabPhoto'),
    voice: t('chat.attachTabVoice'),
    more: t('chat.attachTabMore'),
  };

  if (!showTabBar && openTab == null) return null;

  return (
    <div
      className={`shrink-0 bg-white ${showTabBar ? 'border-t border-black/12' : ''}`}
    >
      {showTabBar && (
        <div className="flex">
          {tabs.map((tab) => {
            const isVoice = tab === 'voice';
            const isActive = !isVoice && tab === openTab;
            const isPhoto = tab === 'photo';
            const isDisabled = isVoice && voiceDisabled;
            return (
              <button
                key={tab}
                type="button"
                aria-label={tabLabels[tab]}
                disabled={isDisabled}
                {...(isPhoto ? photoLongPress : {})}
                onPointerDown={
                  isPhoto
                    ? (event) => {
                        suppressPhotoClick.current = false;
                        photoLongPress.onPointerDown(event);
                      }
                    : undefined
                }
                onClick={() => {
                  if (isPhoto && suppressPhotoClick.current) {
                    suppressPhotoClick.current = false;
                    return;
                  }
                  if (isVoice) {
                    onStartVoice();
                    return;
                  }
                  onToggleTab(tab);
                }}
                className={
                  isCompact
                    ? `relative flex h-11 flex-1 select-none items-center justify-center transition-colors ${
                        isDisabled
                          ? 'cursor-not-allowed opacity-30'
                          : isActive
                            ? 'bg-ola-primary/10'
                            : 'hover:bg-black/5'
                      }`
                    : `flex h-11 flex-1 select-none items-center justify-center ${
                        isDisabled
                          ? 'cursor-not-allowed opacity-30'
                          : isActive
                            ? 'opacity-100'
                            : 'opacity-60'
                      }`
                }
              >
                <img
                  src={
                    isCompact
                      ? (COMPACT_TAB_ICONS[tab] ?? ATTACH_TAB_ICONS[tab].icon)
                      : isActive
                        ? ATTACH_TAB_ICONS[tab].iconActive
                        : ATTACH_TAB_ICONS[tab].icon
                  }
                  alt=""
                  className={
                    isCompact
                      ? `h-6 w-6 object-contain transition-opacity ${isActive ? 'opacity-100' : 'opacity-60'}`
                      : 'h-6 w-6 object-contain'
                  }
                />
                {isCompact && isActive && (
                  <span className="absolute inset-x-0 bottom-0 h-0.5 bg-ola-primary" />
                )}
              </button>
            );
          })}
        </div>
      )}

      {openTab != null && (
        <div className="h-52 overflow-y-auto border-t border-black/12">
          {openTab === 'smiley' &&
            (groupSmileyTabs ? (
              <SmileyGroupPanel
                onPick={onPickEmoji}
                onSendKul={onSendKul}
                onBackspace={onBackspace}
              />
            ) : (
              <SmileyPanel onPick={onPickEmoji} onBackspace={onBackspace} />
            ))}
          {openTab === 'emoji' && (
            <EmojiPanel onPick={onPickEmoji} onBackspace={onBackspace} />
          )}
          {openTab === 'kul' && <KulPanel onSendKul={onSendKul} />}
          {openTab === 'camera' && <CameraPanel onCapture={onPickImage} />}
          {openTab === 'photo' && <PhotoPanel onPickImage={onPickImage} />}
          {openTab === 'more' && <MorePanel onSend={onSend} />}
        </div>
      )}
    </div>
  );
}
