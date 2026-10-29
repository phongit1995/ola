import { useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActionButton,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
} from '@components';
import {
  MOMENT_STATUS,
  MOMENT_TYPE,
  MOMENT_VISIBILITY,
  MOMENT_VISIBILITY_LABEL,
} from '@constants';
import {
  cn,
  createTimeAgoFormatter,
  formatCompactCount,
  isMomentActive,
  isMomentHidden,
  isMomentHiddenByAdmin,
  momentLifeLabel,
  momentPreviewMedia,
} from '@lib';
import type { Moment, MomentViewerSession } from '@app-types';
import { useMomentManage } from '@ola/shared/stores/moment/useMomentManage';
import { MomentCanvas } from './components/MomentCanvas';
import { MomentCommentsDialog } from './components/MomentCommentsDialog';
import { MomentComposer } from './components/MomentComposer';
import {
  MomentClockIcon,
  MomentCommentIcon,
  MomentEyeIcon,
  MomentEyeOffIcon,
  MomentFriendsIcon,
  MomentGlobeIcon,
  MomentImageIcon,
  MomentPlayIcon,
  MomentPlusIcon,
  MomentVideoIcon,
} from './components/MomentIcons';
import { MomentViewer } from './components/MomentViewer';
import { MomentReactionSummary } from './components/MomentReactionChips';
import { MomentReactionsDialog } from './components/MomentReactionsDialog';
import { MomentViewersDialog } from './components/MomentViewersDialog';

const TOGGLE_CLASS =
  'relative inline-flex shrink-0 items-center gap-1.5 rounded-full px-3 py-1.5 text-xs font-semibold transition-colors disabled:opacity-50';
const SKELETON_ROWS = 3;
const STATUS_ICON = 'h-3.5 w-3.5';

function MomentStatus({ moment, nowMs }: { moment: Moment; nowMs: number }) {
  const { t } = useTranslation();
  let icon: ReactNode = <MomentClockIcon className={STATUS_ICON} />;
  let label = momentLifeLabel(t, moment, nowMs);
  let tone = isMomentActive(moment, nowMs)
    ? 'bg-ola-primary-light text-ola-primary-ink'
    : 'bg-black/5 text-black/45';
  if (isMomentHidden(moment)) {
    icon = <MomentEyeOffIcon className={STATUS_ICON} />;
    label = t('moment.hiddenBadge');
    tone = 'bg-black/6 text-black/60';
  } else if (moment.status === MOMENT_STATUS.processing) {
    icon = <MomentVideoIcon className={STATUS_ICON} />;
    label = t('moment.processing');
    tone = 'bg-ola-warning/15 text-ola-warning';
  }
  return (
    <span
      className={cn(
        'mt-1.5 inline-flex max-w-full items-center gap-1 self-start rounded-full px-2 py-0.5 text-xs font-semibold',
        tone
      )}
    >
      {icon}
      <span className="truncate">{label}</span>
    </span>
  );
}

