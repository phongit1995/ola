import { useStoryOverlayStore } from '@/store/storyOverlayStore';
import { StoryDetailPage } from './StoryDetailPage';
import { StoryReaderPage } from './StoryReaderPage';

export function StoryOverlay({ visible }: { visible: boolean }) {
  const stack = useStoryOverlayStore((state) => state.stack);
  const back = useStoryOverlayStore((state) => state.back);
  const openReader = useStoryOverlayStore((state) => state.openReader);
  const goToChapter = useStoryOverlayStore((state) => state.goToChapter);

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
              onBack={back}
              onChangeChapter={goToChapter}
            />
          )}
        </div>
      ))}
    </div>
  );
}
