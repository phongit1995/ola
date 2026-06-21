import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActionButton,
  Avatar,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
  UserName,
  VipIcon,
} from '@components';
import { activeVipTypeId, colorForName, createTimeFormatter } from '@lib';
import type { Relationship } from '@app-types';

interface FriendRequestsScreenProps {
  requests: Relationship[];
  loading: boolean;
  onAccept: (relationship: Relationship) => Promise<void>;
  onDecline: (relationship: Relationship) => Promise<void>;
  onClose: () => void;
}

export function FriendRequestsScreen({
  requests,
  loading,
  onAccept,
  onDecline,
  onClose,
}: FriendRequestsScreenProps) {
  const { t, i18n } = useTranslation();
  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const [busyIds, setBusyIds] = useState<string[]>([]);

  const run = async (
    relationship: Relationship,
    action: (relationship: Relationship) => Promise<void>,
  ) => {
    if (busyIds.includes(relationship.id)) return;
    setBusyIds((prev) => [...prev, relationship.id]);
    try {
      await action(relationship);
    } finally {
      setBusyIds((prev) => prev.filter((id) => id !== relationship.id));
    }
  };

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={t('chat.friendRequests')} onBack={onClose} align="center" />

      <div className="flex-1 overflow-y-auto">
        {loading ? (
          <div className="flex h-full items-center justify-center">
            <Spinner size={32} />
          </div>
        ) : requests.length === 0 ? (
          <p className="px-4 py-10 text-center text-sm text-black/54">
            {t('chat.friendRequestEmpty')}
          </p>
        ) : (
          <ul>
            {requests.map((relationship) => {
              const requester = relationship.requester;
              const name = requester?.fullName || requester?.username || '';
              const vipTypeId = activeVipTypeId(requester?.vipUsed, requester?.vipEndTime);
              const busy = busyIds.includes(relationship.id);
              return (
                <li
                  key={relationship.id}
                  className="flex items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-3"
                >
                  {requester?.avatar ? (
                    <img
                      src={requester.avatar}
                      alt=""
                      className="h-14 w-14 shrink-0 rounded-full object-cover"
                    />
                  ) : (
                    <Avatar name={name} color={colorForName(requester?.id ?? name)} size={56} />
                  )}
                  <div className="min-w-0 flex-1">
                    <span className="flex min-w-0 items-center gap-1">
                      {vipTypeId != null && <VipIcon typeId={vipTypeId} className="h-5 w-5" />}
                      <UserName
                        name={`@${requester?.username ?? ''}`}
                        fullName={requester?.fullName}
                        className="min-w-0 truncate text-base text-black/87"
                        fullNameClassName="text-black/45"
                      />
                    </span>
                    <span className="block truncate text-xs text-black/54">
                      {formatTime(relationship.createdAt)}
                    </span>
                  </div>
                  <div className="flex shrink-0 items-center gap-2">
                    <ActionButton
                      variant="filled"
                      disabled={busy}
                      onClick={() => void run(relationship, onAccept)}
                      className="min-w-[76px] text-center"
                    >
                      {t('chat.acceptRequest')}
                    </ActionButton>
                    <ActionButton
                      variant="outline"
                      disabled={busy}
                      onClick={() => void run(relationship, onDecline)}
                      className="min-w-[76px] text-center"
                    >
                      {t('chat.declineRequest')}
                    </ActionButton>
                  </div>
                </li>
              );
            })}
          </ul>
        )}
      </div>
    </FullScreenOverlay>
  );
}
