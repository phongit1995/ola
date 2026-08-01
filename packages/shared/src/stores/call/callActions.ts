import i18n from 'i18next';
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
  const goIdle = (locallyEndedCallId: string | null = null) =>
    set({ ...initialCallState, locallyEndedCallId });

  return {
    startCall: async (conversationId, callType, peer) => {
      try {
        const data = await CallService.start(conversationId, callType);
        set({
          ...initialCallState,
          mode: 'outgoing',
          active: toActiveCall(data, peer),
          expanded: true,
        });
      } catch (error) {
        toast.error(messageOf(error, i18n.t('call.startFailed')));
      }
    },

    answerIncoming: async () => {
      const incoming = get().incoming;
      if (incoming == null) return;
      try {
        const data = await CallService.answer(incoming.callId);
        set({
          ...initialCallState,
          mode: 'active',
          active: toActiveCall(data, incoming.caller),
          expanded: true,
        });
      } catch (error) {
        toast.error(messageOf(error, i18n.t('call.answerFailed')));
        goIdle();
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

    reset: () => set({ ...initialCallState }),
  };
}
