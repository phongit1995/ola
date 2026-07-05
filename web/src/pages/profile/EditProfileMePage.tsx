import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { UserService } from '@services';
import { ApiError, colorForName, toast } from '@lib';
import type { Gender, UpdateProfileRequest } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import cameraIcon from '@/assets/icons/profile/ic_action_camera.png';
import { Avatar } from '@components';
import { CoverImageEditor } from './components/CoverImageEditor';
import { CoverCropOverlay } from './components/CoverCropOverlay';
import { ChangePasswordDialog } from './components/ChangePasswordDialog';
import { readImageSize } from './imageSize';
import { AVATAR_ASPECT, COVER_ASPECT, INPUT_CLASS, MIN_AVATAR_SOURCE, PHONE_PATTERN } from './constants';

function LockIcon({ className = 'h-4 w-4' }: { className?: string }) {
  return (
    <svg viewBox="0 0 24 24" className={className} fill="currentColor" aria-hidden="true">
      <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" />
    </svg>
  );
}

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return (
    <div className="mt-4 first:mt-0">
      <div className="text-xs text-black/54">{label}</div>
      <div className="mt-1">{children}</div>
      <div className="mt-4 h-px bg-black/12" />
    </div>
  );
}

interface AvatarPickerProps {
  avatar: string;
  nick: string;
  uploading: boolean;
  onPick: (file: File) => void;
}

function AvatarPicker({ avatar, nick, uploading, onPick }: AvatarPickerProps) {
  const { t } = useTranslation();
  const inputRef = useRef<HTMLInputElement>(null);
  const [cropSrc, setCropSrc] = useState<string | null>(null);

  const clearCrop = useCallback(() => {
    setCropSrc((prev) => {
      if (prev) URL.revokeObjectURL(prev);
      return null;
    });
  }, []);

  useEffect(() => clearCrop, [clearCrop]);

  async function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file) return;
    const url = URL.createObjectURL(file);
    try {
      const size = await readImageSize(url);
      if (Math.min(size.width, size.height) < MIN_AVATAR_SOURCE) {
        URL.revokeObjectURL(url);
        toast.error(t('avatar.tooSmall'));
        return;
      }
    } catch {
      URL.revokeObjectURL(url);
      toast.error(t('avatar.error'));
      return;
    }
    clearCrop();
    setCropSrc(url);
  }

  return (
    <div className="mb-4 flex flex-col items-center">
      <button
        type="button"
        onClick={() => inputRef.current?.click()}
        disabled={uploading}
        className="relative"
      >
        {avatar ? (
          <img src={avatar} alt="" className="h-24 w-24 rounded-full object-cover ring-4 ring-white" />
        ) : (
          <Avatar name={nick} color={colorForName(nick)} size={96} />
        )}
        <span className="absolute right-0 bottom-0 flex h-7 w-7 items-center justify-center rounded-full border-2 border-white bg-ola-primary text-white">
          <svg viewBox="0 0 24 24" className="h-4 w-4" fill="currentColor" aria-hidden="true">
            <path d="M9 3 7.17 5H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V7a2 2 0 0 0-2-2h-3.17L15 3H9zm3 5a5 5 0 1 1 0 10 5 5 0 0 1 0-10z" />
          </svg>
        </span>
      </button>
      {uploading ? <span className="mt-2 text-xs text-black/54">{t('common.loading')}</span> : null}
      <input ref={inputRef} type="file" accept="image/*" className="hidden" onChange={handleChange} />
      {cropSrc && (
        <CoverCropOverlay
          src={cropSrc}
          aspect={AVATAR_ASPECT}
          onCancel={clearCrop}
          onApply={(cropped) => {
            onPick(cropped);
            clearCrop();
          }}
        />
      )}
    </div>
  );
}

function GenderSelect({ value, onChange }: { value: Gender; onChange: (gender: Gender) => void }) {
  const { t } = useTranslation();
  return (
    <div className="flex gap-2">
      {(['male', 'female'] as const).map((option) => (
        <button
          key={option}
          type="button"
          onClick={() => onChange(option)}
          className={`flex flex-1 items-center justify-center gap-1 rounded border py-1.5 text-sm ${
            value === option
              ? 'border-ola-primary bg-ola-primary-light text-ola-primary-darker'
              : 'border-black/12 text-black/54'
          }`}
        >
          {option === 'male' ? t('profile.genderMale') : t('profile.genderFemale')}
          <img
            src={option === 'male' ? maleIcon : femaleIcon}
            alt=""
            className="h-4 w-4 object-contain"
          />
        </button>
      ))}
    </div>
  );
}

