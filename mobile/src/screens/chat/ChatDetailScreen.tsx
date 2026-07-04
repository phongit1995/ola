import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  KeyboardAvoidingView,
  NativeScrollEvent,
  NativeSyntheticEvent,
  Platform,
  Pressable,
  Text,
  TextInput,
  View,
} from 'react-native';
import { FlashList, type FlashListRef } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { currentUserId } from '@ola/shared/stores/chat/chatHelpers';
import { createTimeFormatter } from '@ola/shared/lib';
import type { Message, ReactionType } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { Avatar } from '../../components/Avatar';
import { kulToken } from '../../lib/kul';
import { ChatMessageRow } from './ChatMessageRow';
import { SmileyKulPanel } from '../room/SmileyKulPanel';
import { MessageActionSheet, type MessageSheetAction } from '../room/MessageActionSheet';

const backIcon = require('../../assets/icons/ic_back.png');
const likeIcon = require('../../assets/icons/chat/smiley/smiley_35.png');
const smileyIcon = require('../../assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('../../assets/icons/chat/ic_smiley_selected.png');
const kulIcon = require('../../assets/icons/chat/ic_kul.png');
const kulIconActive = require('../../assets/icons/chat/ic_kul_selected.png');
const deleteActionIcon = require('../../assets/icons/chat/ic_menu_delete.png');

const CHAT_BG = '#ECE5DD';
const DIVIDER = 'rgba(0,0,0,0.12)';

type Props = NativeStackScreenProps<RootStackParamList, 'ChatDetail'>;

export function ChatDetailScreen({ navigation, route }: Props) {
  const { conversationId } = route.params;
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();

  const conversations = useChatStore((s) => s.conversations);
  const messages = useChatStore((s) => s.messages);
  const loadingMessages = useChatStore((s) => s.loadingMessages);
  const hasMore = useChatStore((s) => s.hasMore);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const openConversation = useChatStore((s) => s.openConversation);
  const closeConversation = useChatStore((s) => s.closeConversation);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const sendText = useChatStore((s) => s.sendText);
  const resendMessage = useChatStore((s) => s.resendMessage);
  const reactToMessage = useChatStore((s) => s.reactToMessage);
  const deleteMessage = useChatStore((s) => s.deleteMessage);
  const notifyTyping = useChatStore((s) => s.notifyTyping);

  const [draft, setDraft] = useState('');
  const [openTab, setOpenTab] = useState<'smiley' | 'kul' | null>(null);
  const [actionTarget, setActionTarget] = useState<Message | null>(null);
  const listRef = useRef<FlashListRef<Message>>(null);
  const stickToBottomRef = useRef(true);

  useEffect(() => {
    void openConversation(conversationId);
    return () => closeConversation();
  }, [conversationId, openConversation, closeConversation]);

  const conversation = conversations.find((item) => item.id === conversationId);
  const title =
    conversation?.otherUser?.fullName ??
    conversation?.otherUser?.username ??
    conversation?.name ??
    '';
  const peerAvatar = conversation?.otherUser?.avatar;
  const myId = currentUserId();
  const timeFormatter = useMemo(() => createTimeFormatter(i18n.language), [i18n.language]);

  const lastOwnId = useMemo(() => {
    for (let i = messages.length - 1; i >= 0; i -= 1) {
      if (messages[i]!.senderId === myId) return messages[i]!.id;
    }
    return null;
  }, [messages, myId]);

  const scrollToEnd = useCallback(() => {
    if (stickToBottomRef.current) {
      requestAnimationFrame(() => listRef.current?.scrollToEnd({ animated: false }));
    }
  }, []);

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    const { contentOffset, contentSize, layoutMeasurement } = event.nativeEvent;
    stickToBottomRef.current = contentSize.height - contentOffset.y - layoutMeasurement.height < 80;
    if (contentOffset.y < 80 && hasMore) void loadMoreMessages();
  }

  async function send(text: string) {
    const trimmed = text.trim();
    if (trimmed === '') return;
    stickToBottomRef.current = true;
    setDraft('');
    setOpenTab(null);
    await sendText(trimmed);
  }

  const isTyping = draft.trim() !== '';

  function sheetActions(message: Message): MessageSheetAction[] {
    if (message.senderId !== myId) return [];
    return [
      {
        key: 'delete',
        label: t('chat.actionDelete'),
        icon: deleteActionIcon,
        destructive: true,
        onSelect: () => void deleteMessage(message.id),
      },
    ];
  }

  return (
    <KeyboardAvoidingView
      className="flex-1"
      style={{ backgroundColor: CHAT_BG }}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <View className="bg-ola-primary px-2 pb-2" style={{ paddingTop: insets.top + 8 }}>
        <View className="h-9 flex-row items-center gap-2">
          <Pressable
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          <Avatar name={title} uri={peerAvatar} size={32} />
          <View className="flex-1">
            <Text className="text-sm font-bold text-white" numberOfLines={1}>
              {title}
            </Text>
            {typingUsers.length > 0 ? (
              <Text className="text-xs text-white/70">
                {t('chat.typing', { name: typingUsers[0]?.username ?? '' })}
              </Text>
            ) : conversation?.otherUser?.isOnline === true ? (
              <Text className="text-xs text-white/70">{t('chat.online')}</Text>
            ) : null}
          </View>
        </View>
      </View>

      {loadingMessages ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <FlashList
          ref={listRef}
          data={messages}
          keyExtractor={(item) => item.clientMsgId ?? item.id}
          onScroll={handleScroll}
          scrollEventThrottle={16}
          contentContainerStyle={{ paddingVertical: 12 }}
          onContentSizeChange={scrollToEnd}
          renderItem={({ item, index }) => {
            const prev = messages[index - 1];
            const next = messages[index + 1];
            const fromMe = item.senderId === myId;
            const firstInGroup = prev == null || prev.senderId !== item.senderId;
            const lastInGroup = next == null || next.senderId !== item.senderId;
            const showTime =
              lastInGroup || timeFormatter(next!.createdAt) !== timeFormatter(item.createdAt);
            return (
              <ChatMessageRow
                message={item}
                fromMe={fromMe}
                firstInGroup={firstInGroup}
                lastInGroup={lastInGroup}
                showTime={showTime}
                isLastOwn={item.id === lastOwnId}
                peerName={title}
                peerAvatar={peerAvatar}
                timeLabel={timeFormatter(item.createdAt)}
                onLongPress={() => setActionTarget(item)}
                onResend={(id) => void resendMessage(id)}
                onOpenImage={() => undefined}
              />
            );
          }}
        />
      )}

      <View
        className="flex-row items-center gap-1 bg-white px-2 py-2"
        style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
      >
        <Pressable
          onPress={() => setOpenTab((c) => (c === 'smiley' ? null : 'smiley'))}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: openTab === 'smiley' ? 1 : 0.6 }}
        >
          <Image
            source={openTab === 'smiley' ? smileyIconActive : smileyIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <Pressable
          onPress={() => setOpenTab((c) => (c === 'kul' ? null : 'kul'))}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: openTab === 'kul' ? 1 : 0.6 }}
        >
          <Image
            source={openTab === 'kul' ? kulIconActive : kulIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <TextInput
          className="max-h-28 min-h-9 flex-1 rounded-2xl px-3 py-2 text-base"
          style={{ color: 'rgba(0,0,0,0.87)', borderWidth: 1, borderColor: DIVIDER, textAlignVertical: 'center' }}
          placeholder={t('chat.messageInputPlaceholder', { name: title })}
          placeholderTextColor="rgba(0,0,0,0.38)"
          multiline
          value={draft}
          onChangeText={(text) => {
            setDraft(text);
            notifyTyping();
          }}
          onFocus={() => setOpenTab(null)}
        />
        {isTyping ? (
          <Pressable
            onPress={() => void send(draft)}
            className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
          >
            <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
          </Pressable>
        ) : (
          <Pressable
            onPress={() => void send('(y)')}
            onLongPress={() => void send('(Y)')}
            className="h-9 w-9 items-center justify-center"
          >
            <Image source={likeIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
          </Pressable>
        )}
      </View>

      {openTab != null && (
        <SmileyKulPanel
          tab={openTab}
          onPickEmoji={(code) => setDraft((c) => c + code)}
          onSendKul={(index) => void send(kulToken(index))}
        />
      )}

      <MessageActionSheet
        visible={actionTarget != null}
        actions={actionTarget != null ? sheetActions(actionTarget) : []}
        showReactions={actionTarget != null}
        onReact={(type: ReactionType) => {
          if (actionTarget != null) void reactToMessage(actionTarget.id, type);
        }}
        onClose={() => setActionTarget(null)}
      />
    </KeyboardAvoidingView>
  );
}
