import { useMemo, useRef, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ListOptionDialog, type ListOption } from '@components';
import { vipIconUrl, isVipActive, activeVipTypeId } from '@lib';
import type { AuthUser } from '@app-types';
import type { Contact, DeviceType } from '../types';
import { SUGGESTED_FRIENDS } from '../data';
import smileyIcon from '@/assets/icons/chat/ola_smiley_online.png';
import vipIcon from '@/assets/icons/apps/vip.png';
import snapPicIcon from '@/assets/icons/chat/icon_snap_pic.png';
import groupIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';
import devicePhone from '@/assets/icons/chat/ic_device_type_phone.png';
import devicePc from '@/assets/icons/chat/ic_device_type_pc.png';
import deviceApple from '@/assets/icons/chat/ic_device_type_apple.png';
import deviceAndroid from '@/assets/icons/chat/ic_device_type_android.png';
import deviceWinphone from '@/assets/icons/chat/ic_device_type_winphone.png';
import birthdayIcon from '@/assets/icons/chat/ic_buddy_birthday.png';

const DEVICE_ICONS: Record<DeviceType, string> = {
  phone: devicePhone,
  pc: devicePc,
  apple: deviceApple,
  android: deviceAndroid,
  winphone: deviceWinphone,
};

interface ContactListProps {
  contacts: Contact[];
  onSelect: (contact: Contact) => void;
  onOpenProfile: (contact: Contact) => void;
  me?: AuthUser | null;
  onAccountMenu?: () => void;
  onEditStatus?: () => void;
  onPreviewImage?: () => void;
  onPreviewBuddyImage?: (url: string) => void;
  onComingSoon?: () => void;
}

function ActionRow({
  badge,
  title,
  subtitle,
  showChevron = false,
  onClick,
}: {
  badge: ReactNode;
  title: string;
  subtitle: string;
  showChevron?: boolean;
  onClick?: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-3 text-left"
    >
      {badge}
      <span className="min-w-0 flex-1">
        <span className="block text-base text-black/87">{title}</span>
        <span className="block text-xs text-black/54">{subtitle}</span>
      </span>
      {showChevron && <span className="shrink-0 text-xl text-black/26">›</span>}
    </button>
  );
}

function SectionHeader({ label }: { label: string }) {
  return (
    <div className="flex h-9 items-center bg-[#d5d5d5] px-4">
      <span className="truncate text-sm font-medium text-white">{label}</span>
    </div>
  );
}

function BuddyRow({
  contact,
  highlight,
  onSelect,
  onOpenProfile,
  onLongPress,
  onPreviewImage,
}: {
  contact: Contact;
  highlight: boolean;
  onSelect: () => void;
  onOpenProfile: () => void;
  onLongPress: () => void;
  onPreviewImage?: (url: string) => void;
}) {
  const timer = useRef<number | undefined>(undefined);
  const longPressed = useRef(false);
  const showVip = contact.online && contact.vip;
  const vipSrc = contact.vipTypeId != null ? vipIconUrl(contact.vipTypeId) : vipIcon;
  const badge =
    contact.group === 'birthday'
      ? birthdayIcon
      : contact.online
        ? DEVICE_ICONS[contact.deviceType]
        : null;

  function startPress() {
    longPressed.current = false;
    timer.current = window.setTimeout(() => {
      longPressed.current = true;
      onLongPress();
    }, 450);
  }

  function cancelPress() {
    window.clearTimeout(timer.current);
  }

  function handleClick() {
    if (longPressed.current) {
      longPressed.current = false;
      return;
    }
    onSelect();
  }

  function openProfile(event: { stopPropagation: () => void }) {
    event.stopPropagation();
    if (longPressed.current) {
      longPressed.current = false;
      return;
    }
    onOpenProfile();
  }

  return (
    <li>
      <div
        onClick={handleClick}
        onPointerDown={startPress}
        onPointerUp={cancelPress}
        onPointerLeave={cancelPress}
        onContextMenu={(event) => {
          event.preventDefault();
          onLongPress();
        }}
        className={`flex w-full cursor-pointer items-center border-b border-black/12 px-4 py-3 text-left ${
          highlight ? 'bg-[#f1f8e9]' : 'bg-white/80'
        }`}
      >
        <button
          type="button"
          onClick={openProfile}
          aria-label={contact.name}
          className="relative h-10 w-10 shrink-0"
        >
          <span className="block h-10 w-10 overflow-hidden rounded">
            <Avatar name={contact.name} color={contact.color} src={contact.avatar} rounded={false} />
          </span>
          {badge != null && (
            <span className="absolute right-0 bottom-0 flex h-3.5 w-3.5 items-center justify-center rounded-full bg-ola-primary ring-1 ring-white">
              <img src={badge} alt="" className="h-2.5 w-2.5 object-contain" />
            </span>
          )}
        </button>
        <span className="ml-4 min-w-0 flex-1">
          <button type="button" onClick={openProfile} className="flex items-center gap-1 text-left">
            {showVip && <img src={vipSrc} alt="" className="h-6 w-6 shrink-0 object-contain" />}
            <span className="truncate text-base text-black/87">
              {contact.name}
              {contact.fullName != null && contact.fullName !== '' && (
                <span className="text-black/45"> · {contact.fullName}</span>
              )}
            </span>
          </button>
          {contact.status != null && contact.status !== '' && (
            <span className="block truncate text-xs text-black/54">{contact.status}</span>
          )}
        </span>
        {contact.statusImage != null && contact.statusImage !== '' && (
          <img
            src={contact.statusImage}
            alt=""
            onClick={(event) => {
              event.stopPropagation();
              onPreviewImage?.(contact.statusImage!);
            }}
            className="ml-2 h-10 w-10 shrink-0 cursor-pointer rounded border border-black/12 object-cover"
          />
        )}
        {!contact.online && contact.lastActive != null && contact.lastActive !== '' && (
          <span className="ml-2 shrink-0 text-xs text-black/54">{contact.lastActive}</span>
        )}
      </div>
    </li>
  );
}

