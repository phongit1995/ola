import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, TextInput, View } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import {
  ComposerDraftOverlay,
  composerSingleLineHeight,
  useComposerScrollSync,
} from '../../components/SmileyDraftOverlay';
import { SmileyKulPanel } from '../room/SmileyKulPanel';
import { Avatar } from '../../components/Avatar';
import { useSmileyDraft } from '../../hooks/useSmileyDraft';

const smileyIcon = require('../../assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('../../assets/icons/chat/ic_smiley_selected.png');

interface MeCommentComposerProps {
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  autoFocus?: boolean;
  initialDraft?: string;
  replyingTo?: string | null;
  onCancelReply?: () => void;
}

export function MeCommentComposer({
  submitting,
  onSubmit,
  autoFocus,
  initialDraft = '',
  replyingTo,
  onCancelReply,
}: MeCommentComposerProps) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const {
    draft,
    inputValue,
    codes,
    applyDraft,
    handleChangeText,
    insertAtCursor,
    backspaceAtCursor,
    selection,
    handleSelectionChange,
  } = useSmileyDraft(initialDraft);
  const { scrollY: inputScrollY, handleScroll: handleInputScroll } = useComposerScrollSync(draft);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const inputRef = useRef<TextInput>(null);
  const myName = me?.username ?? t('home.guest');
  const canSend = draft.trim() !== '' && !submitting;

  async function submit() {
    if (!canSend) return;
    const ok = await onSubmit(draft);
    if (ok) {
      applyDraft('');
      setSmileyOpen(false);
    }
  }

  return (
    <View>
      {replyingTo != null && replyingTo !== '' && (
        <View
          className="flex-row items-center gap-2 bg-[#eceff1] px-4 py-1.5"
          style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
        >
          <Text numberOfLines={1} className="min-w-0 flex-1 text-xs" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.replyingTo', { name: `@${replyingTo}` })}
          </Text>
          <Pressable onPress={onCancelReply} className="h-6 w-6 items-center justify-center">
            <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.45)' }}>×</Text>
          </Pressable>
        </View>
      )}
      <View
        className="flex-row items-end gap-2 bg-white px-3 py-2"
        style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
      >
        <Avatar name={myName} uri={me?.avatar ?? undefined} size={36} />
        <View
          className="max-h-28 min-h-9 flex-1 justify-center rounded-2xl"
          style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
        >
          <TextInput
            ref={inputRef}
            className="px-3 py-2 text-base"
            style={[
              { color: 'rgba(0,0,0,0.87)', textAlignVertical: 'center', maxHeight: 112 },
              draft === '' ? { height: composerSingleLineHeight(8) } : null,
            ]}
            selectionColor="#7cb342"
            cursorColor="#7cb342"
            placeholder={t('me.commentInputHint')}
            placeholderTextColor="rgba(0,0,0,0.38)"
            multiline
            autoFocus={autoFocus}
            value={inputValue}
            selection={selection}
            onSelectionChange={handleSelectionChange}
            onChangeText={handleChangeText}
            onScroll={handleInputScroll}
            onFocus={() => setSmileyOpen(false)}
          />
          {inputValue !== '' && (
            <ComposerDraftOverlay
              display={inputValue}
              codes={codes}
              scrollY={inputScrollY}
              inputRef={inputRef}
            />
          )}
        </View>
        <Pressable
          onPress={() => setSmileyOpen((open) => !open)}
          className="h-9 w-9 items-center justify-center"
          style={{ opacity: smileyOpen ? 1 : 0.6 }}
        >
          <Image
            source={smileyOpen ? smileyIconActive : smileyIcon}
            style={{ width: 24, height: 24 }}
            resizeMode="contain"
          />
        </Pressable>
        <Pressable
          onPress={() => void submit()}
          disabled={!canSend}
          className="h-9 items-center justify-center rounded-full bg-ola-primary px-4"
          style={{ opacity: canSend ? 1 : 0.4 }}
        >
          <Text className="text-sm font-medium text-white">{t('me.commentSend')}</Text>
        </Pressable>
      </View>

      {smileyOpen && (
        <SmileyKulPanel
          hideKul
          onPickEmoji={insertAtCursor}
          onBackspace={backspaceAtCursor}
        />
      )}
    </View>
  );
}
