import {
  DEFAULT_REEL_BACKGROUND,
  DEFAULT_REEL_FONT,
  REEL_ANGLE_SNAP_DEG,
  REEL_BACKGROUNDS,
  REEL_CENTER_SNAP,
  REEL_ERROR_CODE,
  REEL_FONTS,
  REEL_MAX_VIDEO_SECONDS,
  REEL_MIX_MAX_COLORS,
  REEL_MIX_PREFIX,
  REEL_OVERLAY_SCALE_MAX,
  REEL_OVERLAY_SCALE_MIN,
  REEL_OVERLAY_STYLE,
  REEL_OVERLAY_WIDTH,
  REEL_TEXT_ALIGN,
  REEL_TYPE,
  REEL_VIDEO_EXTENSIONS,
  type ReelBackground,
  type ReelBackgroundKey,
  type ReelFontKey,
} from '../constants/reel';
import type {
  CreateReelItem,
  Reel,
  ReelOverlay,
  ReelTrayGroup,
  ReelViewer,
} from '../types/api/reel.type';
import type {
  ReelDraftSlide,
  ReelMediaDraft,
  ReelPosition,
} from '../types/client/reel.type';
import { toApiError } from './apiError';
import { ImageTooLargeError } from './imageUpload';
import { randomUuid } from './randomUuid';

export interface ReelTray {
  mine: Reel[];
  groups: ReelTrayGroup[];
}

export function isReelBackgroundKey(key: string): key is ReelBackgroundKey {
  return Object.hasOwn(REEL_BACKGROUNDS, key);
}

const REEL_MIX_PATTERN = new RegExp(`^${REEL_MIX_PREFIX}(?:-[0-9a-f]{6}){1,${REEL_MIX_MAX_COLORS}}$`);

export function reelMixKey(colors: readonly string[]): string {
  return [REEL_MIX_PREFIX, ...colors.map((color) => color.replace('#', '').toLowerCase())].join('-');
}

export function parseReelMix(key: string | undefined): string[] | null {
  if (key == null || !REEL_MIX_PATTERN.test(key)) return null;
  return key
    .split('-')
    .slice(1)
    .map((hex) => `#${hex}`);
}

export function toggleReelMixColor(colors: readonly string[], color: string): string[] {
  if (!colors.includes(color)) return [...colors, color].slice(-REEL_MIX_MAX_COLORS);
  if (colors.length === 1) return [...colors];
  return colors.filter((item) => item !== color);
}

function mixedReelBackground(colors: readonly string[]): ReelBackground | null {
  const [from, via, to] = colors;
  if (from == null) return null;
  if (via == null) return { kind: 'solid', color: from };
  return to == null ? { kind: 'gradient', from, to: via } : { kind: 'gradient', from, via, to };
}

export function resolveReelBackground(key: string | undefined): ReelBackground {
  if (key != null && isReelBackgroundKey(key)) return REEL_BACKGROUNDS[key];
  const mix = parseReelMix(key);
  return (mix && mixedReelBackground(mix)) ?? REEL_BACKGROUNDS[DEFAULT_REEL_BACKGROUND];
}

export function reelBackgroundColors(background: ReelBackground): string[] {
  if (background.kind === 'solid') return [background.color];
  return background.via == null
    ? [background.from, background.to]
    : [background.from, background.via, background.to];
}

export function resolveReelFont(key: string): ReelFontKey {
  return REEL_FONTS.find((font) => font === key) ?? DEFAULT_REEL_FONT;
}

export function readableTextColor(hex: string): '#000000' | '#ffffff' {
  const value = hex.replace('#', '');
  if (value.length !== 6) return '#ffffff';
  const r = parseInt(value.slice(0, 2), 16);
  const g = parseInt(value.slice(2, 4), 16);
  const b = parseInt(value.slice(4, 6), 16);
  const luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
  return luminance > 0.6 ? '#000000' : '#ffffff';
}

export function isReelVideoFile(file: { name: string; type: string }): boolean {
  if (file.type.startsWith('video/')) return true;
  const extension = file.name.split('.').pop()?.toLowerCase() ?? '';
  return REEL_VIDEO_EXTENSIONS.some((known) => known === extension);
}

