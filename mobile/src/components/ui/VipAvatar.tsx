import { VipIcon, type VipIconProps } from './VipIcon';

type VipAvatarProps = Omit<VipIconProps, 'size'> & {
  size?: number;
};

export function VipAvatar({ typeId, size = 40 }: VipAvatarProps) {
  return <VipIcon typeId={typeId} size={size} />;
}
