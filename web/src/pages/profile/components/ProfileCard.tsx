import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import checkedIcon from '@/assets/icons/profile/ic_checked.png';
import cameraIcon from '@/assets/icons/profile/ic_action_camera.png';
import kissIcon from '@/assets/icons/profile/sticker_kiss.png';
import maleIcon from '@/assets/icons/profile/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/profile/ic_indicate_female.png';
import marriageIcon from '@/assets/icons/profile/ic_profile_marriage.png';
import birthdayIcon from '@/assets/icons/profile/ic_profile_birthday.png';
import noteIcon from '@/assets/icons/profile/ic_profile_note.png';
import { Avatar, UserName, VipIcon } from '@components';
import { colorForName } from '@lib';
import type { ProfileActions, UserProfile } from '../types';
import type { RelationshipInfo } from '@app-types';
import { RelationButtons } from './RelationButtons';
import { CoverImageEditor } from './CoverImageEditor';
import { COVER_ASPECT } from '../constants';

interface ProfileCardProps {
  profile: UserProfile;
  relationship: RelationshipInfo;
  actions: ProfileActions;
  onPostMe: () => void;
  onUpdateInfo: () => void;
  onOpenUser?: (nick: string) => void;
}

function InfoRow({ icon, text, note }: { icon: string; text: React.ReactNode; note?: boolean }) {
  if (text == null || text === '') return null;
  return (
    <div
      className={`mt-2 ml-4 flex items-center gap-1 text-xs ${
        note ? 'text-ola-primary-darker italic' : 'text-black/54'
      }`}
    >
      <img src={icon} alt="" className="h-3.5 w-auto shrink-0 object-contain" />
      {text}
    </div>
  );
}

export function ProfileCard({
  profile,
  relationship,
  actions,
  onPostMe,
  onUpdateInfo,
  onOpenUser,
}: ProfileCardProps) {
  const { t } = useTranslation();
  const coverInputRef = useRef<HTMLInputElement>(null);
  const [uploadingCover, setUploadingCover] = useState(false);
  const [coverPreview, setCoverPreview] = useState<{ url: string; file: File } | null>(null);

  const triggerCover = () => coverInputRef.current?.click();

  const clearCoverPreview = useCallback(() => {
    setCoverPreview((prev) => {
      if (prev) URL.revokeObjectURL(prev.url);
      return null;
    });
  }, []);

  useEffect(() => clearCoverPreview, [clearCoverPreview]);

  function onCoverPick(event: React.ChangeEvent<HTMLInputElement>) {
    const file = event.target.files?.[0];
    event.target.value = '';
    if (!file) return;
    clearCoverPreview();
    setCoverPreview({ url: URL.createObjectURL(file), file });
  }

  async function applyCover(file: File) {
    setUploadingCover(true);
    await actions.changeCover(file);
    setUploadingCover(false);
    clearCoverPreview();
  }

  return (
    <div className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div
        className="relative mb-12 aspect-video w-full bg-cover bg-center"
        style={
          profile.coverPhoto
            ? { backgroundImage: `url(${profile.coverPhoto})` }
            : { backgroundColor: profile.coverColor }
        }
      >
        {profile.isSelf && (
          <>
            <button
              type="button"
              onClick={triggerCover}
              disabled={uploadingCover}
              aria-label={t('profile.changeCover')}
              className="absolute right-2 bottom-2 flex h-8 w-8 items-center justify-center rounded-full bg-black/40 disabled:opacity-60"
            >
              <img src={cameraIcon} alt="" className="h-5 w-5 object-contain brightness-0 invert" />
            </button>
            <input
              ref={coverInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              aria-label={t('profile.changeCover')}
              onChange={onCoverPick}
            />
            {uploadingCover && (
              <div className="absolute inset-0 flex items-center justify-center bg-black/30 text-sm text-white">
                {t('common.loading')}
              </div>
            )}
          </>
        )}
        <div className="absolute -bottom-12 left-1/2 flex -translate-x-1/2 gap-1 bg-white p-px pb-0.5 shadow-[0_1px_3px_rgba(0,0,0,0.3)]">
          <Avatar name={profile.nick} color={profile.color} size={96} src={profile.avatar} rounded={false} />
          {profile.spouse ? (
            <button
              type="button"
              onClick={() => profile.spouse && onOpenUser?.(profile.spouse.nick)}
              className="leading-none"
            >
              <Avatar
                name={profile.spouse.nick}
                color={colorForName(profile.spouse.nick)}
                size={96}
                src={profile.spouse.avatar}
                rounded={false}
              />
            </button>
          ) : null}
        </div>
      </div>

      {coverPreview && (
        <CoverImageEditor
          src={coverPreview.url}
          aspect={COVER_ASPECT}
          busy={uploadingCover}
          onCancel={clearCoverPreview}
          onApply={applyCover}
        />
      )}

      <div className="flex items-center justify-center gap-1 p-2">
        <UserName
          name={`@${profile.username}`}
          fullName={profile.fullName}
          className="min-w-0 truncate text-lg text-black/87"
          fullNameClassName="text-black/54"
        />
        {profile.verified && <img src={checkedIcon} alt="" className="h-5 w-5 object-contain" />}
      </div>

      <div className="mx-4 h-px bg-black/12" />

      <RelationButtons
        nick={profile.nick}
        isSelf={profile.isSelf}
        onPostMe={onPostMe}
        onUpdateInfo={onUpdateInfo}
        onChangeCover={triggerCover}
        relationship={relationship}
        actions={actions}
      />

      <div className="mx-4 h-px bg-black/12" />

      <div className="mt-4 flex items-center justify-center gap-1">
        <b className="text-xl text-black">{profile.fans}</b>
        <span className="text-xs text-black/54">{t('profile.peopleCare')}</span>
      </div>

      <button
        type="button"
        onClick={actions.kiss}
        disabled={profile.isSelf}
        className="mt-2 flex w-full flex-col items-center gap-1 disabled:opacity-100"
      >
        <img src={kissIcon} alt="" className="max-h-16 object-contain" />
        <span className="text-sm text-black">
          {profile.kisses > 0
            ? t('profile.kissCount', { count: profile.kisses })
            : t('profile.notKissed')}
        </span>
      </button>

      <p className="mt-3 line-clamp-5 px-4 text-center text-xs text-black/54">{profile.bio}</p>

      {profile.vipTypeId != null && (
        <div className="mt-3 ml-4 flex items-center gap-1">
          <VipIcon typeId={profile.vipTypeId} className="h-6 w-6" />
          <span className="text-xs font-bold text-ola-accent">{t('profile.vipAccount')}</span>
        </div>
      )}

      <div className="pb-4">
        <InfoRow
          icon={profile.gender === 'female' ? femaleIcon : maleIcon}
          text={profile.gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')}
        />
        <InfoRow
          icon={marriageIcon}
          text={
            profile.spouse ? (
              <span>
                {t('marriage.marryWithLabel')}{' '}
                <button
                  type="button"
                  onClick={() => profile.spouse && onOpenUser?.(profile.spouse.nick)}
                  className="text-ola-primary-darker"
                >
                  @{profile.spouse.nick}
                </button>
              </span>
            ) : (
              profile.marriage
            )
          }
        />
        <InfoRow icon={birthdayIcon} text={profile.birthday} />
        <div className="mt-2 ml-4 text-xs text-black/54">{profile.joinDate}</div>
        <InfoRow icon={noteIcon} text={t('profile.viewNote')} note />
      </div>
    </div>
  );
}
