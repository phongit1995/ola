import { create } from 'zustand';

interface DownloadGuideState {
  visible: boolean;
  open: () => void;
  close: () => void;
}

export const useDownloadGuideStore = create<DownloadGuideState>((set) => ({
  visible: false,
  open: () => set({ visible: true }),
  close: () => set({ visible: false }),
}));
