import { Fragment, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { createDateSeparatorFormatter, isSameDay } from '@ola/shared/lib';
import type { ChatBotErrorCode, ChatBotMessage } from '@ola/shared/types';
import type { useStickyBottomList } from '@hooks/useStickyBottomList';
import { isoOf } from '../chatBotView';
import type { ChatBotViewer } from '../interface';
import { BotMessageRow } from './BotMessageRow';
import { BotTypingRow } from './BotTypingRow';
import { ChatBotEmptyState } from './ChatBotEmptyState';
import { ChatBotErrorNotice } from './ChatBotErrorNotice';

interface ChatBotMessageListProps {
  list: ReturnType<typeof useStickyBottomList<ChatBotMessage>>;
  messages: ChatBotMessage[];
  viewer: ChatBotViewer;
  waiting: boolean;
  error: ChatBotErrorCode | null;
  onRetry: () => void;
}

export function ChatBotMessageList({
  list,
  messages,
  viewer,
  waiting,
  error,
  onRetry,
}: ChatBotMessageListProps) {
  const { i18n } = useTranslation();
  const dateFormatter = useMemo(
    () => createDateSeparatorFormatter(i18n.language),
    [i18n.language]
  );
  const empty = messages.length === 0 && !waiting;

  if (empty) return <ChatBotEmptyState />;

  return (
    <FlashList
      ref={list.listRef}
      data={messages}
      keyExtractor={(item) => item.id}
      drawDistance={1500}
      maintainVisibleContentPosition={{ startRenderingFromBottom: true }}
      onScroll={list.onScroll}
      onScrollBeginDrag={list.onScrollBeginDrag}
      onScrollEndDrag={list.onScrollEndDrag}
      onMomentumScrollBegin={list.onMomentumScrollBegin}
      onMomentumScrollEnd={list.onMomentumScrollEnd}
      onLayout={list.onListLayout}
      onContentSizeChange={list.onContentSizeChange}
      scrollEventThrottle={16}
      keyboardDismissMode="interactive"
      keyboardShouldPersistTaps="handled"
      contentContainerStyle={{ paddingVertical: 12 }}
      renderItem={({ item, index }) => {
        const prev = messages[index - 1];
        const showDate = !isSameDay(
          isoOf(prev?.createdAt ?? 0),
          isoOf(item.createdAt)
        );
        return (
          <Fragment>
            {showDate && (
              <View className="items-center py-1">
                <Text
                  className="overflow-hidden rounded-full px-3 py-0.5 text-xs text-white"
                  style={{ backgroundColor: 'rgba(0,0,0,0.35)' }}
                >
                  {dateFormatter(isoOf(item.createdAt))}
                </Text>
              </View>
            )}
            <BotMessageRow
              message={item}
              prev={prev}
              next={messages[index + 1]}
              viewer={viewer}
            />
          </Fragment>
        );
      }}
      ListFooterComponent={
        <>
          {waiting && <BotTypingRow />}
          {error != null && (
            <ChatBotErrorNotice code={error} onRetry={onRetry} />
          )}
        </>
      }
    />
  );
}
