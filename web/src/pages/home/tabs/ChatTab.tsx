import { useTranslation } from 'react-i18next';

interface Conversation {
  name: string;
  last: string;
  time: string;
  color: string;
}

const CONVERSATIONS: Conversation[] = [
  { name: 'linhchi92', last: 'Hôm nay trời đẹp ☀️', time: 'vừa tức thì', color: '#7cb342' },
  { name: 'tuananh', last: 'Đang bận...', time: 'vừa tức thì', color: '#5d4037' },
  { name: 'maiphuong', last: 'Nghe nhạc 🎧', time: 'vừa tức thì', color: '#6d4c41' },
  { name: 'quanghuy', last: 'Xin chào!', time: 'vừa tức thì', color: '#4dd0e1' },
  { name: 'thuhuong', last: 'Yêu đời 💚', time: 'vừa tức thì', color: '#5d4037' },
];

export function ChatTab() {
  const { t } = useTranslation();
  return (
    <div className="relative h-full bg-[#f3f3f3]">
      <ul className="divide-y divide-[#e6e6e6]">
        {CONVERSATIONS.map((c) => (
          <li key={c.name} className="flex items-center gap-3 bg-white px-4 py-3">
            <span
              className="flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl text-xl font-medium text-white"
              style={{ backgroundColor: c.color }}
            >
              {c.name.charAt(0).toUpperCase()}
            </span>
            <div className="min-w-0 flex-1">
              <p className="truncate text-base text-gray-900">{c.name}</p>
              <p className="truncate text-sm text-gray-500">{c.last}</p>
            </div>
            <span className="shrink-0 text-xs text-gray-400">{c.time}</span>
          </li>
        ))}
      </ul>

      <button
        type="button"
        aria-label={t('home.composeAria')}
        className="absolute right-4 bottom-4 flex h-14 w-14 items-center justify-center rounded-full bg-ola-primary text-white shadow-lg transition hover:brightness-105"
      >
        <svg
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          strokeWidth="2"
          strokeLinecap="round"
          strokeLinejoin="round"
        >
          <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
        </svg>
      </button>
    </div>
  );
}
