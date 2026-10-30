import { useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { useNavigation } from '@react-navigation/native';
import { MOMENT_STATUS, MOMENT_TYPE, MOMENT_VISIBILITY, MOMENT_VISIBILITY_LABEL } from '@ola/shared/constants';
import {
  createTimeAgoFormatter,
  formatCompactCount,
  isMomentActive,
  isMomentHidden,
  isMomentHiddenByAdmin,
  isMomentMediaPurged,
  isMomentReactorsAvailable,
  isMomentViewersAvailable,
  momentLifeLabel,
  momentPreviewMedia,
} from '@ola/shared/lib';
import { useMomentManage } from '@ola/shared/stores/moment/useMomentManage';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { Moment } from '@ola/shared/types';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { useBottomBarInset } from '@hooks/useBottomBarInset';
import { useThemeColors } from '@hooks/useThemeColors';
import { MomentCanvas } from './components/MomentCanvas';
import { MomentCommentsDialog } from './components/MomentCommentsDialog';
import {
  MomentClockIcon,
  MomentCommentIcon,
  MomentEyeIcon,
  MomentEyeOffIcon,
  MomentFriendsIcon,
  MomentGlobeIcon,
  MomentImageIcon,
  MomentPlusIcon,
  MomentVideoIcon,
} from './components/MomentIcons';
import { MomentReactionSummary } from './components/MomentReactionChips';
import { MomentReactionsDialog } from './components/MomentReactionsDialog';
import { MomentViewersDialog } from './components/MomentViewersDialog';
import { useMomentOverlays } from './useMomentOverlays';

const MUTED_INK = 'rgba(0,0,0,0.54)';
const FAINT_INK = 'rgba(0,0,0,0.4)';
const SOFT_INK = 'rgba(0,0,0,0.6)';
const NEUTRAL_FILL = 'rgba(0,0,0,0.06)';
const WARNING_INK = '#ff9800';
const WARNING_FILL = 'rgba(255,152,0,0.15)';
const SKELETON_FILL = 'rgba(0,0,0,0.07)';
const SKELETON_ROWS = 3;
const STATUS_ICON = 14;
const TOGGLE_ICON = 14;

const styles = StyleSheet.create({
  card: {
    flexDirection: 'row',
    gap: 12,
    padding: 10,
    borderRadius: 16,
    backgroundColor: '#ffffff',
    borderWidth: StyleSheet.hairlineWidth,
    borderColor: 'rgba(0,0,0,0.08)',
    shadowColor: '#000',
    shadowOpacity: 0.06,
    shadowRadius: 4,
    shadowOffset: { width: 0, height: 1 },
    elevation: 1,
  },
  thumb: {
    width: 64,
    height: 112,
    overflow: 'hidden',
    borderRadius: 12,
    backgroundColor: '#ffffff',
    borderWidth: StyleSheet.hairlineWidth,
    borderColor: 'rgba(0,0,0,0.08)',
  },
  videoBadge: {
    position: 'absolute',
    top: 6,
    right: 6,
    width: 20,
    height: 20,
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.5)',
  },
  chip: {
    flexShrink: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    borderRadius: 999,
    paddingHorizontal: 8,
    paddingVertical: 3,
  },
  chipText: { flexShrink: 1, fontSize: 12, fontWeight: '600' },
  toggle: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    borderRadius: 999,
    paddingHorizontal: 12,
    paddingVertical: 6,
  },
  toggleText: { fontSize: 12, fontWeight: '600' },
  purgedCover: { alignItems: 'center', justifyContent: 'center' },
  purgedIcon: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.45)',
  },
});

