import { forwardRef, useImperativeHandle, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Keyboard, Pressable, ScrollView, Text, View } from 'react-native';
import { launchImageLibrary } from 'react-native-image-picker';
import type { NativeUploadFile } from '@ola/shared/lib';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { kulToken } from '@lib/kul';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { useLastKeyboardHeight } from '@hooks/useKeyboardHeight';
import { SmileyKulPanel, SMILEY_PANEL_MIN_CONTENT_HEIGHT } from './SmileyKulPanel';

const likeIcon = require('@assets/icons/chat/smiley/smiley_35.png');
const smileyIcon = require('@assets/icons/chat/ic_smiley.png');
const smileyIconActive = require('@assets/icons/chat/ic_smiley_selected.png');
const photoIcon = require('@assets/icons/chat/ic_local.png');

export interface RoomComposerHandle {
  focus: () => void;
  insertMention: (name: string) => void;
  closePanel: () => void;
}

interface PendingImage {
  id: string;
  uri: string;
  file: NativeUploadFile;
}

interface RoomComposerBarProps {
  disabled: boolean;
  onBeforeSend: () => void;
  onSendText: (content: string) => Promise<void>;
  onSendImage: (file: NativeUploadFile) => Promise<void>;
}

export const RoomComposerBar = forwardRef<RoomComposerHandle, RoomComposerBarProps>(
  function RoomComposerBarInner({ disabled, onBeforeSend, onSendText, onSendImage }, ref) {
    const { t } = useTranslation();
    const pushToast = useToastStore((s) => s.push);
    const [draft, setDraft] = useState('');
    const [panelOpen, setPanelOpen] = useState(false);
    const [pendingImages, setPendingImages] = useState<PendingImage[]>([]);
    const composerRef = useRef<ChatComposerHandle>(null);
    const imageIdRef = useRef(0);
    const lastKeyboardHeight = useLastKeyboardHeight();
    const panelContentHeight = Math.max(SMILEY_PANEL_MIN_CONTENT_HEIGHT, lastKeyboardHeight - 44);

    function togglePanel() {
      if (panelOpen) {
        setPanelOpen(false);
        return;
      }
      Keyboard.dismiss();
      setPanelOpen(true);
    }

    function insertMention(name: string) {
      setDraft((current) => {
        const escaped = name.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const alreadyTagged = new RegExp(`@${escaped}(?![\\p{L}\\p{N}_])`, 'iu');
        if (alreadyTagged.test(current)) return current;
        const prefix = current === '' || current.endsWith(' ') ? current : `${current} `;
        return `${prefix}@${name} `;
      });
    }

    useImperativeHandle(ref, () => ({
      focus: () => composerRef.current?.focus(),
      insertMention,
      closePanel: () => setPanelOpen(false),
    }));

    async function sendText(text: string) {
      const trimmed = text.trim();
      if (trimmed === '' || disabled) return;
      onBeforeSend();
      setDraft('');
      try {
        await onSendText(trimmed);
      } catch {
        setDraft(trimmed);
        pushToast('error', t('room.sendError'));
      }
    }

    async function pickImages() {
      if (disabled) return;
      const keyboardWasVisible = Keyboard.isVisible();
      const result = await launchImageLibrary({ mediaType: 'photo', selectionLimit: 0 });
      if (keyboardWasVisible) requestAnimationFrame(() => composerRef.current?.focus());
      if (result.didCancel) return;
      const assets = result.assets ?? [];
      if (assets.length === 0) {
        if (result.errorCode != null) pushToast('error', t('room.sendError'));
        return;
      }
      setPendingImages((current) => {
        const next = [...current];
        for (const asset of assets) {
          if (asset.uri == null) continue;
          imageIdRef.current += 1;
          next.push({
            id: String(imageIdRef.current),
            uri: asset.uri,
            file: {
              uri: asset.uri,
              name: asset.fileName ?? 'photo.jpg',
              type: asset.type ?? 'image/jpeg',
            },
          });
        }
        return next;
      });
    }

    function removePendingImage(id: string) {
      setPendingImages((current) => current.filter((image) => image.id !== id));
    }

    function clearPendingImages() {
      setPendingImages([]);
    }

    async function sendPendingImages() {
      const images = pendingImages;
      if (images.length === 0 || disabled) return;
      onBeforeSend();
      setPendingImages([]);
      setPanelOpen(false);
      for (const image of images) {
        try {
          await onSendImage(image.file);
        } catch {
          pushToast('error', t('room.sendError'));
        }
      }
    }

    const isTyping = draft.trim() !== '';

    return (
      <View className="bg-white">
        <View
          className="flex-row items-center gap-1 bg-white px-2 py-2"
          style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
        >
          <Pressable
            onPress={togglePanel}
            className="h-9 w-9 items-center justify-center"
            style={{ opacity: panelOpen ? 1 : 0.6 }}
          >
            <Image
              source={panelOpen ? smileyIconActive : smileyIcon}
              style={{ width: 24, height: 24 }}
              resizeMode="contain"
            />
          </Pressable>
          <Pressable
            onPress={() => void pickImages()}
            disabled={disabled}
            className="h-9 w-9 items-center justify-center"
            style={{ opacity: 0.6 }}
          >
            <Image source={photoIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          {pendingImages.length > 0 ? (
            <ScrollView
              horizontal
              showsHorizontalScrollIndicator={false}
              className="min-h-9 flex-1"
              contentContainerClassName="items-center gap-2 px-1 py-1"
            >
              {pendingImages.map((image) => (
                <View key={image.id} className="relative">
                  <Image
                    source={{ uri: image.uri }}
                    style={{ width: 44, height: 44, borderRadius: 8 }}
                    resizeMode="cover"
                  />
                  <Pressable
                    onPress={() => removePendingImage(image.id)}
                    className="absolute h-5 w-5 items-center justify-center rounded-full"
                    style={{ top: -6, right: -6, backgroundColor: 'rgba(0,0,0,0.6)' }}
                  >
                    <Text className="text-xs leading-none text-white">×</Text>
                  </Pressable>
                </View>
              ))}
              <Pressable
                onPress={clearPendingImages}
                className="ml-1 h-9 items-center justify-center rounded-full px-3"
                style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
              >
                <Text className="text-sm font-medium" style={{ color: 'rgba(0,0,0,0.54)' }}>
                  {t('dialog.cancel')}
                </Text>
              </Pressable>
            </ScrollView>
          ) : (
            <View
              className="flex-1 rounded-2xl"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <ChatComposer
                ref={composerRef}
                value={draft}
                onChange={setDraft}
                editable={!disabled}
                placeholder={t('room.chatInputHint')}
                onFocus={() => setPanelOpen(false)}
              />
            </View>
          )}
          {pendingImages.length > 0 ? (
            <Pressable
              onPress={() => void sendPendingImages()}
              disabled={disabled}
              className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
            >
              <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
            </Pressable>
          ) : isTyping ? (
            <Pressable
              onPress={() => {
                void sendText(draft);
                if (!panelOpen) requestAnimationFrame(() => composerRef.current?.focus());
              }}
              disabled={disabled}
              className="h-9 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-90"
            >
              <Text className="text-sm font-semibold text-white">{t('chat.send')}</Text>
            </Pressable>
          ) : (
            <Pressable
              onPress={() => void sendText('(y)')}
              onLongPress={() => void sendText('(Y)')}
              disabled={disabled}
              className="h-9 w-9 items-center justify-center"
            >
              <Image source={likeIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
            </Pressable>
          )}
        </View>

        {panelOpen && !disabled && (
          <SmileyKulPanel
            contentHeight={panelContentHeight}
            onPickEmoji={(code) => composerRef.current?.insertCode(code, true)}
            onBackspace={() => composerRef.current?.backspace()}
            onSendKul={(index) => {
              void sendText(kulToken(index));
              setPanelOpen(false);
            }}
          />
        )}
      </View>
    );
  }
);
