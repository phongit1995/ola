import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAuthStore } from '@/store/authStore';
import { LanguageSwitcher } from '@/components/LanguageSwitcher';
import { BottomTabBar, type TabKey } from './BottomTabBar';
import { ChatTab } from './tabs/ChatTab';
import { AppsTab } from './tabs/AppsTab';

export function HomePage() {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const username = useAuthStore((s) => s.username);
  const logout = useAuthStore((s) => s.logout);

  const [tab, setTab] = useState<TabKey>('chat');
  const [chatSub, setChatSub] = useState<'messages' | 'contacts'>('messages');

  const displayName = username ?? t('home.guest');

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
              {t('home.subMessages')}
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
              {t('home.subContacts')}
            </button>
            <button type="button" aria-label="Menu" className="px-3 text-xl">
              ⋮
            </button>
          </div>
        )}

        {tab === 'rss' && (
          <div className="flex w-full items-center gap-2">
            <input
              placeholder={t('home.search')}
              className="flex-1 rounded bg-white/20 px-3 py-1.5 text-sm text-white outline-none placeholder:text-white/70"
            />
            <button type="button" aria-label="Menu" className="px-2 text-xl">
              ⋮
            </button>
          </div>
        )}

        {tab === 'room' && (
          <span className="flex-1 text-center text-base font-medium">
            {t('home.tabRoom')}
          </span>
        )}
        {tab === 'me' && (
          <span className="flex-1 text-center text-base font-medium">
            {t('home.tabMe')}
          </span>
        )}
        {tab === 'apps' && (
          <span className="flex-1 text-center text-base font-medium">
            {t('home.tabApps')}
          </span>
        )}
      </header>

      <main className="relative flex-1 overflow-y-auto">
        {tab === 'chat' &&
          (chatSub === 'messages' ? (
            <ChatTab />
          ) : (
            <Placeholder text={t('home.contactsEmpty')} />
          ))}
        {tab === 'room' && <Placeholder text={t('home.roomEmpty')} />}
        {tab === 'rss' && <Placeholder text={t('home.rssEmpty')} />}
        {tab === 'me' && (
          <div className="flex flex-col items-center gap-4 p-8">
            <span className="flex h-20 w-20 items-center justify-center rounded-2xl bg-ola-primary text-3xl font-medium text-white">
              {displayName.charAt(0).toUpperCase()}
            </span>
            <p className="text-lg font-semibold text-gray-900">{displayName}</p>
            <LanguageSwitcher tone="dark" />
            <button
              type="button"
              onClick={handleLogout}
              className="rounded-sm border border-ola-primary-dark bg-ola-button px-6 py-2 text-white"
            >
              {t('home.logout')}
            </button>
          </div>
        )}
        {tab === 'apps' && <AppsTab />}
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
