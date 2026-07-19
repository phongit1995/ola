import { create } from 'zustand';
import i18n from 'i18next';
import { RoomService } from '../services';
import { toast } from '../lib';
import type { BrowseRoomsParams, Room } from '../types';

interface RoomListState {
  rooms: Room[];
  total: number;
  loading: boolean;
  error: string | null;
  loaded: boolean;
  fetchRooms: (params?: BrowseRoomsParams, options?: { silent?: boolean }) => Promise<void>;
  reset: () => void;
}

const initialState = {
  rooms: [] as Room[],
  total: 0,
  loading: false,
  error: null as string | null,
  loaded: false,
};

export const useRoomListStore = create<RoomListState>((set) => ({
  ...initialState,
  fetchRooms: async (params, options) => {
    const silent = options?.silent ?? false;
    if (!silent) set({ loading: true, error: null });
    try {
      const result = await RoomService.browse(params);
      set({ rooms: result.items, total: result.total, loading: false, loaded: true });
    } catch (err) {
      set({
        error: err instanceof Error ? err.message : i18n.t('room.loadError'),
        loading: false,
      });
      if (!silent) toast.error(i18n.t('room.loadError'));
    }
  },
  reset: () => set({ ...initialState }),
}));
