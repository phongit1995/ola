import {
  useEffect,
  useMemo,
  useState,
  type ReactNode,
  type UIEvent,
} from 'react';
import { useTranslation } from 'react-i18next';
import type { ParseKeys } from 'i18next';
import { toast, colorForName, createTimeFormatter } from '@lib';
import {
  ScreenHeader,
  FullScreenOverlay,
  Avatar,
  Spinner,
  ConfirmDialog,
} from '@components';
import { MarriageService, RelationshipService } from '@services';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { useFriendsStore } from '@/store/friendsStore';
import { useMarriageStore } from '@/store/marriageStore';
import type { AppNotification } from '@app-types';
import icAddSmall from '@/assets/icons/notify/ic_action_add_small.png';
import icFriend from '@/assets/icons/notify/ic_notification_add_friend.png';
import icHeart from '@/assets/icons/notify/ic_notification_heart.png';

const KIND_CONFIG: Record<string, { icon: string; messageKey: ParseKeys }> = {
  friend_request: { icon: icFriend, messageKey: 'notify.msg_friend' },
  marriage_proposal: { icon: icHeart, messageKey: 'notify.msg_proposal' },
};

interface RowButtonProps {
  variant: 'green' | 'default';
  disabled?: boolean;
  onClick: () => void;
  children: ReactNode;
}

function RowButton({ variant, disabled, onClick, children }: RowButtonProps) {
  const cls =
    variant === 'green'
      ? 'bg-[#9ccc65] text-white'
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
    if (item.type === 'friend_request') {
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
    if (item.type === 'marriage_proposal') {
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
        className="flex-1 overflow-y-auto bg-[#d5d5d5]"
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
              const name = item.actor?.fullName || item.actor?.username || '';
              const message =
                config != null ? t(config.messageKey) : item.preview ?? '';
              return (
                <li key={item.id} className="bg-white/80">
                  <div className="flex min-h-[72px] items-start p-4">
                    <Avatar
                      name={name}
                      src={item.actor?.avatar}
                      color={colorForName(name)}
                    />
                    <div className="ml-4 min-w-0 flex-1">
                      {name !== '' && (
                        <p className="truncate text-base font-bold text-black/87">
                          {name}
                        </p>
                      )}
                      <p className="mt-1 text-sm leading-snug text-black/87">
                        {message}
                      </p>
                      {config != null &&
                        item.preview != null &&
                        item.preview !== '' && (
                          <p className="mt-0.5 truncate text-sm text-black/54">
                            {item.preview}
                          </p>
                        )}

                      {renderActions(item)}

                      <div className="mt-1 flex items-center gap-1">
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
                    {busyId === item.id && <Spinner size={16} />}
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
