import type { Megaphone } from '../api/megaphone.type';

export interface MegaphoneNewEvent {
  megaphone?: Megaphone;
  serverTime?: string;
}

export interface MegaphoneRemovedEvent {
  id?: string;
}
