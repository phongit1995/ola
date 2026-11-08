import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, Text, View } from 'react-native';
import { AVATAR_FRAME_HISTORY_TABS } from '@ola/shared/constants';
import { avatarFramePurchaseLine, avatarFrameTransferLine, createTimeFormatter } from '@ola/shared/lib';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useAvatarFrameHistory } from '@ola/shared/stores/avatar-frame/useAvatarFrameHistory';
import type { AvatarFrameHistoryTab } from '@ola/shared/types';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { useThemeColors } from '@hooks/useThemeColors';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { FRAME_HISTORY_RECEIVED_COLOR, FRAME_HISTORY_SPENT_COLOR, FRAME_HISTORY_THUMB_SIZE } from '../constants';
import { AvatarFrameImage } from '@components/ui/AvatarFrameImage';

interface AvatarFrameHistoryDialogProps {
  visible: boolean;
  onClose: () => void;
}

export function AvatarFrameHistoryDialog({ visible, onClose }: AvatarFrameHistoryDialogProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const myId = useAuthStore((s) => s.user?.id);
  const [tab, setTab] = useState<AvatarFrameHistoryTab>('purchases');
  const history = useAvatarFrameHistory(tab, visible);
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const lines =
    tab === 'purchases'
      ? history.purchases.map((item) => avatarFramePurchaseLine(t, item, myId))
      : history.transfers.map((item) => avatarFrameTransferLine(t, item, myId));

  return (
    <Dialog
      visible={visible}
      onClose={onClose}
      title={t('avatarFrame.history.title')}
      avoidKeyboard={false}
      footer={<DialogButton onPress={onClose}>{t('vip.historyDialog.close')}</DialogButton>}
    >
      <View className="mb-2 flex-row gap-1.5">
        {AVATAR_FRAME_HISTORY_TABS.map(({ key, labelKey }) => {
          const active = tab === key;
          return (
            <Pressable
              key={key}
              onPress={() => setTab(key)}
              className="rounded-full px-3 py-1"
              style={{ backgroundColor: active ? colors.primary : '#efefef' }}
            >
              <Text className="text-xs font-medium" style={{ color: active ? colors.onPrimary : '#5a5a5a' }}>
                {t(labelKey)}
              </Text>
            </Pressable>
          );
        })}
      </View>

      <ScrollView style={{ maxHeight: 360 }}>
        {lines.length === 0 && history.loading ? (
          <View className="items-center justify-center" style={{ height: 120 }}>
            <ActivityIndicator color={colors.primary} />
          </View>
        ) : lines.length === 0 ? (
          <Text className="py-6 text-center" style={{ color: TEXT_SECONDARY }}>
            {t('avatarFrame.history.empty')}
          </Text>
        ) : (
          lines.map((line) => (
            <View
              key={line.id}
              className="flex-row items-center justify-between gap-3 py-2"
              style={{ borderBottomWidth: 1, borderBottomColor: '#eceaea' }}
            >
              <View className="min-w-0 flex-1 flex-row items-center gap-2">
                <AvatarFrameImage frameId={line.frameId} size={FRAME_HISTORY_THUMB_SIZE} />
                <View className="min-w-0 flex-1">
                  <Text numberOfLines={1} className="font-medium" style={{ color: TEXT_PRIMARY }}>
                    {avatarFrameLabel(line.frameId)}
                  </Text>
                  <Text
                    numberOfLines={1}
                    className="text-xs"
                    style={{ color: line.tone === 'credit' ? FRAME_HISTORY_RECEIVED_COLOR : TEXT_SECONDARY }}
                  >
                    {line.text}
                  </Text>
                </View>
              </View>
              <View className="items-end">
                <Text className="text-xs" style={{ color: '#9a9a9c' }}>
                  {formatTime(line.createdAt)}
                </Text>
                {line.amount != null && (
                  <Text className="text-xs" style={{ color: FRAME_HISTORY_SPENT_COLOR }}>
                    {line.amount}
                  </Text>
                )}
              </View>
            </View>
          ))
        )}

        {history.hasMore && (
          <Pressable
            onPress={() => void history.loadMore().catch(() => undefined)}
            disabled={history.loading}
            className="mt-2 items-center rounded py-2 active:opacity-80"
            style={{ borderWidth: 1, borderColor: '#d1cece', backgroundColor: '#f6f6f6' }}
          >
            <Text className="text-sm" style={{ color: '#3a3839' }}>
              {history.loading ? t('common.loading') : t('avatarFrame.history.loadMore')}
            </Text>
          </Pressable>
        )}
      </ScrollView>
    </Dialog>
  );
}
