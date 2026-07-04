import { useMemo } from 'react';
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
import { MeCommentComposer } from './MeCommentComposer';
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

  const { comments, total, loading, error, submitting, add, remove } = useMeComments(post.id, {
    onDelta: (delta) => onCommentDelta(post.id, delta),
  });

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
          <Text className="flex-1 text-sm font-bold text-white">
            {`${t('me.commentsTitle')}${total > 0 ? ` (${total})` : ''}`}
          </Text>
          <View className="w-10" />
        </View>

        <ScrollView className="flex-1" keyboardShouldPersistTaps="handled">
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
              <Text className="py-8 text-center text-sm" style={{ color: '#e53935' }}>
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
              comments.map((comment) => (
                <MeCommentItem
                  key={comment.id}
                  comment={comment}
                  time={formatTime(comment.createdAt)}
                  canDelete={comment.author?.id === meId}
                  onDelete={remove}
                  onOpenProfile={onOpenProfile}
                />
              ))}
          </View>
        </ScrollView>

        <View style={{ paddingBottom: insets.bottom }}>
          <MeCommentComposer submitting={submitting} onSubmit={add} />
        </View>
      </KeyboardAvoidingView>
    </Modal>
  );
}
