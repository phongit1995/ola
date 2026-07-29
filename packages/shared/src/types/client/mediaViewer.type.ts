export interface MediaViewerState {
  images: string[];
  index: number;
  open: boolean;
  openViewer: (images: string[], index?: number) => void;
  close: () => void;
}
