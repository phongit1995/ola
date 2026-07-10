import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { PostAuthor, PostComment } from '@ola/shared/types';
import { renderRichText } from '../../lib/richText';
import { Avatar } from '../../components/Avatar';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { MeLikersDialog } from './MeLikersDialog';

const replyIcon = require('../../assets/icons/me/ic_action_reply_gray.png');
const likeIcon = require('../../assets/icons/me/ic_like_gray.png');
const likeIconActive = require('../../assets/icons/me/ic_like_selected.png');
const deleteIcon = require('../../assets/icons/chat/ic_menu_delete.png');

function CommentLikerStack({ likers }: { likers: PostAuthor[] }) {
  if (likers.length === 0) return null;
  return (
    <View className="flex-row">
      {likers.slice(0, 3).map((liker, index) => (
        <View
          key={liker.id ?? index}
          style={{
            marginLeft: index === 0 ? 0 : -6,
            borderRadius: 999,
            borderWidth: 2,
            borderColor: '#ffffff',
          }}
        >
          <Avatar
            name={liker.fullName != null && liker.fullName !== '' ? liker.fullName : liker.username}
            uri={liker.avatar ?? undefined}
            size={18}
          />
        </View>
      ))}
    </View>
  );
}

interface MeCommentItemProps {
  comment: PostComment;
  time: string;
  canDelete: boolean;
  onDelete: (id: string) => void;
  onReply?: (comment: PostComment) => void;
  onToggleLike: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

function MeCommentItemComponent({
  comment,
  time,
  canDelete,
  onDelete,
  onReply,
  onToggleLike,
  onOpenProfile,
}: MeCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [likersOpen, setLikersOpen] = useState(false);
  const liked = comment.liked;
  const likers = comment.topLikers ?? [];
  const name = comment.author?.username ?? '';
  const color = colorForName(name);

  return (
    <>
      <View
        className="mx-2 mb-2 flex-row items-start gap-2.5 rounded-xl bg-white px-3 py-2.5"
        style={{ elevation: 1, shadowColor: '#000', shadowOpacity: 0.1, shadowRadius: 2, shadowOffset: { width: 0, height: 1 } }}
      >
        <Pressable onPress={() => onOpenProfile?.(name, color)}>
          <Avatar name={name} uri={comment.author?.avatar ?? undefined} size={36} />
        </Pressable>
        <View className="min-w-0 flex-1">
          <View className="flex-row items-center gap-2">
            <Pressable onPress={() => onOpenProfile?.(name, color)} className="min-w-0 shrink">
              <Text numberOfLines={1} className="text-sm font-semibold" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {name}
              </Text>
            </Pressable>
            <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>{time}</Text>
            {canDelete && (
              <Pressable onPress={() => setConfirmOpen(true)} className="ml-auto p-1">
                <Image
                  source={deleteIcon}
                  style={{ width: 16, height: 16, tintColor: 'rgba(0,0,0,0.25)' }}
                  resizeMode="contain"
                />
              </Pressable>
            )}
          </View>
          <Text className="mt-0.5 text-sm leading-relaxed" style={{ color: 'rgba(0,0,0,0.87)' }}>
            {renderRichText(comment.content, {
              own: false,
              onMention: (nick) => onOpenProfile?.(nick, colorForName(nick)),
            })}
          </Text>
          <View className="mt-1.5 flex-row items-center gap-4">
            {onReply != null && (
              <Pressable onPress={() => onReply(comment)} className="flex-row items-center gap-1">
                <Image source={replyIcon} style={{ width: 20, height: 20 }} resizeMode="contain" />
                <Text className="text-xs font-medium" style={{ color: 'rgba(0,0,0,0.45)' }}>
                  {t('me.reply')}
                </Text>
              </Pressable>
            )}
            <View className="ml-auto flex-row items-center gap-1.5">
              {comment.likeCount > 0 && (
                <Pressable onPress={() => setLikersOpen(true)} className="flex-row items-center gap-1">
                  <CommentLikerStack likers={likers} />
                  <Text className="text-xs font-medium" style={{ color: 'rgba(0,0,0,0.55)' }}>
                    {comment.likeCount}
                  </Text>
                </Pressable>
              )}
              <Pressable onPress={() => onToggleLike(comment.id)}>
                <Image
                  source={liked ? likeIconActive : likeIcon}
                  style={{ width: 24, height: 24 }}
                  resizeMode="contain"
                />
              </Pressable>
            </View>
          </View>
        </View>
      </View>

      <ConfirmDialog
        visible={confirmOpen}
        danger
        title={t('me.deleteComment')}
        message={t('me.deleteCommentConfirm')}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          onDelete(comment.id);
          setConfirmOpen(false);
        }}
        onCancel={() => setConfirmOpen(false)}
      />

      {likersOpen && (
        <MeLikersDialog
          postId={comment.postId}
          commentId={comment.id}
          onClose={() => setLikersOpen(false)}
          onOpenProfile={onOpenProfile}
        />
      )}
    </>
  );
}

export const MeCommentItem = memo(MeCommentItemComponent);