export function EditProfileMePage({ onClose }: { onClose: () => void }) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [avatar, setAvatar] = useState(user?.avatar ?? '');
  const [fullName, setFullName] = useState(user?.fullName ?? '');
  const [phone, setPhone] = useState(user?.phone ?? '');
  const [gender, setGender] = useState<Gender>(user?.gender ?? 'male');
  const [dateOfBirth, setDateOfBirth] = useState(user?.dateOfBirth ?? '');
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [coverPreview, setCoverPreview] = useState<{ url: string; file: File } | null>(null);
  const [passwordOpen, setPasswordOpen] = useState(false);
  const coverInputRef = useRef<HTMLInputElement>(null);

  const clearCoverPreview = useCallback(() => {
    setCoverPreview((prev) => {
      if (prev) URL.revokeObjectURL(prev.url);
      return null;
    });
  }, []);

  useEffect(() => clearCoverPreview, [clearCoverPreview]);

  const uploadCover = useCallback(
    async (file: File) => {
      setUploadingCover(true);
      try {
        const { url } = await UserService.uploadAvatar(file);
        await UserService.updateMe({ coverPhoto: url });
        await refreshUser();
        toast.success(t('profileEdit.coverUpdated'));
        return true;
      } catch {
        toast.error(t('profileEdit.coverError'));
        return false;
      } finally {
        setUploadingCover(false);
      }
    },
    [refreshUser, t]
  );

  function pickCover(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file) return;
    clearCoverPreview();
    setCoverPreview({ url: URL.createObjectURL(file), file });
  }

  if (!user) return null;

  const nick = user.fullName || user.username;
  const cover = user.coverPhoto ?? '';

  function validate(): string | null {
    if (!fullName.trim()) return t('profileEdit.fullnameRequired');
    if (phone.trim() && !PHONE_PATTERN.test(phone.trim())) return t('profileEdit.phoneInvalid');
    return null;
  }

  async function uploadAvatar(file: File) {
    if (uploading) return;
    setUploading(true);
    try {
      const result = await UserService.uploadAvatar(file);
      setAvatar(result.url);
      toast.success(t('profileEdit.avatarUpdated'));
    } catch {
      toast.error(t('profileEdit.avatarError'));
    } finally {
      setUploading(false);
    }
  }

  async function save() {
    if (saving) return;
    const validationError = validate();
    if (validationError) {
      setError(validationError);
      return;
    }
    setError(null);
    setSaving(true);
    const payload: UpdateProfileRequest = {
      avatar,
      fullName: fullName.trim(),
      phone: phone.trim(),
      gender,
      dateOfBirth,
    };
    try {
      await UserService.updateMe(payload);
      await refreshUser();
      toast.success(t('profileEdit.saved'));
      onClose();
    } catch (err) {
      const message = err instanceof ApiError ? err.message : t('profileEdit.saveError');
      setError(message);
      toast.error(message);
      setSaving(false);
    }
  }

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-white">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('chat.back')}
          onClick={() => onClose()}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">{t('profileEdit.title')}</span>
        <button
          type="button"
          onClick={() => setPasswordOpen(true)}
          className="flex h-8 shrink-0 items-center gap-1 rounded-full bg-white/15 px-2.5 text-xs font-medium hover:bg-white/25"
        >
          <LockIcon />
          <span>{t('changePassword.title')}</span>
        </button>
      </header>

      <div className="flex-1 overflow-y-auto">
        <div
          className="relative h-44 w-full bg-ola-primary-light bg-cover bg-center"
          style={cover ? { backgroundImage: `url(${cover})` } : undefined}
        >
          <button
            type="button"
            onClick={() => coverInputRef.current?.click()}
            disabled={uploadingCover}
            aria-label={t('profile.changeCover')}
            className="absolute right-2 bottom-2 flex h-8 w-8 items-center justify-center rounded-full bg-black/40 disabled:opacity-60"
          >
            <img src={cameraIcon} alt="" className="h-5 w-5 object-contain brightness-0 invert" />
          </button>
          {uploadingCover && (
            <div className="absolute inset-0 flex items-center justify-center bg-black/30 text-sm text-white">
              {t('common.loading')}
            </div>
          )}
          <input
            ref={coverInputRef}
            type="file"
            accept="image/*"
            className="hidden"
            aria-label={t('profile.changeCover')}
            onChange={pickCover}
          />
        </div>

        {coverPreview && (
          <CoverImageEditor
            src={coverPreview.url}
            aspect={COVER_ASPECT}
            busy={uploadingCover}
            onCancel={clearCoverPreview}
            onApply={async (file) => {
              const ok = await uploadCover(file);
              if (ok) clearCoverPreview();
            }}
          />
        )}

        <div className="p-4">
          {error ? (
            <div className="mb-4 rounded bg-[#e34545]/10 px-3 py-2 text-sm text-[#e34545]">{error}</div>
          ) : null}

          <div className="-mt-12">
            <AvatarPicker avatar={avatar} nick={nick} uploading={uploading} onPick={uploadAvatar} />
          </div>

          <Field label={t('profileEdit.fullnameLabel')}>
            <input
              className={INPUT_CLASS}
              value={fullName}
              onChange={(event) => setFullName(event.target.value)}
              placeholder={t('profileEdit.fullnameHint')}
              maxLength={100}
            />
          </Field>

          <Field label={t('profileEdit.phoneLabel')}>
            <input
              className={INPUT_CLASS}
              value={phone}
              inputMode="tel"
              onChange={(event) => setPhone(event.target.value)}
              placeholder={t('profileEdit.phoneHint')}
              maxLength={20}
            />
          </Field>

          <Field label={t('profileEdit.genderLabel')}>
            <GenderSelect value={gender} onChange={setGender} />
          </Field>

          <Field label={t('profileEdit.birthdayLabel')}>
            <input
              type="date"
              className={INPUT_CLASS}
              value={dateOfBirth}
              onChange={(event) => setDateOfBirth(event.target.value)}
            />
          </Field>
        </div>
      </div>

      <div className="flex shrink-0 gap-3 border-t border-black/12 bg-white p-4">
        <button
          type="button"
          onClick={() => onClose()}
          disabled={saving}
          className="flex-1 rounded border border-black/12 py-2.5 text-sm font-medium text-black/54 disabled:opacity-60"
        >
          {t('common.cancel')}
        </button>
        <button
          type="button"
          onClick={save}
          disabled={saving || uploading}
          className="flex-1 rounded bg-ola-primary py-2.5 text-sm font-medium text-white disabled:opacity-60"
        >
          {saving ? t('profileEdit.saving') : t('profileEdit.save')}
        </button>
      </div>

      <ChangePasswordDialog open={passwordOpen} onClose={() => setPasswordOpen(false)} />
    </div>
  );
}
