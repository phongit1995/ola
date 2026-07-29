export interface NativeUploadFile {
  uri: string;
  name: string;
  type: string;
}

export type UploadFile = Blob | NativeUploadFile;
