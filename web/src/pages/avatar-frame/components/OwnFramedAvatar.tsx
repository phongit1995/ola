import { useTranslation } from 'react-i18next';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { colorForName } from '@lib';
import { useAuthStore } from '@/store/authStore';

interface OwnFramedAvatarProps {
  frameId: string | null;
  size: number;
}

export function OwnFramedAvatar({ frameId, size }: OwnFramedAvatarProps) {
  const { t } = useTranslation();
  const user = useAuthStore((s) => s.user);
  const name = user?.username ?? t('home.guest');
  return (
    <AvatarWithFrame
      name={name}
      color={colorForName(name)}
      src={user?.avatar ?? undefined}
      size={size}
      frameId={frameId}
    />
  );
}
