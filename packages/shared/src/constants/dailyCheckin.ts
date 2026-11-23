import type {
  DailyCheckinBox,
  DailyCheckinOpenReason,
  DailyCheckinRewardType,
  DailyCheckinSlotStatus,
  DailyCheckinTaskCode,
} from '../types/api/dailyCheckin.type';
import type { DailyCheckinTaskTarget } from '../types/client/dailyCheckin.type';

export const DAILY_CHECKIN_SLOT_STATUS = {
  claimed: 'claimed',
  none: 'none',
  missed: 'missed',
  pending: 'pending',
  today: 'today',
  upcoming: 'upcoming',
  outOfReach: 'out_of_reach',
} as const satisfies Record<string, DailyCheckinSlotStatus>;

export const DAILY_CHECKIN_BOX = {
  none: 'none',
  normal: 'normal',
  big: 'big',
} as const satisfies Record<string, DailyCheckinBox>;

export const DAILY_CHECKIN_REWARD_TYPE = {
  vipDays: 'vip_days',
  vipIcon: 'vip_icon',
  avatarFrame: 'avatar_frame',
  megaphoneTicket: 'megaphone_ticket',
  ken: 'ken',
} as const satisfies Record<string, DailyCheckinRewardType>;

export const DAILY_CHECKIN_TASK = {
  mePost: 'me_post',
  meComment: 'me_comment',
  meReact: 'me_react',
  momentPost: 'moment_post',
  momentComment: 'moment_comment',
  storyComment: 'story_comment',
  sendGift: 'send_gift',
  sendMegaphone: 'send_megaphone',
  playGame: 'play_game',
} as const satisfies Record<string, DailyCheckinTaskCode>;

export const DAILY_CHECKIN_OPEN_REASON = {
  taskPending: 'task_pending',
  vipRequired: 'vip_required',
} as const satisfies Record<string, DailyCheckinOpenReason>;

export const DAILY_CHECKIN_ERROR = {
  disabled: 'CHECKIN_DISABLED',
  completed: 'CHECKIN_COMPLETED',
  emailNotVerified: 'CHECKIN_EMAIL_NOT_VERIFIED',
  taskNotDone: 'CHECKIN_TASK_NOT_DONE',
  vipRequired: 'CHECKIN_VIP_REQUIRED',
  nothingToOpen: 'CHECKIN_NOTHING_TO_OPEN',
} as const;

export const DAILY_CHECKIN_TASK_TARGET: Record<DailyCheckinTaskCode, DailyCheckinTaskTarget> = {
  me_post: 'meComposer',
  me_comment: 'meTab',
  me_react: 'meTab',
  moment_post: 'momentCreate',
  moment_comment: 'momentList',
  story_comment: 'storyTab',
  send_gift: 'gifts',
  send_megaphone: 'megaphone',
  play_game: 'gameTab',
};

export const DAILY_CHECKIN_TASK_NAME_KEY = {
  me_post: 'dailyCheckin.tasks.me_post',
  me_comment: 'dailyCheckin.tasks.me_comment',
  me_react: 'dailyCheckin.tasks.me_react',
  moment_post: 'dailyCheckin.tasks.moment_post',
  moment_comment: 'dailyCheckin.tasks.moment_comment',
  story_comment: 'dailyCheckin.tasks.story_comment',
  send_gift: 'dailyCheckin.tasks.send_gift',
  send_megaphone: 'dailyCheckin.tasks.send_megaphone',
  play_game: 'dailyCheckin.tasks.play_game',
} as const satisfies Record<DailyCheckinTaskCode, string>;

export const DAILY_CHECKIN_REWARD_PRIORITY: readonly DailyCheckinRewardType[] = [
  'avatar_frame',
  'vip_icon',
  'megaphone_ticket',
  'vip_days',
  'ken',
];

export const DAILY_CHECKIN_GRID_COLUMNS = 7;
export const DAILY_CHECKIN_FRESH_MS = 30_000;
export const DAILY_CHECKIN_TICK_MS = 1000;
export const DAILY_CHECKIN_RELOAD_RETRY_MS = 10_000;
export const DAILY_CHECKIN_POPUP_STORAGE_KEY = 'ola.dailyCheckin.popupDay';
export const DAILY_CHECKIN_FAB_STORAGE_KEY = 'ola.dailyCheckin.fabHiddenDay';
