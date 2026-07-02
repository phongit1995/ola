export interface NativeUploadFile {
  uri: string;
  name: string;
  type: string;
}

export type UploadFile = Blob | NativeUploadFile;

export function uploadFileMimeType(file: UploadFile): string {
  return file.type;
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

interface ObjectUrlApi {
  createObjectURL?: (blob: Blob) => string;
  revokeObjectURL?: (url: string) => void;
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
