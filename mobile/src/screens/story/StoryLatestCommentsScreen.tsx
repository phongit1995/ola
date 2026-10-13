import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { STORY_LATEST_COMMENTS_THREAD } from '@ola/shared/constants';
import type { StoryComment } from '@ola/shared/types';
import type { StoryStackParamList } from '@navigation/types';
import { STORY_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { StoryCommentList } from './components/StoryCommentList';
import { StoryCommentSheet } from './components/StoryCommentSheet';

type Props = NativeStackScreenProps<
  StoryStackParamList,
  typeof STORY_ROUTES.StoryLatestComments
>;

export function StoryLatestCommentsScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const [replyTarget, setReplyTarget] = useState<StoryComment | null>(null);

  const openStory = useCallback(
    (storyId: string) => navigation.navigate(STORY_ROUTES.StoryDetail, { storyId }),
    [navigation]
  );

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('story.latestComments')} onBack={navigation.goBack} />
      <StoryCommentList
        threadId={STORY_LATEST_COMMENTS_THREAD}
        emptyText={t('story.latestCommentsEmpty')}
        onReply={setReplyTarget}
        onOpenStory={openStory}
      />
      {replyTarget && (
        <StoryCommentSheet
          storyId={replyTarget.storyId}
          initialReplyTarget={replyTarget}
          onClose={() => setReplyTarget(null)}
        />
      )}
    </View>
  );
}
