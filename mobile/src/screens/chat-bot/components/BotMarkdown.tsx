import { memo, useMemo, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Image,
  Linking,
  Platform,
  Pressable,
  ScrollView,
  Text,
  View,
} from 'react-native';
import Clipboard from '@react-native-clipboard/clipboard';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { BOT_CODE_BG, BOT_CODE_TEXT } from '../constants';

const copyActionIcon = require('@assets/icons/chat/ic_menu_copy.png');

const CODE_FENCE_PATTERN = /```([a-zA-Z0-9_+-]*)\n?([\s\S]*?)```/g;
const INLINE_PATTERN =
  /(\*\*[^*]+\*\*|`[^`]+`|https?:\/\/[^\s]+|www\.[^\s]+)/g;
const URL_TOKEN_PATTERN = /^(?:https?:\/\/[^\s]+|www\.[^\s]+)$/;
const URL_TRAILING_PUNCTUATION = /[.,;:!?)\]}'"]+$/;
const BULLET_PATTERN = /^\s*[*\-•]\s+/;
const NUMBERED_PATTERN = /^\s*(\d+)[.)]\s+/;
const HEADING_PATTERN = /^\s*#{1,6}\s+/;

const MONO_FONT = Platform.select({ ios: 'Menlo', default: 'monospace' });
const LINK_COLOR = '#33691e';

function renderUrl(part: string, key: string): ReactNode {
  const trailingMatch = part.match(URL_TRAILING_PUNCTUATION);
  const trailing = trailingMatch == null ? '' : trailingMatch[0];
  const url =
    trailing === '' ? part : part.slice(0, part.length - trailing.length);
  const href = url.startsWith('www.') ? `https://${url}` : url;

  return (
    <Text key={key}>
      <Text
        onPress={() => void Linking.openURL(href).catch(() => undefined)}
        style={{ color: LINK_COLOR, textDecorationLine: 'underline' }}
      >
        {url}
      </Text>
      {trailing}
    </Text>
  );
}

function renderInline(text: string, keyPrefix: string): ReactNode[] {
  return text.split(INLINE_PATTERN).map((part, index) => {
    const key = `${keyPrefix}-${index}`;
    if (part.startsWith('**') && part.endsWith('**') && part.length > 4) {
      return (
        <Text key={key} style={{ fontWeight: '600' }}>
          {part.slice(2, -2)}
        </Text>
      );
    }
    if (part.startsWith('`') && part.endsWith('`') && part.length > 2) {
      return (
        <Text
          key={key}
          style={{
            fontFamily: MONO_FONT,
            fontSize: 13,
            backgroundColor: 'rgba(0,0,0,0.08)',
          }}
        >
          {part.slice(1, -1)}
        </Text>
      );
    }
    if (URL_TOKEN_PATTERN.test(part)) return renderUrl(part, key);
    return <Text key={key}>{part}</Text>;
  });
}

function CodeBlock({ code }: { code: string }) {
  const { t } = useTranslation();
  const push = useToastStore((s) => s.push);

  const copy = () => {
    Clipboard.setString(code);
    push('success', t('chat.chatBotCodeCopied'));
  };

  return (
    <View
      className="my-1 overflow-hidden rounded-lg"
      style={{ backgroundColor: BOT_CODE_BG }}
    >
      <View
        className="flex-row items-center justify-end px-2 py-1"
        style={{ borderBottomWidth: 1, borderBottomColor: 'rgba(255,255,255,0.1)' }}
      >
        <Pressable
          onPress={copy}
          className="flex-row items-center gap-1 rounded px-1.5 py-0.5 active:opacity-70"
        >
          <Image
            source={copyActionIcon}
            style={{ width: 14, height: 14, tintColor: 'rgba(255,255,255,0.7)' }}
            resizeMode="contain"
          />
          <Text
            className="text-[11px]"
            style={{ color: 'rgba(255,255,255,0.7)' }}
          >
            {t('chat.chatBotCopyCode')}
          </Text>
        </Pressable>
      </View>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        <Text
          className="px-3 py-2"
          style={{ fontFamily: MONO_FONT, fontSize: 12, color: BOT_CODE_TEXT }}
        >
          {code}
        </Text>
      </ScrollView>
    </View>
  );
}

function renderParagraphs(text: string, keyPrefix: string): ReactNode[] {
  const blocks: ReactNode[] = [];
  let bullets: string[] = [];

  const flushBullets = () => {
    if (bullets.length === 0) return;
    blocks.push(
      <View key={`${keyPrefix}-ul-${blocks.length}`} className="my-0.5 pl-2">
        {bullets.map((item, index) => (
          <View key={index} className="flex-row">
            <Text className="text-sm text-ola-ink">{'•  '}</Text>
            <Text className="flex-1 text-sm text-ola-ink">
              {renderInline(item, `${keyPrefix}-li-${index}`)}
            </Text>
          </View>
        ))}
      </View>
    );
    bullets = [];
  };

  text.split('\n').forEach((line, index) => {
    const trimmed = line.trim();
    if (trimmed === '') {
      flushBullets();
      return;
    }
    if (BULLET_PATTERN.test(line)) {
      bullets.push(line.replace(BULLET_PATTERN, ''));
      return;
    }
    flushBullets();
    if (HEADING_PATTERN.test(line)) {
      blocks.push(
        <Text
          key={`${keyPrefix}-h-${index}`}
          className="mt-1 text-sm text-ola-ink"
          style={{ fontWeight: '600' }}
        >
          {renderInline(
            line.replace(HEADING_PATTERN, ''),
            `${keyPrefix}-h-${index}`
          )}
        </Text>
      );
      return;
    }
    const numbered = NUMBERED_PATTERN.exec(line);
    if (numbered != null) {
      blocks.push(
        <Text key={`${keyPrefix}-n-${index}`} className="text-sm text-ola-ink">
          <Text style={{ fontWeight: '600' }}>{numbered[1]}. </Text>
          {renderInline(
            line.replace(NUMBERED_PATTERN, ''),
            `${keyPrefix}-n-${index}`
          )}
        </Text>
      );
      return;
    }
    blocks.push(
      <Text key={`${keyPrefix}-p-${index}`} className="text-sm text-ola-ink">
        {renderInline(line, `${keyPrefix}-p-${index}`)}
      </Text>
    );
  });

  flushBullets();
  return blocks;
}

function buildBlocks(content: string): ReactNode[] {
  const parts: ReactNode[] = [];
  let cursor = 0;
  CODE_FENCE_PATTERN.lastIndex = 0;

  for (;;) {
    const match = CODE_FENCE_PATTERN.exec(content);
    if (match == null) break;
    const before = content.slice(cursor, match.index);
    if (before.trim() !== '') {
      parts.push(...renderParagraphs(before, `t${cursor}`));
    }
    parts.push(<CodeBlock key={`code-${match.index}`} code={match[2] ?? ''} />);
    cursor = match.index + match[0].length;
  }

  const tail = content.slice(cursor);
  if (tail.trim() !== '') parts.push(...renderParagraphs(tail, `t${cursor}`));

  return parts;
}

function BotMarkdownComponent({ content }: { content: string }) {
  const blocks = useMemo(() => buildBlocks(content), [content]);

  return <View className="gap-0.5">{blocks}</View>;
}

export const BotMarkdown = memo(BotMarkdownComponent);
