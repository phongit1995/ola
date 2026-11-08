import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import { usePeerAvatarFrames } from '@ola/shared/stores/avatar-frame/usePeerAvatarFrames';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { Dialog } from '@components/ui/Dialog';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { TEXT_SECONDARY } from '@constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { PEER_FRAME_AVATAR_SIZE } from '../constants';

interface PeerAvatarFrameStoreDialogProps {
  userId: string;
  name: string;
  avatar?: string;
  onClose: () => void;
}

function CenterNote({ children }: { children: string }) {
  return (
    <View className="items-center justify-center px-4" style={{ height: 112 }}>
      <Text className="text-center text-sm" style={{ color: TEXT_SECONDARY }}>
        {children}
      </Text>
    </View>
  );
}

export function PeerAvatarFrameStoreDialog({ userId, name, avatar, onClose }: PeerAvatarFrameStoreDialogProps) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const { store, loading, isPrivate, failed, hasMore, loadingMore, loadMore } = usePeerAvatarFrames(
    userId,
    true,
  );

  return (
    <Dialog
      visible
      onClose={onClose}
      showClose
      avoidKeyboard={false}
      title={t('avatarFrame.storeOf', { name })}
    >
      <View style={{ minHeight: 120, maxHeight: 380 }}>
        {loading || (store == null && !isPrivate && !failed) ? (
          <View className="items-center justify-center" style={{ height: 112 }}>
            <ActivityIndicator color={colors.primary} />
          </View>
        ) : isPrivate ? (
          <CenterNote>{t('avatarFrame.storePrivate')}</CenterNote>
        ) : failed || store == null ? (
          <CenterNote>{t('common.error')}</CenterNote>
        ) : store.items.length === 0 ? (
          <CenterNote>{t('avatarFrame.empty')}</CenterNote>
        ) : (
          <ScrollView>
            <Text className="mb-1 text-xs" style={{ color: TEXT_SECONDARY }}>
              {t('avatarFrame.count', { count: store.total })}
            </Text>
            <View className="flex-row flex-wrap">
              {store.items.map((frame) => (
                <View
                  key={frame.frameId}
                  className="items-center"
                  style={{ width: '33.333%', paddingTop: 10, paddingBottom: 6 }}
                >
                  <AvatarWithFrame
                    name={name}
                    uri={avatar}
                    size={PEER_FRAME_AVATAR_SIZE}
                    frameId={frame.frameId}
                    showLoader={false}
                  />
                  <Text
                    numberOfLines={1}
                    className="mt-2 w-full text-center text-[11px]"
                    style={{
                      color: frame.isEquipped ? colors.primary : TEXT_SECONDARY,
                      fontWeight: frame.isEquipped ? '700' : '400',
                    }}
                  >
                    {avatarFrameLabel(frame.frameId)}
                  </Text>
                </View>
              ))}
            </View>
            {hasMore && (
              <Pressable
                onPress={() => void loadMore().catch(() => undefined)}
                disabled={loadingMore}
                className="mt-2 items-center rounded py-2 active:opacity-80"
                style={{ borderWidth: 1, borderColor: '#d1cece', backgroundColor: '#f6f6f6' }}
              >
                <Text className="text-sm" style={{ color: '#3a3839' }}>
                  {loadingMore ? t('common.loading') : t('avatarFrame.history.loadMore')}
                </Text>
              </Pressable>
            )}
          </ScrollView>
        )}
      </View>
    </Dialog>
  );
}
