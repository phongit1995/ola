import { useEffect, useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { ParseKeys } from 'i18next';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { useFriendsStore } from '@ola/shared/stores/friendsStore';
import { useMarriageStore } from '@ola/shared/stores/marriageStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { MarriageService, RelationshipService } from '@ola/shared/services';
import { createTimeFormatter } from '@ola/shared/lib';
import type { AppNotification } from '@ola/shared/types';
import { Avatar } from '@components/Avatar';
import { ConfirmDialog } from '@components/ConfirmDialog';
import { ScreenHeader } from '@components/ScreenHeader';

const icFriend = require('@assets/icons/notify/ic_notification_add_friend.png');
const icHeart = require('@assets/icons/notify/ic_notification_heart.png');

const KIND_CONFIG: Record<string, { icon: number; messageKey: ParseKeys }> = {
  friend_request: { icon: icFriend, messageKey: 'notify.msg_friend' },
  marriage_proposal: { icon: icHeart, messageKey: 'notify.msg_proposal' },
};

interface RowButtonProps {
  variant: 'green' | 'default';
  disabled?: boolean;
  onPress: () => void;
  children: ReactNode;
}

function RowButton({ variant, disabled, onPress, children }: RowButtonProps) {
  const isGreen = variant === 'green';
  return (
    <Pressable
      disabled={disabled}
      onPress={onPress}
      className={`h-7 min-w-16 flex-1 items-center justify-center rounded-sm ${isGreen ? 'bg-[#9ccc65]' : 'ml-2 bg-[#e0e0e0]'} ${disabled ? 'opacity-50' : ''}`}
    >
      <Text className={`text-xs ${isGreen ? 'text-white' : 'text-[#636363]'}`}>{children}</Text>
    </Pressable>
  );
}

function NotificationSeparator() {
  return <View style={{ height: 1, marginHorizontal: 16, backgroundColor: 'rgba(0,0,0,0.12)' }} />;
}

type ProposalAction = { item: AppNotification; kind: 'accept' | 'deny' } | null;

export function NotificationsScreen() {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation();
  const push = useToastStore((s) => s.push);
  const items = useAppNotificationStore((s) => s.items);
  const loading = useAppNotificationStore((s) => s.loading);
  const loadingMore = useAppNotificationStore((s) => s.loadingMore);
  const load = useAppNotificationStore((s) => s.load);
  const loadMore = useAppNotificationStore((s) => s.loadMore);
  const markAllRead = useAppNotificationStore((s) => s.markAllRead);
  const removeLocal = useAppNotificationStore((s) => s.removeLocal);

  const [busyId, setBusyId] = useState<string | null>(null);
  const [proposalAction, setProposalAction] = useState<ProposalAction>(null);

  const formatTime = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  useEffect(() => {
    void load().then(() => markAllRead());
  }, [load, markAllRead]);

  async function runAction(item: AppNotification, action: () => Promise<void>) {
    if (busyId != null) return;
    setBusyId(item.id);
    try {
      await action();
      removeLocal(item.id);
    } catch {
      push('error', t('notify.actionError'));
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
        push('success', t('marriage.acceptedToast', { nick: item.actor?.username ?? '' }));
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
        <View className="mt-1 flex-row">
          <RowButton variant="green" disabled={busyId != null} onPress={() => respondFriendRequest(item, true)}>
            {t('notify.addFriend')}
          </RowButton>
          <RowButton variant="default" disabled={busyId != null} onPress={() => respondFriendRequest(item, false)}>
            {t('notify.decline')}
          </RowButton>
        </View>
      );
    }
    if (item.type === 'marriage_proposal') {
      return (
        <View className="mt-1 flex-row">
          <RowButton variant="green" disabled={busyId != null} onPress={() => setProposalAction({ item, kind: 'accept' })}>
            {t('notify.agree')}
          </RowButton>
          <RowButton variant="default" disabled={busyId != null} onPress={() => setProposalAction({ item, kind: 'deny' })}>
            {t('notify.decline')}
          </RowButton>
        </View>
      );
    }
    return null;
  }

  return (
    <View className="flex-1 bg-[#d5d5d5]">
      <ScreenHeader title={t('notify.title')} onBack={() => navigation.goBack()} />

      {loading && items.length === 0 ? (
        <ActivityIndicator className="py-10" color="#7cb342" />
      ) : items.length === 0 ? (
        <Text className="py-16 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {t('notify.empty')}
        </Text>
      ) : (
        <FlashList
          data={items}
          keyExtractor={(item) => item.id}
          onEndReached={() => void loadMore()}
          onEndReachedThreshold={0.4}
          ItemSeparatorComponent={NotificationSeparator}
          ListFooterComponent={loadingMore ? <ActivityIndicator className="my-4" color="#7cb342" /> : null}
          renderItem={({ item }) => {
            const config = KIND_CONFIG[item.type];
            const name = item.actor?.fullName || item.actor?.username || '';
            const message = config != null ? t(config.messageKey) : item.preview ?? '';
            return (
              <View className="min-h-[72px] flex-row items-start bg-white/80 p-4">
                <Avatar name={name} uri={item.actor?.avatar ?? undefined} size={40} />
                <View className="ml-4 min-w-0 flex-1">
                  {name !== '' && (
                    <Text numberOfLines={1} className="text-base font-bold" style={{ color: 'rgba(0,0,0,0.87)' }}>
                      {name}
                    </Text>
                  )}
                  <Text className="mt-1 text-sm leading-snug" style={{ color: 'rgba(0,0,0,0.87)' }}>
                    {message}
                  </Text>
                  {config != null && item.preview != null && item.preview !== '' && (
                    <Text numberOfLines={1} className="mt-0.5 text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
                      {item.preview}
                    </Text>
                  )}

                  {renderActions(item)}

                  <View className="mt-1 flex-row items-center gap-1">
                    {config != null && (
                      <Image source={config.icon} style={{ width: 18, height: 18 }} resizeMode="contain" />
                    )}
                    <Text className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                      {formatTime(item.createdAt)}
                    </Text>
                  </View>
                </View>
                {busyId === item.id && <ActivityIndicator color="#7cb342" />}
              </View>
            );
          }}
        />
      )}

      <ConfirmDialog
        visible={proposalAction != null}
        title={t('marriage.boxTitle')}
        message={
          proposalAction?.kind === 'deny'
            ? t('marriage.confirmDeny', { nick: proposalAction?.item.actor?.username ?? '' })
            : t('marriage.confirmAccept', { nick: proposalAction?.item.actor?.username ?? '' })
        }
        confirmLabel={proposalAction?.kind === 'deny' ? t('marriage.deny') : t('marriage.accept')}
        cancelLabel={t('marriage.no')}
        danger={proposalAction?.kind === 'deny'}
        onConfirm={confirmProposal}
        onCancel={() => setProposalAction(null)}
      />
    </View>
  );
}
