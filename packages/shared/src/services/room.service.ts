import { http } from '../api';
import { API_PATH } from '../config';
import type {
  MessageResult,
  Room,
  RoomJoinTicket,
  RoomListResult,
  RoomMembersResult,
  RoomMessage,
  RoomMessagesResult,
  BrowseRoomsParams,
  RoomMessagesParams,
  CreateRoomRequest,
  UpdateRoomRequest,
  SendRoomMessageRequest,
} from '../types';

export class RoomService {
  static browse(params: BrowseRoomsParams = {}): Promise<RoomListResult> {
    return http.get<RoomListResult>(API_PATH.rooms.browse, { params });
  }

  static getById(id: string): Promise<Room> {
    return http.get<Room>(API_PATH.rooms.detail(id));
  }

  static join(id: string): Promise<RoomJoinTicket> {
    return http.post<RoomJoinTicket>(API_PATH.rooms.join(id));
  }

  static members(id: string): Promise<RoomMembersResult> {
    return http.get<RoomMembersResult>(API_PATH.rooms.members(id));
  }

  static messages(id: string, params: RoomMessagesParams = {}): Promise<RoomMessagesResult> {
    return http.get<RoomMessagesResult>(API_PATH.rooms.messages(id), { params });
  }

  static sendMessage(id: string, payload: SendRoomMessageRequest): Promise<RoomMessage> {
    return http.post<RoomMessage>(API_PATH.rooms.messages(id), payload);
  }

  static deleteMessage(id: string, messageId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.rooms.message(id, messageId));
  }
}

export class AdminRoomService {
  static create(payload: CreateRoomRequest): Promise<Room> {
    return http.post<Room>(API_PATH.adminRooms.base, payload);
  }

  static list(params: BrowseRoomsParams = {}): Promise<RoomListResult> {
    return http.get<RoomListResult>(API_PATH.adminRooms.base, { params });
  }

  static update(id: string, payload: UpdateRoomRequest): Promise<Room> {
    return http.patch<Room>(API_PATH.adminRooms.detail(id), payload);
  }

  static remove(id: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.adminRooms.detail(id));
  }
}