function MomentStatus({ moment, nowMs }: { moment: Moment; nowMs: number }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const active = isMomentActive(moment, nowMs);
  let color = active ? colors.primaryInk : FAINT_INK;
  let background = active ? colors.primaryLight : NEUTRAL_FILL;
  let label = momentLifeLabel(t, moment, nowMs);
  let icon: ReactNode = <MomentClockIcon size={STATUS_ICON} color={color} />;
  if (isMomentMediaPurged(moment)) {
    color = SOFT_INK;
    background = NEUTRAL_FILL;
    label = t('moment.mediaPurgedBadge');
    icon = <MomentImageIcon size={STATUS_ICON} color={color} />;
  } else if (isMomentHidden(moment)) {
    color = SOFT_INK;
    background = NEUTRAL_FILL;
    label = t('moment.hiddenBadge');
    icon = <MomentEyeOffIcon size={STATUS_ICON} color={color} />;
  } else if (moment.status === MOMENT_STATUS.processing) {
    color = WARNING_INK;
    background = WARNING_FILL;
    label = t('moment.processing');
    icon = <MomentVideoIcon size={STATUS_ICON} color={color} />;
  }
  return (
    <View style={[styles.chip, { backgroundColor: background }]}>
      {icon}
      <Text numberOfLines={1} style={[styles.chipText, { color }]}>
        {label}
      </Text>
    </View>
  );
}

function HiddenToggle({ moment, busy, onToggle }: { moment: Moment; busy: boolean; onToggle: () => void }) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  if (isMomentHiddenByAdmin(moment)) return null;
  const hidden = isMomentHidden(moment);
  const ink = hidden ? colors.onPrimary : 'rgba(0,0,0,0.7)';
  return (
    <Pressable
      accessibilityRole="button"
      disabled={busy}
      onPress={onToggle}
      className="active:opacity-70"
      style={[
        styles.toggle,
        hidden
          ? { backgroundColor: colors.primary }
          : { backgroundColor: '#ffffff', borderWidth: 1, borderColor: 'rgba(0,0,0,0.15)' },
        { opacity: busy ? 0.5 : 1 },
      ]}
    >
      {hidden ? <MomentEyeIcon size={TOGGLE_ICON} color={ink} /> : <MomentEyeOffIcon size={TOGGLE_ICON} color={ink} />}
      <Text style={[styles.toggleText, { color: ink }]}>{t(hidden ? 'moment.unhide' : 'moment.hide')}</Text>
    </Pressable>
  );
}

interface MomentManageRowProps {
  moment: Moment;
  nowMs: number;
  postedAt: string;
  busy: boolean;
  onOpen: () => void;
  onViewers: () => void;
  onReactions: () => void;
  onComments: () => void;
  onToggleHidden: () => void;
}

