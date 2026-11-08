import { Image, Text, View } from 'react-native';
import { MEGAPHONE_IMAGE, MEGAPHONE_LINE } from '@components/megaphone/megaphoneAssets';
import { VipBadge } from '@components/ui/VipBadge';
import { SmileyText } from '@lib/richText';

const ICON_SIZE = 24;
const CONTENT_FONT_SIZE = 14;

interface MegaphonePreviewProps {
  username: string;
  vipTypeId: number | null;
  content: string;
}

export function MegaphonePreview({ username, vipTypeId, content }: MegaphonePreviewProps) {
  return (
    <View
      className="flex-row items-start gap-2 rounded-lg bg-ola-megaphone-soft px-2.5 py-2"
      style={{ borderWidth: 1, borderColor: MEGAPHONE_LINE }}
    >
      <Image source={MEGAPHONE_IMAGE} style={{ width: ICON_SIZE, height: ICON_SIZE }} resizeMode="contain" />
      <VipBadge typeId={vipTypeId} size={ICON_SIZE} />
      <Text className="min-w-0 flex-1 text-sm text-ola-ink">
        <Text className="font-semibold text-ola-megaphone-name">@{username}: </Text>
        <SmileyText text={content} fontSize={CONTENT_FONT_SIZE} />
      </Text>
    </View>
  );
}
