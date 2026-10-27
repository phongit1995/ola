import type {
  MomentHiddenBy,
  MomentOverlayStyle,
  MomentStatus,
  MomentTextAlign,
  MomentType,
  MomentVisibility,
} from '../types/api/moment.type';

export const MOMENT_TYPE = {
  image: 'image',
  video: 'video',
  text: 'text',
} as const satisfies Record<string, MomentType>;

export const MOMENT_VISIBILITY = {
  public: 'public',
  friend: 'friend',
} as const satisfies Record<string, MomentVisibility>;

export const DEFAULT_MOMENT_VISIBILITY: MomentVisibility = MOMENT_VISIBILITY.public;

export const MOMENT_STATUS = {
  ready: 'ready',
  processing: 'processing',
  purging: 'purging',
  purged: 'purged',
} as const satisfies Record<string, MomentStatus>;

export const MOMENT_HIDDEN_BY = {
  owner: 'owner',
  admin: 'admin',
} as const satisfies Record<string, MomentHiddenBy>;

export const MOMENT_OVERLAY_STYLE = {
  plain: 'plain',
  solid: 'solid',
  soft: 'soft',
} as const satisfies Record<string, MomentOverlayStyle>;

export const MOMENT_TEXT_ALIGN = {
  left: 'left',
  center: 'center',
  right: 'right',
} as const satisfies Record<string, MomentTextAlign>;

export const MOMENT_ERROR_CODE = {
  quotaExceeded: 'MOMENT_QUOTA_EXCEEDED',
  videoTooLong: 'MOMENT_VIDEO_TOO_LONG',
  videoCodec: 'MOMENT_VIDEO_UNSUPPORTED_CODEC',
  videoTooLarge: 'MOMENT_VIDEO_TOO_LARGE',
  videoInvalid: 'MOMENT_VIDEO_INVALID',
  videoNotMp4: 'MOMENT_VIDEO_NOT_MP4',
  videoVipRequired: 'MOMENT_VIDEO_VIP_REQUIRED',
  hiddenByAdmin: 'MOMENT_HIDDEN_BY_ADMIN',
} as const;

export const MOMENT_LIFETIME_MS = 24 * 60 * 60 * 1000;
export const MOMENT_SLIDE_MS = 5000;
export const MOMENT_SEEN_AFTER_MS = 1000;
export const MOMENT_SEEN_BATCH = 50;
export const MOMENT_SEEN_FLUSH_MS = 1500;
export const MOMENT_REACT_FLUSH_MS = 800;
export const MOMENT_REACT_MAX_PER_REQUEST = 20;
export const MOMENT_REACT_MAX_PER_TYPE = 99;
export const MOMENT_RETRY_BASE_MS = 1500;
export const MOMENT_RETRY_MAX_MS = 30_000;
export const MOMENT_CLOCK_TICK_MS = 30_000;
export const MOMENT_TRAY_REFRESH_MS = 3 * 60_000;
export const MOMENT_PROCESSING_POLL_MS = 4000;
export const MOMENT_UPLOAD_TIMEOUT_MS = 180_000;
export const MOMENT_VIEWERS_PAGE_SIZE = 50;
export const MOMENT_HISTORY_PAGE_SIZE = 30;
export const MOMENT_THUMB_MAX_EDGE = 360;
export const MOMENT_VIEWER_PREFETCH_GROUPS = 3;
export const MOMENT_MAX_SLIDES = 3;
export const MOMENT_MAX_VIDEO_SECONDS = 30;
export const MOMENT_VIDEO_DURATION_TOLERANCE_S = 0.5;
export const MOMENT_MAX_VIDEO_BYTES = 70 * 1024 * 1024;
export const MOMENT_HOLD_TO_PAUSE_MS = 180;
export const MOMENT_PREV_TAP_ZONE = 0.3;
export const MOMENT_SWIPE_GROUP_PX = 60;
export const MOMENT_SWIPE_CLOSE_PX = 90;
export const MOMENT_TURN_MS = 340;
export const MOMENT_TURN_MIN_FRACTION = 0.35;
export const MOMENT_TURN_SHADE = 0.5;
export const MOMENT_TURN_EDGE_RESISTANCE = 0.25;
export const MOMENT_FADE_MS = 180;
export const MOMENT_CENTER_SNAP = 0.015;
export const MOMENT_ANGLE_SNAP_DEG = 4;
export const MOMENT_SOFT_BACKDROP = 'rgba(0, 0, 0, 0.45)';
export const MOMENT_VIDEO_EXTENSIONS = [
  'mp4',
  'm4v',
  'mov',
  'webm',
  'mkv',
  'avi',
  'wmv',
  'flv',
  '3gp',
  '3g2',
  'ts',
  'mts',
  'm2ts',
  'mpg',
  'mpeg',
  'ogv',
] as const;
export const MOMENT_VIDEO_ACCEPT = [
  'video/*',
  ...MOMENT_VIDEO_EXTENSIONS.map((extension) => `.${extension}`),
].join(',');
export const MOMENT_MAX_OVERLAYS = 5;
export const MOMENT_MAX_OVERLAY_CHARS = 200;
export const MOMENT_OVERLAY_FONT_RATIO = 0.07;
export const MOMENT_OVERLAY_SCALE_MIN = 0.3;
export const MOMENT_OVERLAY_SCALE_MAX = 4;
export const MOMENT_FONT_SIZE_PRESETS = [0.75, 1, 1.25, 1.5, 1.75, 2] as const;
export const MOMENT_OVERLAY_WIDTH = 0.8;

