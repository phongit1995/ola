import { create } from 'zustand';
import type { RoomInfo } from '../../../src/sdk';

type PageUpdate = number | ((current: number) => number);

interface RankedState {
  page: number;
  createOpen: boolean;
  passRoom: RoomInfo | null;
  bet: string;
  createPassword: string;
  createError: string | null;
  passInput: string;
  setPage: (update: PageUpdate) => void;
  openCreate: () => void;
  closeCreate: () => void;
  openPass: (room: RoomInfo) => void;
  closePass: () => void;
  setBet: (bet: string) => void;
  setCreatePassword: (password: string) => void;
  setCreateError: (error: string | null) => void;
  setPassInput: (password: string) => void;
}

export const useRanked = create<RankedState>()((set) => ({
  page: 0,
  createOpen: false,
  passRoom: null,
  bet: '0',
  createPassword: '',
  createError: null,
  passInput: '',
  setPage: (update) =>
    set((state) => ({
      page: typeof update === 'function' ? update(state.page) : update,
    })),
  openCreate: () => set({ createOpen: true, bet: '0', createPassword: '', createError: null }),
  closeCreate: () => set({ createOpen: false, createError: null }),
  openPass: (passRoom) => set({ passRoom, passInput: '' }),
  closePass: () => set({ passRoom: null, passInput: '' }),
  setBet: (bet) => set({ bet }),
  setCreatePassword: (createPassword) => set({ createPassword }),
  setCreateError: (createError) => set({ createError }),
  setPassInput: (passInput) => set({ passInput }),
}));
