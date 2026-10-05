import { create } from 'zustand';
import { SettingsService } from '../../services/settings.service';
import type { StoryConfigState } from '../../types/client/story.type';

export const useStoryConfigStore = create<StoryConfigState>((set, get) => ({
  enabled: null,

  load: async () => {
    const config = await SettingsService.storyConfig().catch(() => null);
    if (config != null) {
      set({ enabled: config.enabled });
      return;
    }
    if (get().enabled == null) set({ enabled: true });
  },
}));
