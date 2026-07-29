import { create } from 'zustand';
import type { MediaViewerState } from '../types/client/mediaViewer.type';

export const useMediaViewerStore = create<MediaViewerState>((set) => ({
  images: [],
  index: 0,
  open: false,
  openViewer: (images, index = 0) => set({ images, index, open: true }),
  close: () => set({ images: [], index: 0, open: false }),
}));
