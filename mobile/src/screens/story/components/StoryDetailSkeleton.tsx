import { View } from 'react-native';

const STRONG = 'rgba(0,0,0,0.08)';
const SOFT = 'rgba(0,0,0,0.06)';
const COVER_WIDTH = 112;
const COVER_HEIGHT = Math.round((COVER_WIDTH * 4) / 3);
const INTRO_LINES = ['100%', '94%', '97%', '62%'] as const;

export function StoryDetailSkeleton() {
  return (
    <View accessibilityState={{ busy: true }} className="flex-1 overflow-hidden">
      <View className="bg-white p-4">
        <View className="flex-row gap-4">
          <View
            className="rounded-lg"
            style={{ width: COVER_WIDTH, height: COVER_HEIGHT, backgroundColor: STRONG }}
          />
          <View className="flex-1 gap-2.5 pt-1">
            <View className="h-5 rounded" style={{ width: '92%', backgroundColor: STRONG }} />
            <View className="h-5 rounded" style={{ width: '66%', backgroundColor: STRONG }} />
            <View className="mt-1 h-4 rounded" style={{ width: '75%', backgroundColor: SOFT }} />
            <View className="mt-auto h-3.5 w-24 rounded" style={{ backgroundColor: SOFT }} />
          </View>
        </View>
        <View className="mt-4 h-14 rounded-xl" style={{ backgroundColor: SOFT }} />
        <View className="mt-4 h-11 rounded-full" style={{ backgroundColor: STRONG }} />
      </View>
      <View className="mt-2 gap-3 bg-white p-4">
        <View className="h-4 w-24 rounded" style={{ backgroundColor: STRONG }} />
        {INTRO_LINES.map((width, index) => (
          <View key={index} className="h-3.5 rounded" style={{ width, backgroundColor: SOFT }} />
        ))}
      </View>
    </View>
  );
}
