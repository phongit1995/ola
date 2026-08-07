import { kulImageForText } from './kul';
import { MESSAGE_TYPE } from '@ola/shared/constants';

interface MessageView {
  type?: string;
  content: string;
}

export interface ReplyExcerptLabels {
  image: string;
  audio: string;
  sticker: string;
}

function messageType(message: MessageView): string {
  return message.type ?? 'text';
}

export function isCopyableMessageText(message: MessageView): boolean {
  return (
    messageType(message) === MESSAGE_TYPE.text &&
    message.content.trim() !== '' &&
    kulImageForText(message.content) == null
  );
}

export function messageReplyExcerpt(
  message: MessageView,
  labels: ReplyExcerptLabels,
): string {
  const type = messageType(message);
  if (type === MESSAGE_TYPE.image) return labels.image;
  if (type === MESSAGE_TYPE.audio) return labels.audio;
  return kulImageForText(message.content) != null
    ? labels.sticker
    : message.content;
}
