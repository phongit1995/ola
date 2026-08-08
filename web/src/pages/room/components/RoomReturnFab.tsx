import notifyIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';

interface RoomReturnFabProps {
  label: string;
  unread: number;
  onClick: () => void;
}

export function RoomReturnFab({ label, unread, onClick }: RoomReturnFabProps) {
  return (
    <button
      type="button"
      aria-label={label}
      onClick={onClick}
      className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary text-ola-on-primary shadow-lg transition hover:brightness-105"
    >
      <img src={notifyIcon} alt="" className="h-6 w-6 object-contain icon-on-primary" />
      {unread > 0 && (
        <span className="absolute -top-1 -right-1 flex h-4 min-w-4 items-center justify-center rounded-full border-2 border-white bg-ola-accent px-1 text-[10px] font-bold text-white">
          {unread}
        </span>
      )}
    </button>
  );
}
