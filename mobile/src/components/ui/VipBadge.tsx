import { VipIcon, type VipIconProps } from './VipIcon';

type VipBadgeProps = Omit<VipIconProps, 'size'> & {
  size?: number;
};

export function VipBadge({ typeId, size = 24 }: VipBadgeProps) {
  return <VipIcon typeId={typeId} size={size} />;
}