function MomentManageRow({
  moment,
  nowMs,
  postedAt,
  busy,
  onOpen,
  onViewers,
  onReactions,
  onComments,
  onToggleHidden,
}: MomentManageRowProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const push = useToastStore((s) => s.push);
  const hidden = isMomentHidden(moment);
  const active = isMomentActive(moment, nowMs);
  const purged = isMomentMediaPurged(moment);
  const viewersAvailable = isMomentViewersAvailable(moment);
  const reactorsAvailable = isMomentReactorsAvailable(moment);
  const viewerLabel = t('moment.viewerCount', { count: moment.viewerCount ?? 0 });
  const viewerCount = formatCompactCount(moment.viewerCount ?? 0, i18n.language);
  const showAudienceUnavailable = () => push('info', t('moment.audienceUnavailable'));
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={purged ? t('moment.mediaPurged') : t('moment.open')}
      onPress={purged ? () => push('info', t('moment.mediaPurged')) : onOpen}
      className="active:opacity-90"
      style={styles.card}
    >
      <View style={styles.thumb}>
        <View style={[StyleSheet.absoluteFill, { opacity: hidden || !active ? 0.5 : 1 }]}>
          <MomentCanvas
            background={moment.background}
            media={momentPreviewMedia(moment)}
            overlays={moment.overlays}
            style={StyleSheet.absoluteFill}
          />
        </View>
        {moment.type === MOMENT_TYPE.video && (
          <View pointerEvents="none" style={styles.videoBadge}>
            <MomentVideoIcon size={12} />
          </View>
        )}
        {purged && (
          <View pointerEvents="none" style={[StyleSheet.absoluteFill, styles.purgedCover]}>
            <View style={styles.purgedIcon}>
              <MomentImageIcon size={16} color="#ffffff" />
            </View>
          </View>
        )}
      </View>

      <View className="min-w-0 flex-1 py-0.5">
        <View className="flex-row items-start gap-2">
          <Text numberOfLines={1} className="min-w-0 flex-1 text-base font-semibold text-ola-ink">
            {postedAt}
          </Text>
          <View style={{ marginVertical: -2 }}>
            <HiddenToggle moment={moment} busy={busy} onToggle={onToggleHidden} />
          </View>
        </View>
        <View className="mt-0.5 flex-row items-center gap-1">
          {moment.visibility === MOMENT_VISIBILITY.public ? (
            <MomentGlobeIcon size={14} color={MUTED_INK} />
          ) : (
            <MomentFriendsIcon size={14} color={MUTED_INK} />
          )}
          <Text className="text-sm" style={{ color: MUTED_INK }}>
            {t(MOMENT_VISIBILITY_LABEL[moment.visibility])}
          </Text>
        </View>
        <View className="mt-1.5 flex-row">
          <MomentStatus moment={moment} nowMs={nowMs} />
        </View>
        <View className="mt-auto flex-row flex-wrap items-center gap-2 pt-2">
          {viewersAvailable ? (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={viewerLabel}
              onPress={onViewers}
              className="flex-row items-center gap-1 rounded-full px-2.5 py-1.5 active:opacity-70"
              style={{ backgroundColor: colors.primaryLight }}
            >
              <MomentEyeIcon size={14} color={colors.primaryInk} />
              <Text className="text-sm font-semibold" style={{ color: colors.primaryInk }}>
                {viewerCount}
              </Text>
            </Pressable>
          ) : (
            <Pressable
              accessibilityLabel={viewerLabel}
              accessibilityHint={t('moment.audienceUnavailable')}
              onPress={showAudienceUnavailable}
              className="flex-row items-center gap-1 px-1"
            >
              <MomentEyeIcon size={14} color={MUTED_INK} />
              <Text className="text-sm" style={{ color: MUTED_INK }}>
                {viewerCount}
              </Text>
            </Pressable>
          )}
          {moment.reactions != null && (moment.reactionCount ?? 0) > 0 ? (
            reactorsAvailable ? (
              <MomentReactionSummary
                reactions={moment.reactions}
                total={moment.reactionCount ?? 0}
                onPress={onReactions}
              />
            ) : (
              <Pressable accessibilityHint={t('moment.audienceUnavailable')} onPress={showAudienceUnavailable}>
                <MomentReactionSummary reactions={moment.reactions} total={moment.reactionCount ?? 0} />
              </Pressable>
            )
          ) : null}
          {(moment.commentCount ?? 0) > 0 ? (
            <Pressable
              accessibilityRole="button"
              accessibilityLabel={t('moment.commentCount', { count: moment.commentCount ?? 0 })}
              onPress={onComments}
              className="flex-row items-center gap-1 rounded-full px-2.5 py-1.5 active:opacity-70"
              style={{ backgroundColor: colors.primaryLight }}
            >
              <MomentCommentIcon size={14} color={colors.primaryInk} />
              <Text className="text-sm font-semibold" style={{ color: colors.primaryInk }}>
                {formatCompactCount(moment.commentCount ?? 0, i18n.language)}
              </Text>
            </Pressable>
          ) : null}
        </View>
      </View>
    </Pressable>
  );
}

function MomentManageSkeleton() {
  return (
    <View className="gap-2.5">
      {Array.from({ length: SKELETON_ROWS }, (_, index) => (
        <View key={index} style={styles.card}>
          <View style={[styles.thumb, { backgroundColor: SKELETON_FILL, borderWidth: 0 }]} />
          <View className="flex-1 gap-2 py-1">
            <View className="h-4 w-2/5 rounded" style={{ backgroundColor: SKELETON_FILL }} />
            <View className="h-3 w-1/4 rounded" style={{ backgroundColor: SKELETON_FILL }} />
            <View className="mt-auto flex-row justify-between">
              <View className="h-7 w-24 rounded-full" style={{ backgroundColor: SKELETON_FILL }} />
              <View className="h-7 w-16 rounded-full" style={{ backgroundColor: SKELETON_FILL }} />
            </View>
          </View>
        </View>
      ))}
    </View>
  );
}

