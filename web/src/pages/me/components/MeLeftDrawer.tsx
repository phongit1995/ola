import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { DEFAULT_AVATAR_COLOR } from '@lib';
import personalIcon from '@/assets/icons/me/ic_drawer_personal.png';
import marriageIcon from '@/assets/icons/me/header/ic_header_marriage.png';
import favoriteIcon from '@/assets/icons/me/header/ic_header_favorite.png';
import visitorsIcon from '@/assets/icons/me/header/ic_header_visitors.png';
import clanIcon from '@/assets/icons/me/header/ic_header_clan.png';
import momentIcon from '@/assets/icons/me/ic_drawer_moment.svg';
import { CLOSE_ANIMATION_MS } from '../constants';

interface MeLeftDrawerProps {
  displayName: string;
  avatarUrl?: string;
  avatarFrameId?: string | null;
  coverUrl?: string;
  showMoment: boolean;
  onClose: () => void;
  onSelect: (key: string) => void;
  onViewProfile: () => void;
}

interface DrawerItem {
  key: string;
  icon: string;
  label: string;
  opticalSize?: number;
  opticalOffsetY?: number;
}

export function MeLeftDrawer({
  displayName,
  avatarUrl,
  avatarFrameId,
  coverUrl,
  showMoment,
  onClose,
  onSelect,
  onViewProfile,
}: MeLeftDrawerProps) {
  const { t } = useTranslation();
  const [shown, setShown] = useState(false);

  useEffect(() => {
    const id = requestAnimationFrame(() => setShown(true));
    return () => cancelAnimationFrame(id);
  }, []);

  function handleClose() {
    setShown(false);
    window.setTimeout(onClose, CLOSE_ANIMATION_MS);
  }

  function viewProfile() {
    onViewProfile();
    handleClose();
  }

  const items: DrawerItem[] = [
    { key: 'personal', icon: personalIcon, label: t('me.drawerPersonal') },
    ...(showMoment
      ? [{ key: 'moment', icon: momentIcon, label: t('moment.trayTitle') }]
      : []),
    {
      key: 'marriage',
      icon: marriageIcon,
      label: t('me.drawerMarriage'),
    },
    {
      key: 'likes',
      icon: favoriteIcon,
      label: t('me.drawerLikes'),
    },
    {
      key: 'visitors',
      icon: visitorsIcon,
      label: t('me.tabVisitors'),
    },
    {
      key: 'clan',
      icon: clanIcon,
      label: t('me.drawerClan'),
      opticalSize: 28,
      opticalOffsetY: 1,
    },
  ];

  function pick(key: string) {
    onSelect(key);
    handleClose();
  }

  return (
    <>
      <button
        type="button"
        aria-label={t('me.closeMenu')}
        onClick={handleClose}
        className={`absolute inset-0 z-30 bg-black/30 transition-opacity duration-200 ${
          shown ? 'opacity-100' : 'opacity-0'
        }`}
      />
      <div
        className={`absolute inset-y-0 left-0 z-40 flex w-60 flex-col bg-white shadow-xl transition-transform duration-200 ${
          shown ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        <button
          type="button"
          aria-label={t('me.viewProfile')}
          onClick={viewProfile}
          style={coverUrl ? { backgroundImage: `url(${coverUrl})` } : undefined}
          className="relative h-28 shrink-0 bg-ola-primary-dark bg-cover bg-center text-left"
        >
          <span className="absolute inset-x-0 bottom-0 flex items-center gap-2 bg-linear-to-t from-black/70 to-transparent px-2 pb-2 pt-8">
            <AvatarWithFrame
              name={displayName}
              src={avatarUrl}
              color={DEFAULT_AVATAR_COLOR}
              size={40}
              frameId={avatarFrameId}
            />
            <span className="min-w-0 flex-1 truncate text-base font-medium text-white">
              {displayName}
            </span>
          </span>
        </button>
        <nav className="min-h-0 flex-1 overflow-y-auto">
          {items.map((item) => (
            <button
              key={item.key}
              type="button"
              onClick={() => pick(item.key)}
              className="flex h-12 w-full items-center gap-2 px-2 text-left hover:bg-ola-primary-light"
            >
              <span className="flex h-8 w-8 shrink-0 items-center justify-center">
                <img
                  src={item.icon}
                  alt=""
                  style={{
                    width: item.opticalSize ?? 24,
                    height: item.opticalSize ?? 24,
                    transform: `translateY(${item.opticalOffsetY ?? 0}px)`,
                  }}
                  className="object-contain opacity-[0.26]"
                />
              </span>
              <span className="min-w-0 flex-1 truncate text-base text-black/87">
                {item.label}
              </span>
            </button>
          ))}
        </nav>
      </div>
    </>
  );
}
