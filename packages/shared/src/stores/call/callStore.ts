import { create } from 'zustand';
import type { CallState } from '../../types/client/call.type';
import { registerOnLogout } from '../auth/authStore';
import { createCallActions } from './callActions';
import { registerCallRealtime } from './callRealtime';
import { initialCallState } from './callState';

export type {
  ActiveCall,
  CallerBrief,
  CallMode,
  CallState,
  IncomingCall,
  WidgetPosition,
} from '../../types/client/call.type';

export const useCallStore = create<CallState>((set, get) => {
  registerCallRealtime(set, get);

  return {
    ...initialCallState,
    ...createCallActions(set, get),
  };
});

registerOnLogout(() => useCallStore.getState().reset());
