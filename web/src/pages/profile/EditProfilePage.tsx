import { useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, ListOptionDialog, type ListOption } from '@components';
import editIcon from '@/assets/icons/profile/ic_action_edit.png';
import quitIcon from '@/assets/icons/profile/ic_action_quit.png';
import type { UserProfile } from './types';

interface EditProfilePageProps {
  profile: UserProfile;
  onClose: () => void;
}

type Gender = 'male' | 'female' | 'flexible';
type EditableField = 'fullname' | 'phone' | 'birthday';

function EditButton({ label, onClick }: { label: string; onClick: () => void }) {
  return (
    <button
      type="button"
      aria-label={label}
      onClick={onClick}
      className="ml-2 flex h-5 w-5 shrink-0 items-center justify-center rounded bg-black/30 p-0.5"
    >
      <img src={editIcon} alt="" className="h-full w-full object-contain" />
    </button>
  );
}

export function EditProfilePage({ profile, onClose }: EditProfilePageProps) {
  const { t } = useTranslation();
  const [fullname, setFullname] = useState(profile.nick);
  const [phone, setPhone] = useState('');
  const [birthday, setBirthday] = useState('1995-08-12');
  const [gender, setGender] = useState<Gender>(profile.gender);
  const [editing, setEditing] = useState<EditableField | null>(null);
  const [genderOpen, setGenderOpen] = useState(false);
  const [supportOpen, setSupportOpen] = useState(false);

  const fullnameRef = useRef<HTMLInputElement>(null);
  const phoneRef = useRef<HTMLInputElement>(null);

  function startEdit(field: EditableField, ref?: HTMLInputElement | null) {
    setEditing(field);
    window.setTimeout(() => ref?.focus(), 0);
  }

  const genderLabels: Record<Gender, string> = {
    male: t('profile.genderMale'),
    female: t('profile.genderFemale'),
    flexible: t('profileEdit.genderFlexible'),
  };

  const genderOptions: ListOption[] = [
    { key: 'male', label: genderLabels.male, onSelect: () => setGender('male') },
    { key: 'female', label: genderLabels.female, onSelect: () => setGender('female') },
    { key: 'flexible', label: genderLabels.flexible, onSelect: () => setGender('flexible') },
  ];

  return (
    <div className="fixed inset-0 z-50 flex flex-col bg-white">
      <header className="flex h-12 shrink-0 items-center gap-2 bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        <button
          type="button"
          aria-label={t('dialog.close')}
          onClick={onClose}
          className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
        >
          <img src={quitIcon} alt="" className="h-5 w-5 object-contain" />
        </button>
        <span className="flex-1 text-base font-medium">{t('profileEdit.title')}</span>
        <span className="w-9" />
      </header>

      <div className="flex-1 overflow-y-auto p-4">
        <div className="pt-2">
          <p className="text-xs text-black/54">{t('profileEdit.fullnameLabel')}</p>
          <div className="mt-1 flex items-center">
            <input
              ref={fullnameRef}
              value={fullname}
              readOnly={editing !== 'fullname'}
              onChange={(event) => setFullname(event.target.value)}
              onBlur={() => setEditing(null)}
              placeholder={t('profileEdit.fullnameHint')}
              className="flex-1 bg-transparent text-sm text-black/87 outline-none placeholder:text-[#e34545]"
            />
            <EditButton
              label={t('profileEdit.fullnameLabel')}
              onClick={() => startEdit('fullname', fullnameRef.current)}
            />
          </div>
        </div>
        <div className="mt-4 h-px bg-black/12" />

        <div className="pt-4">
          <p className="text-xs text-black/54">{t('profileEdit.phoneLabel')}</p>
          <div className="mt-1 flex items-center">
            <input
              ref={phoneRef}
              value={phone}
              type="tel"
              readOnly={editing !== 'phone'}
              onChange={(event) => setPhone(event.target.value)}
              onBlur={() => setEditing(null)}
              placeholder={t('profileEdit.phoneHint')}
              className="flex-1 bg-transparent text-sm text-black/87 outline-none placeholder:text-[#e34545]"
            />
            <EditButton
              label={t('profileEdit.phoneLabel')}
              onClick={() => startEdit('phone', phoneRef.current)}
            />
          </div>
        </div>
        <div className="mt-4 h-px bg-black/12" />

        <div className="pt-4">
          <p className="text-xs text-black/54">{t('profileEdit.birthdayLabel')}</p>
          <div className="mt-1 flex items-center">
            {editing === 'birthday' ? (
              <input
                type="date"
                value={birthday}
                autoFocus
                onChange={(event) => setBirthday(event.target.value)}
                onBlur={() => setEditing(null)}
                className="flex-1 bg-transparent text-sm text-black/87 outline-none"
              />
            ) : (
              <span className="flex-1 text-sm text-black/87">
                {birthday === '' ? (
                  <span className="text-[#e34545]">{t('profileEdit.birthdayHint')}</span>
                ) : (
                  birthday
                )}
              </span>
            )}
            <EditButton
              label={t('profileEdit.birthdayLabel')}
              onClick={() => setEditing('birthday')}
            />
          </div>
        </div>
        <div className="mt-4 h-px bg-black/12" />

        <div className="pt-4">
          <p className="text-xs text-black/54">{t('profileEdit.genderLabel')}</p>
          <div className="mt-1 flex items-center">
            <span className="flex-1 text-sm text-black/87">{genderLabels[gender]}</span>
            <EditButton
              label={t('profileEdit.genderLabel')}
              onClick={() => setGenderOpen(true)}
            />
          </div>
        </div>
        <div className="mt-4 h-px bg-black/12" />

        <button type="button" className="w-full pt-4 text-left">
          <p className="text-xs text-black/54">{t('profileEdit.relationshipLabel')}</p>
          <p className="mt-1 text-sm text-black/87">{profile.marriage}</p>
        </button>
        <div className="mt-4 h-px bg-black/12" />

        <button type="button" className="w-full pt-4 text-left">
          <p className="text-xs text-black/54">{t('profileEdit.passwordLabel')}</p>
          <p className="mt-1 text-sm text-black/87">{t('profileEdit.passwordHint')}</p>
        </button>
        <div className="mt-4 h-px bg-black/12" />

        <div className="pt-4">
          <p className="text-xs text-black/54">{t('profileEdit.joinLabel')}</p>
          <p className="mt-1 text-sm text-black/87">{profile.joinDate}</p>
        </div>

        <button
          type="button"
          className="mt-6 h-12 w-full rounded border border-ola-primary-dark text-sm text-black/87"
        >
          {t('profileEdit.linkFacebook')}
        </button>
        <button
          type="button"
          onClick={() => setSupportOpen(true)}
          className="mt-4 h-12 w-full rounded bg-ola-button text-sm font-medium text-white"
        >
          {t('profileEdit.support')}
        </button>
      </div>

      <ListOptionDialog
        open={genderOpen}
        title={t('profileEdit.genderLabel')}
        options={genderOptions}
        onClose={() => setGenderOpen(false)}
      />
      <Dialog
        open={supportOpen}
        onClose={() => setSupportOpen(false)}
        title={t('profileEdit.support')}
      >
        <p className="py-2 text-center text-black/87">{t('profileEdit.supportHotline')}</p>
      </Dialog>
    </div>
  );
}
