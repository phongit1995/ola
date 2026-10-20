import { useEffect, useMemo, useState, type RefObject } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import { createTimeFormatter } from '@ola/shared/lib';
import { useStoryCommentStore } from '@ola/shared/stores/story/storyCommentStore';
import type { StoryComment } from '@ola/shared/types';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { useStoryTextSize } from '../useStoryTextSize';
import { useStoryCommentListActions } from '../useStoryCommentActions';
import { StoryCommentItem } from './StoryCommentItem';
import { StoryStateMessage } from './StoryStateMessage';

const EMPTY_COMMENTS: StoryComment[] = [];
const MUTED = 'rgba(0,0,0,0.54)';
const LOAD_MORE_MIN_WIDTH = 144;

interface StoryCommentListProps {
  threadId: string;
  emptyText: string;
  onReply: (comment: StoryComment) => void;
  onDeleted?: (commentId: string) => void;
  onOpenStory?: (storyId: string) => void;
  listRef?: RefObject<FlashListRef<StoryComment> | null>;
  onStartShouldSetResponderCapture?: () => boolean;
}

export function StoryCommentList({
  threadId,
  emptyText,
  onReply,
  onDeleted,
  onOpenStory,
  listRef,
  onStartShouldSetResponderCapture,
}: StoryCommentListProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const textSize = useStoryTextSize();
  const thread = useStoryCommentStore((state) => state.threads[threadId]);
  const load = useStoryCommentStore((state) => state.load);
  const loadMore = useStoryCommentStore((state) => state.loadMore);
  const { remove, toggleLike } = useStoryCommentListActions(threadId);
  const [deleteTarget, setDeleteTarget] = useState<StoryComment | null>(null);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const items = thread?.items ?? EMPTY_COMMENTS;
  const status = thread?.status ?? 'loading';

  useEffect(() => {
    void load(threadId);
  }, [threadId, load]);

  function confirmDelete() {
    if (deleteTarget == null) return;
    onDeleted?.(deleteTarget.id);
    void remove(deleteTarget);
    setDeleteTarget(null);
  }

  function renderEmpty() {
    if (status === 'error') {
      return (
        <StoryStateMessage
          kind="error"
          text={t('story.commentLoadError')}
          onRetry={() => void load(threadId)}
        />
      );
    }
    if (status === 'ready') {
      return (
        <Text className="px-6 py-10 text-center" style={[textSize(14, 20), { color: MUTED }]}>
          {emptyText}
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
          onPress={() => void loadMore(threadId)}
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
      <FlashList<StoryComment>
        ref={listRef}
        data={items}
        keyExtractor={(comment) => comment.id}
        keyboardShouldPersistTaps="handled"
        maintainVisibleContentPosition={{ disabled: true }}
        onStartShouldSetResponderCapture={onStartShouldSetResponderCapture}
        renderItem={({ item }) => (
          <StoryCommentItem
            comment={item}
            time={formatTime(item.createdAt)}
            onReply={onReply}
            onDelete={setDeleteTarget}
            onToggleLike={toggleLike}
            onOpenStory={onOpenStory}
          />
        )}
        ListEmptyComponent={renderEmpty()}
        ListFooterComponent={renderFooter()}
      />
      <ConfirmDialog
        visible={deleteTarget != null}
        danger
        title={t('story.commentDelete')}
        message={t('story.commentDeleteConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={confirmDelete}
        onCancel={() => setDeleteTarget(null)}
      />
    </>
  );
}
