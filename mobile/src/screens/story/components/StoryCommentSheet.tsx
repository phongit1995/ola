import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, StatusBar, Text, View } from 'react-native';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import { createTimeFormatter, formatCompactCount, storyCommentAuthorName } from '@ola/shared/lib';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import { useStoryStore } from '@ola/shared/stores/story/storyStore';
import type { StoryComment } from '@ola/shared/types';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { OlaModal } from '@components/ui/OlaModal';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { ToastHost } from '@components/ui/ToastHost';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { commentUnlockMinChars, useStoryAccess } from '../storyAccess';
import { useStoryTextSize } from '../typography';
import { useStoryCommentActions } from '../useStoryCommentActions';
import { StoryCommentComposer, type StoryCommentComposerHandle } from './StoryCommentComposer';
import { StoryCommentItem } from './StoryCommentItem';
import { StoryStateMessage } from './StoryStateMessage';

const EMPTY_COMMENTS: StoryComment[] = [];
const MUTED = 'rgba(0,0,0,0.54)';
const LOAD_MORE_MIN_WIDTH = 144;

interface StoryCommentSheetProps {
  storyId: string;
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

function StoryCommentSheetBody({ storyId, onClose }: StoryCommentSheetProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const bottomBarInset = useBottomBarInset();
  const thread = useStoryCommentStore((state) => state.threads[storyId]);
  const load = useStoryCommentStore((state) => state.load);
  const loadMore = useStoryCommentStore((state) => state.loadMore);
  const commentCount = useStoryStore((state) => state.stories[storyId]?.commentCount ?? 0);
  const access = useStoryAccess(storyId);
  const { sending, send, remove, toggleLike } = useStoryCommentActions(storyId);
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(null);
  const [deleteId, setDeleteId] = useState<string | null>(null);
  const listRef = useRef<FlashListRef<StoryComment>>(null);
  const composerRef = useRef<StoryCommentComposerHandle>(null);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const items = thread?.items ?? EMPTY_COMMENTS;
  const status = thread?.status ?? 'loading';

  useEffect(() => {
    void load(storyId);
  }, [storyId, load]);

  const onReply = useCallback((comment: StoryComment) => {
    setReplyTarget(comment);
    requestAnimationFrame(() => composerRef.current?.focus());
  }, []);

  function closeSmileyPanel() {
    composerRef.current?.closePanel();
    return false;
  }

  async function submit(text: string): Promise<boolean> {
    const ok = await send(text, replyTarget?.id);
    if (ok) {
      setReplyTarget(null);
      listRef.current?.scrollToOffset({ offset: 0, animated: true });
    }
    return ok;
  }

  function confirmDelete() {
    if (deleteId == null) return;
    if (replyTarget?.id === deleteId) setReplyTarget(null);
    void remove(deleteId);
    setDeleteId(null);
  }

  function renderEmpty() {
    if (status === 'error') {
      return (
        <StoryStateMessage
          kind="error"
          text={t('story.commentLoadError')}
          onRetry={() => void load(storyId)}
        />
      );
    }
    if (status === 'ready') {
      return (
        <Text className="px-6 py-10 text-center" style={[textSize(14, 20), { color: MUTED }]}>
          {t('story.commentEmpty')}
        </Text>
      );
    }
    return <ActivityIndicator className="py-10" color={colors.primary} />;
  }

  function renderFooter() {
    if (items.length === 0 || thread?.nextCursor == null) return null;
    return (
      <View className="items-center py-3">
        <Pressable
          accessibilityRole="button"
          disabled={thread.loadingMore}
          onPress={() => void loadMore(storyId)}
          className="h-9 items-center justify-center rounded-full px-4"
          style={{
            minWidth: LOAD_MORE_MIN_WIDTH,
            borderWidth: 1,
            borderColor: colors.primary,
            opacity: thread.loadingMore ? 0.6 : 1,
          }}
        >
          {thread.loadingMore ? (
            <ActivityIndicator size="small" color={colors.primary} />
          ) : (
            <Text style={[textSize(14, 20), { color: colors.primaryInk }]}>
              {t('story.commentLoadMore')}
            </Text>
          )}
        </Pressable>
      </View>
    );
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
          <FlashList<StoryComment>
            ref={listRef}
            data={items}
            keyExtractor={(comment) => comment.id}
            keyboardShouldPersistTaps="handled"
            maintainVisibleContentPosition={{ disabled: true }}
            onStartShouldSetResponderCapture={closeSmileyPanel}
            renderItem={({ item }) => (
              <StoryCommentItem
                comment={item}
                time={formatTime(item.createdAt)}
                onReply={onReply}
                onDelete={setDeleteId}
                onToggleLike={toggleLike}
              />
            )}
            ListEmptyComponent={renderEmpty()}
            ListFooterComponent={renderFooter()}
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

      <ConfirmDialog
        visible={deleteId != null}
        danger
        title={t('story.commentDelete')}
        message={t('story.commentDeleteConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmDelete}
        onCancel={() => setDeleteId(null)}
      />
    </>
  );
}
