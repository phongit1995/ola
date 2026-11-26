import { peerMuteToastText, peerVoiceView, selfMicView } from '../../src/ui/voice';
import { MicIcon, SpeakerIcon } from '../../src/ui/VoiceIcons';
import { useCaro } from '../store/useCaro';

export function SelfVoice({ userId }: { userId: string }) {
  const voice = useCaro((s) => s.voice);
  const toggleMic = useCaro((s) => s.toggleMic);
  const view = selfMicView(voice, userId);
  if (!view) return null;

  return (
    <button
      type="button"
      className={`caro-voice-badge is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={voice.micOn}
      aria-label={view.label}
      disabled={view.busy}
      onClick={toggleMic}
    >
      <MicIcon off={!voice.micOn} />
      {view.state === 'busy' && <span className="caro-voice-spinner" aria-hidden="true" />}
      {view.state === 'error' && <span className="caro-voice-alert" aria-hidden="true" />}
    </button>
  );
}

export function PeerVoice({ userId, name }: { userId: string; name: string }) {
  const voice = useCaro((s) => s.voice);
  const togglePeerMuted = useCaro((s) => s.togglePeerMuted);
  const showToast = useCaro((s) => s.showToast);
  const view = peerVoiceView(voice, userId, name);
  if (!view) return null;

  const press = (): void => {
    togglePeerMuted(userId);
    showToast(peerMuteToastText(name, !view.muted));
  };

  return (
    <button
      type="button"
      className={`caro-voice-badge is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={view.muted}
      aria-label={view.label}
      onClick={press}
    >
      {view.muted ? <SpeakerIcon off /> : <MicIcon off={view.state === 'off'} />}
    </button>
  );
}

export function RoomVoiceIcon() {
  return (
    <span className="caro-room-voice" role="img" aria-label="Bàn có voice">
      <MicIcon />
    </span>
  );
}
