import { useTranslation } from 'react-i18next';
import { Image, Pressable, StyleSheet, Text, View } from 'react-native';
import { formatCompactCount, MOMENT_REACTION_LABEL_KEY } from '@ola/shared/lib';
import type { MomentReactionCount } from '@ola/shared/types';
import { useThemeColors } from '@hooks/useThemeColors';
import { REACTION_IMAGE } from '@lib/reactions';

const SUMMARY_ICONS = 3;
const CHIP_INK = 'rgba(0,0,0,0.7)';

const styles = StyleSheet.create({
  row: { flexDirection: 'row', alignItems: 'center' },
  chip: { flexDirection: 'row', alignItems: 'center', gap: 2 },
  icon: { width: 20, height: 20 },
  stackedIcon: {
    width: 20,
    height: 20,
    borderRadius: 10,
    borderWidth: 2,
    borderColor: '#ffffff',
    backgroundColor: '#ffffff',
  },
  count: { fontSize: 12, fontWeight: '600', color: CHIP_INK },
  summaryPill: {
    gap: 4,
    borderRadius: 999,
    paddingLeft: 6,
    paddingRight: 10,
    paddingVertical: 6,
  },
});

export function MomentReactionCounts({
  reactions,
}: {
  reactions: MomentReactionCount[];
}) {
  const { t, i18n } = useTranslation();
  return (
    <View style={[styles.row, { gap: 8 }]}>
      {reactions.map(({ type, count }) => {
        const image = REACTION_IMAGE[type];
        return (
          <View
            key={type}
            style={styles.chip}
            accessibilityLabel={t(MOMENT_REACTION_LABEL_KEY[type])}
          >
            {image != null && (
              <Image source={image} resizeMode="contain" style={styles.icon} />
            )}
            <Text style={styles.count}>
              {formatCompactCount(count, i18n.language)}
            </Text>
          </View>
        );
      })}
    </View>
  );
}

export function MomentReactionSummary({
  reactions,
  total,
  onPress,
}: {
  reactions: MomentReactionCount[];
  total: number;
  onPress?: () => void;
}) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const label = t('moment.reactionTotal', { count: total });
  const content = (
    <>
      <View style={styles.row}>
        {reactions.slice(0, SUMMARY_ICONS).map(({ type }, index) => {
          const image = REACTION_IMAGE[type];
          if (image == null) return null;
          return (
            <Image
              key={type}
              source={image}
              resizeMode="contain"
              style={[styles.stackedIcon, index > 0 && { marginLeft: -6 }]}
            />
          );
        })}
      </View>
      <Text
        style={[styles.count, onPress != null && { color: colors.primaryInk }]}
      >
        {formatCompactCount(total, i18n.language)}
      </Text>
    </>
  );

  if (onPress == null) {
    return (
      <View style={[styles.row, { gap: 4 }]} accessibilityLabel={label}>
        {content}
      </View>
    );
  }
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      onPress={onPress}
      className="active:opacity-70"
      style={[
        styles.row,
        styles.summaryPill,
        { backgroundColor: colors.primaryLight },
      ]}
    >
      {content}
    </Pressable>
  );
}
