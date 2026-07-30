import { VipIcon } from '@components/ui/VipIcon';

interface VipIconImageProps {
  typeId: number;
  size?: number;
  rounded?: boolean;
}

export function VipIconImage({ typeId, size = 40, rounded = false }: VipIconImageProps) {
  return (
    <VipIcon
      typeId={typeId}
      size={size}
      rounded={rounded}
      fallback="placeholder"
    />
  );
}
