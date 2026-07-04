import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, TextInput, View } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { Avatar } from '../../components/Avatar';

interface MeCommentComposerProps {
  submitting: boolean;
  onSubmit: (text: string) => Promise<boolean>;
}

export function MeCommentComposer({ submitting, onSubmit }: MeCommentComposerProps) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const [draft, setDraft] = useState('');
  const myName = me?.username ?? t('home.guest');
  const canSend = draft.trim() !== '' && !submitting;

  async function submit() {
    if (!canSend) return;
    const ok = await onSubmit(draft);
    if (ok) setDraft('');
  }

  return (
    <View
      className="flex-row items-end gap-2 bg-white px-3 py-2"
      style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
    >
      <Avatar name={myName} uri={me?.avatar ?? undefined} size={36} />
      <TextInput
        className="max-h-28 min-h-9 flex-1 rounded-2xl px-3 py-2 text-base"
        style={{ color: 'rgba(0,0,0,0.87)', textAlignVertical: 'center', borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
        placeholder={t('me.commentInputHint')}
        placeholderTextColor="rgba(0,0,0,0.38)"
        multiline
        value={draft}
        onChangeText={setDraft}
      />
      <Pressable
        onPress={() => void submit()}
        disabled={!canSend}
        className="h-9 items-center justify-center rounded-full bg-ola-primary px-4"
        style={{ opacity: canSend ? 1 : 0.4 }}
      >
        <Text className="text-sm font-medium text-white">{t('me.commentSend')}</Text>
      </Pressable>
    </View>
  );
}
