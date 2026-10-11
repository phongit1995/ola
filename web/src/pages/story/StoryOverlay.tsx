import { useEffect } from 'react';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useAuthStore } from '@/store/authStore';
import { useStoryOverlayStore } from '@/store/storyOverlayStore';
import { StoryDetailPage } from './StoryDetailPage';
import { StoryReaderPage } from './StoryReaderPage';

function refreshStoriesAfterVipChange() {
  const stories = useStoryStore.getState();
  stories.reloadLocked();
  const openStoryIds = new Set(
    useStoryOverlayStore.getState().stack.map((screen) => screen.storyId)
  );
  openStoryIds.forEach((storyId) => void stories.loadStory(storyId));
}

export function StoryOverlay({ visible }: { visible: boolean }) {
  const stack = useStoryOverlayStore((state) => state.stack);
  const back = useStoryOverlayStore((state) => state.back);
  const openReader = useStoryOverlayStore((state) => state.openReader);
  const goToChapter = useStoryOverlayStore((state) => state.goToChapter);

  useEffect(
    () =>
      useAuthStore.subscribe((state, previous) => {
        const vipEndTime = state.user?.vipEndTime;
        if (vipEndTime != null && vipEndTime !== previous.user?.vipEndTime) {
          refreshStoriesAfterVipChange();
        }
      }),
    []
  );

  if (stack.length === 0) return null;

  return (
    <div className={visible ? '' : 'hidden'}>
      {stack.map((screen, index) => (
        <div key={index} className={index === stack.length - 1 ? '' : 'hidden'}>
          {screen.kind === 'detail' ? (
            <StoryDetailPage
              storyId={screen.storyId}
              onBack={back}
              onRead={(position) => openReader(screen.storyId, position)}
            />
          ) : (
            <StoryReaderPage
              storyId={screen.storyId}
              position={screen.position}
              active={visible && index === stack.length - 1}
              onBack={back}
              onChangeChapter={goToChapter}
            />
          )}
        </div>
      ))}
    </div>
  );
}
