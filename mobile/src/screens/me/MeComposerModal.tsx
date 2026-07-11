import { useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { launchImageLibrary } from 'react-native-image-picker';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { NativeUploadFile } from '@ola/shared/lib';
import type { Post, PostVisibility } from '@ola/shared/types';
import { KUL_IMAGES, stickerImageForCode } from '../../lib/kul';
import { SmileyDraftOverlay } from '../../components/SmileyDraftOverlay';
import { imageSizeForHeight } from '../../lib/richText';
import { useSmileyDraft } from '../../hooks/useSmileyDraft';
import { SmileyKulPanel } from '../room/SmileyKulPanel';
import { MeComposerTagPanel } from './MeComposerTagPanel';
import { MeComposerCheckInPanel, type ComposedCheckIn } from './MeComposerCheckInPanel';
import { findActionIcon } from '../../lib/checkInActions';

const checkInCardIcon = require('../../assets/icons/me/ic_check_in.png');
const MAX_IMAGES = 5;
const PRIVACY_OPTIONS: PostVisibility[] = ['public', 'friend', 'private'];

type ComposerPanel = 'smiley' | 'tag' | 'sticker' | 'checkin' | null;
type PickedPhoto = { id: string; uri: string; file?: NativeUploadFile };

interface MeComposerModalProps {
  visible: boolean;
  onClose: () => void;
  editPost?: Post | null;
}

function privacyKey(option: PostVisibility): 'me.privacy_public' {
  return `me.privacy_${option}` as 'me.privacy_public';
}

export function MeComposerModal({ visible, onClose, editPost }: MeComposerModalProps) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const createPost = useMeFeedStore((s) => s.createPost);
  const updatePost = useMeFeedStore((s) => s.updatePost);
  const prependPost = useMeFeedStore((s) => s.prependPost);
  const pushToast = useToastStore((s) => s.push);

  const {
    draft: content,
    setDraft: setContent,
    insertAtCursor,
    selection,
    handleSelectionChange,
  } = useSmileyDraft();
  const [privacy, setPrivacy] = useState<PostVisibility>('public');
  const [photos, setPhotos] = useState<PickedPhoto[]>([]);
  const [sticker, setSticker] = useState<string | null>(null);
  const [checkIn, setCheckIn] = useState<ComposedCheckIn | null>(null);
  const [panel, setPanel] = useState<ComposerPanel>(null);
  const [posting, setPosting] = useState(false);
  const [inputFocused, setInputFocused] = useState(false);
  const imageIdRef = useRef(0);

  const isEdit = editPost != null;

  useEffect(() => {
    if (!visible) return;
    setContent(editPost?.content ?? '');
    setPrivacy(editPost?.visibility ?? 'public');
    setPhotos((editPost?.images ?? []).map((image, index) => ({ id: `e${index}`, uri: image.url })));
    setSticker(editPost?.sticker != null && editPost.sticker !== '' ? editPost.sticker : null);
    setCheckIn(
      editPost?.checkIn != null
        ? {
            name: editPost.checkIn.name,
            address: editPost.checkIn.address ?? '',
            lat: editPost.checkIn.lat ?? 0,
            lng: editPost.checkIn.lng ?? 0,
            action: editPost.checkIn.action,
            actionIcon: editPost.checkIn.actionIcon ?? findActionIcon(editPost.checkIn.action ?? ''),
          }
        : null
    );
    setPanel(null);
  }, [visible, editPost, setContent]);

  function close() {
    onClose();
  }

  async function pickImages() {
    const room = MAX_IMAGES - photos.length;
    if (room <= 0) return;
    setPanel(null);
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: room,
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
    });
    if (result.didCancel) return;
    const assets = result.assets ?? [];
    if (assets.length === 0) {
      if (result.errorCode != null) pushToast('error', t('me.postError'));
      return;
    }
    setPhotos((current) => {
      const next = [...current];
      for (const asset of assets) {
        if (asset.uri == null || next.length >= MAX_IMAGES) continue;
        imageIdRef.current += 1;
        next.push({
          id: `n${imageIdRef.current}`,
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

  function removePhoto(id: string) {
    setPhotos((current) => current.filter((item) => item.id !== id));
  }

  function handleAttach(key: 'local' | 'smiley' | 'tag' | 'checkin' | 'sticker') {
    if (key === 'local') {
      void pickImages();
      return;
    }
    setPanel((current) => (current === key ? null : key));
  }

  const canPost =
    !posting && (content.trim() !== '' || photos.length > 0 || sticker != null || checkIn != null);

  async function submit() {
    if (!canPost) return;
    setPosting(true);
    const files = photos.filter((item) => item.file != null).map((item) => item.file as NativeUploadFile);
    const imageUrls = photos.filter((item) => item.file == null).map((item) => item.uri);
    const payload = {
      content: content.trim(),
      sticker: sticker ?? undefined,
      checkIn: checkIn != null
        ? {
            name: checkIn.name,
            address: checkIn.address,
            lat: checkIn.lat,
            lng: checkIn.lng,
            action: checkIn.action,
            actionIcon: checkIn.actionIcon,
          }
        : undefined,
      visibility: privacy,
    };
    const result = isEdit
      ? await updatePost(editPost.id, payload, files, imageUrls)
      : await createPost(payload, files, imageUrls);
    setPosting(false);
    if (result != null) {
      if (!isEdit) prependPost(result);
      close();
    }
  }

  const stickerImg = stickerImageForCode(sticker);
  const attachButtons = [
    { key: 'local' as const, glyph: '📷', label: t('me.attachLocal') },
    { key: 'smiley' as const, glyph: '😀', label: t('me.attachSmiley') },
    { key: 'tag' as const, glyph: '🏷️', label: t('me.attachTag') },
    { key: 'checkin' as const, glyph: '📍', label: t('me.attachCheckIn') },
    { key: 'sticker' as const, glyph: '😊', label: t('me.attachSticker') },
  ];

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
          <Text className="text-sm font-bold text-white">
            {isEdit ? t('me.editTitle') : t('me.composerTitle')}
          </Text>
          <Pressable
            onPress={() => void submit()}
            disabled={!canPost}
            className="h-9 items-center justify-center rounded-full px-4"
            style={{ opacity: canPost ? 1 : 0.4 }}
          >
            {posting ? (
              <ActivityIndicator color="#ffffff" />
            ) : (
              <Text className="text-sm font-semibold text-white">
                {isEdit ? t('me.saveEdit') : t('me.post')}
              </Text>
            )}
          </Pressable>
        </View>

        <View className="flex-row items-center gap-2 px-4 pt-3">
          <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.54)' }}>
            {t('me.privacyTo')}
          </Text>
          {PRIVACY_OPTIONS.map((option) => {
            const active = option === privacy;
            return (
              <Pressable
                key={option}
                onPress={() => setPrivacy(option)}
                className="rounded-full px-3 py-1"
                style={{
                  borderWidth: 1,
                  borderColor: active ? '#7cb342' : 'rgba(0,0,0,0.12)',
                  backgroundColor: active ? '#f1f8e9' : 'transparent',
                }}
              >
                <Text
                  className="text-xs"
                  style={{ color: active ? '#7cb342' : 'rgba(0,0,0,0.54)' }}
                >
                  {t(privacyKey(option))}
                </Text>
              </Pressable>
            );
          })}
        </View>

        <ScrollView className="flex-1" keyboardShouldPersistTaps="handled">
          <View
            className="mx-4 mt-3"
            style={{
              minHeight: 96,
              borderWidth: 1,
              borderColor: inputFocused ? '#7cb342' : 'rgba(0,0,0,0.12)',
              borderRadius: 6,
            }}
          >
            <TextInput
              className="px-3 py-2 text-base"
              style={{ color: 'transparent', textAlignVertical: 'top', minHeight: 94 }}
              selectionColor="#7cb342"
              cursorColor="#7cb342"
              placeholder={t('me.composerHint')}
              placeholderTextColor="rgba(0,0,0,0.38)"
              multiline
              autoFocus={!isEdit}
              value={content}
              selection={selection}
              onSelectionChange={handleSelectionChange}
              onChangeText={setContent}
              onFocus={() => {
                setInputFocused(true);
                setPanel(null);
              }}
              onBlur={() => setInputFocused(false)}
            />
            {content !== '' && (
              <View pointerEvents="none" className="absolute inset-0 overflow-hidden px-3 py-2">
                <SmileyDraftOverlay text={content} />
              </View>
            )}
          </View>

          {stickerImg != null && (
            <View
              className="mx-4 mt-2 flex-row items-center rounded-md p-2"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Image source={stickerImg} style={imageSizeForHeight(stickerImg, 64)} resizeMode="contain" />
              <Pressable onPress={() => setSticker(null)} className="ml-auto px-2">
                <Text className="text-xs" style={{ color: '#e34545' }}>{t('me.removeSticker')}</Text>
              </Pressable>
            </View>
          )}

          {checkIn != null && (
            <View
              className="mx-4 mt-2 flex-row items-center gap-2 rounded-md p-2"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
            >
              <Image source={checkInCardIcon} style={{ width: 28, height: 28 }} resizeMode="contain" />
              <View className="min-w-0 flex-1">
                {(checkIn.action ?? '') !== '' && (
                  <Text numberOfLines={1} className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                    {checkIn.actionIcon} {checkIn.action}
                  </Text>
                )}
                <Text numberOfLines={1} className="text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
                  {checkIn.name}
                </Text>
              </View>
              <Pressable onPress={() => setCheckIn(null)} className="px-2">
                <Text className="text-xs" style={{ color: '#e34545' }}>{t('me.removeCheckIn')}</Text>
              </Pressable>
            </View>
          )}

          {photos.length > 0 && (
            <ScrollView
              horizontal
              showsHorizontalScrollIndicator={false}
              className="mt-3"
              contentContainerClassName="gap-2 px-4"
            >
              {photos.map((photo) => (
                <View key={photo.id} className="relative">
                  <Image
                    source={{ uri: photo.uri }}
                    style={{ width: 80, height: 80, borderRadius: 6, borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)' }}
                    resizeMode="cover"
                  />
                  <Pressable
                    onPress={() => removePhoto(photo.id)}
                    className="absolute h-5 w-5 items-center justify-center rounded-full"
                    style={{ top: 4, right: 4, backgroundColor: 'rgba(0,0,0,0.6)' }}
                  >
                    <Text className="text-sm leading-none text-white">×</Text>
                  </Pressable>
                </View>
              ))}
            </ScrollView>
          )}

          {photos.length >= MAX_IMAGES && (
            <Text className="mx-4 mt-1 text-xs" style={{ color: 'rgba(0,0,0,0.4)' }}>
              {t('me.maxImages')}
            </Text>
          )}

          {panel === 'sticker' && (
            <View
              className="mx-4 mt-2"
              style={{ borderWidth: 1, borderColor: 'rgba(0,0,0,0.12)', borderRadius: 6 }}
            >
              <ScrollView style={{ maxHeight: 176 }} keyboardShouldPersistTaps="handled">
                <View className="flex-row flex-wrap p-2">
                  {KUL_IMAGES.map((image, index) => (
                    <Pressable
                      key={index}
                      onPress={() => {
                        setSticker(`kul:${index + 1}`);
                        setPanel(null);
                      }}
                      className="items-center justify-center"
                      style={{ width: `${100 / 6}%`, height: 48 }}
                    >
                      <Image source={image} style={{ width: 40, height: 40 }} resizeMode="contain" />
                    </Pressable>
                  ))}
                </View>
              </ScrollView>
            </View>
          )}

          {panel === 'tag' && (
            <View className="mx-4 mt-2">
              <MeComposerTagPanel onMention={(nick) => insertAtCursor(` @${nick} `)} />
            </View>
          )}

          {panel === 'checkin' && (
            <View className="mx-4 mt-2">
              <MeComposerCheckInPanel
                onSelect={(value) => {
                  setCheckIn(value);
                  setPanel(null);
                }}
              />
            </View>
          )}
        </ScrollView>

        <View
          className="flex-row justify-around px-2 pt-2"
          style={{ borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.12)' }}
        >
          {attachButtons.map((button) => (
            <Pressable
              key={button.key}
              onPress={() => handleAttach(button.key)}
              className="items-center gap-0.5 px-2 py-1"
            >
              <Text style={{ fontSize: 24, lineHeight: 24 }}>{button.glyph}</Text>
              <Text
                className="text-xs"
                style={{ color: panel === button.key ? '#7cb342' : 'rgba(0,0,0,0.54)' }}
              >
                {button.label}
              </Text>
            </Pressable>
          ))}
        </View>

        {panel === 'smiley' && (
          <SmileyKulPanel hideKul onPickEmoji={insertAtCursor} />
        )}
      </KeyboardAvoidingView>
    </Modal>
  );
}
