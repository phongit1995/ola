import { create } from 'zustand';

interface MediaViewerState {
  images: string[];
  index: number;
  open: boolean;
  openViewer: (images: string[], index?: number) => void;
  close: () => void;
}

export const useMediaViewerStore = create<MediaViewerState>((set) => ({
  images: [],
  index: 0,
  open: false,
  openViewer: (images, index = 0) => set({ images, index, open: true }),
  close: () => set({ images: [], index: 0, open: false }),
}));
