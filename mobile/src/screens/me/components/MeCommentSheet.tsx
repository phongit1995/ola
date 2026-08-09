import { useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, ScrollView, Text, View } from 'react-native';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { OlaModal } from '@components/ui/OlaModal';
import { MediaViewerModal } from '@components/ui/MediaViewer';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { createTimeFormatter } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { MePostCard } from './MePostCard';
import { MeCommentItem } from './MeCommentItem';
import { MeLikersDialog } from './MeLikersDialog';
import {
  MeCommentComposer,
  type MeCommentComposerHandle,
} from './MeCommentComposer';
import { useMeComments } from '../useMeComments';

interface MeCommentSheetProps {
  post: Post;
  language: string;
  autoFocusInput?: boolean;
  onClose: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onCommentDelta: (postId: string, delta: number) => void;
}

export function MeCommentSheet(props: MeCommentSheetProps) {
  return (
    <OlaModal
      visible
      transparent
      statusBarTranslucent
      navigationBarTranslucent
      animationType="slide"
      onRequestClose={props.onClose}
    >
      <MeCommentSheetBody {...props} />
    </OlaModal>
  );
}

function MeCommentSheetBody({
  post,
  language,
  autoFocusInput = false,
  onClose,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onCommentDelta,
}: MeCommentSheetProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const bottomBarInset = useBottomBarInset();
  const meId = useAuthStore(s => s.user?.id) ?? '';
  const composerRef = useRef<MeCommentComposerHandle>(null);
  const [viewer, setViewer] = useState<{
    images: string[];
    index: number;
  } | null>(null);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);

  const {
    comments,
    total,
    loading,
    error,
    submitting,
    add,
    remove,
    like,
    replyTarget,
    setReplyTarget,
  } = useMeComments(post.id, {
    onDelta: delta => onCommentDelta(post.id, delta),
  });
  const replyingToUsername =
    replyTarget != null ? replyTarget.author?.username ?? null : null;

  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  return (
    <>
      <ChatKeyboardArea>
        <View className="flex-1 bg-[#eceff1]">
          <ScreenHeader
            title={`${t('me.commentsTitle')}${total > 0 ? ` (${total})` : ''}`}
            onBack={onClose}
          />

          <ScrollView
            className="flex-1"
            keyboardShouldPersistTaps="handled"
            onStartShouldSetResponderCapture={() => {
              composerRef.current?.closePanel();
              return false;
            }}
          >
            <MePostCard
              post={post}
              timeLabel={formatTime(post.createdAt)}
              onToggleLike={onToggleLike}
              onToggleDislike={onToggleDislike}
              onOpenProfile={onOpenProfile}
              onOpenLikers={setLikersPostId}
              onOpenPhotos={(images, index) => setViewer({ images, index })}
            />

            <View className="py-2">
              {loading && (
                <ActivityIndicator className="py-8" color={colors.primary} />
              )}
              {!loading && error && (
                <Text
                  className="py-8 text-center text-sm"
                  style={{ color: '#e34545' }}
                >
                  {t('me.commentLoadError')}
                </Text>
              )}
              {!loading && !error && comments.length === 0 && (
                <Text className="py-8 text-center text-sm text-ola-ink-soft">
                  {t('me.commentEmpty')}
                </Text>
              )}
              {!loading &&
                !error &&
                comments.map(comment => {
                  const isOwn = comment.author?.id === meId;
                  return (
                    <MeCommentItem
                      key={comment.id}
                      comment={comment}
                      time={formatTime(comment.createdAt)}
                      canDelete={isOwn}
                      canReport={!isOwn}
                      onDelete={remove}
                      onReply={isOwn ? undefined : setReplyTarget}
                      onToggleLike={like}
                      onOpenProfile={onOpenProfile}
                    />
                  );
                })}
            </View>
          </ScrollView>

          <View style={{ paddingBottom: bottomBarInset }}>
            <MeCommentComposer
              ref={composerRef}
              key={replyTarget?.id ?? 'root'}
              autoFocus={autoFocusInput}
              submitting={submitting}
              onSubmit={add}
              initialDraft={
                replyingToUsername != null ? `@${replyingToUsername} ` : ''
              }
              replyingTo={replyingToUsername}
              onCancelReply={() => setReplyTarget(null)}
            />
          </View>
        </View>
      </ChatKeyboardArea>

      <MediaViewerModal
        images={viewer?.images ?? []}
        index={viewer?.index ?? 0}
        onClose={() => setViewer(null)}
      />

      {likersPostId != null && (
        <MeLikersDialog
          postId={likersPostId}
          onClose={() => setLikersPostId(null)}
          onOpenProfile={onOpenProfile}
        />
      )}
    </>
  );
}
