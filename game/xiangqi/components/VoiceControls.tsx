import { peerMuteToastText, peerVoiceView, selfMicView } from '../../src/ui/voice';
import { MicIcon, SpeakerIcon } from '../../src/ui/VoiceIcons';
import { useXiangqi } from '../store/useXiangqi';

function SelfVoice({ userId }: { userId: string }) {
  const voice = useXiangqi((s) => s.voice);
  const toggleMic = useXiangqi((s) => s.toggleMic);
  const view = selfMicView(voice, userId);
  if (!view) return null;

  return (
    <button
      type="button"
      className={`xq-voice-badge is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={voice.micOn}
      aria-label={view.label}
      disabled={view.busy}
      onClick={toggleMic}
    >
      <MicIcon off={!voice.micOn} />
      {view.state === 'busy' && <span className="xq-voice-spinner" aria-hidden="true" />}
      {view.state === 'error' && <span className="xq-voice-alert" aria-hidden="true" />}
    </button>
  );
}

function PeerVoice({ userId, name }: { userId: string; name: string }) {
  const voice = useXiangqi((s) => s.voice);
  const togglePeerMuted = useXiangqi((s) => s.togglePeerMuted);
  const showToast = useXiangqi((s) => s.showToast);
  const view = peerVoiceView(voice, userId, name);
  if (!view) return null;

  const press = (): void => {
    togglePeerMuted(userId);
    showToast(peerMuteToastText(name, !view.muted));
  };

  return (
    <button
      type="button"
      className={`xq-voice-badge is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={view.muted}
      aria-label={view.label}
      onClick={press}
    >
      {view.muted ? <SpeakerIcon off /> : <MicIcon off={view.state === 'off'} />}
    </button>
  );
}

export function SeatVoice({ userId, name, self }: { userId: string; name: string; self: boolean }) {
  return self ? <SelfVoice userId={userId} /> : <PeerVoice userId={userId} name={name} />;
}

export function RoomVoiceIcon() {
  return (
    <span className="xq-room-voice" role="img" aria-label="Bàn có voice">
      <MicIcon />
    </span>
  );
}

export function VoiceOption({ canVoice, on, onToggle }: { canVoice: boolean; on: boolean; onToggle: () => void }) {
  return (
    <div className={'xq-voice-option' + (canVoice ? '' : ' is-locked')}>
      <span className="xq-voice-option-icon" aria-hidden="true">
        <MicIcon />
      </span>
      <span className="xq-voice-option-text">
        <strong id="xq-create-voice">Voice chat</strong>
        <small>{canVoice ? 'Hai người nói chuyện bằng giọng nói trong bàn.' : 'Cần VIP để mở voice cho bàn.'}</small>
      </span>
      <button
        type="button"
        role="switch"
        className={'xq-switch' + (on ? ' is-on' : '')}
        aria-checked={on}
        aria-labelledby="xq-create-voice"
        disabled={!canVoice}
        onClick={onToggle}
      >
        <span className="xq-switch-knob" />
      </button>
    </div>
  );
}
