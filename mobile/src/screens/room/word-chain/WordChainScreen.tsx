import { useCallback, useEffect, useMemo, useRef, useState, type ReactNode } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  Text,
  View,
  type NativeScrollEvent,
  type NativeSyntheticEvent,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { CompositeScreenProps } from '@react-navigation/native';
import type { BottomTabScreenProps } from '@react-navigation/bottom-tabs';
import { WORD_CHAIN_INPUT_LOCK_HINT_KEYS } from '@ola/shared/constants';
import {
  buildWordChainFeed,
  colorForName,
  createDateSeparatorFormatter,
  remainingGuesses,
  sessionMessages,
  wordChainInputLock,
} from '@ola/shared/lib';
import type { WordChainFeedItem } from '@ola/shared/types';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import type {
  MainTabParamList,
  RoomStackParamList,
  RootStackParamList,
} from '@navigation/types';
import { ROOM_ROUTES, ROOT_ROUTES, TAB_ROUTES } from '@navigation/routes';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { ChatWallpaper } from '@components/ChatWallpaper';
import { useStickyBottomList } from '@hooks/useStickyBottomList';
import { useThemeColors } from '@hooks/useThemeColors';
import { CHAT_BG } from '@screens/chat/constants';
import { useWordChainViewStore, type WordChainScrollAnchor } from '@store/wordChainViewStore';
import { DIVIDER } from '@constants';
import { WordChainComposer } from './WordChainComposer';
import { WordChainGuessDialog } from './WordChainGuessDialog';
import { WordChainHintDialog } from './WordChainHintDialog';
import { WordChainImage } from './WordChainIcons';
import { WordChainLeaderboardDialog } from './WordChainLeaderboardDialog';
import { WordChainLookupDialog } from './WordChainLookupDialog';
import { WordChainMessageRow } from './WordChainMessageRow';
import { WordChainRulesDialog } from './WordChainRulesDialog';
import { WordChainWinCelebration } from './WordChainWinCelebration';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

type Props = CompositeScreenProps<
  NativeStackScreenProps<RoomStackParamList, typeof ROOM_ROUTES.WordChain>,
  CompositeScreenProps<
    BottomTabScreenProps<MainTabParamList, typeof TAB_ROUTES.Room>,
    NativeStackScreenProps<RootStackParamList>
  >
>;

type WordChainDialog = 'hint' | 'guesses' | 'leaderboard' | 'lookup' | 'rules';

const LOCKED_HINT_KEYS = {
  ...WORD_CHAIN_INPUT_LOCK_HINT_KEYS,
  noGuesses: 'wordChain.inputHintOutOfGuesses',
} as const;

const backIcon = require('@assets/icons/ic_back.png');

const LOAD_MORE_AT_TOP_PX = 80;
const ERROR_COLOR = '#e34545';

function HeaderButton({
  label,
  onPress,
  children,
}: {
  label: string;
  onPress: () => void;
  children: ReactNode;
}) {
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={label}
      onPress={onPress}
      className="h-11 w-11 items-center justify-center rounded-full active:bg-white/15"
    >
      {children}
    </Pressable>
  );
}

