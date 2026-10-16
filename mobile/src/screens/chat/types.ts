import type { DeviceType } from '@lib/deviceIcons';

export type ContactGroup = 'birthday' | 'new' | 'utility' | 'friend';

export interface Contact {
  id: string;
  name: string;
  fullName?: string;
  status?: string;
  color: string;
  avatar?: string;
  vip: boolean;
  vipTypeId?: number | null;
  online: boolean;
  deviceType: DeviceType;
  lastActive?: string;
  statusImage?: string;
  group: ContactGroup;
}
