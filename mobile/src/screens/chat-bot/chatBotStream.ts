import { xhrChatBotTransport } from '@ola/shared/services/chatBotXhrTransport';
import {
  streamChatBot as streamWithTransport,
  type StreamChatBotOptions,
} from '@ola/shared/services';

export { ChatBotStreamError } from '@ola/shared/services';

export function streamChatBot(
  options: Omit<StreamChatBotOptions, 'transport'>
): Promise<boolean> {
  return streamWithTransport({ ...options, transport: xhrChatBotTransport });
}
