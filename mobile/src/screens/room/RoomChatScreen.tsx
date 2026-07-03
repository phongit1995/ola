import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Platform,
  Pressable,
  Text,
  TextInput,
  View,
} from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useRoomChatStore } from '@ola/shared/stores/roomChatStore';
import { createTimeFormatter } from '@ola/shared/lib';
import type { RoomMember, RoomMessage } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { Avatar } from '../../components/Avatar';

type Props = NativeStackScreenProps<RootStackParamList, 'RoomChat'>;

function RoomMessageRow({ message, timeLabel }: { message: RoomMessage; timeLabel: string }) {
  return (
    <View className="flex-row gap-2 px-3 py-1.5">
      <Avatar name={message.senderName ?? ''} uri={message.senderAvatar} size={32} />
      <View className="flex-1">
        <View className="flex-row items-center gap-2">
          <Text className="text-sm font-semibold text-ola-primary-dark">
            {message.senderName ?? ''}
          </Text>
          <Text className="text-[10px] text-neutral-400">{timeLabel}</Text>
        </View>
        <Text className="text-base text-neutral-900">{message.content}</Text>
      </View>
    </View>
  );
}

function MemberRow({ member }: { member: RoomMember }) {
  return (
    <View className="flex-row items-center gap-3 px-4 py-2">
      <Avatar name={member.fullName ?? member.username} uri={member.avatar} size={40} />
      <View className="flex-1">
        <Text className="text-base text-neutral-900" numberOfLines={1}>
          {member.fullName ?? member.username}
        </Text>
        {member.bio != null && member.bio !== '' && (
          <Text className="text-xs text-neutral-500" numberOfLines={1}>
            {member.bio}
          </Text>
        )}
      </View>
    </View>
  );
}

export function RoomChatScreen({ navigation, route }: Props) {
  const { roomId, roomName } = route.params;
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();

  const status = useRoomChatStore((s) => s.status);
  const activeTab = useRoomChatStore((s) => s.activeTab);
  const messages = useRoomChatStore((s) => s.messages);
  const members = useRoomChatStore((s) => s.members);
  const memberCount = useRoomChatStore((s) => s.memberCount);
  const open = useRoomChatStore((s) => s.open);
  const close = useRoomChatStore((s) => s.close);
  const setActiveTab = useRoomChatStore((s) => s.setActiveTab);
  const setRoomForeground = useRoomChatStore((s) => s.setRoomForeground);
  const sendMessage = useRoomChatStore((s) => s.sendMessage);
  const loadMoreMessages = useRoomChatStore((s) => s.loadMoreMessages);

  const [draft, setDraft] = useState('');

  useEffect(() => {
    void open({ id: roomId, name: roomName });
    setRoomForeground(true);
    return () => {
      setRoomForeground(false);
      close();
    };
  }, [roomId, roomName, open, close, setRoomForeground]);

  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);
  const invertedMessages = useMemo(() => [...messages].reverse(), [messages]);

  function handleSend() {
    const content = draft.trim();
    if (content === '') return;
    setDraft('');
    void sendMessage(content);
  }

  return (
    <KeyboardAvoidingView
      className="flex-1 bg-white"
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <View
        className="border-b border-neutral-200 bg-ola-primary px-2 pb-2"
        style={{ paddingTop: insets.top + 8 }}
      >
        <View className="flex-row items-center gap-2">
          <Pressable className="px-2 py-1" onPress={() => navigation.goBack()}>
            <Text className="text-xl text-white">‹</Text>
          </Pressable>
          <Text className="flex-1 text-base font-semibold text-white" numberOfLines={1}>
            {roomName}
          </Text>
        </View>
        <View className="mt-1 flex-row">
          <Pressable
            className={`flex-1 items-center border-b-2 pb-1 ${activeTab === 'members' ? 'border-white' : 'border-transparent'}`}
            onPress={() => setActiveTab('members')}
          >
            <Text className="text-sm font-semibold text-white">
              {`${t('room.tabMembers')} (${memberCount})`}
            </Text>
          </Pressable>
          <Pressable
            className={`flex-1 items-center border-b-2 pb-1 ${activeTab === 'messages' ? 'border-white' : 'border-transparent'}`}
            onPress={() => setActiveTab('messages')}
          >
            <Text className="text-sm font-semibold text-white">{t('room.tabMessages')}</Text>
          </Pressable>
        </View>
      </View>

      {status === 'connecting' ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : status === 'error' ? (
        <View className="flex-1 items-center justify-center px-8">
          <Text className="text-center text-sm text-neutral-500">{t('common.error')}</Text>
        </View>
      ) : activeTab === 'members' ? (
        <FlashList
          data={members}
          keyExtractor={(item) => item.userId}
          renderItem={({ item }) => <MemberRow member={item} />}
        />
      ) : (
        <FlashList
          data={invertedMessages}
          inverted
          keyExtractor={(item) => item.id}
          onEndReached={() => void loadMoreMessages()}
          onEndReachedThreshold={0.3}
          renderItem={({ item }) => (
            <RoomMessageRow message={item} timeLabel={timeFormatter(item.createdAt)} />
          )}
        />
      )}

      {status === 'joined' && activeTab === 'messages' && (
        <View
          className="flex-row items-end gap-2 border-t border-neutral-200 px-3 py-2"
          style={{ paddingBottom: Math.max(insets.bottom, 8) }}
        >
          <TextInput
            className="max-h-24 flex-1 rounded-2xl bg-neutral-100 px-4 py-2 text-base text-neutral-900"
            placeholder={t('chat.messageInputPlaceholder')}
            placeholderTextColor="#9ca3af"
            multiline
            value={draft}
            onChangeText={setDraft}
          />
          <Pressable
            className="h-10 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-80"
            onPress={handleSend}
          >
            <Text className="font-semibold text-white">➤</Text>
          </Pressable>
        </View>
      )}
    </KeyboardAvoidingView>
  );
}