export function MomentManageScreen() {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation();
  const colors = useThemeColors();
  const bottomInset = useBottomBarInset();
  const overlays = useMomentOverlays();
  const { moments, loaded, loading, hasMore, loadMore, clockMs, busyId, toggleHidden } = useMomentManage();
  const [viewersId, setViewersId] = useState<string | null>(null);
  const [reactionsId, setReactionsId] = useState<string | null>(null);
  const [commentsId, setCommentsId] = useState<string | null>(null);
  const formatTime = useMemo(() => createTimeAgoFormatter(i18n.language), [i18n.language]);

  function renderContent() {
    if (!loaded && loading) return <MomentManageSkeleton />;
    if (moments.length === 0) {
      return (
        <View className="items-center gap-3 px-4 py-10" style={[styles.card, { flexDirection: 'column' }]}>
          <View
            className="h-16 w-16 items-center justify-center rounded-full"
            style={{ backgroundColor: colors.primaryLight }}
          >
            <MomentImageIcon size={32} color={colors.primaryInk} />
          </View>
          <Text className="text-center text-base text-ola-ink-soft">
            {t('moment.manageEmpty')}
          </Text>
          <Pressable
            accessibilityRole="button"
            onPress={overlays.openComposer}
            className="flex-row items-center gap-1.5 rounded-full px-4 py-1.5 active:opacity-70"
            style={{ backgroundColor: colors.primary }}
          >
            <MomentPlusIcon size={16} color={colors.onPrimary} />
            <Text className="text-base font-medium" style={{ color: colors.onPrimary }}>
              {t('moment.add')}
            </Text>
          </Pressable>
        </View>
      );
    }
    return (
      <>
        <View className="gap-2.5">
          {moments.map((moment) => (
            <MomentManageRow
              key={moment.id}
              moment={moment}
              nowMs={clockMs}
              postedAt={formatTime(moment.createdAt)}
              busy={busyId === moment.id}
              onOpen={() => overlays.openArchive(moment)}
              onViewers={() => setViewersId(moment.id)}
              onReactions={() => setReactionsId(moment.id)}
              onComments={() => setCommentsId(moment.id)}
              onToggleHidden={() => void toggleHidden(moment)}
            />
          ))}
        </View>
        {hasMore && (
          <View className="items-center py-4">
            <Pressable
              accessibilityRole="button"
              disabled={loading}
              onPress={loadMore}
              className="h-9 min-w-36 items-center justify-center rounded-full px-4 active:opacity-70"
              style={{ borderWidth: 1, borderColor: colors.primary, opacity: loading ? 0.6 : 1 }}
            >
              {loading ? (
                <ActivityIndicator size="small" color={colors.primary} />
              ) : (
                <Text className="text-base" style={{ color: colors.primaryInk }}>
                  {t('moment.historyMore')}
                </Text>
              )}
            </Pressable>
          </View>
        )}
      </>
    );
  }

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader
        title={t('moment.manageTitle')}
        onBack={() => navigation.goBack()}
        right={
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('moment.add')}
            hitSlop={6}
            onPress={overlays.openComposer}
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
          >
            <MomentPlusIcon size={24} color={colors.onPrimary} />
          </Pressable>
        }
      />
      <ScrollView contentContainerStyle={{ padding: 12, paddingBottom: 12 + bottomInset }}>
        <Text className="px-1 pb-2 text-sm text-ola-ink-soft">
          {t('moment.manageHint')}
        </Text>
        {renderContent()}
      </ScrollView>

      <MomentViewersDialog
        visible={viewersId != null}
        momentId={viewersId ?? ''}
        onClose={() => setViewersId(null)}
      />
      <MomentReactionsDialog
        visible={reactionsId != null}
        momentId={reactionsId ?? ''}
        total={moments.find(moment => moment.id === reactionsId)?.reactionCount ?? 0}
        onClose={() => setReactionsId(null)}
      />
      <MomentCommentsDialog
        visible={commentsId != null}
        momentId={commentsId ?? ''}
        total={moments.find(moment => moment.id === commentsId)?.commentCount ?? 0}
        onClose={() => setCommentsId(null)}
      />
      {overlays.overlays}
    </View>
  );
}
