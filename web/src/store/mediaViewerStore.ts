import { create } from 'zustand';

interface MediaViewerState {
  photos: string[];
  index: number;
  open: boolean;
  openViewer: (photos: string[], index?: number) => void;
  closeViewer: () => void;
}

export const useMediaViewerStore = create<MediaViewerState>((set) => ({
  photos: [],
  index: 0,
  open: false,
  openViewer: (photos, index = 0) => set({ photos, index, open: true }),
  closeViewer: () => set({ open: false }),
}));
