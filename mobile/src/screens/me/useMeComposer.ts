import { useEffect, useRef, useState, type RefObject } from 'react';
import { useTranslation } from 'react-i18next';
import { Keyboard } from 'react-native';
import { launchImageLibrary } from 'react-native-image-picker';
import { useMeFeedStore } from '@ola/shared/stores/feed/meFeedStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import {
  hasMePostBody,
  imageUploadErrorText,
  meAudioDraftFromPost,
} from '@ola/shared/lib';
import type {
  CreatePostRequest,
  MeAudioDraft,
  NativeUploadFile,
  Post,
  PostVisibility,
} from '@ola/shared/types';
import type { ChatComposerHandle } from '@components/ChatComposer';
import type { VoiceRecorderControlHandle } from '@components/chat/voice/VoiceRecorderControl';
import type { VoiceRecording } from '@hooks/useVoiceRecorder';
import { findActionIcon } from '@lib/checkInActions';
import { compressImagesForUpload } from '@lib/compressImage';
import { uploadFileFromAsset } from '@lib/imagePicker';
import { isPostEditExpired } from '@lib/post';
import {
  deleteTemporaryVoiceFile,
  deleteTemporaryVoiceFileAfterUiUpdate,
} from '@lib/temporaryVoiceFile';
import type { ComposedCheckIn } from './components/MeComposerCheckInPanel';
import { COMPOSER_MAX_IMAGES, COMPOSER_PRIVACY_OPTIONS } from './constants';
import type { PickedAudio, PickedPhoto } from './interface';
import type { ComposerAttachKey, ComposerPanel } from './types';

export type SubmitMePost = (
  payload: CreatePostRequest,
  files: NativeUploadFile[],
  imageUrls: string[],
  audio: MeAudioDraft | null,
) => Promise<Post | null>;

interface UseMeComposerInput {
  visible: boolean;
  onClose: () => void;
  onSaved?: (post: Post) => void;
  editPost?: Post | null;
  privacyOptions?: PostVisibility[];
  submitPost?: SubmitMePost;
  composerRef: RefObject<ChatComposerHandle | null>;
  voiceRecorderRef?: RefObject<VoiceRecorderControlHandle | null>;
}

function pickedAudioFromPost(post: Post | null | undefined): PickedAudio | null {
  const draft = meAudioDraftFromPost(post);
  if (draft?.url == null) return null;
  return { draft, uri: draft.url, temporary: false };
}

function pickedAudioFromRecording(recording: VoiceRecording): PickedAudio {
  return {
    draft: {
      file: recording.file,
      duration: recording.duration,
      waveform: recording.waveform,
    },
    uri: recording.file.uri,
    temporary: true,
  };
}

export function useMeComposer({
  visible,
  onClose,
  onSaved,
  editPost,
  privacyOptions,
  submitPost,
  composerRef,
  voiceRecorderRef,
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
  const [audio, setAudio] = useState<PickedAudio | null>(null);
  const [voiceRecording, setVoiceRecording] = useState(false);
  const [panel, setPanel] = useState<ComposerPanel>(null);
  const [posting, setPosting] = useState(false);
  const imageIdRef = useRef(0);
  const audioRef = useRef<PickedAudio | null>(null);
  audioRef.current = audio;

  const isEdit = editPost != null;

  useEffect(() => {
    if (visible) return;
    const abandoned = audioRef.current;
    if (abandoned?.temporary) void deleteTemporaryVoiceFile(abandoned.uri);
  }, [visible]);

  useEffect(
    () => () => {
      const owned = audioRef.current;
      if (owned?.temporary) void deleteTemporaryVoiceFile(owned.uri);
    },
    [],
  );

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
    setAudio(pickedAudioFromPost(editPost));
    setVoiceRecording(false);
    setPanel(null);
    if (editPost == null) {
      requestAnimationFrame(() => composerRef.current?.focus());
    }
  }, [visible, editPost, privacyOptions, composerRef]);

  function close() {
    if (posting || voiceRecording) return;
    onClose();
  }

  function removeAudio() {
    const current = audioRef.current;
    if (current?.temporary) deleteTemporaryVoiceFileAfterUiUpdate(current.uri);
    setAudio(null);
  }

  function setRecordedAudio(recording: VoiceRecording) {
    const current = audioRef.current;
    if (current?.temporary) deleteTemporaryVoiceFileAfterUiUpdate(current.uri);
    setAudio(pickedAudioFromRecording(recording));
  }

  async function pickImages() {
    const room = COMPOSER_MAX_IMAGES - photos.length;
    if (room <= 0) return;
    const keyboardWasVisible = Keyboard.isVisible();
    const result = await launchImageLibrary({
      mediaType: 'photo',
      selectionLimit: room,
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
          file: uploadFileFromAsset({ ...asset, uri: asset.uri }),
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
    if (key === 'voice') {
      if (audio != null || voiceRecording) return;
      Keyboard.dismiss();
      setPanel(null);
      voiceRecorderRef?.current?.start();
      return;
    }
    if (panel !== key) Keyboard.dismiss();
    setPanel(current => (current === key ? null : key));
  }

  const attachmentCount = photos.length + (audio != null ? 1 : 0);
  const canPost =
    !posting &&
    !voiceRecording &&
    hasMePostBody(content, attachmentCount, sticker, checkIn);

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
    } catch (err) {
      setPosting(false);
      pushToast('error', imageUploadErrorText(t, err, isEdit ? t('me.editError') : t('me.postError')));
      return;
    }
    const imageUrls = photos
      .filter(item => item.file == null)
      .map(item => item.uri);
    const audioDraft = audio?.draft ?? null;
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
    let result: Post | null = null;
    try {
      result = isEdit
        ? await updatePost(
            editPost.id,
            payload,
            files,
            imageUrls,
            editPost.images,
            audioDraft,
          )
        : submitPost != null
          ? await submitPost(payload, files, imageUrls, audioDraft)
          : await createPost(payload, files, imageUrls, audioDraft);
    } catch {
      pushToast('error', isEdit ? t('me.editError') : t('me.postError'));
    } finally {
      setPosting(false);
    }
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
    audio,
    removeAudio,
    setRecordedAudio,
    voiceRecording,
    setVoiceRecording,
    panel,
    setPanel,
    posting,
    canPost,
    close,
    handleAttach,
    submit,
  };
}
