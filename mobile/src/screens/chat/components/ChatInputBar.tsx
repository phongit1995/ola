import { forwardRef, useImperativeHandle, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { DIVIDER } from '@constants';

const likeIcon = require('@assets/icons/chat/smiley/smiley_35.png');

export interface ChatInputBarHandle {
  focus: () => void;
  setText: (text: string) => void;
  clear: () => void;
  insertCode: (code: string, trailingSpace?: boolean) => void;
  backspace: () => void;
}

interface ChatInputBarProps {
  placeholder: string;
  editing: boolean;
  hidden?: boolean;
  refocusOnSend?: boolean;
  onSend: (text: string) => void;
  onTyping: () => void;
  onFocusInput: () => void;
}

export const ChatInputBar = forwardRef<ChatInputBarHandle, ChatInputBarProps>(
  function ChatInputBarInner(
    { placeholder, editing, hidden = false, refocusOnSend = true, onSend, onTyping, onFocusInput },
    ref
  ) {
    const { t } = useTranslation();
    const [draft, setDraft] = useState('');
    const composerRef = useRef<ChatComposerHandle>(null);

    useImperativeHandle(ref, () => ({
      focus: () => composerRef.current?.focus(),
      setText: setDraft,
      clear: () => setDraft(''),
      insertCode: (code, trailingSpace) => composerRef.current?.insertCode(code, trailingSpace),
      backspace: () => composerRef.current?.backspace(),
    }));

    function submit() {
      const text = draft;
      if (text.trim() === '') return;
      setDraft('');
      onSend(text);
      if (refocusOnSend) requestAnimationFrame(() => composerRef.current?.focus());
    }

    const isTyping = draft.trim() !== '';

    return (
      <View
        className="flex-row items-end gap-1 bg-white px-2 py-1.5"
        style={{
          borderTopWidth: 1,
          borderTopColor: DIVIDER,
          display: hidden ? 'none' : 'flex',
        }}
      >
        <View className="flex-1">
          <ChatComposer
            ref={composerRef}
            value={draft}
            onChange={(text) => {
              setDraft(text);
              if (!editing) onTyping();
            }}
            placeholder={placeholder}
            minHeight={36}
            maxHeight={128}
            paddingH={8}
            paddingV={6}
            onFocus={onFocusInput}
          />
        </View>
        {isTyping ? (
          <Pressable
            onPress={submit}
            className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
          >
            <Text className="text-sm font-semibold text-white">
              {editing ? t('chat.actionSave') : t('chat.send')}
            </Text>
          </Pressable>
        ) : (
          <Pressable
            onPress={() => onSend('(y)')}
            onLongPress={() => onSend('(Y)')}
            className="h-9 w-9 items-center justify-center"
          >
            <Image source={likeIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
          </Pressable>
        )}
      </View>
    );
  }
);
