import {
  useEffect,
  useMemo,
  useState,
  type ReactNode,
  type UIEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import type { ParseKeys } from 'i18next';
import {
  toast,
  colorForName,
  createTimeFormatter,
  avatarFrameNotificationText,
  isAvatarFrameNotification,
  isTransferNotification,
  transferNotificationContent,
  vipIconUrl,
} from '@lib';
import {
  ScreenHeader,
  FullScreenOverlay,
  Spinner,
  ConfirmDialog,
  UserName,
  CloseIcon,
} from '@components';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { APP_NOTIFICATION_TYPE, isSystemNotice } from '@constants';
import { MarriageService, RelationshipService } from '@services';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useFriendsStore } from '@ola/shared/stores/friends/friendsStore';
import { useMarriageStore } from '@ola/shared/stores/marriageStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import type { AppNotification } from '@app-types';
import icAddSmall from '@/assets/icons/notify/ic_action_add_small.png';
import icFriend from '@/assets/icons/notify/ic_notification_add_friend.png';
import icHeart from '@/assets/icons/notify/ic_notification_heart.png';
import icGift from '@/assets/games/egg/ic_gift.png';
import icKen from '@/assets/icons/apps/ken.png';
import icVip from '@/assets/icons/apps/vip-crown.webp';
import olaLogo from '@/assets/images/ola-logo.png';
import { AvatarFrameThumb } from '../avatar-frame/components/AvatarFrameThumb';

const NOTIFICATION_FRAME_BADGE_SIZE = 24;

const KIND_CONFIG: Record<string, { icon: string; messageKey: ParseKeys }> = {
  friend_request: { icon: icFriend, messageKey: 'notify.msg_friend' },
  marriage_proposal: { icon: icHeart, messageKey: 'notify.msg_proposal' },
  gift_received: { icon: icGift, messageKey: 'notify.msg_gift' },
  ken_received: { icon: icKen, messageKey: 'notify.msg_ken' },
  vip_received: { icon: icVip, messageKey: 'notify.msg_vip' },
};

function SystemAvatar() {
  return (
    <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-ola-primary">
      <img src={olaLogo} alt="" className="h-6 w-6 object-contain" />
    </span>
  );
}

interface RowButtonProps {
  variant: 'green' | 'default';
  disabled?: boolean;
  onClick: () => void;
  children: ReactNode;
}

function RowButton({ variant, disabled, onClick, children }: RowButtonProps) {
  const cls =
    variant === 'green'
      ? 'bg-ola-button text-ola-on-primary'
      : 'ml-2 bg-[#e0e0e0] text-[#636363]';
  return (
    <button
      type="button"
      disabled={disabled}
      onClick={onClick}
      className={`flex h-7 min-w-16 flex-1 items-center justify-center rounded-sm text-xs disabled:opacity-50 ${cls}`}
    >
      {children}
    </button>
  );
}

type ProposalAction = { item: AppNotification; kind: 'accept' | 'deny' } | null;

