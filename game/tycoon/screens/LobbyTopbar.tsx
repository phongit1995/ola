import type { Ref } from 'react';
import { useShallow } from 'zustand/react/shallow';
import kenUrl from '../assets/lobby/ken.png';
import { TyIcon } from '../components/TyIcon';
import { formatKen } from '../helpers/format';
import { avatarIconUrl } from '../helpers/player';
import type { LobbyProfile } from '../helpers/profile';
import { useTycoon } from '../store/useTycoon';
import { useLobbyTopbarWrap } from './useLobbyTopbarWrap';

function ProfilePill({ profile, ref }: { profile: LobbyProfile; ref: Ref<HTMLDivElement> }) {
  const name = `@${profile.username}`;
  return (
    <div ref={ref} className="ty-lb-pill ty-lb-profile" aria-label={name}>
      <img className="ty-lb-avatar" src={avatarIconUrl(profile.vipType)} alt="" draggable={false} />
      <span className="ty-lb-name" aria-hidden="true">
        {name}
      </span>
    </div>
  );
}

function KenPill({ ken, bodyRef }: { ken: number; bodyRef: Ref<HTMLSpanElement> }) {
  const amount = formatKen(ken);
  return (
    <div className="ty-lb-pill ty-lb-ken" aria-label={`Số dư ${amount} KEN`}>
      <span ref={bodyRef} className="ty-lb-ken-body" aria-hidden="true">
        <b>{amount}</b>
        <img src={kenUrl} alt="" draggable={false} />
      </span>
    </div>
  );
}

export function LobbyTopbar() {
  const { profile, soundOn, toggleSound } = useTycoon(
    useShallow((s) => ({ profile: s.profile, soundOn: s.soundOn, toggleSound: s.toggleSound })),
  );
  const { topRef, profileRef, kenBodyRef, soundRef, wrap } = useLobbyTopbarWrap(profile !== null);

  return (
    <header ref={topRef} className={wrap ? 'ty-lb-top ty-lb-top-wrap' : 'ty-lb-top'}>
      {profile && <ProfilePill profile={profile} ref={profileRef} />}
      {profile && <KenPill ken={profile.ken} bodyRef={kenBodyRef} />}
      <button
        ref={soundRef}
        type="button"
        className="ty-lb-sound"
        onClick={toggleSound}
        aria-label={soundOn ? 'Tắt âm' : 'Bật âm'}
        aria-pressed={soundOn}
      >
        <TyIcon name={soundOn ? 'volume-on' : 'volume-off'} size={24} />
      </button>
    </header>
  );
}
