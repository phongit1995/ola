import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Modal, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { MeService } from '@ola/shared/services';
import { applyPostReaction } from '@ola/shared/stores/postHelpers';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { createTimeFormatter, postTimeLabel } from '@ola/shared/lib';
import type { Post } from '@ola/shared/types';
import { MePostCard } from './components/MePostCard';
import { MeCommentSheet } from './components/MeCommentSheet';
import { MeLikersDialog } from './components/MeLikersDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';

interface MeLikedPostsScreenProps {
  language: string;
  onClose: () => void;
  onOpenProfile: (nick: string, color: string) => void;
}

export function MeLikedPostsScreen({ language, onClose, onOpenProfile }: MeLikedPostsScreenProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [commentPostId, setCommentPostId] = useState<string | null>(null);
  const [commentFocusInput, setCommentFocusInput] = useState(false);
  const [likersPostId, setLikersPostId] = useState<string | null>(null);
  const formatTime = useMemo(() => createTimeFormatter(language), [language]);

  useEffect(() => {
    let active = true;
    MeService.liked({ limit: 30 })
      .then((result) => {
        if (active) setPosts(result.items);
      })
      .catch(() => {
        if (active) push('error', t('common.error'));
      })
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [push, t]);

  const toggleReaction = useCallback(
    async (id: string, type: 'like' | 'dislike') => {
      const current = posts.find((p) => p.id === id);
      if (current == null) return;
      const active = current.myReaction === type;
      setPosts((prev) => prev.map((p) => (p.id === id ? applyPostReaction(p, active ? null : type) : p)));
      try {
        const updated = active ? await MeService.removeReaction(id) : await MeService.react(id, type);
        setPosts((prev) => {
          const next = prev.map((p) => (p.id === id ? updated : p));
          return updated.myReaction === 'like' ? next : next.filter((p) => p.id !== id);
        });
      } catch {
        setPosts((prev) => prev.map((p) => (p.id === id ? current : p)));
      }
    },
    [posts]
  );

  const adjustCommentCount = useCallback((id: string, delta: number) => {
    setPosts((prev) =>
      prev.map((p) => (p.id === id ? { ...p, commentCount: Math.max(0, p.commentCount + delta) } : p))
    );
  }, []);

  const commentPost = commentPostId != null ? posts.find((p) => p.id === commentPostId) ?? null : null;

  return (
    <Modal visible transparent animationType="slide" onRequestClose={onClose}>
      <View className="flex-1 bg-[#eceff1]">
        <ScreenHeader title={t('me.drawerLikes')} onBack={onClose} />

        {loading && posts.length === 0 ? (
          <ActivityIndicator className="py-10" color="#7cb342" size="large" />
        ) : posts.length === 0 ? (
          <Text className="px-6 py-10 text-center text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
            {t('me.likedEmpty')}
          </Text>
        ) : (
          <FlashList
            data={posts}
            keyExtractor={(item) => item.id}
                        renderItem={({ item }) => (
              <MePostCard
                post={item}
                timeLabel={postTimeLabel(item.createdAt, formatTime)}
                onToggleLike={(id) => void toggleReaction(id, 'like')}
                onToggleDislike={(id) => void toggleReaction(id, 'dislike')}
                onOpenProfile={onOpenProfile}
                onOpenComments={(id, focusInput) => {
                  setCommentFocusInput(focusInput === true);
                  setCommentPostId(id);
                }}
                onOpenLikers={(id) => setLikersPostId(id)}
              />
            )}
          />
        )}

        {commentPost != null && (
          <MeCommentSheet
            post={commentPost}
            language={language}
            autoFocusInput={commentFocusInput}
            onClose={() => setCommentPostId(null)}
            onToggleLike={(id) => void toggleReaction(id, 'like')}
            onToggleDislike={(id) => void toggleReaction(id, 'dislike')}
            onOpenProfile={onOpenProfile}
            onOpenLikers={(id) => setLikersPostId(id)}
            onCommentDelta={adjustCommentCount}
          />
        )}

        {likersPostId != null && (
          <MeLikersDialog
            postId={likersPostId}
            onClose={() => setLikersPostId(null)}
            onOpenProfile={onOpenProfile}
          />
        )}
      </View>
    </Modal>
  );
}
