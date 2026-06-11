import { create } from 'zustand';
import { RoomService } from '@services';
import type { BrowseRoomsParams, Room } from '@app-types';

interface RoomState {
  rooms: Room[];
  total: number;
  loading: boolean;
  error: string | null;
  loaded: boolean;
  fetchRooms: (params?: BrowseRoomsParams) => Promise<void>;
  reset: () => void;
}

export const useRoomStore = create<RoomState>((set) => ({
  rooms: [],
  total: 0,
  loading: false,
  error: null,
  loaded: false,
  fetchRooms: async (params) => {
    set({ loading: true, error: null });
    try {
      const result = await RoomService.browse(params);
      set({ rooms: result.items, total: result.total, loading: false, loaded: true });
    } catch (err) {
      set({
        error: err instanceof Error ? err.message : 'Không tải được danh sách phòng',
        loading: false,
      });
    }
  },
  reset: () => set({ rooms: [], total: 0, error: null, loaded: false }),
}));
