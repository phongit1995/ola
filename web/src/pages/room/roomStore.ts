import { create } from 'zustand';
import { RoomService } from '@services';
import { toast } from '@lib';
import type { BrowseRoomsParams, Room } from '@app-types';
import i18n from '@/i18n';

interface RoomState {
  rooms: Room[];
  total: number;
  loading: boolean;
  error: string | null;
  loaded: boolean;
  fetchRooms: (params?: BrowseRoomsParams) => Promise<void>;
  reset: () => void;
}

const initialState = {
  rooms: [] as Room[],
  total: 0,
  loading: false,
  error: null as string | null,
  loaded: false,
};

export const useRoomStore = create<RoomState>((set) => ({
  ...initialState,
  fetchRooms: async (params) => {
    set({ loading: true, error: null });
    try {
      const result = await RoomService.browse(params);
      set({ rooms: result.items, total: result.total, loading: false, loaded: true });
    } catch (err) {
      set({
        error: err instanceof Error ? err.message : i18n.t('room.loadError'),
        loading: false,
      });
      toast.error(i18n.t('room.loadError'));
    }
  },
  reset: () => set({ ...initialState }),
}));
