import type { Megaphone } from '../api/megaphone.type';

export interface MegaphonePlayEvent {
  megaphone?: Megaphone;
}

export interface MegaphoneRemovedEvent {
  id?: string;
}
