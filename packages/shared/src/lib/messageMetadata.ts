import type { MessageMetadata } from '../types/lib.type';

export type { MessageMetadata } from '../types/lib.type';

export function parseMessageMetadata(metadata?: string | null): MessageMetadata {
  if (metadata == null || metadata === '') return {};
  try {
    const parsed = JSON.parse(metadata);
    if (parsed == null || typeof parsed !== 'object' || Array.isArray(parsed)) return {};
    return parsed as MessageMetadata;
  } catch {
    return {};
  }
}