export function ContactList({
  contacts,
  onSelect,
  onOpenProfile,
  me,
  onAccountMenu,
  onEditStatus,
  onPreviewImage,
  onPreviewBuddyImage,
  onComingSoon,
}: ContactListProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const [menuContact, setMenuContact] = useState<Contact | null>(null);
  const hasStatus = me?.bio != null && me.bio !== '';
  const hasVip = isVipActive(me?.vipEndTime);
  const meVipTypeId = activeVipTypeId(me?.vipUsed, me?.vipEndTime);
  const meVipIconSrc = meVipTypeId != null ? vipIconUrl(meVipTypeId) : vipIcon;
  const hasBioImage = me?.bioImage != null && me.bioImage !== '';

  const filtered = useMemo(() => {
    const term = query.trim().toLowerCase();
    if (term === '') return contacts;
    return contacts.filter(
      (c) => c.name.toLowerCase().includes(term) || (c.fullName ?? '').toLowerCase().includes(term),
    );
  }, [contacts, query]);

  const sections = useMemo(() => {
    const pick = (predicate: (c: Contact) => boolean) => filtered.filter(predicate);
    return [
      { key: 'birthday', label: t('chat.sectionBirthday'), highlight: false, items: pick((c) => c.group === 'birthday') },
      { key: 'new', label: t('chat.sectionNew'), highlight: true, items: pick((c) => c.group === 'new') },
      { key: 'utility', label: t('chat.sectionUtility'), highlight: false, items: pick((c) => c.group === 'utility') },
      { key: 'online', label: t('chat.sectionOnline'), highlight: false, items: pick((c) => c.group === 'friend' && c.online) },
      { key: 'friend', label: t('chat.sectionFriend'), highlight: false, items: pick((c) => c.group === 'friend' && !c.online) },
    ].filter((section) => section.items.length > 0);
  }, [filtered, t]);

  const menuOptions: ListOption[] = [
    { key: 'view', label: t('chat.menuViewMe'), onSelect: () => onComingSoon?.() },
    { key: 'alias', label: t('chat.changeAlias'), onSelect: () => onComingSoon?.() },
    { key: 'delete', label: t('dialog.delete'), danger: true, onSelect: () => onComingSoon?.() },
    { key: 'block', label: t('chat.menuBlock'), onSelect: () => onComingSoon?.() },
  ];

  return (
    <div className="h-full overflow-y-auto bg-[#f3f3f3]">
      <div className="border-b border-[#b2b2b2] bg-[#d5d5d5] px-4 py-3">
        <div className="flex h-10 items-center gap-1 rounded-[5px] border border-[#b2b2b2] bg-white px-1">
          <svg viewBox="0 0 24 24" className="h-4 w-4 shrink-0 text-black/38" fill="currentColor" aria-hidden="true">
            <path d="M15.5 14h-.79l-.28-.27a6.5 6.5 0 1 0-.7.7l.27.28v.79l5 5 1.5-1.5-5-5zm-6 0A4.5 4.5 0 1 1 14 9.5 4.5 4.5 0 0 1 9.5 14z" />
          </svg>
          <input
            type="search"
            value={query}
            onChange={(event) => setQuery(event.target.value)}
            placeholder={t('chat.searchContacts')}
            className="w-full bg-transparent text-base text-black/87 outline-none placeholder:text-black/26"
          />
        </div>
      </div>

      {me != null && (
        <div className="border-b border-black/12 bg-white/80">
          {!hasVip && (
            <button
              type="button"
              onClick={onComingSoon}
              className="m-2 block rounded border border-[#ff8f00] bg-white px-3 py-2 text-left"
            >
              <span className="block text-sm font-medium text-ola-accent">{t('chat.vipBannerTitle')}</span>
              <span className="block text-xs text-black/54">{t('chat.vipBannerSub')}</span>
            </button>
          )}
          <div className="flex min-h-[72px] items-center gap-2 px-4 py-2">
            <button type="button" onClick={onAccountMenu} aria-label={t('chat.myAccount')} className="shrink-0">
              <img src={hasVip ? meVipIconSrc : smileyIcon} alt="" className="h-10 w-10 object-contain" />
            </button>
            <button type="button" onClick={onEditStatus} className="min-w-0 flex-1 text-left">
              <span
                className={`block truncate text-base italic ${
                  hasStatus ? 'text-black/87' : 'text-black/26'
                }`}
              >
                {hasStatus ? me.bio : t('chat.myStatusHint')}
              </span>
            </button>
            <button
              type="button"
              onClick={hasBioImage ? onPreviewImage : onEditStatus}
              aria-label={t('chat.myStatusImage')}
              className="shrink-0"
            >
              <img src={hasBioImage ? me.bioImage! : snapPicIcon} alt="" className="h-9 w-9 object-cover" />
            </button>
          </div>
        </div>
      )}

      <button
        type="button"
        onClick={onComingSoon}
        className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-2 text-left"
      >
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[#e0e0e0]">
          <svg viewBox="0 0 24 24" className="h-6 w-6 text-black/54" fill="currentColor" aria-hidden="true">
            <path d="M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5s-3 1.34-3 3 1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z" />
          </svg>
        </span>
        <span className="min-w-0 flex-1">
          <span className="block text-base text-black/87">{t('chat.suggestFriends')}</span>
          <span className="mt-1 flex items-center gap-2">
            {SUGGESTED_FRIENDS.map((friend) => (
              <span key={friend.name} className="block overflow-hidden rounded">
                <Avatar name={friend.name} color={friend.color} size={28} rounded={false} />
              </span>
            ))}
          </span>
        </span>
        <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1 text-[10px] font-bold text-white">
          12
        </span>
        <span className="shrink-0 text-xl text-black/26">›</span>
      </button>

      <ActionRow
        badge={
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-[#1877f2] text-xl font-bold text-white">
            f
          </span>
        }
        title={t('chat.inviteFriends')}
        subtitle={t('chat.inviteFriendsSub')}
        onClick={onComingSoon}
      />
      <ActionRow
        badge={
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded bg-ola-primary">
            <img src={groupIcon} alt="" className="h-6 w-6 object-contain" />
          </span>
        }
        title={t('chat.chatGroup')}
        subtitle={t('chat.chatGroupSub')}
        showChevron
        onClick={onComingSoon}
      />

      {sections.map((section) => (
        <div key={section.key}>
          <SectionHeader label={section.label} />
          <ul>
            {section.items.map((contact) => (
              <BuddyRow
                key={contact.id}
                contact={contact}
                highlight={section.highlight}
                onSelect={() => onSelect(contact)}
                onOpenProfile={() => onOpenProfile(contact)}
                onLongPress={() => setMenuContact(contact)}
                onPreviewImage={onPreviewBuddyImage}
              />
            ))}
          </ul>
        </div>
      ))}

      <ListOptionDialog
        open={menuContact != null}
        title={menuContact?.name ?? ''}
        options={menuOptions}
        onClose={() => setMenuContact(null)}
      />
    </div>
  );
}
