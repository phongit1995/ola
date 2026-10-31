import { userAvatarIconUrl } from '../helpers/avatar';

type PlayerAvatarSize = 'sm' | 'md' | 'lg';

export function PlayerAvatar({
  name,
  vipType,
  size,
}: {
  name: string;
  vipType?: string | null;
  size?: PlayerAvatarSize;
}) {
  return (
    <span className={'tl-avatar tl-avatar-img' + (size ? ` tl-avatar-${size}` : '')}>
      <img src={userAvatarIconUrl(vipType)} alt={name} draggable={false} />
    </span>
  );
}
