import i18n from 'i18next';
import { ringFallbackMs } from '../../constants/call';
import { ApiError } from '../../lib/apiError';
import { toast } from '../../lib/toast';
import { CallService } from '../../services/call.service';
import type { CallTokenResponse } from '../../types/api/call.type';
import type {
  ActiveCall,
  CallerBrief,
  CallGet,
  CallSet,
  CallState,
} from '../../types/client/call.type';
import { armRingTimeout, clearRingTimeout } from './callRuntime.state';
import { initialCallState } from './callState';

type CallActions = Pick<
  CallState,
  | 'startCall'
  | 'answerIncoming'
  | 'declineIncoming'
  | 'endActive'
  | 'markRemoteJoined'
  | 'setExpanded'
  | 'setMiniPos'
  | 'setIncomingPos'
  | 'setLocalVideoPos'
  | 'setLocalVideoWidth'
  | 'setSelectedMicId'
  | 'setSelectedCamId'
  | 'setSelectedSpeakerId'
  | 'setMicMuted'
  | 'setCamOff'
  | 'reset'
>;

export function toActiveCall(
  data: CallTokenResponse,
  peer: CallerBrief
): ActiveCall {
  return {
    callId: data.callId,
    conversationId: data.conversationId,
    callType: data.callType,
    roomName: data.roomName,
    wsUrl: data.wsUrl,
    token: data.token,
    peer,
  };
}

function messageOf(error: unknown, fallback: string): string {
  if (error instanceof ApiError && error.message !== '') return error.message;
  return fallback;
}

export function createCallActions(set: CallSet, get: CallGet): CallActions {
  const goIdle = (locallyEndedCallId: string | null = null) => {
    clearRingTimeout();
    set({ ...initialCallState, locallyEndedCallId });
  };

  const armOutgoingTimeout = (callId: string, ringTimeoutSeconds?: number) => {
    armRingTimeout(() => {
      const { mode, active } = get();
      if (mode !== 'outgoing' || active?.callId !== callId) return;
      set({ ...initialCallState, locallyEndedCallId: callId });
      void CallService.end(callId).catch(() => {});
      toast.info(i18n.t('call.noAnswer'));
    }, ringFallbackMs(ringTimeoutSeconds));
  };

  return {
    startCall: async (conversationId, callType, peer) => {
      if (get().mode !== 'idle' || get().pendingAction != null) return;
      set({ pendingAction: 'starting' });

      try {
        const data = await CallService.start(conversationId, callType);
        if (get().pendingAction !== 'starting') {
          void CallService.end(data.callId).catch(() => {});
          return;
        }
        set({
          ...initialCallState,
          mode: 'outgoing',
          active: toActiveCall(data, peer),
          expanded: true,
        });
        armOutgoingTimeout(data.callId, data.ringTimeoutSeconds);
      } catch (error) {
        if (get().pendingAction === 'starting') set({ pendingAction: null });
        toast.error(messageOf(error, i18n.t('call.startFailed')));
      }
    },

    answerIncoming: async () => {
      const incoming = get().incoming;
      if (incoming == null || get().pendingAction != null) return;
      const callId = incoming.callId;
      set({ pendingAction: 'answering' });

      try {
        const data = await CallService.answer(callId);
        const current = get();
        if (
          current.pendingAction !== 'answering' ||
          current.incoming?.callId !== callId
        ) {
          return;
        }
        clearRingTimeout();
        set({
          ...initialCallState,
          mode: 'active',
          active: toActiveCall(data, incoming.caller),
          expanded: true,
        });
      } catch (error) {
        toast.error(messageOf(error, i18n.t('call.answerFailed')));
        const current = get();
        if (
          current.pendingAction === 'answering' &&
          current.incoming?.callId === callId
        ) {
          goIdle();
        }
      }
    },

    declineIncoming: () => {
      const incoming = get().incoming;
      if (incoming == null) return;
      goIdle(incoming.callId);
      void CallService.decline(incoming.callId).catch(() => {});
      toast.info(i18n.t('call.declined'));
    },

    endActive: () => {
      const { active, mode } = get();
      if (active == null) return;
      goIdle(active.callId);
      void CallService.end(active.callId).catch(() => {});
      toast.info(i18n.t(mode === 'active' ? 'call.ended' : 'call.cancelled'));
    },

    markRemoteJoined: () => {
      if (get().mode !== 'outgoing') return;
      clearRingTimeout();
      set({ mode: 'active' });
    },

    setExpanded: (expanded) => set({ expanded }),
    setMiniPos: (miniPos) => set({ miniPos }),
    setIncomingPos: (incomingPos) => set({ incomingPos }),
    setLocalVideoPos: (localVideoPos) => set({ localVideoPos }),
    setLocalVideoWidth: (localVideoWidth) => set({ localVideoWidth }),
    setSelectedMicId: (selectedMicId) => set({ selectedMicId }),
    setSelectedCamId: (selectedCamId) => set({ selectedCamId }),
    setSelectedSpeakerId: (selectedSpeakerId) => set({ selectedSpeakerId }),
    setMicMuted: (micMuted) => set({ micMuted }),
    setCamOff: (camOff) => set({ camOff }),

    reset: () => {
      clearRingTimeout();
      set({ ...initialCallState });
    },
  };
}
