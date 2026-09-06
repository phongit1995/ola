export interface NativeUploadFile {
  uri: string;
  name: string;
  type: string;
  size?: number;
  width?: number;
  height?: number;
}

export type UploadFile = Blob | NativeUploadFile;
