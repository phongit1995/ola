import type { Participant, RemoteParticipant, RemoteTrack, Room } from 'livekit-client';
import { VOICE_ERROR, type VoiceTokenData } from './protocol';
import type { GameSession } from './socket';

export type VoiceStatus = 'off' | 'connecting' | 'connected' | 'reconnecting' | 'failed';
export type VoiceIssue = 'permission' | 'device' | 'unsupported' | 'interrupted';

export interface VoiceState {
  roomId: string | null;
  status: VoiceStatus;
  canSpeak: boolean;
  micOn: boolean;
  micBusy: boolean;
  speakerOn: boolean;
  audioBlocked: boolean;
  issue: VoiceIssue | null;
  presentIds: string[];
  micOnIds: string[];
  speakingIds: string[];
  mutedIds: string[];
}

export interface VoiceTarget {
  roomId?: string;
  matchId?: string;
  speak: boolean;
}

export interface VoiceClient {
  getState(): VoiceState;
  subscribe(listener: (state: VoiceState) => void): () => void;
  join(target: VoiceTarget): void;
  leave(): void;
  setMic(on: boolean): Promise<void>;
  setSpeaker(on: boolean): void;
  setPeerMuted(userId: string, muted: boolean): void;
  resumeAudio(): void;
  retry(): void;
  destroy(): void;
}

export const VOICE_IDLE: VoiceState = {
  roomId: null,
  status: 'off',
  canSpeak: false,
  micOn: false,
  micBusy: false,
  speakerOn: true,
  audioBlocked: false,
  issue: null,
  presentIds: [],
  micOnIds: [],
  speakingIds: [],
  mutedIds: [],
};

const RECONNECT_DELAYS_MS = [1_000, 3_000, 8_000];
const FAILED_RETRY_MS = 30_000;

type LiveKit = typeof import('livekit-client');

let liveKitModule: Promise<LiveKit> | null = null;

function loadLiveKit(): Promise<LiveKit> {
  liveKitModule ??= import('livekit-client');
  return liveKitModule;
}

export function voiceSupported(): boolean {
  return typeof RTCPeerConnection !== 'undefined';
}

function micIssue(error: unknown): VoiceIssue {
  if (typeof navigator === 'undefined' || !navigator.mediaDevices?.getUserMedia) return 'unsupported';
  const name = error instanceof Error ? error.name : '';
  if (name === 'NotAllowedError' || name === 'SecurityError' || name === 'PermissionDeniedError') return 'permission';
  return 'device';
}

function audioSink(): HTMLElement {
  const existing = document.getElementById('ola-voice-sink');
  if (existing) return existing;
  const sink = document.createElement('div');
  sink.id = 'ola-voice-sink';
  sink.hidden = true;
  document.body.appendChild(sink);
  return sink;
}

function clearAudioSink(): void {
  document.getElementById('ola-voice-sink')?.replaceChildren();
}

