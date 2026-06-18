import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { UserService } from '@services';
import { ApiError, colorForName, toast } from '@lib';
import type { Gender, UpdateProfileRequest } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import maleIcon from '@/assets/icons/chat/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/chat/ic_indicate_female.png';
import { Avatar } from '@components';

const INPUT_CLASS =
  'w-full bg-transparent text-sm text-black/87 outline-none placeholder:text-[#e34545]';

const PHONE_PATTERN = /^[0-9+\-() ]{6,20}$/;

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

  function handleChange(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (file) onPick(file);
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
          <img src={avatar} alt="" className="h-24 w-24 rounded-full object-cover" />
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

export function EditProfileMePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const user = useAuthStore((s) => s.user);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  const [avatar, setAvatar] = useState(user?.avatar ?? '');
  const [fullName, setFullName] = useState(user?.fullName ?? '');
  const [bio, setBio] = useState(user?.bio ?? '');
  const [phone, setPhone] = useState(user?.phone ?? '');
  const [gender, setGender] = useState<Gender>(user?.gender ?? 'male');
  const [dateOfBirth, setDateOfBirth] = useState(user?.dateOfBirth ?? '');
  const [saving, setSaving] = useState(false);
  const [uploading, setUploading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (!user) return null;

  const nick = user.fullName || user.username;

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
      bio: bio.trim(),
      phone: phone.trim(),
      gender,
      dateOfBirth,
    };
    try {
      await UserService.updateMe(payload);
      await refreshUser();
      toast.success(t('profileEdit.saved'));
      navigate(ROUTES.home);
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
          onClick={() => navigate(ROUTES.home)}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <svg viewBox="0 0 24 24" className="h-6 w-6" fill="currentColor" aria-hidden="true">
            <path d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />
          </svg>
        </button>
        <span className="flex-1 truncate text-base font-medium">{t('profileEdit.title')}</span>
      </header>

      <div className="flex-1 overflow-y-auto p-4">
        {error ? (
          <div className="mb-4 rounded bg-[#e34545]/10 px-3 py-2 text-sm text-[#e34545]">{error}</div>
        ) : null}

        <AvatarPicker avatar={avatar} nick={nick} uploading={uploading} onPick={uploadAvatar} />

        <Field label={t('profileEdit.fullnameLabel')}>
          <input
            className={INPUT_CLASS}
            value={fullName}
            onChange={(event) => setFullName(event.target.value)}
            placeholder={t('profileEdit.fullnameHint')}
            maxLength={100}
          />
        </Field>

        <Field label={t('profileEdit.bioLabel')}>
          <textarea
            className={`${INPUT_CLASS} resize-none`}
            value={bio}
            onChange={(event) => setBio(event.target.value)}
            placeholder={t('profileEdit.bioHint')}
            maxLength={500}
            rows={2}
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

      <div className="flex shrink-0 gap-3 border-t border-black/12 bg-white p-4">
        <button
          type="button"
          onClick={() => navigate(ROUTES.home)}
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
    </div>
  );
}
