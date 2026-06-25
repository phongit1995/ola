import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog, SearchIcon, Spinner } from '@components';
import { colorForName, toast } from '@lib';
import { UserService } from '@services';
import { useMeLocalStore, type ViewedProfile } from '@/store/meLocalStore';
import type { UserSearchResult } from '@app-types';
import { CLOSE_ANIMATION_MS } from '../constants';

interface MeRightDrawerProps {
  onClose: () => void;
  onOpenProfile: (username: string, color: string) => void;
}

export function MeRightDrawer({ onClose, onOpenProfile }: MeRightDrawerProps) {
  const { t } = useTranslation();
  const [shown, setShown] = useState(false);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [confirmClear, setConfirmClear] = useState(false);

  const viewedProfiles = useMeLocalStore((state) => state.viewedProfiles);
  const clearViewedProfiles = useMeLocalStore((state) => state.clearViewedProfiles);

  useEffect(() => {
    const id = requestAnimationFrame(() => setShown(true));
    return () => cancelAnimationFrame(id);
  }, []);

  useEffect(() => {
    const keyword = query.trim();
    const timer = setTimeout(() => {
      if (keyword === '') {
        setResults([]);
        setLoading(false);
        return;
      }
      setLoading(true);
      UserService.search(keyword, 30)
        .then((result) => setResults(result.users))
        .catch(() => toast.error(t('me.searchError')))
        .finally(() => setLoading(false));
    }, 350);
    return () => clearTimeout(timer);
  }, [query, t]);

  function handleClose() {
    setShown(false);
    window.setTimeout(onClose, CLOSE_ANIMATION_MS);
  }

  function openProfile(profile: ViewedProfile) {
    onOpenProfile(profile.username, colorForName(profile.username));
    handleClose();
  }

  const searching = query.trim() !== '';

  return (
    <>
      <button
        type="button"
        aria-label={t('me.closeSearch')}
        onClick={handleClose}
        className={`absolute inset-0 z-30 bg-black/30 transition-opacity duration-200 ${
          shown ? 'opacity-100' : 'opacity-0'
        }`}
      />
      <div
        className={`absolute inset-y-0 right-0 z-40 flex w-60 flex-col bg-white shadow-xl transition-transform duration-200 ${
          shown ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        <div className="shrink-0 border-b border-[#b2b2b2] bg-[#d5d5d5] px-4 py-3">
          <div className="flex h-10 items-center gap-1 rounded-[5px] border border-[#b2b2b2] bg-white px-1">
            <SearchIcon className="h-4 w-4 shrink-0 text-black/38" />
            <input
              type="search"
              value={query}
              onChange={(event) => setQuery(event.target.value)}
              placeholder={t('me.searchHint')}
              className="w-full bg-transparent text-base text-black/87 outline-none placeholder:text-black/26"
            />
          </div>
        </div>

        {!searching && viewedProfiles.length > 0 && (
          <div className="flex shrink-0 items-center justify-between bg-white px-4 py-2">
            <span className="text-xs text-black/54">{t('me.recentlyViewed')}</span>
            <button type="button" onClick={() => setConfirmClear(true)} className="text-xs text-black/54">
              {t('me.clearHistory')}
            </button>
          </div>
        )}

        <div className="min-h-0 flex-1 overflow-y-auto pb-2">
          {searching ? (
            loading ? (
              <div className="flex justify-center py-6">
                <Spinner size={24} />
              </div>
            ) : results.length === 0 ? (
              <MeDrawerEmpty message={t('me.searchEmpty')} />
            ) : (
              results.map((user) => (
                <MeSearchRow
                  key={user.id}
                  profile={{
                    id: user.id,
                    username: user.username,
                    fullName: user.fullName,
                    avatar: user.avatar,
                  }}
                  onOpen={openProfile}
                />
              ))
            )
          ) : viewedProfiles.length === 0 ? (
            <MeDrawerEmpty message={t('me.searchHistoryEmpty')} />
          ) : (
            viewedProfiles.map((profile) => (
              <MeSearchRow key={profile.id} profile={profile} onOpen={openProfile} />
            ))
          )}
        </div>
      </div>

      <ConfirmDialog
        open={confirmClear}
        title={t('me.clearHistoryTitle')}
        message={t('me.clearHistoryConfirm')}
        confirmLabel={t('me.clearHistory')}
        cancelLabel={t('common.cancel')}
        danger
        onConfirm={() => {
          clearViewedProfiles();
          setConfirmClear(false);
        }}
        onCancel={() => setConfirmClear(false)}
      />
    </>
  );
}

function MeDrawerEmpty({ message }: { message: string }) {
  return (
    <div className="flex h-full flex-col items-center justify-center gap-3 px-6 text-center">
      <SearchIcon className="h-10 w-10 text-black/12" />
      <p className="text-sm text-black/38">{message}</p>
    </div>
  );
}

interface MeSearchRowProps {
  profile: ViewedProfile;
  onOpen: (profile: ViewedProfile) => void;
}

function MeSearchRow({ profile, onOpen }: MeSearchRowProps) {
  const name = profile.fullName || profile.username;
  return (
    <button
      type="button"
      onClick={() => onOpen(profile)}
      className="flex h-12 w-full items-center gap-2 px-2 text-left hover:bg-ola-primary-light"
    >
      <Avatar name={name} color={colorForName(profile.username)} src={profile.avatar} size={32} />
      <span className="min-w-0 flex-1 truncate text-base text-black/87">{name}</span>
    </button>
  );
}
