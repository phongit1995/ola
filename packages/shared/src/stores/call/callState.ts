import type { CallStateData } from '../../types/client/call.type';
import { CALL_MODE } from '../../constants/call';

export type {
  CallGet,
  CallSet,
  CallState,
  CallStateData,
} from '../../types/client/call.type';

export const initialCallState: CallStateData = {
  mode: CALL_MODE.idle,
  incoming: null,
  active: null,
  expanded: false,
  miniPos: null,
  incomingPos: null,
  localVideoPos: null,
  localVideoWidth: null,
  selectedMicId: null,
  selectedCamId: null,
  selectedSpeakerId: null,
  micMuted: false,
  camOff: false,
  locallyEndedCallId: null,
  pendingAction: null,
};
