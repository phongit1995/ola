import type { TFunction } from 'i18next';
import {
  MAX_UPLOAD_BYTES,
  MAX_UPLOAD_DIMENSION,
  MIN_UPLOAD_DIMENSION,
  UPLOAD_DIMENSION_STEP,
  UPLOAD_PASSTHROUGH_MIME_TYPES,
} from '../constants/image';

export class ImageTooLargeError extends Error {
  constructor() {
    super('image exceeds max upload size');
    this.name = 'ImageTooLargeError';
  }
}

export interface UploadImageInfo {
  type: string;
  name: string;
  size?: number;
  width?: number;
  height?: number;
}

const MIME_BY_EXTENSION: Record<string, string> = {
  jpg: 'image/jpeg',
  jpeg: 'image/jpeg',
  png: 'image/png',
  gif: 'image/gif',
  webp: 'image/webp',
  heic: 'image/heic',
  heif: 'image/heif',
};

export function mimeFromUploadName(name: string): string {
  const extension = name.split('.').pop()?.toLowerCase() ?? '';
  return MIME_BY_EXTENSION[extension] ?? '';
}

export function isGifImage(file: Pick<UploadImageInfo, 'type' | 'name'>): boolean {
  return file.type === 'image/gif' || /\.gif$/i.test(file.name);
}

export function isHeicImage(file: Pick<UploadImageInfo, 'type' | 'name'>): boolean {
  return file.type === 'image/heic' || file.type === 'image/heif' || /\.hei[cf]$/i.test(file.name);
}

export function preservesAlpha(type: string): boolean {
  return type === 'image/png' || type === 'image/webp';
}

export function withUploadExtension(name: string, extension: 'jpg' | 'png'): string {
  const base = name.replace(/\.[^./\\]+$/, '');
  return `${base === '' ? 'image' : base}.${extension}`;
}

export function assertUploadSize(size: number | undefined): void {
  if (size != null && size > MAX_UPLOAD_BYTES) throw new ImageTooLargeError();
}

export function canUploadImageOriginal(file: UploadImageInfo): boolean {
  if (!UPLOAD_PASSTHROUGH_MIME_TYPES.includes(file.type)) return false;
  if (file.size == null || file.size > MAX_UPLOAD_BYTES) return false;
  if (file.width == null || file.height == null) return false;
  return Math.max(file.width, file.height) <= MAX_UPLOAD_DIMENSION;
}

export function initialUploadLongestSide(width: number, height: number): number {
  return Math.min(MAX_UPLOAD_DIMENSION, Math.max(width, height, 1));
}

export function nextUploadLongestSide(longest: number): number {
  return Math.max(MIN_UPLOAD_DIMENSION, Math.round(longest * UPLOAD_DIMENSION_STEP));
}

export function isMinUploadLongestSide(longest: number): boolean {
  return longest <= MIN_UPLOAD_DIMENSION;
}

export function fitUploadDimensions(
  width: number,
  height: number,
  longest: number
): { width: number; height: number } {
  const scale = Math.min(1, longest / Math.max(width, height, 1));
  return {
    width: Math.max(1, Math.round(width * scale)),
    height: Math.max(1, Math.round(height * scale)),
  };
}

export function imageUploadErrorText(t: TFunction, error: unknown, fallback: string): string {
  return error instanceof ImageTooLargeError ? t('common.imageTooLarge') : fallback;
}
