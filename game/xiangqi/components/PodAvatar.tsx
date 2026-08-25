import { avatarIconUrl } from '../helpers/player';

export function PodAvatar({ vipType, src, tone }: { vipType?: string | null; src?: string; tone: 'red' | 'black' }) {
  return (
    <div className={`xq-pod-avatar xq-pod-avatar-${tone}`}>
      <img className="xq-pod-avatar-img" src={src ?? avatarIconUrl(vipType)} alt="" draggable={false} />
    </div>
  );
}
