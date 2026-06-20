import { http } from '@api';
import { API_PATH } from '@config';
import type {
  FriendListParams,
  FriendListResult,
  MessageResult,
  Relationship,
  RelationshipListResult,
  RespondAction,
} from '@app-types';

export class RelationshipService {
  static friends(params: FriendListParams = {}): Promise<FriendListResult> {
    return http.get<FriendListResult>(API_PATH.relationships.friends, { params });
  }

  static sendRequest(userId: string): Promise<Relationship> {
    return http.post<Relationship>(API_PATH.relationships.request, { userId });
  }

  static respond(id: string, action: RespondAction): Promise<Relationship | MessageResult> {
    return http.put<Relationship | MessageResult>(API_PATH.relationships.respond(id), { action });
  }

  static cancel(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.relationships.cancel(id));
  }

  static unfriend(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.relationships.unfriend(id));
  }

  static block(userId: string): Promise<Relationship> {
    return http.post<Relationship>(API_PATH.relationships.block, { userId });
  }

  static unblock(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.relationships.unblock(id));
  }

  static blocked(params: FriendListParams = {}): Promise<RelationshipListResult> {
    return http.get<RelationshipListResult>(API_PATH.relationships.blocked, { params });
  }
}
