import { useRef, useState, type PointerEvent as ReactPointerEvent, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import smileyIcon from '@/assets/icons/chat/ic_smiley.png';
import smileyIconActive from '@/assets/icons/chat/ic_smiley_selected.png';
import emojiIcon from '@/assets/icons/emoji/10_smiley_colon_dash_D.png';
import kulIcon from '@/assets/icons/chat/ic_kul.png';
import kulIconActive from '@/assets/icons/chat/ic_kul_selected.png';
import smileyTabIcon from '@/assets/icons/chat/ic_tab_smiley.png';
import emojiTabIcon from '@/assets/icons/chat/ic_tab_emoji.png';
import kulTabIcon from '@/assets/icons/chat/ic_tab_kul.png';
import backspaceIcon from '@/assets/icons/chat/ic_backspace_selected.png';
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
import { EMOJI_IMAGES, emojiToken, formatDurationMs, KUL_IMAGES, toast } from '@lib';
import { useLongPress, useVoiceRecorder } from '@hooks';
import { SmileyGrid } from './SmileyGrid';

export type AttachTab = 'smiley' | 'emoji' | 'kul' | 'camera' | 'photo' | 'voice' | 'more';

export type AttachBarVariant = 'full' | 'compact';

export interface AttachSendPayload {
  kind: 'location' | 'ken' | 'vip' | 'voice';
  address?: string;
  kenAmount?: number;
  vipDirection?: 'sent' | 'received';
  voiceDuration?: string;
}

const ALL_TABS: AttachTab[] = ['smiley', 'emoji', 'kul', 'camera', 'photo', 'voice', 'more'];

const ATTACH_TAB_ICONS: Record<AttachTab, { icon: string; iconActive: string }> = {
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
  openTab: AttachTab | null;
  onToggleTab: (tab: AttachTab) => void;
  onPickEmoji: (emoji: string) => void;
  onBackspace?: () => void;
  onPickImage: () => void;
  onSendKul: (index: number) => void;
  onSend: (payload: AttachSendPayload) => void;
  onRecorded?: (blob: Blob, duration: number) => void;
  tabs?: AttachTab[];
  showTabBar?: boolean;
  variant?: AttachBarVariant;
}

function InsertPanel({ onBackspace, children }: { onBackspace?: () => void; children: ReactNode }) {
  return (
    <div className="flex h-full flex-col">
      <div className="flex-1 overflow-y-auto">{children}</div>
      {onBackspace != null && (
        <div className="flex h-8 shrink-0 items-center justify-end gap-1 border-t border-black/12 bg-white px-2">
          <span className="mr-1 h-4 w-px bg-black/12" />
          <button
            type="button"
            onMouseDown={(event) => event.preventDefault()}
            onClick={onBackspace}
            aria-label="backspace"
            title="backspace"
            className="flex h-full w-12 items-center justify-center"
          >
            <img src={backspaceIcon} alt="" className="h-5 w-5 object-contain" />
          </button>
        </div>
      )}
    </div>
  );
}

function SmileyPanel({ onPick, onBackspace }: { onPick: (code: string) => void; onBackspace?: () => void }) {
  return (
    <InsertPanel onBackspace={onBackspace}>
      <SmileyGrid onPick={onPick} />
    </InsertPanel>
  );
}

function EmojiPanel({ onPick, onBackspace }: { onPick: (token: string) => void; onBackspace?: () => void }) {
  return (
    <InsertPanel onBackspace={onBackspace}>
      <div className="grid grid-cols-8 gap-1 p-2">
        {EMOJI_IMAGES.map((image, index) => (
          <button
            key={index}
            type="button"
            onMouseDown={(event) => event.preventDefault()}
            onClick={() => onPick(emojiToken(index + 1))}
            className="flex h-9 items-center justify-center rounded hover:bg-gray-100"
          >
            <img src={image} alt="" className="h-[22px] w-auto object-contain" />
          </button>
        ))}
      </div>
    </InsertPanel>
  );
}

function KulPanel({ onSendKul }: { onSendKul: (index: number) => void }) {
  return (
    <div className="grid grid-cols-6 gap-1 p-2">
      {KUL_IMAGES.map((image, index) => (
        <button
          key={index}
          type="button"
          onClick={() => onSendKul(index + 1)}
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

function VoicePanel({ onRecorded }: { onRecorded: (blob: Blob, duration: number) => void }) {
  const { t } = useTranslation();
  const [cancelArmed, setCancelArmed] = useState(false);
  const activeRef = useRef(false);
  const heldRef = useRef(false);
  const cancelRef = useRef(false);
  const recorder = useVoiceRecorder((error) => {
    activeRef.current = false;
    heldRef.current = false;
    cancelRef.current = false;
    setCancelArmed(false);
    toast.error(error === 'denied' ? t('chat.voiceMicDenied') : t('chat.voiceRecordError'));
  });

  async function finalize() {
    if (!activeRef.current) return;
    activeRef.current = false;
    if (cancelRef.current) {
      recorder.cancel();
      cancelRef.current = false;
      setCancelArmed(false);
      return;
    }
    const result = await recorder.stop();
    setCancelArmed(false);
    if (result != null) onRecorded(result.blob, result.duration);
  }

  async function handlePointerDown(event: ReactPointerEvent<HTMLButtonElement>) {
    event.currentTarget.setPointerCapture?.(event.pointerId);
    heldRef.current = true;
    cancelRef.current = false;
    setCancelArmed(false);
    const started = await recorder.start();
    if (!started) {
      heldRef.current = false;
      return;
    }
    activeRef.current = true;
    if (!heldRef.current) await finalize();
  }

  function handlePointerMove(event: ReactPointerEvent<HTMLButtonElement>) {
    if (!activeRef.current) return;
    const rect = event.currentTarget.getBoundingClientRect();
    const outside =
      event.clientX < rect.left ||
      event.clientX > rect.right ||
      event.clientY < rect.top ||
      event.clientY > rect.bottom;
    cancelRef.current = outside;
    setCancelArmed(outside);
  }

  async function handlePointerUp() {
    heldRef.current = false;
    if (!activeRef.current) return;
    await finalize();
  }

  return (
    <div className="flex h-full flex-col items-center justify-between bg-[#d5d5d5] py-4">
      <span className="text-sm text-black/54">{formatDurationMs(recorder.elapsedMs)}</span>
      <button
        type="button"
        onPointerDown={handlePointerDown}
        onPointerMove={handlePointerMove}
        onPointerUp={handlePointerUp}
        onPointerCancel={handlePointerUp}
        className={`flex h-24 w-24 touch-none items-center justify-center rounded-full text-base font-medium text-white shadow-md transition select-none active:scale-95 ${
          recorder.isRecording ? `scale-110 ${cancelArmed ? 'bg-ola-error' : 'bg-ola-accent'}` : 'bg-ola-accent'
        }`}
      >
        {t('chat.attachRecord')}
      </button>
      <span className="text-xs text-black/54">
        {cancelArmed ? t('chat.voiceReleaseCancel') : t('chat.attachRecordCancelTip')}
      </span>
    </div>
  );
}

function MorePanel({ onSend }: { onSend: (payload: AttachSendPayload) => void }) {
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
  onSendKul,
  onSend,
  onRecorded,
  tabs = ALL_TABS,
  showTabBar = true,
  variant = 'full',
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
    <div className={`shrink-0 bg-white ${showTabBar ? 'border-t border-black/12' : ''}`}>
      {showTabBar && (
        <div className="flex">
          {tabs.map((tab) => {
          const isActive = tab === openTab;
          const isPhoto = tab === 'photo';
          return (
            <button
              key={tab}
              type="button"
              aria-label={tabLabels[tab]}
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
                onToggleTab(tab);
              }}
              className={
                isCompact
                  ? `relative flex h-11 flex-1 select-none items-center justify-center transition-colors ${
                      isActive ? 'bg-ola-primary/10' : 'hover:bg-black/5'
                    }`
                  : `flex h-11 flex-1 select-none items-center justify-center ${
                      isActive ? 'opacity-100' : 'opacity-60'
                    }`
              }
            >
              <img
                src={
                  isCompact
                    ? COMPACT_TAB_ICONS[tab] ?? ATTACH_TAB_ICONS[tab].icon
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
                <span className="absolute inset-x-4 bottom-0 h-0.5 rounded-full bg-ola-primary" />
              )}
            </button>
          );
        })}
        </div>
      )}

      {openTab != null && (
        <div className="h-52 overflow-y-auto border-t border-black/12">
          {openTab === 'smiley' && <SmileyPanel onPick={onPickEmoji} onBackspace={onBackspace} />}
          {openTab === 'emoji' && <EmojiPanel onPick={onPickEmoji} onBackspace={onBackspace} />}
          {openTab === 'kul' && <KulPanel onSendKul={onSendKul} />}
          {openTab === 'camera' && <CameraPanel onCapture={onPickImage} />}
          {openTab === 'photo' && <PhotoPanel onPickImage={onPickImage} />}
          {openTab === 'voice' && <VoicePanel onRecorded={onRecorded ?? (() => undefined)} />}
          {openTab === 'more' && <MorePanel onSend={onSend} />}
        </div>
      )}
    </div>
  );
}
