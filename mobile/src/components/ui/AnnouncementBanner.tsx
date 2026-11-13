import { useEffect } from 'react';
import { Linking, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import {
  selectVisibleAnnouncement,
  useAnnouncementStore,
} from '@ola/shared/stores/announcementStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useThemeColors } from '@hooks/useThemeColors';
import { Dialog, DialogButton } from './Dialog';
import { MarqueePill } from './MarqueePill';

const MARQUEE_SPEED_PX_PER_SECOND = 40;
const MARQUEE_MIN_DURATION_MS = 8000;
const MARQUEE_MAX_DURATION_MS = 45000;

const megaphoneIcon = require('@assets/icons/announcement-megaphone.png');

function announcementMarqueeMs(travelPx: number): number {
  return Math.min(
    MARQUEE_MAX_DURATION_MS,
    Math.max(MARQUEE_MIN_DURATION_MS, (travelPx / MARQUEE_SPEED_PX_PER_SECOND) * 1000),
  );
}

interface BannerPillProps {
  title: string;
  onOpenDetail: () => void;
  onDismiss: () => void;
  onMarqueeDone: () => void;
}

function BannerPill({ title, onOpenDetail, onDismiss, onMarqueeDone }: BannerPillProps) {
  const colors = useThemeColors();
  return (
    <MarqueePill
      icon={megaphoneIcon}
      marqueeDurationMs={announcementMarqueeMs}
      onOpen={onOpenDetail}
      onDismiss={onDismiss}
      onDone={onMarqueeDone}
    >
      <Text className="text-sm font-semibold" style={{ color: colors.primaryInk }}>
        {title}
      </Text>
    </MarqueePill>
  );
}

export function AnnouncementBanner() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const userId = useAuthStore((s) => s.user?.id);
  const announcement = useAnnouncementStore((s) => s.announcement);
  const visible = useAnnouncementStore(selectVisibleAnnouncement);
  const detailOpen = useAnnouncementStore((s) => s.detailOpen);
  const openDetail = useAnnouncementStore((s) => s.openDetail);
  const closeDetail = useAnnouncementStore((s) => s.closeDetail);
  const hide = useAnnouncementStore((s) => s.hide);
  const dismiss = useAnnouncementStore((s) => s.dismiss);

  useEffect(() => {
    if (userId != null) void useAnnouncementStore.getState().load();
  }, [userId]);

  if (announcement == null) return null;

  return (
    <>
      {visible != null && (
        <View
          pointerEvents="box-none"
          style={{
            position: 'absolute',
            left: 24,
            right: 24,
            top: insets.top + 56,
            zIndex: 50,
          }}
        >
          <BannerPill
            key={visible.id}
            title={visible.title}
            onOpenDetail={openDetail}
            onDismiss={dismiss}
            onMarqueeDone={hide}
          />
        </View>
      )}
      <Dialog
        visible={detailOpen}
        onClose={closeDetail}
        title={t('announcement.detailTitle')}
        showClose
        footer={
          announcement.link ? (
            <DialogButton
              variant="green"
              onPress={() => void Linking.openURL(announcement.link)}
            >
              {t('announcement.openLink')}
            </DialogButton>
          ) : undefined
        }
      >
        <ScrollView style={{ maxHeight: 360 }}>
          <Text className="mb-1 font-bold" style={{ color: '#3a3839' }}>
            {announcement.title}
          </Text>
          {announcement.content ? (
            <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
              {announcement.content}
            </Text>
          ) : null}
        </ScrollView>
      </Dialog>
    </>
  );
}
