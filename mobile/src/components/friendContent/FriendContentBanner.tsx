import { Pressable, Text, View } from 'react-native';
import Animated, { FadeInUp } from 'react-native-reanimated';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import {
  friendContentLabel,
  friendContentName,
  useFriendContentNotice,
  useFriendContentStore,
} from '@ola/shared/stores/friendContent';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { SmileyText } from '@lib/richText';

const PREVIEW_FONT_SIZE = 14;

export function FriendContentBanner() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const notice = useFriendContentNotice();
  if (notice == null) return null;
  const name = friendContentName(notice);
  const { open, dismiss } = useFriendContentStore.getState();

  return (
    <View
      pointerEvents="box-none"
      style={{ position: 'absolute', left: 0, right: 0, top: insets.top + 8, zIndex: 60, paddingHorizontal: 12 }}
    >
      <Animated.View
        key={notice.contentId}
        entering={FadeInUp.duration(220)}
        className="flex-row items-center rounded-2xl bg-white"
        style={{
          shadowColor: '#000',
          shadowOpacity: 0.18,
          shadowRadius: 12,
          shadowOffset: { width: 0, height: 4 },
          elevation: 8,
        }}
      >
        <Pressable onPress={open} className="min-w-0 flex-1 flex-row items-center gap-3 p-3">
          <AvatarWithFrame
            name={name}
            uri={notice.author.avatar ?? undefined}
            size={40}
            frameId={notice.author.avatarFrameId}
          />
          <View className="min-w-0 flex-1">
            <Text numberOfLines={2} className="text-sm leading-snug text-ola-ink">
              <Text className="font-bold">{name}</Text> {friendContentLabel(notice.kind)}
            </Text>
            {notice.preview != null && notice.preview !== '' && (
              <Text numberOfLines={1} className="mt-0.5 text-sm text-ola-ink-soft">
                <SmileyText text={notice.preview} fontSize={PREVIEW_FONT_SIZE} />
              </Text>
            )}
          </View>
        </Pressable>
        <Pressable
          onPress={dismiss}
          accessibilityRole="button"
          accessibilityLabel={t('dialog.close')}
          hitSlop={8}
          style={{ width: 32, height: 32, marginRight: 8, alignItems: 'center', justifyContent: 'center' }}
        >
          <Text className="text-xl text-ola-ink-soft">×</Text>
        </Pressable>
      </Animated.View>
    </View>
  );
}