export type MomentBackground =
  | { kind: 'solid'; color: string }
  | { kind: 'gradient'; from: string; via?: string; to: string };

export const MOMENT_BACKGROUNDS = {
  sky: { kind: 'gradient', from: '#4facfe', to: '#0061ff' },
  sunset: { kind: 'gradient', from: '#ff9a44', to: '#fc6076' },
  grape: { kind: 'gradient', from: '#a18cd1', to: '#6a3093' },
  forest: { kind: 'gradient', from: '#9ccc65', to: '#33691e' },
  ocean: { kind: 'gradient', from: '#26c6da', to: '#00695c' },
  peach: { kind: 'gradient', from: '#ffd1a9', to: '#ff6f91' },
  night: { kind: 'gradient', from: '#434343', to: '#000000' },
  flame: { kind: 'gradient', from: '#f5af19', to: '#f12711' },
  cherry: { kind: 'gradient', from: '#f45c43', to: '#eb3349' },
  candy: { kind: 'gradient', from: '#fc5c7d', to: '#6a82fb' },
  aurora: { kind: 'gradient', from: '#e100ff', to: '#7f00ff' },
  violet: { kind: 'gradient', from: '#8e2de2', to: '#4a00e0' },
  cosmic: { kind: 'gradient', from: '#ff00cc', to: '#333399' },
  lagoon: { kind: 'gradient', from: '#43cea2', to: '#185a9d' },
  meadow: { kind: 'gradient', from: '#38ef7d', to: '#11998e' },
  gold: { kind: 'gradient', from: '#ffd200', to: '#f7971e' },
  coral: { kind: 'gradient', from: '#feb47b', to: '#ff7e5f' },
  dusk: { kind: 'gradient', from: '#fd746c', to: '#2c3e50' },
  royal: { kind: 'gradient', from: '#243b55', to: '#141e30' },
  rose: { kind: 'solid', color: '#e91e63' },
  sun: { kind: 'solid', color: '#ffc107' },
  ink: { kind: 'solid', color: '#263238' },
  paper: { kind: 'solid', color: '#f5f5f5' },
  red: { kind: 'solid', color: '#e53935' },
  orange: { kind: 'solid', color: '#fb8c00' },
  green: { kind: 'solid', color: '#43a047' },
  jade: { kind: 'solid', color: '#00897b' },
  blue: { kind: 'solid', color: '#1e88e5' },
  purple: { kind: 'solid', color: '#8e24aa' },
  black: { kind: 'solid', color: '#000000' },
} as const satisfies Record<string, MomentBackground>;

export type MomentBackgroundKey = keyof typeof MOMENT_BACKGROUNDS;

export const DEFAULT_MOMENT_BACKGROUND: MomentBackgroundKey = 'sky';

export const MOMENT_MIX_PREFIX = 'mix';

export const MOMENT_MIX_MAX_COLORS = 3;

export const MOMENT_MIX_ICON_COLORS = ['#ff4081', '#ffc107', '#4caf50', '#2196f3', '#9c27b0'] as const;

export const MOMENT_MIX_COLORS = [
  '#ffffff',
  '#000000',
  '#e53935',
  '#ff4081',
  '#9c27b0',
  '#673ab7',
  '#3f51b5',
  '#2196f3',
  '#00bcd4',
  '#009688',
  '#4caf50',
  '#8bc34a',
  '#ffeb3b',
  '#ffc107',
  '#ff9800',
  '#795548',
] as const;

export const MOMENT_FONTS = ['sans', 'serif', 'mono', 'hand', 'round', 'art'] as const;

export type MomentFontKey = (typeof MOMENT_FONTS)[number];

export const DEFAULT_MOMENT_FONT: MomentFontKey = 'sans';

export const MOMENT_LEGACY_BOLD_FONT = 'bold';

export const MOMENT_FONT_LABEL = {
  sans: 'moment.font_sans',
  serif: 'moment.font_serif',
  mono: 'moment.font_mono',
  hand: 'moment.font_hand',
  round: 'moment.font_round',
  art: 'moment.font_art',
} as const satisfies Record<MomentFontKey, string>;

export const MOMENT_FONT_CAPS = {
  sans: { bold: true, italic: true },
  serif: { bold: true, italic: true },
  mono: { bold: true, italic: true },
  hand: { bold: true, italic: false },
  round: { bold: true, italic: false },
  art: { bold: false, italic: false },
} as const satisfies Record<MomentFontKey, { bold: boolean; italic: boolean }>;

export const MOMENT_VISIBILITY_LABEL = {
  public: 'moment.visibility_public',
  friend: 'moment.visibility_friend',
} as const satisfies Record<MomentVisibility, string>;

export const MOMENT_TEXT_COLORS = [
  '#ffffff',
  '#000000',
  '#e34545',
  '#ff9800',
  '#ffeb3b',
  '#7cb342',
  '#26c6da',
  '#2196f3',
  '#9c27b0',
  '#ff4081',
] as const;
