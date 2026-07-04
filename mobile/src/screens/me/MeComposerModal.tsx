import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';

interface MeComposerModalProps {
  visible: boolean;
  onClose: () => void;
}

export function MeComposerModal({ visible, onClose }: MeComposerModalProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const createPost = useMeFeedStore((s) => s.createPost);
  const prependPost = useMeFeedStore((s) => s.prependPost);
  const [content, setContent] = useState('');
  const [posting, setPosting] = useState(false);

  const canPost = content.trim() !== '' && !posting;

  function close() {
    setContent('');
    onClose();
  }

  async function submit() {
    if (!canPost) return;
    setPosting(true);
    const created = await createPost({ content: content.trim(), visibility: 'public' }, [], []);
    setPosting(false);
    if (created != null) {
      prependPost(created);
      close();
    }
  }

  return (
    <Modal visible={visible} animationType="slide" onRequestClose={close}>
      <KeyboardAvoidingView
        className="flex-1 bg-white"
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      >
        <View
          className="flex-row items-center justify-between bg-ola-primary px-2 pb-2"
          style={{ paddingTop: insets.top + 8 }}
        >
          <Pressable onPress={close} className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15">
            <Text className="text-2xl leading-none text-white">×</Text>
          </Pressable>
          <Text className="text-sm font-bold text-white">{t('me.composerTitle')}</Text>
          <Pressable
            onPress={() => void submit()}
            disabled={!canPost}
            className="h-9 items-center justify-center rounded-full px-4"
            style={{ opacity: canPost ? 1 : 0.4 }}
          >
            {posting ? (
              <ActivityIndicator color="#ffffff" />
            ) : (
              <Text className="text-sm font-semibold text-white">{t('me.post')}</Text>
            )}
          </Pressable>
        </View>
        <TextInput
          className="flex-1 px-4 py-3 text-base"
          style={{ color: 'rgba(0,0,0,0.87)', textAlignVertical: 'top' }}
          placeholder={t('me.composerHint')}
          placeholderTextColor="rgba(0,0,0,0.38)"
          multiline
          autoFocus
          value={content}
          onChangeText={setContent}
        />
      </KeyboardAvoidingView>
    </Modal>
  );
}
