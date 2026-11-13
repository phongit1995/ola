import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { useThemeColors } from '@hooks/useThemeColors';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { UserListDialog } from '@components/ui/UserListDialog';
import {
  blockedRelationshipName,
  useBlockedRelationships,
} from '@ola/shared/stores/friends/useBlockedRelationships';

export function BlockedListDialog({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const { items, loading, busyId, unblock } = useBlockedRelationships();

  return (
    <UserListDialog
      visible
      title={t('chat.menuBlockList')}
      onClose={onClose}
      loading={loading}
      isEmpty={items.length === 0}
      empty={
        <Text className="py-2 text-center text-base text-ola-ink-soft">
          {t('chat.blockListEmpty')}
        </Text>
      }
      divided={false}
      listMaxHeight={320}
    >
      {items.map((item) => {
        const name = blockedRelationshipName(item);
        return (
          <View key={item.id} className="flex-row items-center gap-3 py-2">
            <AvatarWithFrame name={name} uri={item.addressee?.avatar ?? undefined} size={40} frameId={item.addressee?.avatarFrameId} />
            <Text
              numberOfLines={1}
              className="min-w-0 flex-1 text-base text-ola-ink"
            >
              {name}
            </Text>
            <Pressable
              onPress={() => void unblock(item)}
              disabled={busyId === item.id}
              className="rounded px-3 py-1.5"
              style={{ borderWidth: 1, borderColor: colors.primary, opacity: busyId === item.id ? 0.5 : 1 }}
            >
              <Text className="text-sm font-medium" style={{ color: colors.primary }}>
                {t('chat.unblock')}
              </Text>
            </Pressable>
          </View>
        );
      })}
    </UserListDialog>
  );
}
