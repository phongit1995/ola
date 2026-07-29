import type { NativeUploadFile, UploadFile } from '../types/client/upload.type';
import type { ObjectUrlApi } from '../types/lib.type';

export type { NativeUploadFile, UploadFile } from '../types/client/upload.type';

export function asNativeUploadFile(file: UploadFile): NativeUploadFile | undefined {
  if (typeof Blob !== 'undefined' && file instanceof Blob) return undefined;
  return file as NativeUploadFile;
}

export function nativeUploadFileFromUri(
  uri: string,
  name: string,
  type: string
): NativeUploadFile | undefined {
  if (!uri.startsWith('file://') && !uri.startsWith('content://')) {
    return undefined;
  }
  return { uri, name, type };
}

export function uploadFileMimeType(file: UploadFile): string {
  return file.type;
}

export function audioUploadFilename(mimeType: string): string {
  switch (mimeType.split(';', 1)[0]?.trim().toLowerCase()) {
    case 'audio/mp4':
    case 'audio/x-m4a':
      return 'voice.m4a';
    case 'audio/aac':
      return 'voice.aac';
    case 'audio/mpeg':
      return 'voice.mp3';
    case 'audio/wav':
    case 'audio/x-wav':
      return 'voice.wav';
    case 'audio/ogg':
      return 'voice.ogg';
    case 'audio/webm':
    default:
      return 'voice.webm';
  }
}

export function appendUploadFile(
  form: FormData,
  field: string,
  file: UploadFile,
  filename?: string
): void {
  if (typeof Blob !== 'undefined' && file instanceof Blob) {
    const append = form.append.bind(form) as (name: string, value: Blob, fileName?: string) => void;
    if (filename != null) {
      append(field, file, filename);
    } else {
      append(field, file);
    }
    return;
  }
  const native = file as NativeUploadFile;
  form.append(field, {
    uri: native.uri,
    name: filename ?? native.name,
    type: native.type,
  } as unknown as Blob);
}

export function blobWithType(blob: Blob, type: string): Blob {
  if (blob.type !== '') return blob;
  const BlobCtor = Blob as unknown as new (parts: Blob[], options: { type: string }) => Blob;
  return new BlobCtor([blob], { type });
}

function objectUrlApi(): ObjectUrlApi | undefined {
  return (globalThis as { URL?: ObjectUrlApi }).URL;
}

export function uploadPreviewUrl(file: UploadFile): string {
  if (typeof Blob !== 'undefined' && file instanceof Blob) {
    return objectUrlApi()?.createObjectURL?.(file) ?? '';
  }
  return (file as NativeUploadFile).uri;
}

export function releaseUploadPreviewUrl(url: string): void {
  if (url.startsWith('blob:')) objectUrlApi()?.revokeObjectURL?.(url);
}
