import i18n from 'i18next';
import { ringFallbackMs } from '../../constants/call';
import { CALL_SOCKET_EVENTS } from '../../constants/socket';
import { formatCallDuration, peerDisplayName } from '../../lib/callFormat';
import { toast } from '../../lib/toast';
import { CallService } from '../../services/call.service';
import { SocketService } from '../../services/socket.service';
import { UserService } from '../../services/user.service';
import type {
  CallAcceptedEvent,
  CallDeclinedEvent,
  CallEndedEvent,
  IncomingCallEvent,
} from '../../types/realtime/call.type';
import type { CallerBrief, CallGet, CallSet } from '../../types/client/call.type';
import { useChatStore } from '../chat/chatStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import { armRingTimeout, clearRingTimeout } from './callRuntime.state';
import { initialCallState } from './callState';

function callerFromConversations(event: IncomingCallEvent): CallerBrief | null {
  const conversation = useChatStore
    .getState()
    .conversations.find((item) => item.id === event.conversationId);
  const other = conversation?.otherUser;
  if (other == null || other.id !== event.callerId) return null;
  return {
    id: other.id,
    username: other.username,
    fullName: other.fullName,
    avatar: other.avatar,
  };
}

async function fetchCaller(callerId: string): Promise<CallerBrief | null> {
  try {
    const profile = await UserService.publicProfile(callerId);
    return {
      id: profile.id,
      username: profile.username,
      fullName: profile.fullName,
      avatar: profile.avatar,
    };
  } catch {
    return null;
  }
}

function currentCallId(get: CallGet): string | null {
  const { active, incoming } = get();
  return active?.callId ?? incoming?.callId ?? null;
}

function handleIncoming(set: CallSet, get: CallGet, event: IncomingCallEvent) {
  if (get().mode !== 'idle' || get().pendingAction != null) {
    void CallService.decline(event.callId).catch(() => {});
    return;
  }

  const cached = callerFromConversations(event);
  set({
    ...initialCallState,
    mode: 'incoming',
    incoming: { ...event, caller: cached ?? { id: event.callerId } },
  });

  armRingTimeout(() => {
    const { mode, incoming } = get();
    if (mode !== 'incoming' || incoming?.callId !== event.callId) return;
    set({ ...initialCallState });
    toast.info(i18n.t('call.missedCall'));
  }, ringFallbackMs(event.ringTimeoutSeconds));

  if (cached != null) return;

  void fetchCaller(event.callerId).then((caller) => {
    if (caller == null) return;
    const incoming = get().incoming;
    if (incoming == null || incoming.callId !== event.callId) return;
    set({ incoming: { ...incoming, caller } });
  });
}

function handleAccepted(set: CallSet, get: CallGet, event: CallAcceptedEvent) {
  const { active, mode } = get();
  if (mode !== 'outgoing' || active?.callId !== event.callId) return;
  clearRingTimeout();
  set({ mode: 'active' });
}

function handleDeclined(set: CallSet, get: CallGet, event: CallDeclinedEvent) {
  const active = get().active;
  if (active?.callId !== event.callId) return;
  clearRingTimeout();
  set({ ...initialCallState });
  toast.info(
    i18n.t('call.peerDeclined', {
      name: peerDisplayName(active.peer, i18n.t('call.unknownUser')),
    })
  );
}

function handleEnded(set: CallSet, get: CallGet, event: CallEndedEvent) {
  const { active, incoming, locallyEndedCallId } = get();
  const wasIncoming = incoming?.callId === event.callId;
  const wasActive = active?.callId === event.callId;

  if (locallyEndedCallId === event.callId) {
    set({ locallyEndedCallId: null });
    return;
  }
  if (!wasIncoming && !wasActive) return;

  clearRingTimeout();
  set({ ...initialCallState });

  if (event.status === 'missed') {
    toast.info(i18n.t(wasIncoming ? 'call.missedCall' : 'call.noAnswer'));
    return;
  }
  if (event.durationSeconds > 0) {
    toast.success(
      i18n.t('call.endedWithDuration', {
        duration: formatCallDuration(event.durationSeconds),
      })
    );
    return;
  }
  toast.info(i18n.t('call.ended'));
}

function reconcileOngoingCall(set: CallSet, get: CallGet) {
  if (get().mode === 'idle' || get().pendingAction != null) return;
  const trackedId = currentCallId(get);
  if (trackedId == null) return;

  void CallService.ongoing()
    .then((data) => {
      if (currentCallId(get) !== trackedId) return;
      if (get().pendingAction != null) return;

      if (data == null || data.callId !== trackedId) {
        clearRingTimeout();
        set({ ...initialCallState });
        toast.info(i18n.t('call.ended'));
        return;
      }
      if (data.status === 'active' && get().mode === 'outgoing') {
        clearRingTimeout();
        set({ mode: 'active' });
      }
    })
    .catch(() => {});
}

export function registerCallRealtime(set: CallSet, get: CallGet) {
  if (!claimRealtimeRegistration('call')) return;

  SocketService.on<IncomingCallEvent>(CALL_SOCKET_EVENTS.incoming, (event) =>
    handleIncoming(set, get, event)
  );
  SocketService.on<CallAcceptedEvent>(CALL_SOCKET_EVENTS.accepted, (event) =>
    handleAccepted(set, get, event)
  );
  SocketService.on<CallDeclinedEvent>(CALL_SOCKET_EVENTS.declined, (event) =>
    handleDeclined(set, get, event)
  );
  SocketService.on<CallEndedEvent>(CALL_SOCKET_EVENTS.ended, (event) =>
    handleEnded(set, get, event)
  );

  SocketService.onReconnect(() => reconcileOngoingCall(set, get));
}
