import { useEffect, useRef, useState } from 'react';
import { useThirteen } from '../store/useThirteen';
import { ConfirmModal } from './ConfirmModal';

const VOICE_RETRY_TEXT = 'Đang kết nối lại voice…';

export function MicIcon({ off = false, className }: { off?: boolean; className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <rect x="9" y="3" width="6" height="11" rx="3" />
      <path d="M5.5 11a6.5 6.5 0 0 0 13 0M12 17.5V21M8.5 21h7" />
      {off && <path d="M4 4l16 16" />}
    </svg>
  );
}

export function SpeakerIcon({ off = false, className }: { off?: boolean; className?: string }) {
  return (
    <svg className={className} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" aria-hidden="true">
      <path d="M4 9.5h3.5L12 5.5v13l-4.5-4H4z" />
      {off ? <path d="M16 9.5l5 5M21 9.5l-5 5" /> : <path d="M15.5 9a4 4 0 0 1 0 6M18 6.5a7.5 7.5 0 0 1 0 11" />}
    </svg>
  );
}

function SelfMicToggle({ userId }: { userId: string }) {
  const voice = useThirteen((s) => s.voice);
  const toggleMic = useThirteen((s) => s.toggleMic);
  const showToast = useThirteen((s) => s.showToast);
  if (voice.status === 'off' || (voice.status === 'connected' && !voice.canSpeak)) return null;

  const failed = voice.status === 'failed';
  const busy = !failed && (voice.status !== 'connected' || voice.micBusy);
  const blocked = failed || (!voice.micOn && voice.issue != null);
  const state = voice.micOn ? 'on' : busy ? 'busy' : blocked ? 'error' : 'off';
  const speaking = voice.micOn && voice.speakingIds.includes(userId);
  const label = voice.micOn
    ? 'Mic đang bật, chạm để tắt'
    : failed
      ? 'Voice bị gián đoạn, chạm để kết nối lại'
      : busy
        ? 'Đang kết nối voice'
        : 'Mic đang tắt, chạm để bật';

  const press = (): void => {
    if (failed) showToast(VOICE_RETRY_TEXT);
    toggleMic();
  };

  return (
    <button
      type="button"
      className={`tl-voice-badge tl-voice-self is-${state}${speaking ? ' is-speaking' : ''}`}
      aria-pressed={voice.micOn}
      aria-label={label}
      disabled={busy}
      onClick={press}
    >
      <MicIcon off={!voice.micOn} />
      {state === 'busy' && <span className="tl-mic-spinner" aria-hidden="true" />}
      {state === 'error' && <span className="tl-mic-alert" aria-hidden="true" />}
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

function PeerVoiceMenu({ userId, name, onClose }: { userId: string; name: string; onClose: () => void }) {
  const muted = useThirteen((s) => s.voice.mutedIds.includes(userId));
  const togglePeerMuted = useThirteen((s) => s.togglePeerMuted);
  const menuRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const close = (event: PointerEvent): void => {
      if (!menuRef.current?.parentElement?.contains(event.target as Node)) onClose();
    };
    document.addEventListener('pointerdown', close);
    return () => document.removeEventListener('pointerdown', close);
  }, [onClose]);

  return (
    <div ref={menuRef} className="tl-voice-menu" role="menu">
      <span className="tl-voice-menu-name">{name}</span>
      <button
        type="button"
        role="menuitem"
        className="tl-voice-menu-btn"
        onClick={() => {
          togglePeerMuted(userId);
          onClose();
        }}
      >
        <SpeakerIcon off={!muted} />
        {muted ? 'Bật tiếng' : 'Tắt tiếng'}
      </button>
      <small>Chỉ áp dụng trên máy bạn</small>
    </div>
  );
}

function PeerVoice({ userId, name }: { userId: string; name: string }) {
  const voice = useThirteen((s) => s.voice);
  const [menuOpen, setMenuOpen] = useState(false);
  if (voice.status === 'off' || !voice.presentIds.includes(userId)) return null;

  const muted = voice.mutedIds.includes(userId);
  const micOn = voice.micOnIds.includes(userId);
  const speaking = micOn && voice.speakerOn && !muted && voice.speakingIds.includes(userId);
  const badge = muted ? 'muted' : micOn ? 'on' : 'off';
  const badgeLabel = muted ? `Bạn đã tắt tiếng ${name}` : micOn ? `${name} đang mở mic` : `${name} đang tắt mic`;

  return (
    <>
      <span
        className={`tl-voice-badge is-${badge}${speaking ? ' is-speaking' : ''}`}
        role="img"
        aria-label={speaking ? `${name} đang nói` : badgeLabel}
      >
        {badge === 'muted' ? <SpeakerIcon off /> : <MicIcon off={badge === 'off'} />}
      </span>
      <button
        type="button"
        className="tl-voice-hit"
        aria-label={muted ? `Bật tiếng ${name}` : `Tắt tiếng ${name}`}
        aria-haspopup="menu"
        aria-expanded={menuOpen}
        onClick={() => setMenuOpen((open) => !open)}
      />
      {menuOpen && <PeerVoiceMenu userId={userId} name={name} onClose={() => setMenuOpen(false)} />}
    </>
  );
}

export function SeatVoice({ userId, name, self = false }: { userId: string; name: string; self?: boolean }) {
  return self ? <SelfMicToggle userId={userId} /> : <PeerVoice userId={userId} name={name} />;
}

export function VoiceAudioUnlock() {
  const blocked = useThirteen((s) => s.voice.audioBlocked && s.voice.status === 'connected');
  const resumeVoiceAudio = useThirteen((s) => s.resumeVoiceAudio);
  if (!blocked) return null;
  return (
    <button type="button" className="tl-voice-unlock" onClick={resumeVoiceAudio}>
      <SpeakerIcon />
      Chạm để nghe voice của bàn
    </button>
  );
}

export function MicPrimer() {
  const open = useThirteen((s) => s.micPrimerOpen);
  const confirmMicPrimer = useThirteen((s) => s.confirmMicPrimer);
  const dismissMicPrimer = useThirteen((s) => s.dismissMicPrimer);
  if (!open) return null;
  return (
    <ConfirmModal
      title="Nói chuyện với cả bàn"
      text="Cho phép micro để mọi người trong bàn nghe bạn nói. Bạn có thể tắt mic bất cứ lúc nào bằng nút mic."
      confirmLabel="Tiếp tục"
      cancelLabel="Để sau"
      onConfirm={confirmMicPrimer}
      onCancel={dismissMicPrimer}
      style02
    />
  );
}
