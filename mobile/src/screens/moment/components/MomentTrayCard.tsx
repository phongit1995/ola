import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { MOMENT_TYPE } from '@ola/shared/constants';
import { colorForName, momentPreviewMedia } from '@ola/shared/lib';
import type { Moment } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { useThemeColors } from '@hooks/useThemeColors';
import { MOMENT_TRAY_CARD_HEIGHT, MOMENT_TRAY_CARD_WIDTH } from '../constants';
import { MomentCanvas } from './MomentCanvas';
import { MomentPlusIcon, MomentVideoIcon } from './MomentIcons';

const CARD_RADIUS = 12;
const AVATAR_SIZE = 30;

const CARD_SIZE = { width: MOMENT_TRAY_CARD_WIDTH, height: MOMENT_TRAY_CARD_HEIGHT };

const styles = StyleSheet.create({
  card: {
    borderRadius: CARD_RADIUS,
    overflow: 'hidden',
    backgroundColor: '#000000',
    elevation: 2,
    shadowColor: '#000000',
    shadowOpacity: 0.25,
    shadowRadius: 2,
    shadowOffset: { width: 0, height: 1 },
  },
  shade: { position: 'absolute', left: 0, right: 0, bottom: 0, height: 64 },
  ring: { position: 'absolute', top: 8, left: 8, borderRadius: 999, padding: 2 },
  ringInner: { borderRadius: 999, backgroundColor: '#ffffff', padding: 1.5 },
  videoBadge: {
    position: 'absolute',
    top: 8,
    right: 8,
    width: 24,
    height: 24,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.45)',
  },
  label: { position: 'absolute', left: 8, right: 8, bottom: 8, color: '#ffffff', fontWeight: '600' },
});

interface MomentTrayCardProps {
  moment: Moment;
  label: string;
  ringed: boolean;
  onPress: () => void;
}

export function MomentTrayCard({ moment, label, ringed, onPress }: MomentTrayCardProps) {
  const colors = useThemeColors();
  const author = moment.author;
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      onPress={onPress}
      style={[styles.card, CARD_SIZE]}
    >
      <MomentCanvas
        background={moment.background}
        media={momentPreviewMedia(moment)}
        overlays={moment.overlays}
        style={StyleSheet.absoluteFill}
      />
      <LinearGradient
        pointerEvents="none"
        colors={['rgba(0,0,0,0)', 'rgba(0,0,0,0.75)']}
        style={styles.shade}
      />
      <View
        pointerEvents="none"
        style={[styles.ring, { backgroundColor: ringed ? colors.primary : 'rgba(255,255,255,0.8)' }]}
      >
        <View style={styles.ringInner}>
          <Avatar
            name={author.username}
            color={colorForName(author.username)}
            uri={author.avatar ?? undefined}
            size={AVATAR_SIZE}
          />
        </View>
      </View>
      {moment.type === MOMENT_TYPE.video && (
        <View pointerEvents="none" style={styles.videoBadge}>
          <MomentVideoIcon size={14} />
        </View>
      )}
      <Text
        numberOfLines={2}
        style={[styles.label, { fontSize: 12, lineHeight: 15 }]}
      >
        {label}
      </Text>
    </Pressable>
  );
}

export function MomentAddCard({ onPress }: { onPress: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t('moment.add')}
      onPress={onPress}
      style={[
        CARD_SIZE,
        {
          borderRadius: CARD_RADIUS,
          borderWidth: 2,
          borderStyle: 'dashed',
          borderColor: '#d5d5d5',
          backgroundColor: '#f3f3f3',
          alignItems: 'center',
          justifyContent: 'center',
          gap: 12,
        },
      ]}
    >
      <View
        style={{
          width: 40,
          height: 40,
          borderRadius: 20,
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: colors.primary,
        }}
      >
        <MomentPlusIcon size={20} color={colors.onPrimary} />
      </View>
      <Text
        style={{
          paddingHorizontal: 4,
          textAlign: 'center',
          fontWeight: '600',
          fontSize: 12,
          color: 'rgba(0,0,0,0.7)',
        }}
      >
        {t('moment.add')}
      </Text>
    </Pressable>
  );
}
