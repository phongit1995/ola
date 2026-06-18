import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { toast } from '@lib';
import { ScreenHeader, FullScreenOverlay } from '@components';

type Privacy = 'public' | 'friends' | 'private';
type MediaKind = 'photo' | 'video' | 'sound';

interface Album {
  id: string;
  name: string;
  count: number;
  privacy: Privacy;
  kind: MediaKind;
  cover: string;
}

const MOCK_ALBUMS: Album[] = [
  { id: '1', name: 'Ảnh của tôi', count: 128, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#90caf9,#1976d2)' },
  { id: '2', name: 'Du lịch', count: 54, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#a5d6a7,#388e3c)' },
  { id: '3', name: 'Video', count: 12, privacy: 'friends', kind: 'video', cover: 'linear-gradient(135deg,#ffcc80,#f57c00)' },
  { id: '4', name: 'Riêng tư', count: 7, privacy: 'private', kind: 'photo', cover: 'linear-gradient(135deg,#ce93d8,#7b1fa2)' },
  { id: '5', name: 'Ghi âm', count: 31, privacy: 'friends', kind: 'sound', cover: 'linear-gradient(135deg,#ef9a9a,#c62828)' },
  { id: '6', name: 'Kỷ niệm', count: 203, privacy: 'public', kind: 'photo', cover: 'linear-gradient(135deg,#b0bec5,#546e7a)' },
];

function KindIcon({ kind }: { kind: MediaKind }) {
  const cls = 'h-9 w-9 opacity-90';
  if (kind === 'video') {
    return (
      <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
        <path d="M4 6a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2v-2.5l4 3.5V5l-4 3.5V6a2 2 0 0 0-2-2z" />
      </svg>
    );
  }
  if (kind === 'sound') {
    return (
      <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
        <path d="M12 3v10.55A4 4 0 1 0 14 17V7h4V3z" />
      </svg>
    );
  }
  return (
    <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
      <path d="M21 19V5a2 2 0 0 0-2-2H5a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2zM8.5 13.5l2.5 3 3.5-4.5 4.5 6H5z" />
    </svg>
  );
}

function PrivacyBadge({ privacy }: { privacy: Privacy }) {
  const cls = 'h-4 w-4 drop-shadow';
  if (privacy === 'private') {
    return (
      <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
        <path d="M18 8h-1V6a5 5 0 0 0-10 0v2H6a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V10a2 2 0 0 0-2-2zM9 6a3 3 0 0 1 6 0v2H9z" />
      </svg>
    );
  }
  if (privacy === 'friends') {
    return (
      <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
        <path d="M16 11a3 3 0 1 0-3-3 3 3 0 0 0 3 3zm-8 0a3 3 0 1 0-3-3 3 3 0 0 0 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h7v-2.5c0-1.07.41-1.93 1.04-2.6A11.6 11.6 0 0 0 8 13zm8 0a11.6 11.6 0 0 0-1.04.05A3.5 3.5 0 0 1 16 16.5V19h7v-2.5c0-2.33-4.67-3.5-7-3.5z" />
      </svg>
    );
  }
  return (
    <svg viewBox="0 0 24 24" className={cls} fill="#fff" aria-hidden="true">
      <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2zm6.9 6h-2.6a15.5 15.5 0 0 0-1.2-3.2A8 8 0 0 1 18.9 8zM12 4a13.7 13.7 0 0 1 1.7 4h-3.4A13.7 13.7 0 0 1 12 4zM4.3 14a7.8 7.8 0 0 1 0-4h3a16.5 16.5 0 0 0 0 4zm.8 2h2.6a15.5 15.5 0 0 0 1.2 3.2A8 8 0 0 1 5.1 16zm2.6-8H5.1a8 8 0 0 1 3.8-3.2A15.5 15.5 0 0 0 7.7 8zM12 20a13.7 13.7 0 0 1-1.7-4h3.4A13.7 13.7 0 0 1 12 20zm2.3-6H9.7a14.7 14.7 0 0 1 0-4h4.6a14.7 14.7 0 0 1 0 4zm.9 5.2a15.5 15.5 0 0 0 1.2-3.2h2.6a8 8 0 0 1-3.8 3.2zM16.96 14a16.5 16.5 0 0 0 0-4h3a7.8 7.8 0 0 1 0 4z" />
    </svg>
  );
}

function FolderIcon() {
  return (
    <svg viewBox="0 0 24 24" className="h-3 w-3" fill="#fff" aria-hidden="true">
      <path d="M10 4H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V8a2 2 0 0 0-2-2h-8z" />
    </svg>
  );
}

export function MediaStorePage() {
  const { t } = useTranslation();
  const navigate = useNavigate();

  function comingSoon() {
    toast.info(t('media.comingSoon'));
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('media.title')} onBack={() => navigate(ROUTES.home)} />

      <div className="flex-1 overflow-y-auto bg-white">
        <div className="grid grid-cols-3 gap-x-1 gap-y-2 px-2 pb-4 pt-2">
          {MOCK_ALBUMS.map((album) => (
            <button
              key={album.id}
              type="button"
              onClick={comingSoon}
              className="flex flex-col items-center active:opacity-80"
            >
              <span className="relative aspect-square w-full overflow-hidden rounded-sm shadow">
                <span
                  className="flex h-full w-full items-center justify-center"
                  style={{ background: album.cover }}
                >
                  <KindIcon kind={album.kind} />
                </span>
                <span className="absolute right-1 top-1">
                  <PrivacyBadge privacy={album.privacy} />
                </span>
                <span className="absolute inset-x-0 bottom-0 flex items-center gap-1 bg-black/40 px-1 py-1 text-xs text-white">
                  <FolderIcon />
                  {album.count}
                </span>
              </span>
              <span className="w-full truncate p-0.5 text-center text-sm font-bold text-black/87">
                {album.name}
              </span>
            </button>
          ))}
        </div>
      </div>
    </FullScreenOverlay>
  );
}