function HiddenToggle({
  moment,
  busy,
  onToggle,
}: {
  moment: Moment;
  busy: boolean;
  onToggle: () => void;
}) {
  const { t } = useTranslation();
  if (isMomentHiddenByAdmin(moment)) return null;
  const hidden = isMomentHidden(moment);
  return (
    <button
      type="button"
      disabled={busy}
      onClick={onToggle}
      className={cn(
        TOGGLE_CLASS,
        hidden
          ? 'bg-ola-primary text-ola-on-primary hover:bg-ola-primary-dark'
          : 'bg-white text-black/70 ring-1 ring-black/15 hover:bg-black/5'
      )}
    >
      {hidden ? (
        <MomentEyeIcon className="h-3.5 w-3.5" />
      ) : (
        <MomentEyeOffIcon className="h-3.5 w-3.5" />
      )}
      {t(hidden ? 'moment.unhide' : 'moment.hide')}
    </button>
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
  const hidden = isMomentHidden(moment);
  const active = isMomentActive(moment, nowMs);
  const viewerLabel = t('moment.viewerCount', {
    count: moment.viewerCount ?? 0,
  });
  const viewerCount = formatCompactCount(
    moment.viewerCount ?? 0,
    i18n.language
  );
  return (
    <li className="group relative flex gap-3 rounded-2xl bg-white p-2.5 shadow-sm ring-1 ring-black/5 transition hover:shadow-md hover:ring-black/10">
      <button
        type="button"
        aria-label={t('moment.open')}
        onClick={onOpen}
        className="absolute inset-0 rounded-2xl focus-visible:outline-2 focus-visible:outline-ola-primary"
      />
      <div className="pointer-events-none relative h-28 w-16 shrink-0 overflow-hidden rounded-xl bg-white ring-1 ring-black/5">
        <div
          className={cn(
            'absolute inset-0',
            (hidden || !active) && 'opacity-50 saturate-50'
          )}
        >
          <MomentCanvas
            background={moment.background}
            media={momentPreviewMedia(moment)}
            overlays={moment.overlays}
          />
        </div>
        <span className="absolute inset-0 flex items-center justify-center opacity-0 transition-opacity group-hover:opacity-100">
          <span className="flex h-9 w-9 items-center justify-center rounded-full bg-black/45 text-white">
            <MomentPlayIcon className="ml-0.5 h-4 w-4" />
          </span>
        </span>
        {moment.type === MOMENT_TYPE.video && (
          <span className="absolute top-1.5 right-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-black/50 text-white">
            <MomentVideoIcon className="h-3 w-3" />
          </span>
        )}
      </div>

      <div className="pointer-events-none relative flex min-w-0 flex-1 flex-col py-0.5">
        <div className="flex items-start gap-2">
          <p className="min-w-0 flex-1 truncate text-[15px] font-semibold text-black/87">
            {postedAt}
          </p>
          <span className="pointer-events-auto -my-0.5 shrink-0">
            <HiddenToggle
              moment={moment}
              busy={busy}
              onToggle={onToggleHidden}
            />
          </span>
        </div>
        <p className="mt-0.5 inline-flex items-center gap-1 text-xs text-black/54">
          {moment.visibility === MOMENT_VISIBILITY.public ? (
            <MomentGlobeIcon className="h-3.5 w-3.5" />
          ) : (
            <MomentFriendsIcon className="h-3.5 w-3.5" />
          )}
          {t(MOMENT_VISIBILITY_LABEL[moment.visibility])}
        </p>
        <MomentStatus moment={moment} nowMs={nowMs} />
        <div className="mt-auto flex flex-wrap items-center gap-2 pt-2">
          {active ? (
            <button
              type="button"
              title={viewerLabel}
              aria-label={viewerLabel}
              onClick={onViewers}
              className="pointer-events-auto relative inline-flex shrink-0 items-center gap-1 rounded-full bg-ola-primary-light px-2.5 py-1.5 text-xs font-semibold text-ola-primary-ink transition-colors hover:bg-ola-primary/15"
            >
              <MomentEyeIcon className="h-3.5 w-3.5" />
              {viewerCount}
            </button>
          ) : (
            <span
              title={viewerLabel}
              aria-label={viewerLabel}
              className="inline-flex shrink-0 items-center gap-1 px-1 text-xs text-black/54"
            >
              <MomentEyeIcon className="h-3.5 w-3.5" />
              {viewerCount}
            </span>
          )}
          {moment.reactions != null && (moment.reactionCount ?? 0) > 0 && (
            <MomentReactionSummary
              reactions={moment.reactions}
              total={moment.reactionCount ?? 0}
              onClick={active ? onReactions : undefined}
            />
          )}
          {(moment.commentCount ?? 0) > 0 && (
            <button
              type="button"
              title={t('moment.commentCount', {
                count: moment.commentCount ?? 0,
              })}
              aria-label={t('moment.commentCount', {
                count: moment.commentCount ?? 0,
              })}
              onClick={onComments}
              className="pointer-events-auto relative inline-flex shrink-0 items-center gap-1 rounded-full bg-ola-primary-light px-2.5 py-1.5 text-xs font-semibold text-ola-primary-ink transition-colors hover:bg-ola-primary/15"
            >
              <MomentCommentIcon className="h-3.5 w-3.5" />
              {formatCompactCount(moment.commentCount ?? 0, i18n.language)}
            </button>
          )}
        </div>
      </div>
    </li>
  );
}

function MomentManageSkeleton() {
  return (
    <ul className="flex flex-col gap-2.5" aria-hidden="true">
      {Array.from({ length: SKELETON_ROWS }, (_, index) => (
        <li
          key={index}
          className="flex animate-pulse gap-3 rounded-2xl bg-white p-2.5 shadow-sm ring-1 ring-black/5"
        >
          <span className="h-28 w-16 shrink-0 rounded-xl bg-black/8" />
          <span className="flex flex-1 flex-col gap-2 py-1">
            <span className="h-4 w-2/5 rounded bg-black/8" />
            <span className="h-3 w-1/4 rounded bg-black/6" />
            <span className="mt-auto flex justify-between">
              <span className="h-7 w-24 rounded-full bg-black/6" />
              <span className="h-7 w-16 rounded-full bg-black/6" />
            </span>
          </span>
        </li>
      ))}
    </ul>
  );
}

export function MomentManageView({ onClose }: { onClose: () => void }) {
  const { t, i18n } = useTranslation();
  const {
    moments,
    loaded,
    loading,
    hasMore,
    loadMore,
    clockMs,
    busyId,
    toggleHidden,
  } = useMomentManage();
  const [viewersId, setViewersId] = useState<string | null>(null);
  const [reactionsId, setReactionsId] = useState<string | null>(null);
  const [commentsId, setCommentsId] = useState<string | null>(null);
  const [viewerSession, setViewerSession] =
    useState<MomentViewerSession | null>(null);
  const [composerOpen, setComposerOpen] = useState(false);
  const formatTime = useMemo(
    () => createTimeAgoFormatter(i18n.language),
    [i18n.language]
  );

  function openMoment(moment: Moment) {
    setViewerSession({
      groups: [{ author: moment.author, moments: [] }],
      startIndex: 0,
      own: true,
      archive: true,
      startMomentId: moment.id,
    });
  }

  function renderContent() {
    if (!loaded && loading) return <MomentManageSkeleton />;
    if (moments.length === 0) {
      return (
        <div className="flex flex-col items-center gap-3 rounded-2xl bg-white px-4 py-10 text-center shadow-sm ring-1 ring-black/5">
          <span className="flex h-16 w-16 items-center justify-center rounded-full bg-ola-primary-light text-ola-primary-ink">
            <MomentImageIcon className="h-8 w-8" />
          </span>
          <p className="text-sm text-black/54">{t('moment.manageEmpty')}</p>
          <ActionButton
            onClick={() => setComposerOpen(true)}
            className="inline-flex items-center gap-1.5 px-4 py-1.5"
          >
            <MomentPlusIcon className="h-4 w-4" />
            {t('moment.add')}
          </ActionButton>
        </div>
      );
    }
    return (
      <>
        <ul className="flex flex-col gap-2.5">
          {moments.map((moment) => (
            <MomentManageRow
              key={moment.id}
              moment={moment}
              nowMs={clockMs}
              postedAt={formatTime(moment.createdAt)}
              busy={busyId === moment.id}
              onOpen={() => openMoment(moment)}
              onViewers={() => setViewersId(moment.id)}
              onReactions={() => setReactionsId(moment.id)}
              onComments={() => setCommentsId(moment.id)}
              onToggleHidden={() => void toggleHidden(moment)}
            />
          ))}
        </ul>
        {hasMore && (
          <div className="flex justify-center py-4">
            <ActionButton
              variant="outline"
              disabled={loading}
              onClick={loadMore}
            >
              {loading ? <Spinner size={18} /> : t('moment.historyMore')}
            </ActionButton>
          </div>
        )}
      </>
    );
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('moment.manageTitle')} onBack={onClose}>
        <button
          type="button"
          aria-label={t('moment.add')}
          onClick={() => setComposerOpen(true)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <MomentPlusIcon className="h-6 w-6" />
        </button>
      </ScreenHeader>
      <div className="min-h-0 flex-1 overflow-y-auto bg-ola-surface">
        <div className="mx-auto w-full max-w-2xl p-3">
          <p className="px-1 pb-2 text-xs text-black/54">
            {t('moment.manageHint')}
          </p>
          {renderContent()}
        </div>
      </div>

      <MomentViewersDialog
        open={viewersId != null}
        momentId={viewersId ?? ''}
        onClose={() => setViewersId(null)}
      />
      <MomentReactionsDialog
        open={reactionsId != null}
        momentId={reactionsId ?? ''}
        total={
          moments.find((moment) => moment.id === reactionsId)?.reactionCount ??
          0
        }
        onClose={() => setReactionsId(null)}
      />
      <MomentCommentsDialog
        open={commentsId != null}
        momentId={commentsId ?? ''}
        total={
          moments.find((moment) => moment.id === commentsId)?.commentCount ?? 0
        }
        onClose={() => setCommentsId(null)}
      />
      {viewerSession && (
        <MomentViewer
          session={viewerSession}
          onClose={() => setViewerSession(null)}
        />
      )}
      {composerOpen && (
        <MomentComposer onClose={() => setComposerOpen(false)} />
      )}
    </FullScreenOverlay>
  );
}
