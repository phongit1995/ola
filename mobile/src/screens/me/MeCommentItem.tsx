import { memo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { PostComment } from '@ola/shared/types';
import { renderRichText } from '../../lib/richText';
import { Avatar } from '../../components/Avatar';
import { ConfirmDialog } from '../../components/ConfirmDialog';

interface MeCommentItemProps {
  comment: PostComment;
  time: string;
  canDelete: boolean;
  onDelete: (id: string) => void;
  onOpenProfile?: (nick: string, color: string) => void;
}

function MeCommentItemComponent({
  comment,
  time,
  canDelete,
  onDelete,
  onOpenProfile,
}: MeCommentItemProps) {
  const { t } = useTranslation();
  const [confirmOpen, setConfirmOpen] = useState(false);
  const name = comment.author?.username ?? '';
  const color = colorForName(name);

  return (
    <View
      className="mx-2 mb-2 flex-row items-start gap-3 rounded-lg bg-white px-4 py-3"
      style={{ elevation: 1, shadowColor: '#000', shadowOpacity: 0.12, shadowRadius: 2, shadowOffset: { width: 0, height: 1 } }}
    >
      <Pressable onPress={() => onOpenProfile?.(name, color)}>
        <Avatar name={name} uri={comment.author?.avatar ?? undefined} size={40} />
      </Pressable>
      <View className="min-w-0 flex-1">
        <View className="flex-row items-center gap-2">
          <Pressable onPress={() => onOpenProfile?.(name, color)} className="min-w-0 flex-1">
            <Text numberOfLines={1} className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.87)' }}>
              {name}
            </Text>
          </Pressable>
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>{time}</Text>
        </View>
        <Text className="mt-1 text-sm leading-relaxed" style={{ color: 'rgba(0,0,0,0.87)' }}>
          {renderRichText(comment.content, {
            own: false,
            onMention: (nick) => onOpenProfile?.(nick, colorForName(nick)),
          })}
        </Text>
      </View>
      {canDelete && (
        <Pressable onPress={() => setConfirmOpen(true)} className="px-1">
          <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>{t('common.clear')}</Text>
        </Pressable>
      )}

      <ConfirmDialog
        visible={confirmOpen}
        danger
        title={t('me.deleteComment')}
        message={t('me.deleteCommentConfirm')}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => {
          onDelete(comment.id);
          setConfirmOpen(false);
        }}
        onCancel={() => setConfirmOpen(false)}
      />
    </View>
  );
}

export const MeCommentItem = memo(MeCommentItemComponent);
