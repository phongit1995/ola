import type { TFunction } from 'i18next';
import {
  DEFAULT_MOMENT_BACKGROUND,
  DEFAULT_MOMENT_FONT,
  MOMENT_ANGLE_SNAP_DEG,
  MOMENT_BACKGROUNDS,
  MOMENT_CENTER_SNAP,
  MOMENT_ERROR_CODE,
  MOMENT_FONT_CAPS,
  MOMENT_FONT_SIZE_PRESETS,
  MOMENT_FONTS,
  MOMENT_HIDDEN_BY,
  MOMENT_LEGACY_BOLD_FONT,
  MOMENT_MAX_SLIDES,
  MOMENT_MAX_VIDEO_SECONDS,
  MOMENT_MIX_MAX_COLORS,
  MOMENT_MIX_PREFIX,
  MOMENT_OVERLAY_SCALE_MAX,
  MOMENT_OVERLAY_SCALE_MIN,
  MOMENT_OVERLAY_STYLE,
  MOMENT_OVERLAY_WIDTH,
  MOMENT_STATUS,
  MOMENT_TEXT_ALIGN,
  MOMENT_TYPE,
  MOMENT_VIDEO_EXTENSIONS,
  type MomentBackground,
  type MomentBackgroundKey,
  type MomentFontKey,
} from '../constants/moment';
import type {
  CreateMomentItem,
  Moment,
  MomentAuthor,
  MomentOverlay,
  MomentTrayGroup,
  MomentType,
} from '../types/api/moment.type';
import type { ReactionType } from '../types/api/chat.type';
import type {
  MomentDraftSlide,
  MomentMediaDraft,
  MomentPosition,
} from '../types/client/moment.type';
import { toApiError } from './apiError';
import { ImageTooLargeError } from './imageUpload';
import { randomUuid } from './randomUuid';

export interface MomentTray {
  mine: Moment[];
  groups: MomentTrayGroup[];
}

export function isMomentBackgroundKey(key: string): key is MomentBackgroundKey {
  return Object.hasOwn(MOMENT_BACKGROUNDS, key);
}

const MOMENT_MIX_PATTERN = new RegExp(`^${MOMENT_MIX_PREFIX}(?:-[0-9a-f]{6}){1,${MOMENT_MIX_MAX_COLORS}}$`);

export function momentMixKey(colors: readonly string[]): string {
  return [MOMENT_MIX_PREFIX, ...colors.map((color) => color.replace('#', '').toLowerCase())].join('-');
}

export function parseMomentMix(key: string | undefined): string[] | null {
  if (key == null || !MOMENT_MIX_PATTERN.test(key)) return null;
  return key
    .split('-')
    .slice(1)
    .map((hex) => `#${hex}`);
}

export function toggleMomentMixColor(colors: readonly string[], color: string): string[] {
  if (!colors.includes(color)) return [...colors, color].slice(-MOMENT_MIX_MAX_COLORS);
  if (colors.length === 1) return [...colors];
  return colors.filter((item) => item !== color);
}

function mixedMomentBackground(colors: readonly string[]): MomentBackground | null {
  const [from, via, to] = colors;
  if (from == null) return null;
  if (via == null) return { kind: 'solid', color: from };
  return to == null ? { kind: 'gradient', from, to: via } : { kind: 'gradient', from, via, to };
}

export function resolveMomentBackground(key: string | undefined): MomentBackground {
  if (key != null && isMomentBackgroundKey(key)) return MOMENT_BACKGROUNDS[key];
  const mix = parseMomentMix(key);
  return (mix && mixedMomentBackground(mix)) ?? MOMENT_BACKGROUNDS[DEFAULT_MOMENT_BACKGROUND];
}

export function momentBackgroundColors(background: MomentBackground): string[] {
  if (background.kind === 'solid') return [background.color];
  return background.via == null
    ? [background.from, background.to]
    : [background.from, background.via, background.to];
}

