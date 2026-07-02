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
    if (filename != null) {
      form.append(field, file, filename);
    } else {
      form.append(field, file);
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
