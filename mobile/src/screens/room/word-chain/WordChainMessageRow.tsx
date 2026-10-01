import { memo, useEffect, type ReactNode } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Pressable, Text as RNText, View } from 'react-native';
import Animated, {
  Easing,
  useAnimatedStyle,
  useReducedMotion,
  useSharedValue,
  withRepeat,
  withTiming,
} from 'react-native-reanimated';
import {
  WORD_CHAIN_MESSAGE_TYPE,
  WORD_CHAIN_SENDER_TYPE,
} from '@ola/shared/constants';
import {
  formatClockHM,
  lastSyllable,
  wordChainGuessesText,
  wordChainMoveStatus,
  wordChainWrongReason,
} from '@ola/shared/lib';
import type { WordChainMessage, WordChainMoveStatus } from '@ola/shared/types';
import { ChatText as Text } from '@components/ui/ChatText';
import { VipAvatar } from '@components/ui/VipAvatar';
import { useThemeColors } from '@hooks/useThemeColors';
import { BUBBLE_IN_BG, BUBBLE_IN_SHADOW } from '@constants';
import { InfoIcon, WordChainImage, WordChainStatusIcon } from './WordChainIcons';
import { WORD_CHAIN_ICONS } from './wordChainAssets';

const AVATAR_SIZE = 32;
const NAME_INDENT = AVATAR_SIZE + 8;
const STATUS_ICON_SIZE = 28;
const GLOW_DURATION_MS = 1100;
const GLOW_REPEATS = 3;
const GLOW_COLOR = 'rgb(255,193,7)';
const TEXT_MAIN = 'rgba(0,0,0,0.87)';
const TEXT_SOFT = 'rgba(0,0,0,0.8)';
const TEXT_MUTED = 'rgba(0,0,0,0.35)';

const STRONG_COMPONENTS = {
  strong: <RNText style={{ fontWeight: '700', color: TEXT_MAIN }} />,
};

interface WordChainMessageRowProps {
  message: WordChainMessage;
  replyTo?: WordChainMessage;
  isOwn: boolean;
  celebrating: boolean;
  onWordInfo: (word: string) => void;
  onOpenProfile: (username: string) => void;
}

