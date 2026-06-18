import { useTranslation } from 'react-i18next';
import checkedIcon from '@/assets/icons/profile/ic_checked.png';
import cameraIcon from '@/assets/icons/profile/ic_action_camera.png';
import kissIcon from '@/assets/icons/profile/sticker_kiss.png';
import maleIcon from '@/assets/icons/profile/ic_indicate_male.png';
import femaleIcon from '@/assets/icons/profile/ic_indicate_female.png';
import marriageIcon from '@/assets/icons/profile/ic_profile_marriage.png';
import birthdayIcon from '@/assets/icons/profile/ic_profile_birthday.png';
import noteIcon from '@/assets/icons/profile/ic_profile_note.png';
import { Avatar } from '@components';
import type { ProfileActions, UserProfile } from '../types';
import type { RelationshipInfo } from '@app-types';
import { RelationButtons } from './RelationButtons';

interface ProfileCardProps {
  profile: UserProfile;
  relationship: RelationshipInfo;
  actions: ProfileActions;
  onPostMe: () => void;
  onUpdateInfo: () => void;
}

function InfoRow({ icon, text, note }: { icon: string; text: string; note?: boolean }) {
  return (
    <div
      className={`mt-2 ml-4 flex items-center gap-1 text-xs ${
        note ? 'text-ola-primary-darker italic' : 'text-black/54'
      }`}
    >
      <img src={icon} alt="" className="h-4 w-4 object-contain" />
      {text}
    </div>
  );
}

export function ProfileCard({ profile, relationship, actions, onPostMe, onUpdateInfo }: ProfileCardProps) {
  const { t } = useTranslation();

  return (
    <div className="mb-2 bg-white shadow-[0_1px_2px_rgba(0,0,0,0.18)]">
      <div
        className="relative mb-12 h-48 w-full bg-cover bg-center"
        style={
          profile.coverPhoto
            ? { backgroundImage: `url(${profile.coverPhoto})` }
            : { backgroundColor: profile.coverColor }
        }
      >
        {profile.isSelf && (
          <img
            src={cameraIcon}
            alt=""
            className="absolute right-2 bottom-2 h-6 w-6 object-contain"
          />
        )}
        <div className="absolute -bottom-12 left-1/2 flex -translate-x-1/2 bg-white p-1 pb-1.5 shadow-[0_1px_3px_rgba(0,0,0,0.3)]">
          <Avatar name={profile.nick} color={profile.color} size={96} src={profile.avatar} rounded={false} />
        </div>
      </div>

      <div className="flex items-center justify-center gap-1 p-2">
        <span className="text-lg text-black/54">{profile.nick}</span>
        {profile.verified && <img src={checkedIcon} alt="" className="h-5 w-5 object-contain" />}
      </div>

      <div className="mx-4 h-px bg-black/12" />

      <RelationButtons
        nick={profile.nick}
        isSelf={profile.isSelf}
        onPostMe={onPostMe}
        onUpdateInfo={onUpdateInfo}
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

      {profile.vip && (
        <div className="mt-3 ml-4 flex items-center gap-1">
          <span className="flex h-6 w-6 items-center justify-center rounded-full bg-ola-accent text-xs font-bold text-white">
            ★
          </span>
          <span className="text-xs font-bold text-ola-accent">{t('profile.vipAccount')}</span>
        </div>
      )}

      <div className="pb-4">
        <InfoRow
          icon={profile.gender === 'female' ? femaleIcon : maleIcon}
          text={profile.gender === 'female' ? t('profile.genderFemale') : t('profile.genderMale')}
        />
        <InfoRow icon={marriageIcon} text={profile.marriage} />
        <InfoRow icon={birthdayIcon} text={profile.birthday} />
        <div className="mt-2 ml-4 text-xs text-black/54">{profile.joinDate}</div>
        <InfoRow icon={noteIcon} text={t('profile.viewNote')} note />
      </div>
    </div>
  );
}
