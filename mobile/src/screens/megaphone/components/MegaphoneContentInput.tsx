import { useEffect, useRef, useState } from 'react';
import { Image, Keyboard, Pressable, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { SmileyKulPanel } from '@screens/room/components/SmileyKulPanel';

const smileyIcon = require('@assets/icons/chat/ic_tab_emoji.png');

const INPUT_MIN_HEIGHT = 56;
const INPUT_MAX_HEIGHT = 112;
const INPUT_FONT_SIZE = 14;
const INPUT_COLOR = 'rgba(0,0,0,0.87)';
const INPUT_PLACEHOLDER_COLOR = 'rgba(0,0,0,0.38)';
const INPUT_BORDER = 'rgba(0,0,0,0.12)';
const ERROR_BORDER = '#e34545';
const FOOTER_HEIGHT = 28;

interface MegaphoneContentInputProps {
  value: string;
  tooLong: boolean;
  counter: string;
  onChange: (value: string) => void;
}

export function MegaphoneContentInput({ value, tooLong, counter, onChange }: MegaphoneContentInputProps) {
  const { t } = useTranslation();
  const inputRef = useRef<ChatComposerHandle>(null);
  const [smileyOpen, setSmileyOpen] = useState(false);

  useEffect(() => {
    requestAnimationFrame(() => inputRef.current?.focus());
  }, []);

  function toggleSmiley() {
    if (smileyOpen) {
      setSmileyOpen(false);
      inputRef.current?.focus();
      return;
    }
    Keyboard.dismiss();
    setSmileyOpen(true);
  }

  return (
    <View className="gap-2">
      <View className="rounded" style={{ borderWidth: 1, borderColor: tooLong ? ERROR_BORDER : INPUT_BORDER }}>
        <ChatComposer
          ref={inputRef}
          value={value}
          onChange={onChange}
          onFocus={() => setSmileyOpen(false)}
          placeholder={t('megaphone.placeholder')}
          fontSize={INPUT_FONT_SIZE}
          minHeight={INPUT_MIN_HEIGHT}
          maxHeight={INPUT_MAX_HEIGHT}
          paddingH={12}
          paddingV={8}
          alignTop
          textColor={INPUT_COLOR}
          placeholderTextColor={INPUT_PLACEHOLDER_COLOR}
        />
        <View className="flex-row items-center justify-between pl-1 pr-2" style={{ height: FOOTER_HEIGHT }}>
          <Pressable
            accessibilityRole="button"
            accessibilityLabel={t('chat.attachTabSmiley')}
            accessibilityState={{ selected: smileyOpen }}
            onPress={toggleSmiley}
            hitSlop={8}
            className="items-center justify-center"
            style={{ width: FOOTER_HEIGHT, height: FOOTER_HEIGHT }}
          >
            <Image source={smileyIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          <Text className={`text-xs ${tooLong ? 'font-semibold text-ola-error' : 'text-ola-ink-faint'}`}>
            {counter}
          </Text>
        </View>
      </View>
      {smileyOpen && (
        <View className="overflow-hidden rounded" style={{ borderWidth: 1, borderColor: INPUT_BORDER }}>
          <SmileyKulPanel
            hideKul
            onPickEmoji={(code) => inputRef.current?.insertCode(code, true)}
            onBackspace={() => inputRef.current?.backspace()}
          />
        </View>
      )}
    </View>
  );
}