function WordInfoButton({
  word,
  onWordInfo,
}: {
  word: string;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  return (
    <Pressable
      accessibilityRole="button"
      accessibilityLabel={t('wordChain.wordInfo', { word })}
      hitSlop={8}
      onPress={() => onWordInfo(word)}
      className="items-center justify-center self-center"
      style={{ width: 20, height: 20 }}
    >
      <InfoIcon size={20} color="rgba(0,0,0,0.45)" />
    </Pressable>
  );
}

function ReplyQuote({ message }: { message: WordChainMessage }) {
  const colors = useThemeColors();
  return (
    <View
      className="mb-1.5 rounded py-0.5 pl-2 pr-1"
      style={{
        borderLeftWidth: 2,
        borderLeftColor: colors.primary,
        backgroundColor: 'rgba(0,0,0,0.05)',
      }}
    >
      <Text
        numberOfLines={1}
        className="text-xs font-semibold"
        style={{ color: 'rgba(0,0,0,0.6)' }}
      >
        @{message.senderName}
      </Text>
      <Text numberOfLines={2} className="text-xs" style={{ color: 'rgba(0,0,0,0.45)' }}>
        {message.content}
      </Text>
    </View>
  );
}

function BotReply({
  replyTo,
  status,
  time,
  children,
}: {
  replyTo?: WordChainMessage;
  status: WordChainMoveStatus;
  time: string;
  children: ReactNode;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  return (
    <View className="w-full" style={{ gap: 2 }}>
      <View className="flex-row items-baseline gap-1.5" style={{ marginLeft: NAME_INDENT }}>
        <Text
          numberOfLines={1}
          className="text-sm font-semibold"
          style={{ color: colors.primaryInk }}
        >
          {t('wordChain.bot')}
        </Text>
        <Text className="text-xs" style={{ color: TEXT_MUTED }}>
          {time}
        </Text>
      </View>
      <View className="flex-row items-start gap-2" style={{ maxWidth: '85%' }}>
        <WordChainImage source={WORD_CHAIN_ICONS.bot} size={AVATAR_SIZE} />
        <View
          className="rounded-2xl px-3.5 py-2"
          style={[{ flexShrink: 1, backgroundColor: BUBBLE_IN_BG }, BUBBLE_IN_SHADOW]}
        >
          {replyTo != null && <ReplyQuote message={replyTo} />}
          <View className="flex-row items-start" style={{ gap: 6 }}>
            <WordChainStatusIcon status={status} size={20} decorative />
            <Text className="text-sm" style={{ flexShrink: 1, color: TEXT_SOFT }}>
              {children}
            </Text>
          </View>
        </View>
      </View>
    </View>
  );
}

function NoticeCard({
  message,
  onWordInfo,
}: {
  message: WordChainMessage;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const isSession = message.type === WORD_CHAIN_MESSAGE_TYPE.sessionStarted;
  const word = message.word ?? '';
  return (
    <View
      className="items-center self-center rounded-xl px-4 py-2"
      style={{
        maxWidth: '85%',
        gap: 2,
        backgroundColor: 'rgba(255,255,255,0.9)',
        borderWidth: 1,
        borderColor: 'rgba(0,0,0,0.05)',
        shadowColor: '#000',
        shadowOpacity: 0.06,
        shadowRadius: 2,
        shadowOffset: { width: 0, height: 1 },
        elevation: 1,
      }}
    >
      <Text className="text-sm font-semibold" style={{ color: colors.primaryInk }}>
        {isSession ? t('wordChain.sessionStarted') : t('wordChain.gameStarted')}
      </Text>
      <View className="flex-row items-center" style={{ gap: 6 }}>
        <Text className="text-sm" style={{ flexShrink: 1, color: 'rgba(0,0,0,0.7)' }}>
          <Trans
            i18nKey={isSession ? 'wordChain.startWordLine' : 'wordChain.currentWordLine'}
            values={{ word }}
            components={{ word: <RNText style={{ fontSize: 16, fontWeight: '700', color: TEXT_MAIN }} /> }}
          />
        </Text>
        {word !== '' && <WordInfoButton word={word} onWordInfo={onWordInfo} />}
      </View>
    </View>
  );
}

function BotMessage({
  message,
  replyTo,
  onWordInfo,
}: {
  message: WordChainMessage;
  replyTo?: WordChainMessage;
  onWordInfo: (word: string) => void;
}) {
  const { t } = useTranslation();
  const time = formatClockHM(message.createdAt);

  if (message.type === WORD_CHAIN_MESSAGE_TYPE.wrongAnswer) {
    return (
      <BotReply replyTo={replyTo} status={wordChainMoveStatus(message) ?? 'error'} time={time}>
        <RNText style={{ fontWeight: '700', color: TEXT_MAIN }}>
          {wordChainWrongReason(t, message)}
        </RNText>{' '}
        {wordChainGuessesText(t, message.remainingGuesses ?? 0)}
      </BotReply>
    );
  }

  if (message.type === WORD_CHAIN_MESSAGE_TYPE.win) {
    const winner = replyTo?.senderName;
    return (
      <BotReply replyTo={replyTo} status="win" time={time}>
        {winner != null && winner !== '' ? (
          <Trans
            i18nKey="wordChain.winTitle"
            values={{ name: winner }}
            components={{ mention: STRONG_COMPONENTS.strong }}
          />
        ) : (
          t('wordChain.winTitleUnknown')
        )}{' '}
        {t('wordChain.winBody', { syllable: lastSyllable(message.word) })}
      </BotReply>
    );
  }

  return <NoticeCard message={message} onWordInfo={onWordInfo} />;
}

function WinGlow() {
  const reducedMotion = useReducedMotion();
  const progress = useSharedValue(0);

  useEffect(() => {
    if (reducedMotion) return;
    progress.value = withRepeat(
      withTiming(1, { duration: GLOW_DURATION_MS, easing: Easing.out(Easing.quad) }),
      GLOW_REPEATS,
      false
    );
  }, [progress, reducedMotion]);

  const style = useAnimatedStyle(() => ({
    opacity: progress.value === 0 ? 0 : 0.85 * (1 - progress.value),
    transform: [{ scaleX: 1 + 0.12 * progress.value }, { scaleY: 1 + 0.3 * progress.value }],
  }));

  if (reducedMotion) return null;
  return (
    <Animated.View
      pointerEvents="none"
      style={[
        {
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          borderRadius: 16,
          borderWidth: 3,
          borderColor: GLOW_COLOR,
        },
        style,
      ]}
    />
  );
}

function MoveBubble({
  message,
  isOwn,
  celebrating,
  onWordInfo,
  onOpenProfile,
}: {
  message: WordChainMessage;
  isOwn: boolean;
  celebrating: boolean;
  onWordInfo: (word: string) => void;
  onOpenProfile: (username: string) => void;
}) {
  const colors = useThemeColors();
  const status = wordChainMoveStatus(message);
  const isValidWord = status === 'correct' || status === 'win';
  const senderName = message.senderName ?? '';
  const canOpenProfile = !isOwn && senderName !== '';
  const openSender = () => onOpenProfile(senderName);
  const avatar = <VipAvatar typeId={message.senderVipTypeId} size={AVATAR_SIZE} />;

  return (
    <View
      className="w-full"
      style={{
        gap: 2,
        alignItems: isOwn ? 'flex-end' : 'flex-start',
        paddingBottom: status != null ? 12 : 0,
      }}
    >
      <View
        className="items-baseline gap-1.5"
        style={{
          maxWidth: '80%',
          flexDirection: isOwn ? 'row-reverse' : 'row',
          marginLeft: isOwn ? 0 : NAME_INDENT,
          marginRight: isOwn ? NAME_INDENT : 0,
        }}
      >
        <Text
          numberOfLines={1}
          onPress={canOpenProfile ? openSender : undefined}
          className="text-sm font-semibold"
          style={{ flexShrink: 1, color: 'rgba(0,0,0,0.72)' }}
        >
          {senderName}
        </Text>
        <Text className="text-xs" style={{ color: TEXT_MUTED }}>
          {formatClockHM(message.createdAt)}
        </Text>
      </View>
      <View
        className="items-start gap-2"
        style={{ maxWidth: '80%', flexDirection: isOwn ? 'row-reverse' : 'row' }}
      >
        {canOpenProfile ? (
          <Pressable onPress={openSender} accessibilityLabel={senderName}>
            {avatar}
          </Pressable>
        ) : (
          avatar
        )}
        <View style={{ flexShrink: 1, position: 'relative' }}>
          <View
            className="rounded-2xl px-3.5 py-2"
            style={[
              { backgroundColor: isOwn ? colors.primary : BUBBLE_IN_BG },
              isOwn ? null : BUBBLE_IN_SHADOW,
            ]}
          >
            <Text
              className="text-base"
              style={{ color: isOwn ? colors.onPrimary : TEXT_MAIN }}
            >
              {message.content}
            </Text>
          </View>
          {celebrating && <WinGlow />}
          {status != null && (
            <View
              pointerEvents="none"
              style={{
                position: 'absolute',
                bottom: -12,
                left: isOwn ? -8 : undefined,
                right: isOwn ? undefined : -8,
                width: STATUS_ICON_SIZE,
                height: STATUS_ICON_SIZE,
              }}
            >
              <WordChainStatusIcon status={status} size={STATUS_ICON_SIZE} />
            </View>
          )}
        </View>
        {isValidWord && (
          <WordInfoButton word={message.word || message.content} onWordInfo={onWordInfo} />
        )}
      </View>
    </View>
  );
}

function WordChainMessageRowComponent({
  message,
  replyTo,
  isOwn,
  celebrating,
  onWordInfo,
  onOpenProfile,
}: WordChainMessageRowProps) {
  if (message.senderType === WORD_CHAIN_SENDER_TYPE.bot) {
    return <BotMessage message={message} replyTo={replyTo} onWordInfo={onWordInfo} />;
  }
  return (
    <MoveBubble
      message={message}
      isOwn={isOwn}
      celebrating={celebrating}
      onWordInfo={onWordInfo}
      onOpenProfile={onOpenProfile}
    />
  );
}

export const WordChainMessageRow = memo(WordChainMessageRowComponent);
