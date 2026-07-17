import { useTranslation } from 'react-i18next';
import { Pressable, Text, useWindowDimensions, View } from 'react-native';
import type { Message } from '@ola/shared/types';
import { RichTextView } from '@components/ui/RichTextView';
import { DIVIDER } from '@constants';
import { replyExcerpt } from '../chatMessageView';

interface ReplyPreviewBarProps {
  replyTarget: Message;
  fallbackName: string;
  onClear: () => void;
}

export function ReplyPreviewBar({ replyTarget, fallbackName, onClear }: ReplyPreviewBarProps) {
  const { t } = useTranslation();
  const { width: windowWidth } = useWindowDimensions();

  return (
    <View
      className="flex-row items-center gap-2 bg-black/5 px-3 py-1.5"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
    >
      <View className="h-8 w-0.5 rounded bg-ola-primary" />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-xs font-semibold text-ola-primary">
          {t('chat.replyingTo', { name: replyTarget.senderName ?? fallbackName })}
        </Text>
        <RichTextView
          content={replyExcerpt(t, replyTarget)}
          own={false}
          color="rgba(0,0,0,0.54)"
          maxWidth={windowWidth - 70}
          fontSize={12}
          maxLines={1}
          onMention={() => undefined}
        />
      </View>
      <Pressable onPress={onClear} className="h-7 w-7 items-center justify-center rounded-full">
        <Text className="text-lg text-ola-ink-soft">×</Text>
      </Pressable>
    </View>
  );
}
