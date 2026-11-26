import { peerMuteToastText, peerVoiceView, selfMicView } from '../../src/ui/voice';
import { MicIcon, SpeakerIcon } from '../../src/ui/VoiceIcons';
import { useThirteen } from '../store/useThirteen';

function SelfMicToggle({ userId }: { userId: string }) {
  const voice = useThirteen((s) => s.voice);
  const toggleMic = useThirteen((s) => s.toggleMic);
  const view = selfMicView(voice, userId);
  if (!view) return null;

  return (
    <button
      type="button"
      className={`tl-voice-badge tl-voice-self is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={voice.micOn}
      aria-label={view.label}
      disabled={view.busy}
      onClick={toggleMic}
    >
      <MicIcon off={!voice.micOn} />
      {view.state === 'busy' && <span className="tl-mic-spinner" aria-hidden="true" />}
      {view.state === 'error' && <span className="tl-mic-alert" aria-hidden="true" />}
    </button>
  );
}

export function SpeakerButton() {
  const status = useThirteen((s) => s.voice.status);
  const speakerOn = useThirteen((s) => s.voice.speakerOn);
  const toggleSpeaker = useThirteen((s) => s.toggleSpeaker);
  if (status === 'off') return null;
  return (
    <button
      type="button"
      className={'tl-icon-btn tl-speaker-btn' + (speakerOn ? '' : ' is-muted')}
      aria-pressed={!speakerOn}
      aria-label={speakerOn ? 'Tắt tiếng voice của bàn' : 'Bật tiếng voice của bàn'}
      onClick={toggleSpeaker}
    >
      <SpeakerIcon off={!speakerOn} />
    </button>
  );
}

function PeerVoice({ userId, name }: { userId: string; name: string }) {
  const voice = useThirteen((s) => s.voice);
  const togglePeerMuted = useThirteen((s) => s.togglePeerMuted);
  const showToast = useThirteen((s) => s.showToast);
  const view = peerVoiceView(voice, userId, name);
  if (!view) return null;

  const press = (): void => {
    togglePeerMuted(userId);
    showToast(peerMuteToastText(name, !view.muted));
  };

  return (
    <button
      type="button"
      className={`tl-voice-badge tl-voice-peer is-${view.state}${view.speaking ? ' is-speaking' : ''}`}
      aria-pressed={view.muted}
      aria-label={view.label}
      onClick={press}
    >
      {view.muted ? <SpeakerIcon off /> : <MicIcon off={view.state === 'off'} />}
    </button>
  );
}

export function SeatVoice({ userId, name, self = false }: { userId: string; name: string; self?: boolean }) {
  return self ? <SelfMicToggle userId={userId} /> : <PeerVoice userId={userId} name={name} />;
}
