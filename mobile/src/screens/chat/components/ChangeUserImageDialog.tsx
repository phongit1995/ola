import { useState } from 'react';
import type { ReactNode } from 'react';
import { Pressable, Text, View } from 'react-native';
import { MeService, UserService } from '@ola/shared/services';
import { toast } from '@ola/shared/lib';
import type { NativeUploadFile } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { Dialog, DialogButton } from '@components/ui/Dialog';
import { pickValidatedCroppedImage } from '@lib/imagePicker';

interface ChangeUserImageTexts {
  title: string;
  tooSmall: string;
  error: string;
  success: string;
  saving: string;
  save: string;
  cancel: string;
  changeHint: string;
  postToMe: string;
  postContent: string;
}

interface PickerRenderProps {
  shownUri: string;
  saving: boolean;
  openPicker: () => void;
}

interface ChangeUserImageDialogProps {
  visible: boolean;
  onClose: () => void;
  outputWidth: number;
  outputHeight: number;
  currentUrl: string;
  texts: ChangeUserImageTexts;
  buildUpdate: (url: string) => Parameters<typeof UserService.updateMe>[0];
  renderPicker: (picker: PickerRenderProps) => ReactNode;
}

function CheckBox({ checked }: { checked: boolean }) {
  return (
    <View
      className="h-5 w-5 items-center justify-center rounded"
      style={{
        borderWidth: checked ? 0 : 1,
        borderColor: 'rgba(0,0,0,0.3)',
        backgroundColor: checked ? '#7cb342' : 'transparent',
      }}
    >
      {checked && <Text className="text-xs font-bold text-white">✓</Text>}
    </View>
  );
}

export function ChangeUserImageDialog({
  visible,
  onClose,
  outputWidth,
  outputHeight,
  currentUrl,
  texts,
  buildUpdate,
  renderPicker,
}: ChangeUserImageDialogProps) {
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [file, setFile] = useState<NativeUploadFile | null>(null);
  const [postToMe, setPostToMe] = useState(false);
  const [saving, setSaving] = useState(false);

  function close() {
    if (saving) return;
    setFile(null);
    setPostToMe(false);
    onClose();
  }

  async function pick() {
    if (saving) return;
    const picked = await pickValidatedCroppedImage(outputWidth, outputHeight, texts);
    if (picked == null) return;
    setFile(picked);
  }

  async function save() {
    if (file == null || saving) return;
    setSaving(true);
    try {
      const uploaded = await UserService.uploadAvatar(file);
      await UserService.updateMe(buildUpdate(uploaded.url));
      if (postToMe) {
        await MeService.create({
          content: texts.postContent,
          images: [{ url: uploaded.url }],
        });
      }
      await refreshUser();
      toast.success(texts.success);
      setSaving(false);
      setFile(null);
      setPostToMe(false);
      onClose();
    } catch {
      toast.error(texts.error);
      setSaving(false);
    }
  }

  return (
    <Dialog
      visible={visible}
      onClose={close}
      dismissOnBackdrop={!saving}
      title={texts.title}
      footer={
        <>
          <DialogButton variant="green" onPress={() => void save()} disabled={saving || file == null}>
            {saving ? texts.saving : texts.save}
          </DialogButton>
          <DialogButton variant="default" onPress={close} disabled={saving}>
            {texts.cancel}
          </DialogButton>
        </>
      }
    >
      <View className="items-center py-2">
        {renderPicker({ shownUri: file?.uri ?? currentUrl, saving, openPicker: () => void pick() })}

        <Text className="mt-3 text-xs text-ola-ink-soft">
          {texts.changeHint}
        </Text>

        <Pressable
          className="mt-6 flex-row items-center justify-center gap-3"
          onPress={() => setPostToMe((v) => !v)}
          disabled={saving}
        >
          <CheckBox checked={postToMe} />
          <Text className="text-sm text-ola-ink">
            {texts.postToMe}
          </Text>
        </Pressable>
      </View>
    </Dialog>
  );
}
