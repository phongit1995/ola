import { useMemo, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  ScrollView,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { createTimeFormatter, formatDateDMY, isSameDay } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { MePostCard } from './MePostCard';
import { MeCommentItem } from './MeCommentItem';
import { MeCommentComposer, type MeCommentComposerHandle } from './MeCommentComposer';
import { useMeComments } from './useMeComments';

interface MeCommentSheetProps {
  post: Post;
  language: string;
  onClose: () => void;
  onToggleLike: (id: string) => void;
  onToggleDislike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
  onOpenLikers?: (id: string) => void;
  onCommentDelta: (postId: string, delta: number) => void;
}

export function MeCommentSheet({
  post,
  language,
  onClose,
  onToggleLike,
  onToggleDislike,
  onOpenProfile,
  onOpenLikers,
  onCommentDelta,
}: MeCommentSheetProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const meId = useAuthStore((s) => s.user?.id) ?? '';
  const composerRef = useRef<MeCommentComposerHandle>(null);

  const { comments, total, loading, error, submitting, add, remove, like, replyTarget, setReplyTarget } =
    useMeComments(post.id, {
      onDelta: (delta) => onCommentDelta(post.id, delta),
    });
  const replyingToUsername = replyTarget != null ? replyTarget.author?.username ?? null : null;

  const formatTime = useMemo(() => createTimeFormatter(language), [language]);
  const postTime = isSameDay(post.createdAt, new Date().toISOString())
    ? formatTime(post.createdAt)
    : formatDateDMY(post.createdAt);

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <KeyboardAvoidingView
        className="flex-1 bg-[#eceff1]"
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      >
        <View className="flex-row items-center bg-ola-primary px-1" style={{ paddingTop: insets.top }}>
          <Pressable onPress={onClose} className="h-12 w-10 items-center justify-center">
            <Text className="text-2xl leading-none text-white">×</Text>
          </Pressable>
          <Text className="flex-1 text-lg font-medium text-white">
            {`${t('me.commentsTitle')}${total > 0 ? ` (${total})` : ''}`}
          </Text>
          <View className="w-10" />
        </View>

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
            timeLabel={postTime}
            onToggleLike={onToggleLike}
            onToggleDislike={onToggleDislike}
            onOpenProfile={onOpenProfile}
            onOpenLikers={onOpenLikers}
          />

          <View className="py-2">
            {loading && <ActivityIndicator className="py-8" color="#7cb342" />}
            {!loading && error && (
              <Text className="py-8 text-center text-sm" style={{ color: '#e34545' }}>
                {t('me.commentLoadError')}
              </Text>
            )}
            {!loading && !error && comments.length === 0 && (
              <Text className="py-8 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                {t('me.commentEmpty')}
              </Text>
            )}
            {!loading &&
              !error &&
              comments.map((comment) => {
                const isOwn = comment.author?.id === meId;
                return (
                  <MeCommentItem
                    key={comment.id}
                    comment={comment}
                    time={formatTime(comment.createdAt)}
                    canDelete={isOwn}
                    onDelete={remove}
                    onReply={isOwn ? undefined : setReplyTarget}
                    onToggleLike={like}
                    onOpenProfile={onOpenProfile}
                  />
                );
              })}
          </View>
        </ScrollView>

        <View style={{ paddingBottom: insets.bottom }}>
          <MeCommentComposer
            ref={composerRef}
            key={replyTarget?.id ?? 'root'}
            submitting={submitting}
            onSubmit={add}
            initialDraft={replyingToUsername != null ? `@${replyingToUsername} ` : ''}
            replyingTo={replyingToUsername}
            onCancelReply={() => setReplyTarget(null)}
          />
        </View>
      </KeyboardAvoidingView>
    </Modal>
  );
}
