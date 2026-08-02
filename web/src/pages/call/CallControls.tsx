import { Track } from 'livekit-client';
import { useTranslation } from 'react-i18next';
import { useCallStore } from '@/store/callStore';
import {
  CamIcon,
  CamOffIcon,
  EndCallIcon,
  MicOffIcon,
  SettingsIcon,
} from './icons';
import { MicLevelIcon } from './MicLevelIcon';
import { useCallMediaToggle } from './hooks/useCallMediaToggle';
import { useTrackMuteSync } from './hooks/useTrackMuteSync';

interface CallControlsProps {
  isVideo: boolean;
  onOpenSettings: () => void;
}

interface ControlButtonProps {
  label: string;
  active?: boolean;
  tone?: 'neutral' | 'danger';
  onClick: () => void;
  children: React.ReactNode;
}

function ControlButton({
  label,
  active = false,
  tone = 'neutral',
  onClick,
  children,
}: ControlButtonProps) {
  const toneClass =
    tone === 'danger'
      ? 'bg-ola-error text-white hover:brightness-110'
      : active
      ? 'bg-white/90 text-ola-primary-darker'
      : 'bg-white/15 text-white hover:bg-white/25';

  return (
    <button
      type="button"
      aria-label={label}
      onClick={onClick}
      className={`flex h-14 w-14 items-center justify-center rounded-full transition duration-150 ease-out active:scale-95 ${toneClass}`}
    >
      {children}
    </button>
  );
}

export function CallControls({ isVideo, onOpenSettings }: CallControlsProps) {
  const { t } = useTranslation();
  const { localParticipant, micMuted, camOff, toggleMic, toggleCam } =
    useCallMediaToggle();
  const endActive = useCallStore((s) => s.endActive);

  useTrackMuteSync(Track.Source.Microphone, micMuted);
  useTrackMuteSync(Track.Source.Camera, camOff);

  return (
    <div className="flex items-center justify-center gap-4 pb-8 pt-4">
      <ControlButton
        label={micMuted ? t('call.unmute') : t('call.mute')}
        active={micMuted}
        onClick={toggleMic}
      >
        {micMuted ? (
          <MicOffIcon className="h-6 w-6" />
        ) : (
          <MicLevelIcon participant={localParticipant} muted={micMuted} />
        )}
      </ControlButton>

      {isVideo && (
        <ControlButton
          label={camOff ? t('call.cameraOn') : t('call.cameraOff')}
          active={camOff}
          onClick={toggleCam}
        >
          {camOff ? (
            <CamOffIcon className="h-6 w-6" />
          ) : (
            <CamIcon className="h-6 w-6" />
          )}
        </ControlButton>
      )}

      <ControlButton label={t('call.settings')} onClick={onOpenSettings}>
        <SettingsIcon className="h-6 w-6" />
      </ControlButton>

      <ControlButton
        label={t('call.endCall')}
        tone="danger"
        onClick={endActive}
      >
        <EndCallIcon className="h-6 w-6" />
      </ControlButton>
    </div>
  );
}
