import { useEffect, useRef, useState, type RefObject } from 'react';
import { useTranslation } from 'react-i18next';
import { Keyboard } from 'react-native';
import { launchImageLibrary } from 'react-native-image-picker';
import { useMeFeedStore } from '@ola/shared/stores/meFeedStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type {
  CreatePostRequest,
  NativeUploadFile,
  Post,
  PostVisibility,
} from '@ola/shared/types';
import type { ChatComposerHandle } from '@components/ChatComposer';
import { findActionIcon } from '@lib/checkInActions';
import { compressImagesForUpload } from '@lib/compressImage';
import { isPostEditExpired } from '@lib/post';
import type { ComposedCheckIn } from './components/MeComposerCheckInPanel';
import { COMPOSER_MAX_IMAGES, COMPOSER_PRIVACY_OPTIONS } from './constants';
import type { PickedPhoto } from './interface';
import type { ComposerAttachKey, ComposerPanel } from './types';

interface UseMeComposerInput {
  visible: boolean;
  onClose: () => void;
  onSaved?: (post: Post) => void;
  editPost?: Post | null;
  privacyOptions?: PostVisibility[];
  submitPost?: (
    payload: CreatePostRequest,
    files: NativeUploadFile[],
    imageUrls: string[],
  ) => Promise<Post | null>;
  composerRef: RefObject<ChatComposerHandle | null>;
}

export function useMeComposer({
  visible,
  onClose,
  onSaved,
  editPost,
  privacyOptions,
  submitPost,
  composerRef,
}: UseMeComposerInput) {
  const { t } = useTranslation();
  const createPost = useMeFeedStore(s => s.createPost);
  const updatePost = useMeFeedStore(s => s.updatePost);
  const prependPost = useMeFeedStore(s => s.prependPost);
  const pushToast = useToastStore(s => s.push);

  const [content, setContent] = useState('');
  const [privacy, setPrivacy] = useState<PostVisibility>('public');
  const [photos, setPhotos] = useState<PickedPhoto[]>([]);
  const [sticker, setSticker] = useState<string | null>(null);
  const [checkIn, setCheckIn] = useState<ComposedCheckIn | null>(null);
  const [panel, setPanel] = useState<ComposerPanel>(null);
  const [posting, setPosting] = useState(false);
  const imageIdRef = useRef(0);

  const isEdit = editPost != null;

  useEffect(() => {
    if (!visible) return;
    setContent(editPost?.content ?? '');
    const visibilityOptions =
      privacyOptions != null && privacyOptions.length > 0
        ? privacyOptions
        : COMPOSER_PRIVACY_OPTIONS;
    setPrivacy(
      editPost != null && visibilityOptions.includes(editPost.visibility)
        ? editPost.visibility
        : (visibilityOptions[0] ?? 'public')
    );
    setPhotos(
      (editPost?.images ?? []).map((image, index) => ({
        id: `e${index}`,
        uri: image.url,
      })),
    );
    setSticker(
      editPost?.sticker != null && editPost.sticker !== ''
        ? editPost.sticker
        : null,
    );
    setCheckIn(
      editPost?.checkIn != null
        ? {
            name: editPost.checkIn.name,
            address: editPost.checkIn.address ?? '',
            lat: editPost.checkIn.lat ?? 0,
            lng: editPost.checkIn.lng ?? 0,
            action: editPost.checkIn.action,
            actionIcon:
              editPost.checkIn.actionIcon ??
              findActionIcon(editPost.checkIn.action ?? ''),
          }
        : null,
    );
    setPanel(null);
    if (editPost == null) {
      requestAnimationFrame(() => composerRef.current?.focus());
    }
  }, [visible, editPost, privacyOptions, composerRef]);

  function close() {
    if (posting) return;
    onClose();
  }

  async function pickImages() {
    const room = COMPOSER_MAX_IMAGES - photos.length;
    if (room <= 0) return;
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: room,
      maxWidth: 1920,
      maxHeight: 1920,
      quality: 0.9,
    });
    if (keyboardWasVisible)
      requestAnimationFrame(() => composerRef.current?.focus());
    if (result.didCancel) return;
    const assets = result.assets ?? [];
    if (assets.length === 0) {
      if (result.errorCode != null) pushToast('error', t('common.error'));
      return;
    }
    setPhotos(current => {
      const next = [...current];
      for (const asset of assets) {
        if (asset.uri == null || next.length >= COMPOSER_MAX_IMAGES) continue;
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
    setPhotos(current => current.filter(item => item.id !== id));
  }

  function handleAttach(key: ComposerAttachKey) {
    if (key === 'local') {
      void pickImages();
      return;
    }
    if (panel !== key) Keyboard.dismiss();
    setPanel(current => (current === key ? null : key));
  }

  const canPost = !posting && (content.trim() !== '' || photos.length > 0);

  async function submit() {
    if (!canPost) return;
    if (isEdit && isPostEditExpired(editPost.createdAt)) {
      pushToast('info', t('me.editExpired'));
      return;
    }
    setPosting(true);
    let files: NativeUploadFile[];
    try {
      files = await compressImagesForUpload(
        photos
          .filter(item => item.file != null)
          .map(item => item.file as NativeUploadFile),
      );
    } catch {
      setPosting(false);
      pushToast('error', isEdit ? t('me.editError') : t('me.postError'));
      return;
    }
    const imageUrls = photos
      .filter(item => item.file == null)
      .map(item => item.uri);
    const payload = {
      content: content.trim(),
      sticker: sticker ?? undefined,
      checkIn:
        checkIn != null
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
      ? await updatePost(editPost.id, payload, files, imageUrls, editPost.images)
      : submitPost != null
        ? await submitPost(payload, files, imageUrls)
        : await createPost(payload, files, imageUrls);
    setPosting(false);
    if (result != null) {
      if (!isEdit && submitPost == null) prependPost(result);
      onSaved?.(result);
      onClose();
    }
  }

  return {
    isEdit,
    content,
    setContent,
    privacy,
    setPrivacy,
    photos,
    removePhoto,
    sticker,
    setSticker,
    checkIn,
    setCheckIn,
    panel,
    setPanel,
    posting,
    canPost,
    close,
    handleAttach,
    submit,
  };
}
