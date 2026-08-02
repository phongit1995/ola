import { useState } from 'react';
import { Pressable, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useCallStore } from '@store/callStore';
import {
  CamIcon,
  CamOffIcon,
  EndCallIcon,
  MicIcon,
  MicOffIcon,
  SpeakerIcon,
  SwitchCameraIcon,
} from './icons';
import { useCallMediaToggle } from './hooks/useCallMediaToggle';
import { setSpeakerEnabled } from './lib/callAudioSession';

const ACTIVE_ICON_COLOR = '#33691e';

interface ControlButtonProps {
  label: string;
  active?: boolean;
  tone?: 'neutral' | 'danger';
  onPress: () => void;
  children: React.ReactNode;
}

function ControlButton({
  label,
  active = false,
  tone = 'neutral',
  onPress,
  children,
}: ControlButtonProps) {
  const toneClass =
    tone === 'danger'
      ? 'bg-ola-error'
      : active
        ? 'bg-white/90'
        : 'bg-white/15 active:bg-white/25';

  return (
    <Pressable
      accessibilityLabel={label}
      onPress={onPress}
      className={`h-14 w-14 items-center justify-center rounded-full ${toneClass}`}
    >
      {children}
    </Pressable>
  );
}

interface CallControlsProps {
  isVideo: boolean;
}

export function CallControls({ isVideo }: CallControlsProps) {
  const { t } = useTranslation();
  const endActive = useCallStore((s) => s.endActive);
  const { micMuted, camOff, toggleMic, toggleCam, switchCamera } =
    useCallMediaToggle();
  const [speakerOn, setSpeakerOn] = useState(isVideo);

  const toggleSpeaker = async () => {
    const next = !speakerOn;
    const applied = await setSpeakerEnabled(next).catch(() => false);
    if (applied) setSpeakerOn(next);
  };

  return (
    <View className="flex-row items-center justify-center gap-4">
      <ControlButton
        label={micMuted ? t('call.unmute') : t('call.mute')}
        active={micMuted}
        onPress={toggleMic}
      >
        {micMuted ? (
          <MicOffIcon size={24} color={ACTIVE_ICON_COLOR} />
        ) : (
          <MicIcon size={24} />
        )}
      </ControlButton>

      {isVideo && (
        <ControlButton
          label={camOff ? t('call.cameraOn') : t('call.cameraOff')}
          active={camOff}
          onPress={toggleCam}
        >
          {camOff ? (
            <CamOffIcon size={24} color={ACTIVE_ICON_COLOR} />
          ) : (
            <CamIcon size={24} />
          )}
        </ControlButton>
      )}

      {isVideo && !camOff && (
        <ControlButton label={t('call.switchCamera')} onPress={switchCamera}>
          <SwitchCameraIcon size={24} />
        </ControlButton>
      )}

      <ControlButton
        label={t('call.speaker')}
        active={speakerOn}
        onPress={() => void toggleSpeaker()}
      >
        <SpeakerIcon
          size={24}
          color={speakerOn ? ACTIVE_ICON_COLOR : undefined}
        />
      </ControlButton>

      <ControlButton
        label={t('call.endCall')}
        tone="danger"
        onPress={() => void endActive()}
      >
        <EndCallIcon size={24} />
      </ControlButton>
    </View>
  );
}
