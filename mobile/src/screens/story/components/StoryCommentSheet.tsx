import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { StatusBar, View } from 'react-native';
import type { FlashListRef } from '@shopify/flash-list';
import { formatCompactCount, storyCommentAuthorName } from '@ola/shared/lib';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import type { StoryComment } from '@ola/shared/types';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ToastHost } from '@components/ui/ToastHost';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { commentUnlockMinChars, useStoryAccess } from '../useStoryAccess';
import { useStoryCommentActions } from '../useStoryCommentActions';
import { StoryCommentComposer, type StoryCommentComposerHandle } from './StoryCommentComposer';
import { StoryCommentList } from './StoryCommentList';

interface StoryCommentSheetProps {
  storyId: string;
  initialReplyTarget?: StoryComment;
  onClose: () => void;
}

export function StoryCommentSheet(props: StoryCommentSheetProps) {
  return (
    <OlaModal
      visible
      transparent
      statusBarTranslucent
      navigationBarTranslucent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <StoryCommentSheetBody {...props} />
      <ToastHost />
    </OlaModal>
  );
}

function StoryCommentSheetBody({ storyId, initialReplyTarget, onClose }: StoryCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const bottomBarInset = useBottomBarInset();
  const commentCount = useStoryStore((state) => state.stories[storyId]?.commentCount ?? 0);
  const access = useStoryAccess(storyId);
  const { sending, send } = useStoryCommentActions(storyId);
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(initialReplyTarget ?? null);
  const listRef = useRef<FlashListRef<StoryComment>>(null);
  const composerRef = useRef<StoryCommentComposerHandle>(null);

  useEffect(() => {
    if (initialReplyTarget) requestAnimationFrame(() => composerRef.current?.focus());
  }, [initialReplyTarget]);

  const onReply = useCallback((comment: StoryComment) => {
    setReplyTarget(comment);
    requestAnimationFrame(() => composerRef.current?.focus());
  }, []);

  const clearDeletedReply = useCallback((commentId: string) => {
    setReplyTarget((target) => (target?.id === commentId ? null : target));
  }, []);

  const closeSmileyPanel = useCallback(() => {
    composerRef.current?.closePanel();
    return false;
  }, []);

  async function submit(text: string): Promise<boolean> {
    const ok = await send(text, replyTarget?.id);
    if (ok) {
      setReplyTarget(null);
      listRef.current?.scrollToOffset({ offset: 0, animated: true });
    }
    return ok;
  }

  return (
    <>
      <StatusBar translucent barStyle="light-content" />
      <ChatKeyboardArea>
        <View className="flex-1 bg-white">
          <ScreenHeader
            title={
              commentCount > 0
                ? `${t('story.comments')} (${formatCompactCount(commentCount, i18n.language)})`
                : t('story.comments')
            }
            onBack={onClose}
          />
          <StoryCommentList
            threadId={storyId}
            emptyText={t('story.commentEmpty')}
            onReply={onReply}
            onDeleted={clearDeletedReply}
            listRef={listRef}
            onStartShouldSetResponderCapture={closeSmileyPanel}
          />
          <View style={{ paddingBottom: bottomBarInset }}>
            <StoryCommentComposer
              ref={composerRef}
              sending={sending}
              replyingTo={replyTarget ? storyCommentAuthorName(replyTarget) : null}
              unlockMinChars={commentUnlockMinChars(access)}
              onCancelReply={() => setReplyTarget(null)}
              onSubmit={submit}
            />
          </View>
        </View>
      </ChatKeyboardArea>
    </>
  );
}
