import { forwardRef, useEffect, useImperativeHandle, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { ChatComposer, type ChatComposerHandle } from '../../components/ChatComposer';
import { SmileyKulPanel } from '../room/SmileyKulPanel';
import { Avatar } from '../../components/Avatar';

const smileyIcon = require('../../assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('../../assets/icons/chat/ic_smiley_selected.png');

export interface MeCommentComposerHandle {
  closePanel: () => void;
}

interface MeCommentComposerProps {
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
  autoFocus?: boolean;
  initialDraft?: string;
  replyingTo?: string | null;
  onCancelReply?: () => void;
}

export const MeCommentComposer = forwardRef<MeCommentComposerHandle, MeCommentComposerProps>(
  function MeCommentComposerInner(
    { submitting, onSubmit, autoFocus, initialDraft = '', replyingTo, onCancelReply },
    ref
  ) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const [draft, setDraft] = useState(initialDraft);
  const [smileyOpen, setSmileyOpen] = useState(false);
  const composerRef = useRef<ChatComposerHandle>(null);
  const myName = me?.username ?? t('home.guest');
  const canSend = draft.trim() !== '' && !submitting;

  useEffect(() => {
    if (autoFocus === true) {
      requestAnimationFrame(() => composerRef.current?.focus());
    }
  }, [autoFocus]);

  useImperativeHandle(ref, () => ({
    closePanel: () => setSmileyOpen(false),
  }));

  async function submit() {
    if (!canSend) return;
    const ok = await onSubmit(draft);
    if (ok) {
      setDraft('');
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
          className="flex-1 rounded-2xl"
          style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
        >
          <ChatComposer
            ref={composerRef}
            value={draft}
            onChange={setDraft}
            placeholder={t('me.commentInputHint')}
            onFocus={() => setSmileyOpen(false)}
          />
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
          onPickEmoji={(code) => composerRef.current?.insertCode(code, true)}
          onBackspace={() => composerRef.current?.backspace()}
        />
      )}
    </View>
  );
});
