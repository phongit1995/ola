import { http } from '../api';
import { API_PATH } from '../config';
import {
  appendUploadFile,
  audioUploadFilename,
  uploadFileMimeType,
  type UploadFile,
} from '../lib/upload';
import type {
  MessageResult,
  ReactionType,
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

export interface SendRoomAudioOptions {
  clientMsgId?: string;
  replyToId?: string;
  waveform?: number[];
}

const AUDIO_UPLOAD_TIMEOUT_MS = 120_000;

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

  static sendImage(
    id: string,
    file: UploadFile,
    clientMsgId?: string,
    filename?: string
  ): Promise<RoomMessage> {
    const form = new FormData();
    appendUploadFile(form, 'file', file, filename);
    if (clientMsgId != null) form.append('clientMsgId', clientMsgId);
    return http.postForm<RoomMessage>(API_PATH.rooms.messagesImages(id), form);
  }

  static sendAudio(
    id: string,
    file: UploadFile,
    duration: number,
    options: SendRoomAudioOptions = {}
  ): Promise<RoomMessage> {
    const form = new FormData();
    appendUploadFile(form, 'file', file, audioUploadFilename(uploadFileMimeType(file)));
    form.append('duration', String(duration));
    if (options.clientMsgId != null) form.append('clientMsgId', options.clientMsgId);
    if (options.replyToId != null) form.append('replyToId', options.replyToId);
    if (options.waveform != null && options.waveform.length > 0) {
      form.append('waveform', JSON.stringify(options.waveform));
    }
    return http.postForm<RoomMessage>(API_PATH.rooms.messagesAudio(id), form, {
      timeout: AUDIO_UPLOAD_TIMEOUT_MS,
    });
  }

  static deleteMessage(id: string, messageId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.rooms.message(id, messageId));
  }

  static toggleMessageReaction(
    id: string,
    messageId: string,
    type: ReactionType
  ): Promise<RoomMessage> {
    return http.post<RoomMessage>(API_PATH.rooms.messageReactions(id, messageId), { type });
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
