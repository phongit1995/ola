import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { RelationshipService, UserService } from '@ola/shared/services';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { UserSearchResult } from '@ola/shared/types';
import { Avatar } from '@components/ui/Avatar';
import { UserListDialog } from '@components/ui/UserListDialog';

interface AddContactDialogProps {
  onClose: () => void;
  onOpenProfile?: (username: string) => void;
}

export function AddContactDialog({ onClose, onOpenProfile }: AddContactDialogProps) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [sentIds, setSentIds] = useState<string[]>([]);
  const [acceptedIds, setAcceptedIds] = useState<string[]>([]);
  const [busyId, setBusyId] = useState<string | null>(null);

  useEffect(() => {
    const value = query.trim();
    const timer = setTimeout(() => {
      if (value === '') {
        setResults([]);
        setLoading(false);
        return;
      }
      setLoading(true);
      UserService.search(value, 30)
        .then((result) => setResults(result.users))
        .catch(() => push('error', t('chat.searchError')))
        .finally(() => setLoading(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, push, t]);

  async function sendRequest(user: UserSearchResult) {
    setBusyId(user.id);
    try {
      await RelationshipService.sendRequest(user.id);
      setSentIds((ids) => [...ids, user.id]);
      push('success', t('chat.friendRequestSent'));
    } catch {
      push('error', t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  async function acceptRequest(user: UserSearchResult) {
    if (user.requestId == null) return;
    setBusyId(user.id);
    try {
      await RelationshipService.respond(user.requestId, 'accept');
      setAcceptedIds((ids) => [...ids, user.id]);
      push('success', t('chat.requestAccepted'));
    } catch {
      push('error', t('chat.actionError'));
    } finally {
      setBusyId(null);
    }
  }

  function renderRelationButton(user: UserSearchResult) {
    const busy = busyId === user.id;
    const disabledStyle = { borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' } as const;
    if (acceptedIds.includes(user.id) || user.relationship === 'friend') {
      return (
        <View className="rounded px-3 py-1.5" style={disabledStyle}>
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>{t('chat.alreadyFriendShort')}</Text>
        </View>
      );
    }
    if (sentIds.includes(user.id) || user.relationship === 'pending_outgoing') {
      return (
        <View className="rounded px-3 py-1.5" style={disabledStyle}>
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>{t('chat.friendRequestSentShort')}</Text>
        </View>
      );
    }
    if (user.relationship === 'pending_incoming') {
      return (
        <Pressable
          disabled={busy}
          onPress={() => void acceptRequest(user)}
          className="rounded px-3 py-1.5"
          style={{ borderWidth: 1, borderColor: '#7cb342', opacity: busy ? 0.5 : 1 }}
        >
          <Text className="text-sm font-medium" style={{ color: '#7cb342' }}>{t('chat.acceptRequest')}</Text>
        </Pressable>
      );
    }
    if (user.relationship === 'blocked_by_me') {
      return (
        <View className="rounded px-3 py-1.5" style={disabledStyle}>
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.38)' }}>{t('chat.blocked')}</Text>
        </View>
      );
    }
    if (user.relationship === 'blocked_by_them') {
      return null;
    }
    return (
      <Pressable
        disabled={busy}
        onPress={() => void sendRequest(user)}
        className="rounded px-3 py-1.5"
        style={{ borderWidth: 1, borderColor: '#7cb342', opacity: busy ? 0.5 : 1 }}
      >
        <Text className="text-sm font-medium" style={{ color: '#7cb342' }}>{t('chat.menuMakeFriend')}</Text>
      </Pressable>
    );
  }

  const emptyMessage = query.trim() === '' ? t('chat.addContactHint') : t('chat.addContactEmpty');

  return (
    <UserListDialog
      visible
      title={t('chat.menuAddContact')}
      onClose={onClose}
      loading={loading}
      isEmpty={results.length === 0}
      empty={
        <Text className="py-6 text-center text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
          {emptyMessage}
        </Text>
      }
      search={{
        value: query,
        onChange: setQuery,
        placeholder: t('chat.addContactSearchPlaceholder'),
        autoFocus: true,
      }}
      listMaxHeight={320}
    >
      {results.map((item) => (
        <View key={item.id} className="flex-row items-center gap-3 py-2">
          <Pressable
            className="min-w-0 flex-1 flex-row items-center gap-3"
            onPress={() => onOpenProfile?.(item.username)}
          >
            <View className="relative">
              <Avatar name={item.fullName || item.username} uri={item.avatar ?? undefined} size={40} />
              {item.isOnline && (
                <View
                  className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary"
                  style={{ borderWidth: 2, borderColor: '#fff' }}
                />
              )}
            </View>
            <View className="min-w-0 flex-1">
              <Text numberOfLines={1} className="text-base" style={{ color: 'rgba(0,0,0,0.87)' }}>
                {item.fullName || item.username}
              </Text>
              <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
                @{item.username}
              </Text>
            </View>
          </Pressable>
          {renderRelationButton(item)}
        </View>
      ))}
    </UserListDialog>
  );
}
