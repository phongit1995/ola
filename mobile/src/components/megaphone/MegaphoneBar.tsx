import { useCallback, useEffect } from 'react';
import { View } from 'react-native';
import type { NavigationContainerRefWithCurrent, ParamListBase } from '@react-navigation/native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { selectVisibleAnnouncement, useAnnouncementStore } from '@ola/shared/stores/announcementStore';
import { useMegaphoneStore } from '@ola/shared/stores/megaphone/megaphoneStore';
import type { Megaphone } from '@ola/shared/types';
import { MARQUEE_INTRO_MS, MarqueePill } from '@components/ui/MarqueePill';
import { MEGAPHONE_IMAGE } from './megaphoneAssets';
import { MegaphoneText } from './MegaphoneText';
import { useMegaphoneCovered } from './useMegaphoneCovered';

const MS_PER_SECOND = 1000;
const MARQUEE_MIN_MS = 1000;
const PILL_SIDE_GAP = 24;
const PILL_TOP_OFFSET = 56;

type NavigationRef = NavigationContainerRefWithCurrent<ParamListBase>;

function MegaphonePill({ megaphone }: { megaphone: Megaphone }) {
  const { t } = useTranslation();
  const markSeen = useMegaphoneStore((s) => s.markSeen);
  const { id, displaySeconds } = megaphone;
  const finish = useCallback(() => markSeen(id), [id, markSeen]);
  const marqueeDurationMs = useCallback(
    () => Math.max(MARQUEE_MIN_MS, displaySeconds * MS_PER_SECOND - MARQUEE_INTRO_MS),
    [displaySeconds],
  );

  return (
    <MarqueePill
      icon={MEGAPHONE_IMAGE}
      dismissLabel={t('megaphone.dismiss')}
      opaque
      marqueeDurationMs={marqueeDurationMs}
      onDismiss={finish}
      onDone={finish}
    >
      <MegaphoneText megaphone={megaphone} />
    </MarqueePill>
  );
}

export function MegaphoneBar({ navigationRef }: { navigationRef: NavigationRef }) {
  const insets = useSafeAreaInsets();
  const megaphone = useMegaphoneStore((s) => s.current);
  const stop = useMegaphoneStore((s) => s.stop);
  const announcing = useAnnouncementStore((s) => selectVisibleAnnouncement(s) != null);
  const covered = useMegaphoneCovered(navigationRef);
  const id = megaphone?.id;

  useEffect(() => {
    if (id != null && covered) stop(id);
  }, [id, covered, stop]);

  if (megaphone == null || announcing || covered) return null;

  return (
    <View
      pointerEvents="box-none"
      style={{
        position: 'absolute',
        left: PILL_SIDE_GAP,
        right: PILL_SIDE_GAP,
        top: insets.top + PILL_TOP_OFFSET,
        zIndex: 50,
      }}
    >
      <MegaphonePill key={megaphone.id} megaphone={megaphone} />
    </View>
  );
}
