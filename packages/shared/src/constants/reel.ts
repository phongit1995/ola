import type {
  ReelOverlayStyle,
  ReelStatus,
  ReelTextAlign,
  ReelType,
  ReelVisibility,
} from '../types/api/reel.type';

export const REEL_TYPE = {
  image: 'image',
  video: 'video',
  text: 'text',
} as const satisfies Record<string, ReelType>;

export const REEL_VISIBILITY = {
  public: 'public',
  friend: 'friend',
} as const satisfies Record<string, ReelVisibility>;

export const REEL_STATUS = {
  ready: 'ready',
  processing: 'processing',
} as const satisfies Record<string, ReelStatus>;

export const REEL_OVERLAY_STYLE = {
  plain: 'plain',
  solid: 'solid',
  soft: 'soft',
} as const satisfies Record<string, ReelOverlayStyle>;

export const REEL_TEXT_ALIGN = {
  left: 'left',
  center: 'center',
  right: 'right',
} as const satisfies Record<string, ReelTextAlign>;

export const REEL_ERROR_CODE = {
  quotaExceeded: 'REEL_QUOTA_EXCEEDED',
  videoTooLong: 'REEL_VIDEO_TOO_LONG',
  videoCodec: 'REEL_VIDEO_UNSUPPORTED_CODEC',
  videoTooLarge: 'REEL_VIDEO_TOO_LARGE',
  videoInvalid: 'REEL_VIDEO_INVALID',
  videoNotMp4: 'REEL_VIDEO_NOT_MP4',
} as const;

export const REEL_LIFETIME_MS = 24 * 60 * 60 * 1000;
export const REEL_SLIDE_MS = 5000;
export const REEL_SEEN_AFTER_MS = 1000;
export const REEL_SEEN_BATCH = 50;
export const REEL_SEEN_FLUSH_MS = 1500;
export const REEL_RETRY_BASE_MS = 1500;
export const REEL_RETRY_MAX_MS = 30_000;
export const REEL_CLOCK_TICK_MS = 30_000;
export const REEL_PROCESSING_POLL_MS = 4000;
export const REEL_UPLOAD_TIMEOUT_MS = 180_000;
export const REEL_VIEWERS_PAGE_SIZE = 50;
export const REEL_THUMB_MAX_EDGE = 360;
export const REEL_MAX_IMAGES = 3;
export const REEL_MAX_VIDEO_SECONDS = 20;
export const REEL_VIDEO_DURATION_TOLERANCE_S = 0.5;
export const REEL_MAX_VIDEO_BYTES = 45 * 1024 * 1024;
export const REEL_HOLD_TO_PAUSE_MS = 180;
export const REEL_PREV_TAP_ZONE = 0.3;
export const REEL_SWIPE_GROUP_PX = 60;
export const REEL_SWIPE_CLOSE_PX = 90;
export const REEL_CENTER_SNAP = 0.015;
export const REEL_ANGLE_SNAP_DEG = 4;
export const REEL_SOFT_BACKDROP = 'rgba(0, 0, 0, 0.45)';
export const REEL_VIDEO_EXTENSIONS = [
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
export const REEL_VIDEO_ACCEPT = [
  'video/*',
  ...REEL_VIDEO_EXTENSIONS.map((extension) => `.${extension}`),
].join(',');
export const REEL_MAX_OVERLAYS = 5;
export const REEL_MAX_OVERLAY_CHARS = 200;
export const REEL_OVERLAY_FONT_RATIO = 0.07;
export const REEL_OVERLAY_SCALE_MIN = 0.3;
export const REEL_OVERLAY_SCALE_MAX = 4;
export const REEL_OVERLAY_WIDTH = 0.8;

export type ReelBackground =
  | { kind: 'solid'; color: string }
  | { kind: 'gradient'; from: string; via?: string; to: string };

export const REEL_BACKGROUNDS = {
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
} as const satisfies Record<string, ReelBackground>;

export type ReelBackgroundKey = keyof typeof REEL_BACKGROUNDS;

export const DEFAULT_REEL_BACKGROUND: ReelBackgroundKey = 'sky';

export const REEL_MIX_PREFIX = 'mix';

export const REEL_MIX_MAX_COLORS = 3;

export const REEL_MIX_ICON_COLORS = ['#ff4081', '#ffc107', '#4caf50', '#2196f3', '#9c27b0'] as const;

export const REEL_MIX_COLORS = [
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

export const REEL_FONTS = ['sans', 'serif', 'bold'] as const;

export type ReelFontKey = (typeof REEL_FONTS)[number];

export const DEFAULT_REEL_FONT: ReelFontKey = 'sans';

export const REEL_FONT_LABEL = {
  sans: 'reel.font_sans',
  serif: 'reel.font_serif',
  bold: 'reel.font_bold',
} as const satisfies Record<ReelFontKey, string>;

export const REEL_VISIBILITY_LABEL = {
  public: 'reel.visibility_public',
  friend: 'reel.visibility_friend',
} as const satisfies Record<ReelVisibility, string>;

export const REEL_TEXT_COLORS = [
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
