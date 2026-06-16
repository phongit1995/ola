import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar } from '@components';
import { DEFAULT_AVATAR_COLOR } from '@lib';
import noteIcon from '@/assets/icons/me/ic_indicate_note.png';
import boxIcon from '@/assets/icons/me/ic_indicate_box.png';
import likeIcon from '@/assets/icons/me/ic_section_like.png';
import eggIcon from '@/assets/icons/me/ic_indicate_broken_egg.png';
import androidIcon from '@/assets/icons/me/ic_indicate_android.png';
import olaIcon from '@/assets/icons/me/ic_indicate_me.png';
import funnyIcon from '@/assets/icons/me/ic_indicate_funny.png';
import publicIcon from '@/assets/icons/me/ic_indicate_public.png';
import rssIcon from '@/assets/icons/me/ic_indicate_rss.png';

interface MeLeftDrawerProps {
  displayName: string;
  onClose: () => void;
  onSelect: (key: string) => void;
}

const CLOSE_ANIMATION_MS = 200;

interface DrawerItem {
  key: string;
  icon: string;
  label: string;
}

export function MeLeftDrawer({ displayName, onClose, onSelect }: MeLeftDrawerProps) {
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

  const items: DrawerItem[] = [
    { key: 'diary', icon: noteIcon, label: t('me.drawerDiary') },
    { key: 'marriage', icon: boxIcon, label: t('me.drawerMarriage') },
    { key: 'likes', icon: likeIcon, label: t('me.drawerLikes') },
    { key: 'egg', icon: eggIcon, label: t('me.drawerEgg') },
    { key: 'android', icon: androidIcon, label: '#Android' },
    { key: 'ola', icon: olaIcon, label: '#Ola' },
    { key: 'funny', icon: funnyIcon, label: t('me.drawerFunny') },
    { key: 'public', icon: publicIcon, label: t('me.drawerPublic') },
    { key: 'rss', icon: rssIcon, label: 'RSS' },
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
        <div className="relative h-28 shrink-0 bg-ola-primary-dark">
          <div className="absolute inset-x-0 bottom-0 flex items-center gap-2 bg-linear-to-t from-black/70 to-transparent px-2 pb-2 pt-8">
            <Avatar name={displayName} color={DEFAULT_AVATAR_COLOR} size={40} />
            <span className="min-w-0 flex-1 truncate text-base font-medium text-white">
              {displayName}
            </span>
          </div>
        </div>
        <nav className="min-h-0 flex-1 overflow-y-auto">
          {items.map((item) => (
            <button
              key={item.key}
              type="button"
              onClick={() => pick(item.key)}
              className="flex h-12 w-full items-center gap-2 px-2 text-left hover:bg-ola-primary-light"
            >
              <span className="flex h-8 w-8 shrink-0 items-center justify-center">
                <img src={item.icon} alt="" className="h-6 w-6 object-contain" />
              </span>
              <span className="truncate text-base text-black/87">{item.label}</span>
            </button>
          ))}
        </nav>
      </div>
    </>
  );
}
