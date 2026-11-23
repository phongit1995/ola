import type {
  DailyCheckinBox,
  DailyCheckinReward,
  DailyCheckinStatus,
} from '../api/dailyCheckin.type';

export type DailyCheckinTaskTarget =
  | 'meComposer'
  | 'meTab'
  | 'momentCreate'
  | 'momentList'
  | 'storyTab'
  | 'gifts'
  | 'megaphone'
  | 'gameTab';

export type DailyCheckinTodayKind = 'checkin' | 'noGift' | 'task' | 'open' | 'opened' | 'completed';

export type DailyCheckinFabKind = 'checkin' | 'task' | 'open';

export type DailyCheckinRestInfo =
  | { kind: 'rest'; days: number }
  | { kind: 'lastRest'; slot: number }
  | { kind: 'unreachable'; slot: number };

export type DailyCheckinActionOutcome = 'done' | 'needsEmail' | 'vipRequired' | 'failed';

export type DailyCheckinNotice = 'needsEmail' | 'vipRequired';

export interface DailyCheckinOpened {
  slot: number;
  box: DailyCheckinBox;
  items: DailyCheckinReward[];
}

export interface DailyCheckinLoadOptions {
  force?: boolean;
}

export interface DailyCheckinState {
  status: DailyCheckinStatus | null;
  loadedAt: number;
  loading: boolean;
  acting: boolean;
  opened: DailyCheckinOpened | null;
  notice: DailyCheckinNotice | null;
  popupRequest: number;
  load: (options?: DailyCheckinLoadOptions) => Promise<void>;
  checkIn: () => Promise<DailyCheckinActionOutcome>;
  open: () => Promise<DailyCheckinActionOutcome>;
  dismissOpened: () => void;
  dismissNotice: () => void;
  requestPopup: () => void;
  reset: () => void;
}
