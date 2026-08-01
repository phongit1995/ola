import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { CallTokenResponse, CallType } from '../types/api/call.type';

export class CallService {
  static start(
    conversationId: string,
    callType: CallType
  ): Promise<CallTokenResponse> {
    return http.post<CallTokenResponse>(API_PATH.calls.start, {
      conversationId,
      callType,
    });
  }

  static answer(callId: string): Promise<CallTokenResponse> {
    return http.post<CallTokenResponse>(API_PATH.calls.answer(callId));
  }

  static decline(callId: string): Promise<void> {
    return http.post<void>(API_PATH.calls.decline(callId));
  }

  static end(callId: string): Promise<void> {
    return http.post<void>(API_PATH.calls.end(callId));
  }
}
