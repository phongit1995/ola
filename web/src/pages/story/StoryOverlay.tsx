import { useEffect } from 'react';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import { useAuthStore } from '@/store/authStore';
import {
  useStoryOverlayStore,
  type StoryScreen,
} from '@/store/storyOverlayStore';
import { StoryLatestCommentsPage } from './StoryLatestCommentsPage';
import { StoryDetailPage } from './StoryDetailPage';
import { StoryReaderPage } from './StoryReaderPage';

function refreshStoriesAfterVipChange() {
  const stories = useStoryStore.getState();
  stories.reloadLocked();
  const openStoryIds = new Set(
    useStoryOverlayStore
      .getState()
      .stack.flatMap((screen) =>
        screen.kind === 'latestComments' ? [] : [screen.storyId]
      )
  );
  openStoryIds.forEach((storyId) => void stories.loadStory(storyId));
}

export function StoryOverlay({ visible }: { visible: boolean }) {
  const stack = useStoryOverlayStore((state) => state.stack);
  const back = useStoryOverlayStore((state) => state.back);
  const openStory = useStoryOverlayStore((state) => state.openStory);
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

  function renderScreen(screen: StoryScreen, active: boolean) {
    switch (screen.kind) {
      case 'latestComments':
        return (
          <StoryLatestCommentsPage onBack={back} onOpenStory={openStory} />
        );
      case 'detail':
        return (
          <StoryDetailPage
            storyId={screen.storyId}
            onBack={back}
            onRead={(position) => openReader(screen.storyId, position)}
          />
        );
      case 'reader':
        return (
          <StoryReaderPage
            storyId={screen.storyId}
            position={screen.position}
            active={visible && active}
            onBack={back}
            onChangeChapter={goToChapter}
          />
        );
    }
  }

  return (
    <div className={visible ? '' : 'hidden'}>
      {stack.map((screen, index) => {
        const active = index === stack.length - 1;
        return (
          <div key={index} className={active ? '' : 'hidden'}>
            {renderScreen(screen, active)}
          </div>
        );
      })}
    </div>
  );
}
