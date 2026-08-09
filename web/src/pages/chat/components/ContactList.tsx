import { useMemo, useState, type ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ListOptionDialog,
  SearchIcon,
  VipAvatar,
  VipIcon,
  type ListOption,
} from '@components';
import { isVipActive, activeVipTypeId, colorForName } from '@lib';
import { CHAT_BOT_TYPE } from '@ola/shared/constants';
import type { AuthUser, ChatBotType, Relationship } from '@app-types';
import type { Contact } from '../interface';

const REQUEST_PREVIEW_COUNT = 3;
import { BuddyRow } from './BuddyRow';
import snapPicIcon from '@/assets/icons/chat/icon_snap_pic.png';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import { BotAvatar } from '@/pages/chat-bot/components/BotAvatar';

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
  requests?: Relationship[];
  onOpenSuggested?: () => void;
  onOpenRequests?: () => void;
  onOpenChatBot?: (bot: ChatBotType) => void;
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
    <div className="flex h-9 items-center bg-ola-border-strong px-4">
      <span className="truncate text-sm font-medium text-white">{label}</span>
    </div>
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
  requests = [],
  onOpenRequests,
  onOpenChatBot,
}: ContactListProps) {
  const { t } = useTranslation();
  const [query, setQuery] = useState('');
  const [menuContact, setMenuContact] = useState<Contact | null>(null);
  const hasStatus = me?.bio != null && me.bio !== '';
  const hasVip = isVipActive(me?.vipEndTime);
  const meVipTypeId = activeVipTypeId(me?.vipUsed, me?.vipEndTime);
  const hasBioImage = me?.bioImage != null && me.bioImage !== '';

  const filtered = useMemo(() => {
    const term = query.trim().toLowerCase();
    if (term === '') return contacts;
    return contacts.filter(
      (c) =>
        c.name.toLowerCase().includes(term) ||
        (c.fullName ?? '').toLowerCase().includes(term)
    );
  }, [contacts, query]);

  const sections = useMemo(() => {
    const pick = (predicate: (c: Contact) => boolean) =>
      filtered.filter(predicate);
    return [
      {
        key: 'birthday',
        label: t('chat.sectionBirthday'),
        highlight: false,
        items: pick((c) => c.group === 'birthday'),
      },
      {
        key: 'new',
        label: t('chat.sectionNew'),
        highlight: true,
        items: pick((c) => c.group === 'new'),
      },
      {
        key: 'utility',
        label: t('chat.sectionUtility'),
        highlight: false,
        items: pick((c) => c.group === 'utility'),
      },
      {
        key: 'online',
        label: t('chat.sectionOnline'),
        highlight: false,
        items: pick((c) => c.group === 'friend' && c.online),
      },
      {
        key: 'friend',
        label: t('chat.sectionFriend'),
        highlight: false,
        items: pick((c) => c.group === 'friend' && !c.online),
      },
    ].filter((section) => section.items.length > 0);
  }, [filtered, t]);

  const menuOptions: ListOption[] = [
    {
      key: 'view',
      label: t('chat.menuViewMe'),
      onSelect: () => onComingSoon?.(),
    },
    {
      key: 'alias',
      label: t('chat.changeAlias'),
      onSelect: () => onComingSoon?.(),
    },
    {
      key: 'delete',
      label: t('dialog.delete'),
      danger: true,
      onSelect: () => onComingSoon?.(),
    },
    {
      key: 'block',
      label: t('chat.menuBlock'),
      onSelect: () => onComingSoon?.(),
    },
  ];

  return (
    <div className="h-full overflow-y-auto bg-ola-surface">
      <div className="border-b border-[#b2b2b2] bg-ola-border-strong px-4 py-3">
        <div className="flex h-10 items-center gap-1 rounded-[5px] border border-[#b2b2b2] bg-white px-1">
          <SearchIcon className="h-4 w-4 shrink-0 text-black/38" />
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
            <div className="p-2">
              <button
                type="button"
                onClick={onComingSoon}
                className="block w-full rounded border border-[#ff8f00] bg-white px-3 py-2 text-left"
              >
                <span className="block text-sm font-medium text-ola-accent">
                  {t('chat.vipBannerTitle')}
                </span>
                <span className="block text-xs text-black/54">
                  {t('chat.vipBannerSub')}
                </span>
              </button>
            </div>
          )}
          <div className="flex min-h-[72px] items-center gap-2 px-4 py-2">
            <button
              type="button"
              onClick={onAccountMenu}
              aria-label={t('chat.myAccount')}
              className="shrink-0"
            >
              <VipAvatar typeId={meVipTypeId} />
            </button>
            <button
              type="button"
              onClick={onEditStatus}
              className="min-w-0 flex-1 text-left"
            >
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
              <img
                src={hasBioImage ? me.bioImage! : snapPicIcon}
                alt=""
                className="h-9 w-9 object-cover"
              />
            </button>
          </div>
        </div>
      )}

      {requests.length > 0 && (
        <button
          type="button"
          onClick={onOpenRequests}
          className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-2 text-left"
        >
          <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-ola-primary">
            <img
              src={addFriendIcon}
              alt=""
              className="h-6 w-6 object-contain icon-on-primary"
            />
          </span>
          <span className="min-w-0 flex-1">
            <span className="block text-base text-black/87">
              {t('chat.friendRequests')}
            </span>
            <span className="mt-1 flex items-center gap-2">
              {requests.slice(0, REQUEST_PREVIEW_COUNT).map((relationship) => {
                const requester = relationship.requester;
                const name = requester?.fullName || requester?.username || '';
                const vipTypeId = activeVipTypeId(
                  requester?.vipUsed,
                  requester?.vipEndTime
                );
                return (
                  <span key={relationship.id} className="relative block">
                    {requester?.avatar ? (
                      <img
                        src={requester.avatar}
                        alt=""
                        className="h-7 w-7 rounded object-cover"
                      />
                    ) : (
                      <Avatar
                        name={name}
                        color={colorForName(requester?.id ?? name)}
                        size={28}
                        rounded={false}
                      />
                    )}
                    {vipTypeId != null && (
                      <VipIcon
                        typeId={vipTypeId}
                        className="absolute -right-1 -bottom-1 h-3.5 w-3.5"
                      />
                    )}
                  </span>
                );
              })}
            </span>
          </span>
          <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1 text-[10px] font-bold text-white">
            {requests.length}
          </span>
          <span className="shrink-0 text-xl text-black/26">›</span>
        </button>
      )}

      {/* TODO: "Có thể bạn muốn làm quen" — tạm ẩn, chờ API gợi ý kết bạn thật
          (SuggestedFriendsScreen đang chạy trên SUGGESTED_FRIENDS hardcode, nút Kết bạn chỉ toast).
          Mở lại thì import lại PeopleIcon, SUGGESTED_FRIENDS và prop onOpenSuggested.
      <button
        type="button"
        onClick={onOpenSuggested}
        className="flex w-full items-center gap-3 border-b border-black/12 bg-white/80 px-4 py-2 text-left"
      >
        <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[#e0e0e0]">
          <PeopleIcon />
        </span>
        <span className="min-w-0 flex-1">
          <span className="block text-base text-black/87">
            {t('chat.suggestFriends')}
          </span>
          <span className="mt-1 flex items-center gap-2">
            {SUGGESTED_FRIENDS.slice(0, 3).map((friend) => (
              <span key={friend.name} className="block overflow-hidden rounded">
                <Avatar
                  name={friend.name}
                  color={friend.color}
                  size={28}
                  rounded={false}
                />
              </span>
            ))}
          </span>
        </span>
        <span className="flex h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1 text-[10px] font-bold text-white">
          {SUGGESTED_FRIENDS.length}
        </span>
        <span className="shrink-0 text-xl text-black/26">›</span>
      </button>
      */}

      {/* TODO: "Mời thêm bạn bè" — tạm ẩn, chưa có chức năng mời bạn qua Facebook
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
      */}

      {/* TODO: "Chat nhóm" — tạm ẩn, chưa có chức năng chat nhóm. Mở lại thì import lại groupIcon.
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
      */}

      <SectionHeader label={t('chat.sectionApps')} />
      <ActionRow
        badge={
          <BotAvatar name={t('chat.chatBot')} className="h-12 w-12 rounded-lg" />
        }
        title={t('chat.chatBot')}
        subtitle={t('chat.chatBotSub')}
        showChevron
        onClick={() => onOpenChatBot?.(CHAT_BOT_TYPE.olala)}
      />
      <ActionRow
        badge={
          <BotAvatar
            bot={CHAT_BOT_TYPE.olavi}
            name={t('chat.fortuneBot')}
            className="h-12 w-12 rounded-lg"
          />
        }
        title={t('chat.fortuneBot')}
        subtitle={t('chat.fortuneBotSub')}
        showChevron
        onClick={() => onOpenChatBot?.(CHAT_BOT_TYPE.olavi)}
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
