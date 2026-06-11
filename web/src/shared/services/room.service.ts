import { api } from '@api';
import { API_PATH } from '@config';
import type {
  IApiResponse,
  MessageResult,
  Room,
  RoomListResult,
  RoomMembersResult,
  RoomMessage,
  RoomMessagesResult,
  BrowseRoomsParams,
  RoomMessagesParams,
  CreateRoomRequest,
  UpdateRoomRequest,
  SendRoomMessageRequest,
} from '@app-types';

export class RoomService {
  static async browse(params: BrowseRoomsParams = {}): Promise<RoomListResult> {
    const { data } = await api.get<IApiResponse<RoomListResult>>(API_PATH.rooms.browse, { params });
    return data.data;
  }

  static async getById(id: string): Promise<Room> {
    const { data } = await api.get<IApiResponse<Room>>(API_PATH.rooms.detail(id));
    return data.data;
  }

  static async members(id: string): Promise<RoomMembersResult> {
    const { data } = await api.get<IApiResponse<RoomMembersResult>>(API_PATH.rooms.members(id));
    return data.data;
  }

  static async messages(id: string, params: RoomMessagesParams = {}): Promise<RoomMessagesResult> {
    const { data } = await api.get<IApiResponse<RoomMessagesResult>>(API_PATH.rooms.messages(id), {
      params,
    });
    return data.data;
  }

  static async sendMessage(id: string, payload: SendRoomMessageRequest): Promise<RoomMessage> {
    const { data } = await api.post<IApiResponse<RoomMessage>>(API_PATH.rooms.messages(id), payload);
    return data.data;
  }

  static async deleteMessage(id: string, messageId: string): Promise<MessageResult> {
    const { data } = await api.delete<IApiResponse<MessageResult>>(
      API_PATH.rooms.message(id, messageId)
    );
    return data.data;
  }
}

export class AdminRoomService {
  static async create(payload: CreateRoomRequest): Promise<Room> {
    const { data } = await api.post<IApiResponse<Room>>(API_PATH.adminRooms.base, payload);
    return data.data;
  }

  static async list(params: BrowseRoomsParams = {}): Promise<RoomListResult> {
    const { data } = await api.get<IApiResponse<RoomListResult>>(API_PATH.adminRooms.base, {
      params,
    });
    return data.data;
  }

  static async update(id: string, payload: UpdateRoomRequest): Promise<Room> {
    const { data } = await api.patch<IApiResponse<Room>>(API_PATH.adminRooms.detail(id), payload);
    return data.data;
  }

  static async remove(id: string): Promise<MessageResult> {
    const { data } = await api.delete<IApiResponse<MessageResult>>(API_PATH.adminRooms.detail(id));
    return data.data;
  }
}
