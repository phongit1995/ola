export * from './api';

export interface Room {
  id: number;
  name: string;
  description?: string;
  memberCount?: number;
}
