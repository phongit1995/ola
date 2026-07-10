import { create } from 'zustand';

interface MediaViewerState {
  images: string[];
  index: number;
  openViewer: (images: string[], index?: number) => void;
  close: () => void;
}

export const useMediaViewerStore = create<MediaViewerState>((set) => ({
  images: [],
  index: 0,
  openViewer: (images, index = 0) => set({ images, index }),
  close: () => set({ images: [], index: 0 }),
}));
