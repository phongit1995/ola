import { create } from 'zustand';
import i18n from 'i18next';
import { toast } from '../lib/toast';
import { RoomService } from '../services/room.service';
import type { RoomListState } from '../types/client/room.type';
import { initialRoomListState } from './roomList.state';

export const useRoomListStore = create<RoomListState>((set) => ({
  ...initialRoomListState,
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
  reset: () => set({ ...initialRoomListState }),
}));
