import type { ReactNode } from 'react';
import { avatarIconUrl } from '../helpers/player';

export function PodAvatar({
  vipType,
  src,
  tone,
  children,
}: {
  vipType?: string | null;
  src?: string;
  tone: 'red' | 'black';
  children?: ReactNode;
}) {
  return (
    <div className={`xq-pod-avatar xq-pod-avatar-${tone}`}>
      <img className="xq-pod-avatar-img" src={src ?? avatarIconUrl(vipType)} alt="" draggable={false} />
      {children}
    </div>
  );
}
