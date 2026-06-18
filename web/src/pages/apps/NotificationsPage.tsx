import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast, colorForName } from '@lib';
import { ScreenHeader, FullScreenOverlay, Avatar } from '@components';
import icFriend from '@/assets/icons/notify/ic_notification_add_friend.png';
import icMention from '@/assets/icons/notify/ic_notification_mention.png';
import icLike from '@/assets/icons/notify/ic_notification_like.png';
import icPhoto from '@/assets/icons/notify/ic_notification_photo.png';
import icAddSmall from '@/assets/icons/notify/ic_action_add_small.png';

type NotificationType = 'friend' | 'mention' | 'like' | 'photo' | 'proposal' | 'divorce';

const TYPE_ICON: Partial<Record<NotificationType, string>> = {
  friend: icFriend,
  mention: icMention,
  like: icLike,
  photo: icPhoto,
};

interface NotificationItem {
  id: string;
  sender: string;
  type: NotificationType;
  time: string;
}

const MOCK_NOTIFICATIONS: NotificationItem[] = [
  { id: '1', sender: 'Minh Anh', type: 'friend', time: '5 phút trước' },
  { id: '2', sender: 'Hoàng Nam', type: 'mention', time: '12 phút trước' },
  { id: '3', sender: 'Lan Phương', type: 'like', time: '1 giờ trước' },
  { id: '4', sender: 'Đức Huy', type: 'photo', time: '2 giờ trước' },
  { id: '5', sender: 'Thu Trang', type: 'proposal', time: 'Hôm qua' },
  { id: '6', sender: 'Bảo Ngọc', type: 'divorce', time: '3 ngày trước' },
];

function TypeIcon({ type }: { type: NotificationType }) {
  const icon = TYPE_ICON[type];
  if (icon == null) return null;
  return <img src={icon} alt="" className="h-[18px] w-[18px] shrink-0 object-contain" />;
}

interface RowButtonProps {
  variant: 'green' | 'default';
  onClick: () => void;
  children: ReactNode;
}

function RowButton({ variant, onClick, children }: RowButtonProps) {
  const cls =
    variant === 'green'
      ? 'bg-[#9ccc65] text-white'
      : 'ml-2 bg-[#e0e0e0] text-[#636363]';
  return (
    <button
      type="button"
      onClick={onClick}
      className={`flex h-7 min-w-16 flex-1 items-center justify-center rounded-sm text-xs ${cls}`}
    >
      {children}
    </button>
  );
}

export function NotificationsPage() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  function comingSoon() {
    toast.info(t('notify.comingSoon'));
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('notify.title')} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto bg-[#d5d5d5]">
        <ul>
          {MOCK_NOTIFICATIONS.map((item) => {
            const text = t(`notify.msg_${item.type}`);
            const showFriendButton = item.type === 'friend';
            const showProposalButtons = item.type === 'proposal';
            return (
              <li key={item.id} className="bg-white/80">
                <div className="flex min-h-[72px] items-start p-4">
                  <Avatar name={item.sender} color={colorForName(item.sender)} />
                  <div className="ml-4 min-w-0 flex-1">
                    <p className="truncate text-base font-bold text-black/87">{item.sender}</p>
                    <p className="mt-1 text-sm leading-snug text-black/87">{text}</p>

                    {showFriendButton && (
                      <div className="mt-1 flex">
                        <RowButton variant="green" onClick={comingSoon}>
                          <img src={icAddSmall} alt="" className="mr-1 h-3 w-3 object-contain" />
                          {t('notify.addFriend')}
                        </RowButton>
                      </div>
                    )}
                    {showProposalButtons && (
                      <div className="mt-1 flex">
                        <RowButton variant="green" onClick={comingSoon}>
                          {t('notify.agree')}
                        </RowButton>
                        <RowButton variant="default" onClick={comingSoon}>
                          {t('notify.decline')}
                        </RowButton>
                      </div>
                    )}

                    <div className="mt-1 flex items-center gap-1">
                      <TypeIcon type={item.type} />
                      <span className="text-xs text-black/54">{item.time}</span>
                    </div>
                  </div>
                </div>
                <div className="mx-4 h-px bg-black/12" />
              </li>
            );
          })}
        </ul>
      </div>
    </FullScreenOverlay>
  );
}
