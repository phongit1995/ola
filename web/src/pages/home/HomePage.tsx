import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthStore } from '@/store/authStore';
import { BottomTabBar, type TabKey } from './BottomTabBar';
import { ChatTab } from './tabs/ChatTab';

const APPS = [
  'Thông báo',
  'Kho Game',
  'Cá nhân',
  'Kho VIP',
  'KEN',
  'Đăng Q.Cáo',
  'Hình Ảnh',
  'Ola Mall',
  'Lân cận',
  'Cài đặt',
];

export function HomePage() {
  const navigate = useNavigate();
  const username = useAuthStore((s) => s.username);
  const logout = useAuthStore((s) => s.logout);

  const [tab, setTab] = useState<TabKey>('chat');
  const [chatSub, setChatSub] = useState<'messages' | 'contacts'>('messages');

  function handleLogout() {
    logout();
    navigate('/login');
  }

  return (
    <div className="flex h-screen flex-col bg-white font-sans">
      <header className="flex h-12 shrink-0 items-center bg-ola-primary px-2 text-white shadow-[0_1px_0_rgba(0,0,0,.12)]">
        {tab === 'chat' && (
          <div className="flex w-full items-center">
            <button
              type="button"
              onClick={() => setChatSub('messages')}
              className={`flex-1 self-stretch text-base font-medium ${
                chatSub === 'messages'
                  ? 'border-b-2 border-white text-white'
                  : 'text-white/70'
              }`}
            >
              TIN NHẮN
            </button>
            <button
              type="button"
              onClick={() => setChatSub('contacts')}
              className={`flex-1 self-stretch text-base font-medium ${
                chatSub === 'contacts'
                  ? 'border-b-2 border-white text-white'
                  : 'text-white/70'
              }`}
            >
              DANH BẠ
            </button>
            <button type="button" aria-label="Menu" className="px-3 text-xl">
              ⋮
            </button>
          </div>
        )}

        {tab === 'rss' && (
          <div className="flex w-full items-center gap-2">
            <input
              placeholder="Tìm kiếm"
              className="flex-1 rounded bg-white/20 px-3 py-1.5 text-sm text-white outline-none placeholder:text-white/70"
            />
            <button type="button" aria-label="Menu" className="px-2 text-xl">
              ⋮
            </button>
          </div>
        )}

        {tab === 'room' && (
          <span className="flex-1 text-center text-base font-medium">
            Phòng chat
          </span>
        )}
        {tab === 'me' && (
          <span className="flex-1 text-center text-base font-medium">Me</span>
        )}
        {tab === 'apps' && (
          <span className="flex-1 text-center text-base font-medium">
            Ứng dụng
          </span>
        )}
      </header>

      <main className="relative flex-1 overflow-y-auto">
        {tab === 'chat' &&
          (chatSub === 'messages' ? (
            <ChatTab />
          ) : (
            <Placeholder text="Danh bạ trống" />
          ))}
        {tab === 'room' && <Placeholder text="Chưa có phòng chat" />}
        {tab === 'rss' && <Placeholder text="Chưa có tin RSS" />}
        {tab === 'me' && (
          <div className="flex flex-col items-center gap-4 p-8">
            <span className="flex h-20 w-20 items-center justify-center rounded-2xl bg-ola-primary text-3xl font-medium text-white">
              {(username ?? 'K').charAt(0).toUpperCase()}
            </span>
            <p className="text-lg font-semibold text-gray-900">
              {username ?? 'khách'}
            </p>
            <button
              type="button"
              onClick={handleLogout}
              className="rounded-sm border border-ola-primary-dark bg-ola-button px-6 py-2 text-white"
            >
              Đăng xuất
            </button>
          </div>
        )}
        {tab === 'apps' && (
          <ul className="divide-y divide-[#e6e6e6]">
            {APPS.map((name) => (
              <li key={name} className="px-4 py-3.5 text-base text-gray-800">
                {name}
              </li>
            ))}
          </ul>
        )}
      </main>

      <BottomTabBar active={tab} onChange={setTab} badges={{ chat: 3 }} />
    </div>
  );
}

function Placeholder({ text }: { text: string }) {
  return (
    <div className="flex h-full items-center justify-center bg-[#f3f3f3] text-sm text-gray-400">
      {text}
    </div>
  );
}
