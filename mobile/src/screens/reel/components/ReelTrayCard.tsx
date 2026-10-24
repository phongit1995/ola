import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, Text, View, type ViewStyle } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { REEL_TYPE } from '@ola/shared/constants';
import { colorForName, reelPreviewMedia } from '@ola/shared/lib';
import type { Reel } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { useThemeColors } from '@hooks/useThemeColors';
import { REEL_TRAY_CARD_HEIGHT, REEL_TRAY_CARD_WIDTH } from '../constants';
import { ReelCanvas } from './ReelCanvas';
import { ReelPlusIcon, ReelVideoIcon } from './ReelIcons';

const CARD_RADIUS = 12;
const AVATAR_SIZE = 30;

function cardSize(width: number | undefined): ViewStyle {
  if (width == null) return { width: REEL_TRAY_CARD_WIDTH, height: REEL_TRAY_CARD_HEIGHT };
  return { width, height: (width * 16) / 9 };
}

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

interface ReelTrayCardProps {
  reel: Reel;
  label: string;
  ringed: boolean;
  width?: number;
  onPress: () => void;
}

export function ReelTrayCard({ reel, label, ringed, width, onPress }: ReelTrayCardProps) {
  const colors = useThemeColors();
  const author = reel.author;
  const fluid = width != null;
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      onPress={onPress}
      style={[styles.card, cardSize(width)]}
    >
      <ReelCanvas
        background={reel.background}
        media={reelPreviewMedia(reel)}
        overlays={reel.overlays}
        fit="cover"
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
            name={author.fullName || author.username}
            color={colorForName(author.username)}
            uri={author.avatar ?? undefined}
            size={AVATAR_SIZE}
          />
        </View>
      </View>
      {reel.type === REEL_TYPE.video && (
        <View pointerEvents="none" style={styles.videoBadge}>
          <ReelVideoIcon size={14} />
        </View>
      )}
      <Text
        numberOfLines={2}
        style={[styles.label, { fontSize: fluid ? 14 : 12, lineHeight: fluid ? 18 : 15 }]}
      >
        {label}
      </Text>
    </Pressable>
  );
}

export function ReelAddCard({ width, onPress }: { width?: number; onPress: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const fluid = width != null;
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t('reel.add')}
      onPress={onPress}
      style={[
        cardSize(width),
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
        <ReelPlusIcon size={20} color={colors.onPrimary} />
      </View>
      <Text
        style={{
          paddingHorizontal: 4,
          textAlign: 'center',
          fontWeight: '600',
          fontSize: fluid ? 14 : 12,
          color: 'rgba(0,0,0,0.7)',
        }}
      >
        {t('reel.add')}
      </Text>
    </Pressable>
  );
}
