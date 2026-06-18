import { useRef, useState, type ChangeEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, DialogButton } from '@components';
import { UserService } from '@services';
import { ApiError, toast } from '@lib';
import type { UpdateProfileRequest } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import snapPicIcon from '@/assets/icons/chat/icon_snap_pic.png';

interface StatusEditDialogProps {
  open: boolean;
  onClose: () => void;
}

export function StatusEditDialog({ open, onClose }: StatusEditDialogProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const fileRef = useRef<HTMLInputElement>(null);

  const [bio, setBio] = useState(user?.bio ?? '');
  const [imageUrl, setImageUrl] = useState(user?.bioImage ?? '');
  const [uploading, setUploading] = useState(false);
  const [saving, setSaving] = useState(false);

  if (!user) return null;

  async function pickImage(event: ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file || uploading) return;
    setUploading(true);
    try {
      const result = await UserService.uploadAvatar(file);
      setImageUrl(result.url);
    } catch {
      toast.error(t('avatar.error'));
    } finally {
      setUploading(false);
    }
  }

  async function save() {
    if (saving) return;
    setSaving(true);
    const payload: UpdateProfileRequest = {
      bio: bio.trim(),
      bioImage: imageUrl !== '' ? imageUrl : null,
    };
    try {
      await UserService.updateMe(payload);
      await refreshUser();
      toast.success(t('statusDialog.saved'));
      onClose();
    } catch (err) {
      const message = err instanceof ApiError ? err.message : t('statusDialog.saveError');
      toast.error(message);
      setSaving(false);
    }
  }

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('statusDialog.title')}
      footer={
        <>
          <DialogButton onClick={onClose} disabled={saving}>
            {t('common.cancel')}
          </DialogButton>
          <DialogButton variant="green" onClick={save} disabled={saving || uploading}>
            {t('statusDialog.save')}
          </DialogButton>
        </>
      }
    >
      <div className="flex flex-col gap-3 p-1">
        <button
          type="button"
          onClick={() => fileRef.current?.click()}
          disabled={uploading}
          className="flex items-center gap-3 text-left"
        >
          <img
            src={imageUrl !== '' ? imageUrl : snapPicIcon}
            alt=""
            className="h-14 w-14 shrink-0 rounded-sm border border-black/12 object-cover"
          />
          <span className="text-xs text-black/54">
            {uploading ? t('common.loading') : t('statusDialog.photoHint')}
          </span>
        </button>
        <textarea
          autoFocus
          value={bio}
          onChange={(event) => setBio(event.target.value)}
          placeholder={t('chat.myStatusHint')}
          maxLength={500}
          className="min-h-24 w-full resize-none rounded-sm border border-black/12 bg-white p-2 text-base text-black/87 outline-none placeholder:text-black/38"
        />
        <input ref={fileRef} type="file" accept="image/*" className="hidden" onChange={pickImage} />
      </div>
    </Dialog>
  );
}