export function isReelActive(reel: Reel, nowMs: number): boolean {
  return Date.parse(reel.expiresAt) > nowMs;
}

export function reelExpiresInMs(reel: Reel, nowMs: number): number {
  const remaining = Date.parse(reel.expiresAt) - nowMs;
  return Number.isFinite(remaining) ? Math.max(0, remaining) : 0;
}

export function activeReelGroups(
  groups: readonly ReelTrayGroup[],
  nowMs: number,
  hiddenIds: ReadonlySet<string> = new Set()
): ReelTrayGroup[] {
  return groups
    .map((group) => ({
      ...group,
      reels: group.reels.filter(
        (reel) => isReelActive(reel, nowMs) && !hiddenIds.has(reel.id)
      ),
    }))
    .filter((group) => group.reels.length > 0);
}

export function visibleReelTray(
  tray: ReelTray,
  seenIds: ReadonlySet<string>,
  nowMs: number
): ReelTray {
  return {
    mine: tray.mine.filter((reel) => isReelActive(reel, nowMs)),
    groups: activeReelGroups(tray.groups, nowMs, seenIds),
  };
}

export function appendReelGroups(
  current: readonly ReelTrayGroup[],
  incoming: readonly ReelTrayGroup[]
): ReelTrayGroup[] {
  const known = new Set(current.map((group) => group.author.id));
  return [
    ...current,
    ...incoming.filter((group) => !known.has(group.author.id)),
  ];
}

export function clampReelUnit(value: number): number {
  return Math.min(1, Math.max(0, value));
}

export function clampReelScale(scale: number): number {
  return Math.min(REEL_OVERLAY_SCALE_MAX, Math.max(REEL_OVERLAY_SCALE_MIN, scale));
}

export function nextReelOption<T>(list: readonly T[], current: T): T {
  const index = list.indexOf(current);
  return list[(index + 1) % list.length] ?? current;
}

export function settleReelAngle(deg: number): number {
  const normalized = ((((deg + 180) % 360) + 360) % 360) - 180;
  return Math.abs(normalized) < REEL_ANGLE_SNAP_DEG ? 0 : normalized;
}

export function isNearReelCenter(x: number): boolean {
  return Math.abs(x - 0.5) < REEL_CENTER_SNAP;
}

export interface ReelSnappedPoint {
  x: number;
  y: number;
  snapX: boolean;
  snapY: boolean;
}

export function snapReelPoint(x: number, y: number): ReelSnappedPoint {
  const clampedX = clampReelUnit(x);
  const clampedY = clampReelUnit(y);
  const snapX = isNearReelCenter(clampedX);
  const snapY = isNearReelCenter(clampedY);
  return { x: snapX ? 0.5 : clampedX, y: snapY ? 0.5 : clampedY, snapX, snapY };
}

export function patchReelOverlay(
  slide: ReelDraftSlide,
  id: string,
  patch: Partial<ReelOverlay>
): ReelDraftSlide {
  return {
    ...slide,
    overlays: slide.overlays.map((overlay) => (overlay.id === id ? { ...overlay, ...patch } : overlay)),
  };
}

export function removeReelOverlay(slide: ReelDraftSlide, id: string): ReelDraftSlide {
  return { ...slide, overlays: slide.overlays.filter((overlay) => overlay.id !== id) };
}

export function raiseReelOverlay(slide: ReelDraftSlide, id: string): ReelDraftSlide {
  const overlay = slide.overlays.find((item) => item.id === id);
  if (overlay == null || slide.overlays.at(-1) === overlay) return slide;
  return { ...slide, overlays: [...slide.overlays.filter((item) => item !== overlay), overlay] };
}

export function createReelOverlay(): ReelOverlay {
  return {
    id: randomUuid(),
    text: '',
    x: 0.5,
    y: 0.5,
    w: REEL_OVERLAY_WIDTH,
    scale: 1,
    rotation: 0,
    color: '#ffffff',
    style: REEL_OVERLAY_STYLE.plain,
    font: DEFAULT_REEL_FONT,
    align: REEL_TEXT_ALIGN.center,
  };
}