export function NotificationsPage({ onClose }: { onClose: () => void }) {
  const { t, i18n } = useTranslation();
  const items = useAppNotificationStore((s) => s.items);
  const loading = useAppNotificationStore((s) => s.loading);
  const load = useAppNotificationStore((s) => s.load);
  const loadMore = useAppNotificationStore((s) => s.loadMore);
  const markAllRead = useAppNotificationStore((s) => s.markAllRead);
  const removeLocal = useAppNotificationStore((s) => s.removeLocal);
  const hide = useAppNotificationStore((s) => s.hide);
  const pushOverlay = useAppOverlayStore((s) => s.push);

  const [busyId, setBusyId] = useState<string | null>(null);
  const [proposalAction, setProposalAction] = useState<ProposalAction>(null);

  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );

  useEffect(() => {
    void load().then(() => markAllRead());
  }, [load, markAllRead]);

  function handleScroll(event: UIEvent<HTMLDivElement>) {
    const el = event.currentTarget;
    if (el.scrollHeight - el.scrollTop - el.clientHeight < 200) void loadMore();
  }

  async function runAction(item: AppNotification, action: () => Promise<void>) {
    if (busyId != null) return;
    setBusyId(item.id);
    try {
      await action();
      removeLocal(item.id);
    } catch {
      toast.error(t('notify.actionError'));
      void load();
    } finally {
      setBusyId(null);
    }
  }

  function respondFriendRequest(item: AppNotification, accept: boolean) {
    if (item.refId == null) return;
    const refId = item.refId;
    void runAction(item, async () => {
      await RelationshipService.respond(refId, accept ? 'accept' : 'reject');
      void useFriendsStore.getState().loadRequests();
      if (accept) void useFriendsStore.getState().loadFriends();
    });
  }

  function confirmProposal() {
    if (proposalAction == null) return;
    const { item, kind } = proposalAction;
    setProposalAction(null);
    if (item.refId == null) return;
    const refId = item.refId;
    void runAction(item, async () => {
      if (kind === 'accept') {
        await MarriageService.accept(refId);
        toast.success(
          t('marriage.acceptedToast', { nick: item.actor?.username ?? '' })
        );
      } else {
        await MarriageService.reject(refId);
      }
      void useMarriageStore.getState().load();
    });
  }

  function renderActions(item: AppNotification) {
    if (item.refId == null) return null;
    if (item.type === APP_NOTIFICATION_TYPE.friendRequest) {
      return (
        <div className="mt-1 flex">
          <RowButton
            variant="green"
            disabled={busyId != null}
            onClick={() => respondFriendRequest(item, true)}
          >
            <img
              src={icAddSmall}
              alt=""
              className="mr-1 h-3 w-3 object-contain"
            />
            {t('notify.addFriend')}
          </RowButton>
          <RowButton
            variant="default"
            disabled={busyId != null}
            onClick={() => respondFriendRequest(item, false)}
          >
            {t('notify.decline')}
          </RowButton>
        </div>
      );
    }
    if (item.type === APP_NOTIFICATION_TYPE.marriageProposal) {
      return (
        <div className="mt-1 flex">
          <RowButton
            variant="green"
            disabled={busyId != null}
            onClick={() => setProposalAction({ item, kind: 'accept' })}
          >
            {t('notify.agree')}
          </RowButton>
          <RowButton
            variant="default"
            disabled={busyId != null}
            onClick={() => setProposalAction({ item, kind: 'deny' })}
          >
            {t('notify.decline')}
          </RowButton>
        </div>
      );
    }
    return null;
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('notify.title')} onBack={onClose} />

      <div
        className="flex-1 overflow-y-auto bg-ola-border-strong"
        onScroll={handleScroll}
      >
        {loading && items.length === 0 ? (
          <div className="flex justify-center py-10">
            <Spinner size={24} />
          </div>
        ) : items.length === 0 ? (
          <div className="py-16 text-center text-sm text-black/54">
            {t('notify.empty')}
          </div>
        ) : (
          <ul>
            {items.map((item) => {
              const config = KIND_CONFIG[item.type];
              const system = isSystemNotice(item.type);
              const actor = system ? undefined : item.actor;
              const name = system
                ? t('notify.systemSender')
                : actor?.fullName || actor?.username || '';
              const handle = actor != null ? `@${actor.username}` : name;
              const transfer = transferNotificationContent(t, item);
              const message =
                transfer?.text ??
                avatarFrameNotificationText(t, item) ??
                (config != null ? t(config.messageKey) : item.preview ?? '');
              const frameNotification = isAvatarFrameNotification(item.type);
              const receivedFrameId = frameNotification
                ? item.transfer?.frameId
                : undefined;
              const openTarget = frameNotification
                ? () => pushOverlay('avatarFrameStore')
                : undefined;
              const badge = transfer?.badge;
              const badgeIsVipIcon =
                badge?.kind === 'vip' && badge.vipTypeId != null;
              const showPreview =
                config != null &&
                !isTransferNotification(item.type) &&
                item.preview != null &&
                item.preview !== '';
              return (
                <li key={item.id} className="bg-white/80">
                  <div
                    onClick={openTarget}
                    className={`flex min-h-[72px] items-start p-4 ${
                      openTarget != null ? 'cursor-pointer active:bg-black/5' : ''
                    }`}
                  >
                    {system ? (
                      <SystemAvatar />
                    ) : (
                      <AvatarWithFrame
                        name={name}
                        src={item.actor?.avatar}
                        color={colorForName(name)}
                        frameId={item.actor?.avatarFrameId}
                      />
                    )}
                    <div className="ml-4 min-w-0 flex-1">
                      <div className="flex items-center gap-2">
                        <UserName
                          name={handle}
                          fullName={actor?.fullName}
                          className="min-w-0 flex-1 truncate text-base font-bold text-black/87"
                          fullNameClassName="font-normal text-black/54"
                        />
                        <div className="flex shrink-0 items-center gap-1">
                          {config != null && (
                            <img
                              src={config.icon}
                              alt=""
                              className="h-[18px] w-[18px] shrink-0 object-contain"
                            />
                          )}
                          <span className="text-xs text-black/54">
                            {formatTime(item.createdAt)}
                          </span>
                        </div>
                      </div>
                      <p className="mt-1 flex items-center gap-1 text-sm leading-snug text-black/87">
                        <span className="min-w-0">{message}</span>
                        {receivedFrameId != null && receivedFrameId !== '' && (
                          <AvatarFrameThumb
                            frameId={receivedFrameId}
                            size={NOTIFICATION_FRAME_BADGE_SIZE}
                          />
                        )}
                        {badge != null && (
                          <img
                            src={
                              badge.kind === 'ken'
                                ? icKen
                                : badge.vipTypeId != null
                                  ? vipIconUrl(badge.vipTypeId)
                                  : icVip
                            }
                            alt=""
                            className={
                              badgeIsVipIcon
                                ? '-my-1 h-6 w-6 shrink-0 object-contain'
                                : 'h-4 w-4 shrink-0 object-contain'
                            }
                          />
                        )}
                      </p>
                      {showPreview && (
                        <p className="mt-0.5 truncate text-sm text-black/54">
                          {item.preview}
                        </p>
                      )}

                      {renderActions(item)}
                    </div>
                    {busyId === item.id && <Spinner size={16} />}
                    {system && (
                      <button
                        type="button"
                        onClick={() => void hide(item.id)}
                        aria-label={t('notify.hide')}
                        title={t('notify.hide')}
                        className="-mt-2 -mr-2 ml-2 flex h-8 w-8 shrink-0 items-center justify-center rounded-full text-black/54 transition-colors hover:bg-black/5"
                      >
                        <CloseIcon className="h-3.5 w-3.5" strokeWidth={2.5} />
                      </button>
                    )}
                  </div>
                  <div className="mx-4 h-px bg-black/12" />
                </li>
              );
            })}
          </ul>
        )}
      </div>

      <ConfirmDialog
        open={proposalAction != null}
        title={t('marriage.boxTitle')}
        message={
          proposalAction?.kind === 'deny'
            ? t('marriage.confirmDeny', {
                nick: proposalAction?.item.actor?.username ?? '',
              })
            : t('marriage.confirmAccept', {
                nick: proposalAction?.item.actor?.username ?? '',
              })
        }
        confirmLabel={
          proposalAction?.kind === 'deny'
            ? t('marriage.deny')
            : t('marriage.accept')
        }
        cancelLabel={t('marriage.no')}
        danger={proposalAction?.kind === 'deny'}
        onConfirm={confirmProposal}
        onCancel={() => setProposalAction(null)}
      />
    </FullScreenOverlay>
  );
}
