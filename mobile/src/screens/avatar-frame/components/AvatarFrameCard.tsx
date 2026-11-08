import { Pressable, Text, View } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { useThemeColors } from '@hooks/useThemeColors';
import { TEXT_PRIMARY } from '@constants';
import { FRAME_CARD_AVATAR_SIZE, FRAME_GRID_COLUMNS } from '../constants';
import { avatarFrameLabel } from '@ola/shared/lib/avatarFrame';

interface AvatarFrameCardProps {
  frameId: string;
  subtitle?: string;
  badge?: string;
  highlighted?: boolean;
  onPress: () => void;
}

export function AvatarFrameCard({ frameId, subtitle, badge, highlighted = false, onPress }: AvatarFrameCardProps) {
  const colors = useThemeColors();
  const username = useAuthStore((s) => s.user?.username ?? '');
  const avatar = useAuthStore((s) => s.user?.avatar ?? undefined);
  return (
    <View style={{ width: `${100 / FRAME_GRID_COLUMNS}%`, padding: 4 }}>
      <Pressable
        onPress={onPress}
        className="items-center rounded-lg bg-white active:opacity-80"
        style={{
          paddingTop: 14,
          paddingBottom: 8,
          paddingHorizontal: 4,
          borderWidth: highlighted ? 2 : 1,
          borderColor: highlighted ? colors.primary : 'rgba(0,0,0,0.08)',
        }}
      >
        <AvatarWithFrame
          name={username}
          uri={avatar}
          size={FRAME_CARD_AVATAR_SIZE}
          frameId={frameId}
          showLoader={false}
        />
        <Text
          numberOfLines={1}
          className="mt-3 w-full text-center text-xs"
          style={{ color: TEXT_PRIMARY }}
        >
          {avatarFrameLabel(frameId)}
        </Text>
        {subtitle != null && (
          <Text
            numberOfLines={1}
            className="mt-0.5 text-xs font-semibold"
            style={{ color: colors.primaryDarker }}
          >
            {subtitle}
          </Text>
        )}
        {badge != null && (
          <View
            className="rounded-full px-1.5"
            style={{ position: 'absolute', top: 4, right: 4, backgroundColor: colors.primary }}
          >
            <Text className="text-[10px] font-semibold" style={{ color: colors.onPrimary }}>
              {badge}
            </Text>
          </View>
        )}
      </Pressable>
    </View>
  );
}