export function resolveMomentFont(key: string): MomentFontKey {
  return MOMENT_FONTS.find((font) => font === key) ?? DEFAULT_MOMENT_FONT;
}

export interface MomentTextFace {
  font: MomentFontKey;
  bold: boolean;
  italic: boolean;
}

export function resolveMomentTextFace(
  overlay: Pick<MomentOverlay, 'font' | 'bold' | 'italic'>
): MomentTextFace {
  if (overlay.font === MOMENT_LEGACY_BOLD_FONT) return { font: 'round', bold: true, italic: false };
  const font = resolveMomentFont(overlay.font);
  const caps = MOMENT_FONT_CAPS[font];
  return {
    font,
    bold: caps.bold && overlay.bold === true,
    italic: caps.italic && overlay.italic === true,
  };
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

export function isMomentVideoFile(file: { name: string; type: string }): boolean {
  if (file.type.startsWith('video/')) return true;
  const extension = file.name.split('.').pop()?.toLowerCase() ?? '';
  return MOMENT_VIDEO_EXTENSIONS.some((known) => known === extension);
}

export function isMomentActive(moment: Moment, nowMs: number): boolean {
  return Date.parse(moment.expiresAt) > nowMs;
}

const MINUTE_MS = 60_000;
const HOUR_MS = 60 * MINUTE_MS;

export function momentTimeLeftLabel(t: TFunction, moment: Moment, nowMs: number): string {
  const remaining = momentExpiresInMs(moment, nowMs);
  const hours = Math.floor(remaining / HOUR_MS);
  if (hours >= 1) return t('moment.remainingHours', { count: hours });
  return t('moment.remainingMinutes', { count: Math.max(1, Math.ceil(remaining / MINUTE_MS)) });
}

export function momentLifeLabel(t: TFunction, moment: Moment, nowMs: number): string {
  return isMomentActive(moment, nowMs) ? momentTimeLeftLabel(t, moment, nowMs) : t('moment.expired');
}

export function isMomentHidden(moment: Moment): boolean {
  return moment.hidden === true;
}

export function isMomentHiddenByAdmin(moment: Moment): boolean {
  return isMomentHidden(moment) && moment.hiddenBy === MOMENT_HIDDEN_BY.admin;
}

export function isMomentMediaPurged(moment: Moment): boolean {
  return moment.mediaPurged === true;
}

export type MomentNoticeKey = 'moment.processing' | 'moment.mediaError';

export const MOMENT_REACTION_LABEL_KEY = {
  LIKE: 'moment.reactionLike',
  LOVE: 'moment.reactionLove',
  HAHA: 'moment.reactionHaha',
  WOW: 'moment.reactionWow',
  SAD: 'moment.reactionSad',
  ANGRY: 'moment.reactionAngry',
} as const satisfies Record<ReactionType, string>;

export function momentNoticeKey(moment: Moment, mediaFailed: boolean): MomentNoticeKey | null {
  if (moment.status === MOMENT_STATUS.processing) return 'moment.processing';
  if (isMomentMediaPurged(moment)) return null;
  return mediaFailed ? 'moment.mediaError' : null;
}

export function momentExpiresInMs(moment: Moment, nowMs: number): number {
  const remaining = Date.parse(moment.expiresAt) - nowMs;
  return Number.isFinite(remaining) ? Math.max(0, remaining) : 0;
}

export function activeMomentGroups(
  groups: readonly MomentTrayGroup[],
  nowMs: number,
  hiddenIds: ReadonlySet<string> = new Set()
): MomentTrayGroup[] {
  return groups
    .map((group) => ({
      ...group,
      moments: group.moments.filter(
        (moment) => isMomentActive(moment, nowMs) && !hiddenIds.has(moment.id)
      ),
    }))
    .filter((group) => group.moments.length > 0);
}

export function visibleMomentTray(tray: MomentTray, nowMs: number): MomentTray {
  return {
    mine: tray.mine.filter((moment) => isMomentActive(moment, nowMs) && !isMomentHidden(moment)),
    groups: activeMomentGroups(tray.groups, nowMs),
  };
}

export function isMomentSeen(moment: Moment, seenIds: ReadonlySet<string>): boolean {
  return moment.seen === true || seenIds.has(moment.id);
}

export function isMomentGroupSeen(group: MomentTrayGroup, seenIds: ReadonlySet<string>): boolean {
  return group.moments.every((moment) => isMomentSeen(moment, seenIds));
}

export function momentGroupStartIndex(
  group: MomentTrayGroup | undefined,
  seenIds: ReadonlySet<string>
): number {
  const index = group?.moments.findIndex((moment) => !isMomentSeen(moment, seenIds)) ?? -1;
  return Math.max(index, 0);
}

export function appendMomentGroups(
  current: readonly MomentTrayGroup[],
  incoming: readonly MomentTrayGroup[]
): MomentTrayGroup[] {
  const known = new Set(current.map((group) => group.author.id));
  return [
    ...current,
    ...incoming.filter((group) => !known.has(group.author.id)),
  ];
}

export function clampMomentUnit(value: number): number {
  return Math.min(1, Math.max(0, value));
}

export function clampMomentScale(scale: number): number {
  return Math.min(MOMENT_OVERLAY_SCALE_MAX, Math.max(MOMENT_OVERLAY_SCALE_MIN, scale));
}

export function momentFontSizeOptions(scale: number): number[] {
  const current = Math.round(scale * 100) / 100;
  const presets: number[] = [...MOMENT_FONT_SIZE_PRESETS];
  if (!presets.includes(current)) presets.push(current);
  return presets.sort((a, b) => a - b);
}

export function momentFontSizeLabel(scale: number): string {
  return `${Math.round(scale * 100)}%`;
}

export function nextMomentOption<T>(list: readonly T[], current: T): T {
  const index = list.indexOf(current);
  return list[(index + 1) % list.length] ?? current;
}

export function settleMomentAngle(deg: number): number {
  const normalized = ((((deg + 180) % 360) + 360) % 360) - 180;
  return Math.abs(normalized) < MOMENT_ANGLE_SNAP_DEG ? 0 : normalized;
}

export function isNearMomentCenter(x: number): boolean {
  return Math.abs(x - 0.5) < MOMENT_CENTER_SNAP;
}

export interface MomentSnappedPoint {
  x: number;
  y: number;
  snapX: boolean;
  snapY: boolean;
}

export function snapMomentPoint(x: number, y: number): MomentSnappedPoint {
  const clampedX = clampMomentUnit(x);
  const clampedY = clampMomentUnit(y);
  const snapX = isNearMomentCenter(clampedX);
  const snapY = isNearMomentCenter(clampedY);
  return { x: snapX ? 0.5 : clampedX, y: snapY ? 0.5 : clampedY, snapX, snapY };
}

export function patchMomentOverlay(
  slide: MomentDraftSlide,
  id: string,
  patch: Partial<MomentOverlay>
): MomentDraftSlide {
  return {
    ...slide,
    overlays: slide.overlays.map((overlay) => (overlay.id === id ? { ...overlay, ...patch } : overlay)),
  };
}

export function removeMomentOverlay(slide: MomentDraftSlide, id: string): MomentDraftSlide {
  return { ...slide, overlays: slide.overlays.filter((overlay) => overlay.id !== id) };
}

export function raiseMomentOverlay(slide: MomentDraftSlide, id: string): MomentDraftSlide {
  const overlay = slide.overlays.find((item) => item.id === id);
  if (overlay == null || slide.overlays.at(-1) === overlay) return slide;
  return { ...slide, overlays: [...slide.overlays.filter((item) => item !== overlay), overlay] };
}

export function createMomentOverlay(): MomentOverlay {
  return {
    id: randomUuid(),
    text: '',
    x: 0.5,
    y: 0.5,
    w: MOMENT_OVERLAY_WIDTH,
    scale: 1,
    rotation: 0,
    color: '#ffffff',
    style: MOMENT_OVERLAY_STYLE.plain,
    font: DEFAULT_MOMENT_FONT,
    align: MOMENT_TEXT_ALIGN.center,
  };
}

export function createMomentDraftSlide(media: MomentMediaDraft | null): MomentDraftSlide {
  return {
    id: randomUuid(),
    media,
    background: DEFAULT_MOMENT_BACKGROUND,
    overlays: [],
  };
}

export function hasMomentOverlayText(slide: Pick<MomentDraftSlide, 'overlays'>): boolean {
  return slide.overlays.some((overlay) => overlay.text.trim() !== '');
}

export function createBlankMomentSlide(): MomentDraftSlide {
  return { ...createMomentDraftSlide(null), blank: true };
}

export function momentPhotoRoom(slideCount: number): number {
  return MOMENT_MAX_SLIDES - slideCount + 1;
}

export function fillMomentSlidePhotos(
  slides: readonly MomentDraftSlide[],
  index: number,
  photos: readonly MomentMediaDraft[]
): MomentDraftSlide[] {
  const target = slides[index];
  const [first, ...rest] = photos;
  if (target == null || first == null) return [...slides];
  return [
    ...slides.slice(0, index),
    { ...target, media: first, blank: false },
    ...rest.map((photo) => createMomentDraftSlide(photo)),
    ...slides.slice(index + 1),
  ];
}

export interface MomentSlideIssue {
  index: number;
  messageKey: 'moment.chooseFirst' | 'moment.emptyText';
}

export function momentSlideIssue(
  slides: readonly Pick<MomentDraftSlide, 'media' | 'overlays' | 'blank'>[]
): MomentSlideIssue | null {
  const blank = slides.findIndex((slide) => slide.blank === true);
  if (blank >= 0) return { index: blank, messageKey: 'moment.chooseFirst' };
  const missingText = slides.findIndex(
    (slide) => slide.media == null && !hasMomentOverlayText(slide)
  );
  return missingText >= 0 ? { index: missingText, messageKey: 'moment.emptyText' } : null;
}

export function momentCreateItems(
  slides: readonly Pick<MomentDraftSlide, 'media' | 'background' | 'overlays'>[]
): CreateMomentItem[] {
  return slides.map((slide) => ({
    type: slide.media?.type ?? MOMENT_TYPE.text,
    background: slide.media ? undefined : slide.background,
    overlays: slide.overlays.map((overlay) => {
      const face = resolveMomentTextFace(overlay);
      return { ...overlay, bold: face.bold, italic: face.italic };
    }),
  }));
}

export function momentUploadType(slides: readonly Pick<MomentDraftSlide, 'media'>[]): MomentType {
  if (slides.some((slide) => slide.media?.type === MOMENT_TYPE.video)) return MOMENT_TYPE.video;
  if (slides.some((slide) => slide.media?.type === MOMENT_TYPE.image)) return MOMENT_TYPE.image;
  return MOMENT_TYPE.text;
}

export function momentMedia(moment: Moment): MomentMediaDraft | null {
  if (!moment.mediaUrl) {
    return moment.thumbUrl ? { type: MOMENT_TYPE.image, url: moment.thumbUrl } : null;
  }
  if (moment.type === MOMENT_TYPE.video) {
    return {
      type: MOMENT_TYPE.video,
      url: moment.mediaUrl,
      posterUrl: moment.thumbUrl,
      duration: moment.duration,
    };
  }
  if (moment.type === MOMENT_TYPE.image) return { type: MOMENT_TYPE.image, url: moment.mediaUrl };
  return null;
}

export function momentPreloadUrl(moment: Moment): string | undefined {
  const media = momentMedia(moment);
  return media?.type === MOMENT_TYPE.image ? media.url : media?.posterUrl;
}

export function momentPreviewMedia(moment: Moment): MomentMediaDraft | null {
  if (moment.thumbUrl) return { type: MOMENT_TYPE.image, url: moment.thumbUrl };
  return momentMedia(moment);
}

const MOMENT_PUBLISH_ERROR_KEY = {
  [MOMENT_ERROR_CODE.quotaExceeded]: 'moment.errorQuota',
  [MOMENT_ERROR_CODE.videoTooLong]: 'moment.videoTooLong',
  [MOMENT_ERROR_CODE.videoCodec]: 'moment.errorCodec',
  [MOMENT_ERROR_CODE.videoTooLarge]: 'moment.errorTooLarge',
  [MOMENT_ERROR_CODE.videoInvalid]: 'moment.videoInvalid',
  [MOMENT_ERROR_CODE.videoNotMp4]: 'moment.videoMp4Only',
  [MOMENT_ERROR_CODE.videoVipRequired]: 'moment.videoVipRequired',
} as const;

type MomentPublishErrorCode = keyof typeof MOMENT_PUBLISH_ERROR_KEY;

export type MomentPublishErrorKey =
  | (typeof MOMENT_PUBLISH_ERROR_KEY)[MomentPublishErrorCode]
  | 'moment.postFailed';

function isMomentPublishErrorCode(code: string | undefined): code is MomentPublishErrorCode {
  return code != null && Object.hasOwn(MOMENT_PUBLISH_ERROR_KEY, code);
}

export function momentPublishError(error: unknown): {
  key: MomentPublishErrorKey;
  params: { count: number };
} {
  const params = { count: MOMENT_MAX_VIDEO_SECONDS };
  if (error instanceof ImageTooLargeError) return { key: 'moment.errorTooLarge', params };
  const { code } = toApiError(error);
  return {
    key: isMomentPublishErrorCode(code) ? MOMENT_PUBLISH_ERROR_KEY[code] : 'moment.postFailed',
    params,
  };
}

export function momentGroupStep(
  groupCount: number,
  groupIndex: number,
  direction: 1 | -1
): MomentPosition | null {
  const next = groupIndex + direction;
  if (next >= groupCount) return null;
  return { groupIndex: Math.max(0, next), itemIndex: 0 };
}

export function momentGroupEntryStep(
  groups: readonly MomentTrayGroup[],
  groupIndex: number,
  direction: 1 | -1,
  seenIds: ReadonlySet<string>
): MomentPosition | null {
  const position = momentGroupStep(groups.length, groupIndex, direction);
  if (position == null) return null;
  return {
    groupIndex: position.groupIndex,
    itemIndex: momentGroupStartIndex(groups[position.groupIndex], seenIds),
  };
}

export interface MomentSeenStep {
  seenIds: ReadonlySet<string>;
  unseenOnly: boolean;
}

function nextGroupPosition(
  groups: readonly MomentTrayGroup[],
  groupIndex: number,
  seen: MomentSeenStep
): MomentPosition | null {
  for (let index = groupIndex + 1; index < groups.length; index += 1) {
    const group = groups[index];
    if (group == null || (seen.unseenOnly && isMomentGroupSeen(group, seen.seenIds))) continue;
    return { groupIndex: index, itemIndex: momentGroupStartIndex(group, seen.seenIds) };
  }
  return null;
}

export function momentItemStep(
  groups: readonly MomentTrayGroup[],
  position: MomentPosition,
  direction: 1 | -1,
  seen?: MomentSeenStep
): MomentPosition | null {
  const count = groups[position.groupIndex]?.moments.length ?? 0;
  const itemIndex = position.itemIndex + direction;
  if (itemIndex >= 0 && itemIndex < count) {
    return { groupIndex: position.groupIndex, itemIndex };
  }
  if (direction === 1 && seen != null) return nextGroupPosition(groups, position.groupIndex, seen);
  return momentGroupStep(groups.length, position.groupIndex, direction);
}

export function appendMomentUsers<T extends { user: MomentAuthor }>(
  current: readonly T[],
  incoming: readonly T[]
): T[] {
  const known = new Set(current.map((item) => item.user.id));
  return [...current, ...incoming.filter((item) => !known.has(item.user.id))];
}