export function createVoiceClient(
  session: Pick<GameSession, 'requestVoiceToken' | 'onVoiceToken'> & Partial<Pick<GameSession, 'onConnectionChange'>>,
): VoiceClient {
  let state: VoiceState = VOICE_IDLE;
  let target: VoiceTarget | null = null;
  let room: Room | null = null;
  let generation = 0;
  let micWanted = false;
  let reconnectAttempt = 0;
  let reconnectTimer: ReturnType<typeof setTimeout> | null = null;
  const muted = new Set<string>();
  const listeners = new Set<(state: VoiceState) => void>();

  const set = (patch: Partial<VoiceState>): void => {
    state = { ...state, ...patch };
    listeners.forEach((listener) => listener(state));
  };

  const clearReconnect = (): void => {
    if (reconnectTimer) clearTimeout(reconnectTimer);
    reconnectTimer = null;
  };

  const shouldHear = (identity: string): boolean => state.speakerOn && !muted.has(identity);

  const syncSubscriptions = (): void => {
    if (!room) return;
    room.remoteParticipants.forEach((participant: RemoteParticipant) => {
      participant.audioTrackPublications.forEach((publication) => {
        const wanted = shouldHear(participant.identity);
        if (publication.isDesired !== wanted) publication.setSubscribed(wanted);
      });
    });
  };

  const refreshPeers = (): void => {
    if (!room) return;
    const participants: Participant[] = [room.localParticipant, ...room.remoteParticipants.values()];
    set({
      presentIds: participants.map((participant) => participant.identity),
      micOnIds: participants.filter((participant) => participant.isMicrophoneEnabled).map((participant) => participant.identity),
      speakingIds: room.activeSpeakers
        .map((participant) => participant.identity)
        .filter((identity) => !muted.has(identity)),
      micOn: room.localParticipant.isMicrophoneEnabled,
    });
  };

  const teardown = (): void => {
    clearReconnect();
    const current = room;
    room = null;
    if (!current) return;
    void current.disconnect();
    clearAudioSink();
  };

  const requestToken = (): void => {
    if (!target) return;
    session.requestVoiceToken({
      ...(target.roomId ? { roomId: target.roomId } : {}),
      ...(target.matchId ? { matchId: target.matchId } : {}),
    });
  };

  const scheduleReconnect = (): void => {
    const delay = RECONNECT_DELAYS_MS[reconnectAttempt];
    if (!target) {
      set({ status: 'failed' });
      return;
    }
    if (delay === undefined) {
      set({ status: 'failed' });
      clearReconnect();
      reconnectTimer = setTimeout(requestToken, FAILED_RETRY_MS);
      return;
    }
    reconnectAttempt += 1;
    set({ status: 'reconnecting' });
    clearReconnect();
    reconnectTimer = setTimeout(requestToken, delay);
  };

  const watchMicEnded = (liveKit: LiveKit, current: Room): void => {
    const track = current.localParticipant.getTrackPublication(liveKit.Track.Source.Microphone)?.track;
    track?.once(liveKit.TrackEvent.Ended, () => {
      if (room !== current) return;
      micWanted = false;
      void current.localParticipant.setMicrophoneEnabled(false).catch(() => undefined);
      set({ issue: 'interrupted' });
      refreshPeers();
    });
  };

  const enableMic = async (liveKit: LiveKit, current: Room, on: boolean): Promise<void> => {
    set(on ? { micBusy: true, issue: null } : { micBusy: true });
    try {
      await current.localParticipant.setMicrophoneEnabled(on);
      if (room !== current) return;
      if (on) watchMicEnded(liveKit, current);
      set({ issue: null });
    } catch (error) {
      micWanted = false;
      set({ issue: micIssue(error) });
    } finally {
      if (room === current) {
        set({ micBusy: false });
        refreshPeers();
      }
    }
  };

  const connect = async (reply: VoiceTokenData): Promise<void> => {
    const ticket = generation;
    const liveKit = await loadLiveKit();
    if (ticket !== generation || !reply.url || !reply.token) return;
    teardown();
    const { Room: LiveKitRoom, RoomEvent, Track } = liveKit;
    const current = new LiveKitRoom({
      adaptiveStream: false,
      dynacast: false,
      publishDefaults: { stopMicTrackOnMute: true },
      audioCaptureDefaults: { echoCancellation: true, noiseSuppression: true, autoGainControl: true },
    });
    room = current;
    const live =
      <Args extends unknown[]>(handler: (...args: Args) => void) =>
      (...args: Args): void => {
        if (room === current) handler(...args);
      };
    current
      .on(RoomEvent.ParticipantConnected, live(() => {
        syncSubscriptions();
        refreshPeers();
      }))
      .on(RoomEvent.ParticipantDisconnected, live(refreshPeers))
      .on(RoomEvent.TrackPublished, live(() => {
        syncSubscriptions();
        refreshPeers();
      }))
      .on(RoomEvent.TrackUnpublished, live(refreshPeers))
      .on(RoomEvent.TrackMuted, live(refreshPeers))
      .on(RoomEvent.TrackUnmuted, live(refreshPeers))
      .on(RoomEvent.LocalTrackPublished, live(refreshPeers))
      .on(RoomEvent.LocalTrackUnpublished, live(refreshPeers))
      .on(RoomEvent.ActiveSpeakersChanged, live(refreshPeers))
      .on(RoomEvent.TrackSubscribed, live((track: RemoteTrack) => {
        if (track.kind === Track.Kind.Audio) audioSink().appendChild(track.attach());
      }))
      .on(RoomEvent.TrackUnsubscribed, live((track: RemoteTrack) => {
        track.detach().forEach((element) => element.remove());
      }))
      .on(RoomEvent.AudioPlaybackStatusChanged, live(() => set({ audioBlocked: !current.canPlaybackAudio })))
      .on(RoomEvent.Reconnecting, live(() => set({ status: 'reconnecting' })))
      .on(RoomEvent.Reconnected, live(() => {
        set({ status: 'connected' });
        refreshPeers();
      }))
      .on(RoomEvent.Disconnected, live(() => {
        room = null;
        clearAudioSink();
        set({ micOn: false, presentIds: [], micOnIds: [], speakingIds: [] });
        scheduleReconnect();
      }));

    try {
      await current.connect(reply.url, reply.token, { autoSubscribe: false });
    } catch {
      if (room !== current) return;
      room = null;
      scheduleReconnect();
      return;
    }
    if (room !== current) {
      void current.disconnect();
      return;
    }
    reconnectAttempt = 0;
    set({
      roomId: reply.roomId ?? target?.roomId ?? null,
      status: 'connected',
      canSpeak: reply.canSpeak,
      audioBlocked: !current.canPlaybackAudio,
    });
    syncSubscriptions();
    refreshPeers();
    if (micWanted && reply.canSpeak) await enableMic(liveKit, current, true);
  };

  const retry = (): void => {
    if (!target || state.status !== 'failed') return;
    clearReconnect();
    reconnectAttempt = 0;
    set({ status: 'reconnecting' });
    requestToken();
  };

  const leave = (): void => {
    generation += 1;
    target = null;
    micWanted = false;
    muted.clear();
    teardown();
    set({ ...VOICE_IDLE, speakerOn: state.speakerOn });
  };

  const unsubscribeToken = session.onVoiceToken((reply) => {
    if (!target) return;
    if (target.roomId && reply.roomId && reply.roomId !== target.roomId) return;
    if (reply.error) {
      teardown();
      if (reply.error === VOICE_ERROR.unavailable) {
        scheduleReconnect();
        return;
      }
      set({ ...VOICE_IDLE, speakerOn: state.speakerOn, mutedIds: [...muted] });
      return;
    }
    void connect(reply);
  });

  const unsubscribeConnection = session.onConnectionChange?.((connected) => {
    if (connected) retry();
  });

  const wake = (): void => {
    if (typeof document === 'undefined' || document.visibilityState !== 'hidden') retry();
  };
  const onlineTarget = typeof window !== 'undefined' ? window : null;
  const visibilityTarget = typeof document !== 'undefined' ? document : null;
  onlineTarget?.addEventListener?.('online', wake);
  visibilityTarget?.addEventListener?.('visibilitychange', wake);

  return {
    getState: () => state,
    subscribe(listener) {
      listeners.add(listener);
      return () => listeners.delete(listener);
    },
    join(next) {
      if (!voiceSupported()) {
        leave();
        return;
      }
      const sameRoom = next.roomId != null && next.roomId === (target?.roomId ?? state.roomId);
      if (sameRoom && state.status !== 'off' && state.status !== 'failed' && target?.speak === next.speak) {
        target = { ...target, ...next };
        return;
      }
      generation += 1;
      if (!sameRoom) {
        micWanted = false;
        muted.clear();
      }
      target = next;
      reconnectAttempt = 0;
      set({ status: 'connecting', issue: null, mutedIds: [...muted] });
      requestToken();
    },
    leave,
    async setMic(on) {
      micWanted = on;
      const current = room;
      if (!current || !state.canSpeak) return;
      void current.startAudio().catch(() => undefined);
      await enableMic(await loadLiveKit(), current, on);
    },
    setSpeaker(on) {
      set({ speakerOn: on });
      syncSubscriptions();
    },
    setPeerMuted(userId, isMuted) {
      if (isMuted) muted.add(userId);
      else muted.delete(userId);
      set({ mutedIds: [...muted] });
      syncSubscriptions();
      refreshPeers();
    },
    resumeAudio() {
      void room?.startAudio().then(() => set({ audioBlocked: false })).catch(() => undefined);
    },
    retry,
    destroy() {
      leave();
      unsubscribeToken();
      unsubscribeConnection?.();
      onlineTarget?.removeEventListener?.('online', wake);
      visibilityTarget?.removeEventListener?.('visibilitychange', wake);
      listeners.clear();
    },
  };
}
