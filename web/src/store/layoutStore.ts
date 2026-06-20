import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface LayoutState {
  wide: boolean;
  setWide: (wide: boolean) => void;
}

export const useLayoutStore = create<LayoutState>()(
  persist(
    (set) => ({
      wide: false,
      setWide: (wide) => set({ wide }),
    }),
    { name: 'ola.layout' }
  )
);
