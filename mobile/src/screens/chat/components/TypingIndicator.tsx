import { View } from 'react-native';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';

interface TypingIndicatorProps {
  name: string;
  avatar?: string;
  avatarFrameId?: string | null;
}

export function TypingIndicator({ name, avatar, avatarFrameId }: TypingIndicatorProps) {
  return (
    <View className="mt-1 flex-row items-end gap-1 px-3">
      <AvatarWithFrame name={name} uri={avatar} size={32} frameId={avatarFrameId} />
      <View
        className="flex-row items-center gap-1 rounded-2xl rounded-tl-sm bg-white px-3 py-3"
        style={{
          shadowColor: '#000',
          shadowOpacity: 0.08,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 1,
        }}
      >
        <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.25)' }} />
        <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.4)' }} />
        <View className="h-1.5 w-1.5 rounded-full" style={{ backgroundColor: 'rgba(0,0,0,0.55)' }} />
      </View>
    </View>
  );
}