export function createReelDraftSlide(media: ReelMediaDraft | null): ReelDraftSlide {
  return {
    id: randomUuid(),
    media,
    background: DEFAULT_REEL_BACKGROUND,
    overlays: [],
  };
}

export function hasReelOverlayText(slide: Pick<ReelDraftSlide, 'overlays'>): boolean {
  return slide.overlays.some((overlay) => overlay.text.trim() !== '');
}

export function reelCreateItems(
  slides: readonly Pick<ReelDraftSlide, 'media' | 'background' | 'overlays'>[]
): CreateReelItem[] {
  return slides.map((slide) => ({
    background: slide.media ? undefined : slide.background,
    overlays: slide.overlays,
  }));
}

export function reelMedia(reel: Reel): ReelMediaDraft | null {
  if (!reel.mediaUrl) {
    return reel.thumbUrl ? { type: REEL_TYPE.image, url: reel.thumbUrl } : null;
  }
  if (reel.type === REEL_TYPE.video) {
    return {
      type: REEL_TYPE.video,
      url: reel.mediaUrl,
      posterUrl: reel.thumbUrl,
      duration: reel.duration,
    };
  }
  if (reel.type === REEL_TYPE.image) return { type: REEL_TYPE.image, url: reel.mediaUrl };
  return null;
}

export function reelPreviewMedia(reel: Reel): ReelMediaDraft | null {
  if (reel.thumbUrl) return { type: REEL_TYPE.image, url: reel.thumbUrl };
  return reelMedia(reel);
}

const REEL_PUBLISH_ERROR_KEY = {
  [REEL_ERROR_CODE.quotaExceeded]: 'reel.errorQuota',
  [REEL_ERROR_CODE.videoTooLong]: 'reel.videoTooLong',
  [REEL_ERROR_CODE.videoCodec]: 'reel.errorCodec',
  [REEL_ERROR_CODE.videoTooLarge]: 'reel.errorTooLarge',
  [REEL_ERROR_CODE.videoInvalid]: 'reel.videoInvalid',
  [REEL_ERROR_CODE.videoNotMp4]: 'reel.videoMp4Only',
} as const;

type ReelPublishErrorCode = keyof typeof REEL_PUBLISH_ERROR_KEY;

export type ReelPublishErrorKey =
  | (typeof REEL_PUBLISH_ERROR_KEY)[ReelPublishErrorCode]
  | 'reel.postFailed';

function isReelPublishErrorCode(code: string | undefined): code is ReelPublishErrorCode {
  return code != null && Object.hasOwn(REEL_PUBLISH_ERROR_KEY, code);
}

export function reelPublishError(error: unknown): {
  key: ReelPublishErrorKey;
  params: { count: number };
} {
  const params = { count: REEL_MAX_VIDEO_SECONDS };
  if (error instanceof ImageTooLargeError) return { key: 'reel.errorTooLarge', params };
  const { code } = toApiError(error);
  return {
    key: isReelPublishErrorCode(code) ? REEL_PUBLISH_ERROR_KEY[code] : 'reel.postFailed',
    params,
  };
}

export function reelGroupStep(
  groupCount: number,
  groupIndex: number,
  direction: 1 | -1
): ReelPosition | null {
  const next = groupIndex + direction;
  if (next >= groupCount) return null;
  return { groupIndex: Math.max(0, next), itemIndex: 0 };
}

export function reelItemStep(
  groups: readonly ReelTrayGroup[],
  position: ReelPosition,
  direction: 1 | -1
): ReelPosition | null {
  const count = groups[position.groupIndex]?.reels.length ?? 0;
  const itemIndex = position.itemIndex + direction;
  if (itemIndex >= 0 && itemIndex < count) {
    return { groupIndex: position.groupIndex, itemIndex };
  }
  return reelGroupStep(groups.length, position.groupIndex, direction);
}

export function appendReelViewers(
  current: readonly ReelViewer[],
  incoming: readonly ReelViewer[]
): ReelViewer[] {
  const known = new Set(current.map((item) => item.user.id));
  return [...current, ...incoming.filter((item) => !known.has(item.user.id))];
}
