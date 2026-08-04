import { Image, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { Avatar } from '@components/ui/Avatar';

const backIcon = require('@assets/icons/ic_back.png');
const moreIcon = require('@assets/icons/chat/ic_more_white.png');

interface ChatHeaderProps {
  title: string;
  subtitle: string;
  avatar?: string;
  right?: React.ReactNode;
  onBack: () => void;
  onOpenProfile: () => void;
  onMore: () => void;
}

export function ChatHeader({
  title,
  subtitle,
  avatar,
  right,
  onBack,
  onOpenProfile,
  onMore,
}: ChatHeaderProps) {
  const insets = useSafeAreaInsets();

  return (
    <View className="bg-ola-primary px-2 pb-2" style={{ paddingTop: insets.top + 8 }}>
      <View className="h-9 flex-row items-center gap-2">
        <Pressable
          className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
          onPress={onBack}
        >
          <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
        </Pressable>
        <Pressable className="flex-1 flex-row items-center gap-2" onPress={onOpenProfile}>
          <Avatar name={title} uri={avatar} size={32} />
          <View className="flex-1">
            <Text className="text-sm font-bold text-white" numberOfLines={1}>
              {title}
            </Text>
            {subtitle !== '' && (
              <Text className="text-xs text-white/70" numberOfLines={1}>
                {subtitle}
              </Text>
            )}
          </View>
        </Pressable>
        {right}
        <Pressable
          className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
          onPress={onMore}
        >
          <Image source={moreIcon} style={{ width: 20, height: 20, tintColor: '#fff' }} resizeMode="contain" />
        </Pressable>
      </View>
    </View>
  );
}