export function WordChainScreen({ navigation }: Props) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const opened = useWordChainStore((store) => store.opened);
  const status = useWordChainStore((store) => store.status);
  const state = useWordChainStore((store) => store.state);
  const guesses = useWordChainStore((store) => store.guesses);
  const allMessages = useWordChainStore((store) => store.messages);
  const hasMore = useWordChainStore((store) => store.hasMore);
  const loadingMore = useWordChainStore((store) => store.loadingMore);
  const loadMoreMessages = useWordChainStore((store) => store.loadMoreMessages);
  const sendMove = useWordChainStore((store) => store.sendMove);
  const lookup = useWordChainStore((store) => store.lookup);
  const clearLookup = useWordChainStore((store) => store.clearLookup);
  const celebration = useWordChainStore((store) => store.celebration);
  const open = useWordChainStore((store) => store.open);
  const close = useWordChainStore((store) => store.close);
  const minimize = useWordChainStore((store) => store.minimize);
  const dismissCelebration = useWordChainStore((store) => store.dismissCelebration);
  const currentUserId = useAuthStore((store) => store.user?.id) ?? '';
  const [dialog, setDialog] = useState<WordChainDialog | null>(null);
  const [lookupWord, setLookupWord] = useState('');
  const wasOpenedRef = useRef(false);
  const restoreAnchorRef = useRef(useWordChainViewStore.getState().anchor);
  const {
    listRef,
    onListLayout,
    onContentSizeChange,
    onScroll,
    onScrollBeginDrag,
    onScrollEndDrag,
    onMomentumScrollBegin,
    onMomentumScrollEnd,
    pinOnNextContent,
    unstick,
    isUserInteracting,
    isStuckToBottom,
    requestScrollToBottom,
  } = useStickyBottomList<WordChainFeedItem>({
    initialStuck: restoreAnchorRef.current == null,
  });

  useEffect(() => {
    open();
    const missedCelebration = useWordChainStore.getState().celebration;
    if (missedCelebration != null) dismissCelebration(missedCelebration.id);
    return () => {
      if (!useWordChainStore.getState().minimized) close();
    };
  }, [open, close, dismissCelebration]);

  useEffect(() => {
    if (opened) {
      wasOpenedRef.current = true;
      return;
    }
    if (wasOpenedRef.current && navigation.isFocused()) navigation.goBack();
  }, [opened, navigation]);

  const openProfile = useCallback(
    (username: string) =>
      navigation.navigate(ROOT_ROUTES.ProfileView, {
        userId: username,
        color: colorForName(username),
      }),
    [navigation]
  );

  const openLookup = useCallback(
    (word: string) => {
      clearLookup();
      setLookupWord(word);
      setDialog('lookup');
      if (word !== '') void lookup(word);
    },
    [clearLookup, lookup]
  );

  const messages = useMemo(
    () => sessionMessages(allMessages, state?.sessionId),
    [allMessages, state?.sessionId]
  );
  const feed = useMemo(() => buildWordChainFeed(messages), [messages]);
  const dateFormatter = useMemo(
    () => createDateSeparatorFormatter(i18n.language),
    [i18n.language]
  );
  const remaining = remainingGuesses(state, guesses);
  const lock = wordChainInputLock(state, guesses, currentUserId);
  const celebrationId = celebration?.id ?? null;

  const send = useCallback(
    (content: string) => {
      pinOnNextContent();
      return sendMove(content);
    },
    [pinOnNextContent, sendMove]
  );

  function handleScroll(event: NativeSyntheticEvent<NativeScrollEvent>) {
    onScroll(event);
    if (
      isUserInteracting() &&
      event.nativeEvent.contentOffset.y < LOAD_MORE_AT_TOP_PX &&
      hasMore &&
      !loadingMore
    ) {
      unstick();
      void loadMoreMessages();
    }
  }

  const renderItem = useCallback(
    ({ item }: { item: WordChainFeedItem }) =>
      item.kind === 'date' ? (
        <View className="items-center pb-3">
          <Text
            className="rounded-full px-3 py-0.5 text-xs text-white"
            style={{ backgroundColor: 'rgba(0,0,0,0.35)', overflow: 'hidden' }}
          >
            {dateFormatter(item.createdAt)}
          </Text>
        </View>
      ) : (
        <View className="pb-3">
          <WordChainMessageRow
            message={item.message}
            replyTo={item.replyTo}
            isOwn={item.message.senderId === currentUserId}
            celebrating={item.message.id === celebrationId}
            onWordInfo={openLookup}
            onOpenProfile={openProfile}
          />
        </View>
      ),
    [dateFormatter, currentUserId, celebrationId, openLookup, openProfile]
  );

  const closeDialog = () => setDialog(null);

  function handleContentSizeChange(width: number, height: number) {
    onContentSizeChange(width, height);
    const anchor = restoreAnchorRef.current;
    if (anchor == null || height <= 0) return;
    restoreAnchorRef.current = null;
    useWordChainViewStore.setState({ anchor: null });
    const index = feed.findIndex((item) => item.key === anchor.key);
    if (index < 0) {
      requestScrollToBottom();
      return;
    }
    void listRef.current?.scrollToIndex({
      index,
      viewPosition: 0,
      viewOffset: anchor.offset,
      animated: false,
    });
  }

  function scrollAnchor(): WordChainScrollAnchor | null {
    const list = listRef.current;
    if (list == null || isStuckToBottom()) return null;
    const index = list.getFirstVisibleIndex();
    const item = feed[index];
    const layout = list.getLayout(index);
    if (item == null || layout == null) return null;
    return {
      key: item.key,
      offset: list.getAbsoluteLastScrollOffset() - layout.y - list.getFirstItemOffset(),
    };
  }

  function minimizeRoom() {
    useWordChainViewStore.setState({ anchor: scrollAnchor() });
    minimize();
    navigation.goBack();
  }

  return (
    <View className="flex-1 bg-white">
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-center px-2">
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('chat.back')}
            hitSlop={6}
            onPress={() => navigation.goBack()}
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
          >
            <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          <View className="min-w-0 flex-1 flex-row items-center gap-2 pl-1">
            <WordChainImage source={WORD_CHAIN_ICONS.room} size={32} />
            <Text numberOfLines={1} className="shrink text-lg font-medium text-white">
              {t('wordChain.title')}
            </Text>
          </View>
          <View className="flex-row items-center">
            <HeaderButton
              label={t('wordChain.leaderboardTitle')}
              onPress={() => setDialog('leaderboard')}
            >
              <WordChainImage source={WORD_CHAIN_ICONS.leaderboard} size={44} />
            </HeaderButton>
            <HeaderButton label={t('wordChain.rulesTitle')} onPress={() => setDialog('rules')}>
              <WordChainImage source={WORD_CHAIN_ICONS.rules} size={36} />
            </HeaderButton>
            {status === 'joined' && (
              <HeaderButton label={t('wordChain.minimize')} onPress={minimizeRoom}>
                <WordChainImage source={WORD_CHAIN_ICONS.minimize} size={34} />
              </HeaderButton>
            )}
          </View>
        </View>
      </View>

      {status === 'error' ? (
        <View className="flex-1 items-center justify-center gap-4 px-8">
          <Text className="text-center text-base" style={{ color: 'rgba(0,0,0,0.7)' }}>
            {t('wordChain.joinError')}
          </Text>
          <Pressable
            onPress={() => navigation.goBack()}
            className="rounded-full bg-ola-primary px-6 py-2 active:opacity-90"
          >
            <Text className="text-sm font-medium text-white">{t('chat.back')}</Text>
          </Pressable>
        </View>
      ) : status !== 'joined' ? (
        <View className="flex-1 items-center justify-center gap-3">
          <ActivityIndicator color={colors.primary} size="large" />
          <Text className="text-sm text-ola-ink-soft">{t('wordChain.joining')}</Text>
        </View>
      ) : (
        <ChatKeyboardArea>
          <View className="flex-1" style={{ backgroundColor: CHAT_BG }}>
            <ChatWallpaper />
            {feed.length === 0 ? (
              <View className="items-center gap-2 py-6">
                <WordChainImage source={WORD_CHAIN_ICONS.room} size={64} />
                <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>
                  {t('wordChain.empty')}
                </Text>
              </View>
            ) : (
              <FlashList
                ref={listRef}
                data={feed}
                extraData={celebrationId}
                keyExtractor={(item) => item.key}
                getItemType={(item) => item.kind}
                drawDistance={1500}
                maintainVisibleContentPosition={{ startRenderingFromBottom: true }}
                onScroll={handleScroll}
                onScrollBeginDrag={onScrollBeginDrag}
                onScrollEndDrag={onScrollEndDrag}
                onMomentumScrollBegin={onMomentumScrollBegin}
                onMomentumScrollEnd={onMomentumScrollEnd}
                scrollEventThrottle={16}
                contentContainerClassName="p-3"
                onContentSizeChange={handleContentSizeChange}
                onLayout={onListLayout}
                keyboardShouldPersistTaps="handled"
                ListHeaderComponent={
                  loadingMore ? (
                    <Text className="py-1 text-center text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                      {t('common.loading')}
                    </Text>
                  ) : null
                }
                renderItem={renderItem}
              />
            )}
          </View>

          <View
            className="flex-row items-baseline gap-3 bg-white px-4 pt-2"
            style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
          >
            <Text numberOfLines={1} className="min-w-0 flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
              <Trans
                i18nKey="wordChain.currentWordLine"
                values={{ word: state?.word ?? '' }}
                components={{
                  word: <Text style={{ fontSize: 16, fontWeight: '600', color: 'rgba(0,0,0,0.87)' }} />,
                }}
              />
            </Text>
            <Text
              className="text-sm"
              style={{
                color: remaining === 0 ? ERROR_COLOR : 'rgba(0,0,0,0.54)',
                fontWeight: remaining === 0 ? '500' : '400',
                fontVariant: ['tabular-nums'],
              }}
            >
              {t('wordChain.guessesBadge', { value: remaining, limit: state?.guessLimit ?? 0 })}
            </Text>
          </View>

          <WordChainComposer
            syllable={state?.requiredSyllable}
            lockedHint={lock != null ? t(LOCKED_HINT_KEYS[lock]) : undefined}
            onSend={send}
            onHint={() => setDialog('hint')}
            onLookup={() => openLookup('')}
            onBuyGuesses={lock === 'noGuesses' ? () => setDialog('guesses') : undefined}
          />
        </ChatKeyboardArea>
      )}

      {celebration != null && (
        <WordChainWinCelebration
          key={celebration.id}
          winner={celebration}
          isOwn={celebration.senderId === currentUserId}
        />
      )}

      {dialog === 'hint' && <WordChainHintDialog onClose={closeDialog} onSend={send} />}
      {dialog === 'guesses' && <WordChainGuessDialog onClose={closeDialog} />}
      <WordChainLeaderboardDialog visible={dialog === 'leaderboard'} onClose={closeDialog} />
      {dialog === 'lookup' && (
        <WordChainLookupDialog initialWord={lookupWord} onClose={closeDialog} />
      )}
      <WordChainRulesDialog visible={dialog === 'rules'} onClose={closeDialog} />
    </View>
  );
}
