import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { colorForName } from '@ola/shared/lib';
import type { SavedAccount } from '@ola/shared/stores/savedAccountsStore';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { CachedImage } from '@components/ui/CachedImage';

interface SavedAccountGalleryProps {
  accounts: SavedAccount[];
  onPick: (account: SavedAccount) => void;
  onRemove: (username: string) => void;
}

export function SavedAccountGallery({ accounts, onPick, onRemove }: SavedAccountGalleryProps) {
  const { t } = useTranslation();
  const [removeTarget, setRemoveTarget] = useState<string | null>(null);

  return (
    <>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        className="mb-4 w-full max-w-md grow-0"
        contentContainerClassName="min-w-full justify-center gap-8 px-1 py-1"
      >
        {accounts.map((account) => (
          <View key={account.username} className="items-center gap-1">
            <View className="relative">
              <Pressable
                onPress={() => onPick(account)}
                className="h-24 w-24 items-center justify-center overflow-hidden rounded shadow"
                style={{ backgroundColor: colorForName(account.username) }}
              >
                {account.avatar != null && account.avatar !== '' ? (
                  <CachedImage
                    uri={account.avatar}
                    style={{ width: 96, height: 96 }}
                    resizeMode="cover"
                  />
                ) : (
                  <Text className="text-[38px] font-semibold text-white">
                    {account.username.trim().charAt(0).toUpperCase() || '?'}
                  </Text>
                )}
              </Pressable>
              <Pressable
                accessibilityLabel={t('login.removeAccount')}
                onPress={() => setRemoveTarget(account.username)}
                className="absolute bottom-0 right-0 h-6 w-6 items-center justify-center rounded bg-black/40"
              >
                <Text className="text-sm leading-none text-white">×</Text>
              </Pressable>
            </View>
            <Text numberOfLines={1} className="max-w-24 text-sm font-bold text-white">
              {account.username}
            </Text>
          </View>
        ))}
      </ScrollView>

      <ConfirmDialog
        visible={removeTarget != null}
        title={t('login.removeAccountTitle')}
        message={t('login.removeAccountConfirm', {
          username: removeTarget != null ? `@${removeTarget}` : '',
        })}
        confirmLabel={t('common.delete')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          if (removeTarget != null) {
            onRemove(removeTarget);
          }
          setRemoveTarget(null);
        }}
        onCancel={() => setRemoveTarget(null)}
      />
    </>
  );
}
