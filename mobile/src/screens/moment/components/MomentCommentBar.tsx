import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import type { MomentMyComment } from '@ola/shared/types';
import { SmileyText } from '@lib/richText';
import { MomentCheckIcon, MomentCommentIcon } from './MomentIcons';

const COMMENT_FONT_SIZE = 14;
const ICON_SIZE = 18;

const styles = StyleSheet.create({
  pill: {
    height: 44,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    borderRadius: 999,
    borderWidth: 1,
    borderColor: 'rgba(255,255,255,0.4)',
    backgroundColor: 'rgba(255,255,255,0.14)',
    paddingHorizontal: 12,
  },
  sent: {
    borderColor: 'rgba(255,255,255,0.18)',
    backgroundColor: 'rgba(0,0,0,0.28)',
  },
  text: { flex: 1, color: 'rgba(255,255,255,0.88)', fontSize: COMMENT_FONT_SIZE },
});

interface MomentCommentBarProps {
  myComment?: MomentMyComment;
  onComment: () => void;
}

export function MomentCommentBar({ myComment, onComment }: MomentCommentBarProps) {
  const { t } = useTranslation();

  if (myComment != null) {
    const label =
      myComment.content === '' ? t('moment.commented') : `${t('moment.commented')}: ${myComment.content}`;
    return (
      <View accessible accessibilityLabel={label} style={[styles.pill, styles.sent]}>
        <MomentCheckIcon size={ICON_SIZE} color="rgba(255,255,255,0.9)" />
        <Text numberOfLines={1} style={styles.text}>
          {myComment.content === '' ? (
            t('moment.commented')
          ) : (
            <SmileyText text={myComment.content} fontSize={COMMENT_FONT_SIZE} />
          )}
        </Text>
      </View>
    );
  }

  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t('moment.commentPlaceholder')}
      onPress={onComment}
      className="active:opacity-70"
      style={styles.pill}
    >
      <MomentCommentIcon size={ICON_SIZE} color="rgba(255,255,255,0.9)" />
      <Text numberOfLines={1} style={styles.text}>
        {t('moment.commentPlaceholder')}
      </Text>
    </Pressable>
  );
}
