import { create } from 'zustand';
import type { StoryConfigState } from '../../types/client/story.type';
import { loadAppConfig } from '../appConfigStore';

export const useStoryConfigStore = create<StoryConfigState>((set, get) => ({
  enabled: null,

  load: async () => {
    const config = await loadAppConfig('story');
    if (config != null) {
      set({ enabled: config.enabled });
      return;
    }
    if (get().enabled == null) set({ enabled: false });
  },
}));
