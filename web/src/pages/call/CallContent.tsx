import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useRoomContext } from '@livekit/components-react';
import { peerDisplayName } from '@lib';
import { useCallStore } from '@/store/callStore';
import { computeStatusLabel } from './callStatus';
import { CallControls } from './CallControls';
import { CallMiniWidget } from './CallMiniWidget';
import { CallSettingsPanel } from './CallSettingsPanel';
import { CallVideoArea } from './CallVideoArea';
import { MinimizeIcon } from './icons';
import { useArmCallTracks } from './hooks/useArmCallTracks';
import { useAudioPlayback } from './hooks/useAudioPlayback';
import { useCallConnectTimeout } from './hooks/useCallConnectTimeout';
import { useConnectionState, useElapsedSeconds } from './hooks/useCallTelemetry';
import { usePeerPresenceWatcher } from './hooks/usePeerPresenceWatcher';

export function CallContent() {
  const { t } = useTranslation();
  const room = useRoomContext();
  const [settingsOpen, setSettingsOpen] = useState(false);

  const mode = useCallStore((s) => s.mode);
  const active = useCallStore((s) => s.active);
  const expanded = useCallStore((s) => s.expanded);
  const camOff = useCallStore((s) => s.camOff);
  const setExpanded = useCallStore((s) => s.setExpanded);

  const isVideo = active?.callType === 'video';
  const connectionState = useConnectionState(room);
  const elapsed = useElapsedSeconds(mode === 'active');
  const audio = useAudioPlayback();

  useArmCallTracks(true, isVideo);
  usePeerPresenceWatcher();
  useCallConnectTimeout();

  if (active == null) return null;

  const peerName = peerDisplayName(active.peer, t('call.unknownUser'));
  const statusLabel = computeStatusLabel(mode, connectionState, elapsed, t);

  const enableAudioButton = audio.blocked ? (
    <button
      type="button"
      onClick={audio.enable}
      className="absolute left-1/2 top-3 z-[128] -translate-x-1/2 rounded-full bg-white px-4 py-2 text-sm font-semibold text-ola-primary-darker shadow-lg"
    >
      {t('call.enableAudio')}
    </button>
  ) : null;

  if (!expanded) {
    return (
      <>
        {enableAudioButton}
        <CallMiniWidget peerName={peerName} statusLabel={statusLabel} />
      </>
    );
  }

  return (
    <div className="absolute inset-0 z-[122] flex flex-col bg-gradient-to-br from-ola-primary-darker via-ola-primary-dark to-ola-primary text-white">
      <div className="flex items-center gap-3 px-4 pt-5">
        <div className="min-w-0 flex-1">
          <p className="truncate text-lg font-semibold">{peerName}</p>
          <p className="truncate text-sm text-white/70">{statusLabel}</p>
        </div>
        <button
          type="button"
          aria-label={t('call.minimize')}
          onClick={() => setExpanded(false)}
          className="flex h-9 w-9 items-center justify-center rounded-full bg-white/10 hover:bg-white/20"
        >
          <MinimizeIcon />
        </button>
      </div>

      <CallVideoArea
        peer={active.peer}
        peerName={peerName}
        isVideo={isVideo}
        camOff={camOff}
      />

      <CallControls
        isVideo={isVideo}
        onOpenSettings={() => setSettingsOpen(true)}
      />

      {settingsOpen && (
        <CallSettingsPanel onClose={() => setSettingsOpen(false)} />
      )}

      {enableAudioButton}
    </div>
  );
}
