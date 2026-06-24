import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ScreenHeader, UserName } from '@components';
import { colorForName, toast } from '@lib';
import { UserService } from '@services';
import type { UserSearchResult } from '@app-types';
import { useMarriageStore } from './marriageStore';

const MESSAGE_LIMIT = 500;

interface ProposeComposerProps {
  onClose: () => void;
}

function isBlocked(user: UserSearchResult): boolean {
  return user.relationship === 'blocked_by_me' || user.relationship === 'blocked_by_them';
}

export function ProposeComposer({ onClose }: ProposeComposerProps) {
  const { t } = useTranslation();
  const propose = useMarriageStore((s) => s.propose);
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<UserSearchResult[]>([]);
  const [searching, setSearching] = useState(false);
  const [selected, setSelected] = useState<UserSearchResult | null>(null);
  const [message, setMessage] = useState('');
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    if (selected != null) return;
    const keyword = query.trim();
    const timer = setTimeout(() => {
      if (keyword === '') {
        setResults([]);
        setSearching(false);
        return;
      }
      setSearching(true);
      UserService.search(keyword, 20)
        .then((result) => setResults(result.users))
        .catch(() => setResults([]))
        .finally(() => setSearching(false));
    }, 300);
    return () => clearTimeout(timer);
  }, [query, selected]);

  function pick(user: UserSearchResult) {
    setSelected(user);
    setResults([]);
    setQuery('');
  }

  function clearSelected() {
    setSelected(null);
    setQuery('');
  }

  const canSend = selected != null && message.trim().length > 0 && !busy;

  async function send() {
    if (busy) return;
    if (selected == null) {
      toast.info(t('marriage.needReceiver'));
      return;
    }
    const body = message.trim();
    if (body.length === 0) {
      toast.info(t('marriage.needMessage'));
      return;
    }
    setBusy(true);
    try {
      await propose(selected.id, body);
      toast.success(t('marriage.sent', { nick: selected.username }));
      onClose();
    } catch {
      toast.error(t('common.error'));
    } finally {
      setBusy(false);
    }
  }

  return (
    <div className="flex h-full w-full flex-col items-center bg-[#fff0f4]">
      <div className="flex h-full w-full max-w-[645px] flex-col overflow-hidden bg-[#fff0f4]">
        <ScreenHeader title={t('marriage.composeTitle')} onBack={onClose}>
          <button
            type="button"
            onClick={() => void send()}
            disabled={!canSend}
            className="rounded-full bg-[#ff4d7d] px-4 py-1.5 text-sm font-bold text-white shadow-[0_2px_0_#c2185b] transition-transform active:translate-y-0.5 active:shadow-none disabled:bg-black/15 disabled:text-white/70 disabled:shadow-none"
          >
            {t('marriage.send')}
          </button>
        </ScreenHeader>

        <div className="min-h-0 flex-1 overflow-y-auto">
          <div className="flex flex-col items-center gap-1 px-5 pt-6 pb-4 text-center">
            <div className="text-5xl text-[#ff4d7d] drop-shadow-[0_2px_4px_rgba(255,77,125,0.35)]">
              💍
            </div>
            <p className="max-w-xs text-sm text-black/55">{t('marriage.composeIntro')}</p>
          </div>

          <div className="flex flex-col gap-5 px-4 pb-6">
            <section className="flex flex-col gap-2">
              <p className="px-1 text-xs font-bold uppercase tracking-wide text-[#c2185b]">
                {t('marriage.receiverLabel')}
              </p>

              {selected != null ? (
                <div className="flex items-center gap-3 rounded-2xl border border-[#ffd0de] bg-white p-3 shadow-[0_2px_10px_rgba(255,77,125,0.12)]">
                  <span className="h-10 w-10 shrink-0 overflow-hidden rounded">
                    <Avatar
                      name={selected.username}
                      color={colorForName(selected.username)}
                      src={selected.avatar}
                      size={40}
                      rounded={false}
                    />
                  </span>
                  <div className="flex min-w-0 flex-1 flex-col">
                    <span className="flex min-w-0 items-center gap-1 text-base">
                      <UserName
                        name={selected.username}
                        fullName={selected.fullName || undefined}
                        className="min-w-0 truncate text-black/87"
                        fullNameClassName="text-black/54"
                      />
                    </span>
                    {selected.bio ? (
                      <span className="truncate text-xs text-black/54">{selected.bio}</span>
                    ) : null}
                  </div>
                  <button
                    type="button"
                    onClick={clearSelected}
                    className="shrink-0 rounded-full bg-[#fff0f4] px-3 py-1.5 text-xs font-semibold text-[#c2185b] hover:bg-[#ffe0ea]"
                  >
                    {t('marriage.changeReceiver')}
                  </button>
                </div>
              ) : (
                <div className="relative">
                  <span className="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 text-black/35">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" aria-hidden="true">
                      <circle cx="11" cy="11" r="7" stroke="currentColor" strokeWidth="2" />
                      <path
                        d="m20 20-3.2-3.2"
                        stroke="currentColor"
                        strokeWidth="2"
                        strokeLinecap="round"
                      />
                    </svg>
                  </span>
                  <input
                    value={query}
                    onChange={(event) => setQuery(event.target.value)}
                    placeholder={t('marriage.searchPlaceholder')}
                    className="w-full rounded-2xl border border-[#ffd0de] bg-white py-3 pl-10 pr-3 text-sm outline-none transition-colors focus:border-[#ff4d7d] focus:shadow-[0_0_0_3px_rgba(255,77,125,0.15)]"
                  />
                  {(results.length > 0 || searching) && (
                    <ul className="absolute z-10 mt-2 max-h-64 w-full overflow-y-auto rounded-2xl border border-[#ffd0de] bg-white py-1 shadow-[0_8px_24px_rgba(0,0,0,0.12)]">
                      {searching && results.length === 0 ? (
                        <li className="px-3 py-2.5 text-sm text-black/45">{t('common.loading')}</li>
                      ) : (
                        results.map((user) => {
                          const blocked = isBlocked(user);
                          return (
                            <li key={user.id}>
                              <button
                                type="button"
                                disabled={blocked}
                                onClick={() => pick(user)}
                                className="flex w-full items-center gap-3 px-3 py-2.5 text-left hover:bg-[#fff0f4] disabled:opacity-50 disabled:hover:bg-transparent"
                              >
                                <span className="h-9 w-9 shrink-0 overflow-hidden rounded">
                                  <Avatar
                                    name={user.username}
                                    color={colorForName(user.username)}
                                    src={user.avatar}
                                    size={36}
                                    rounded={false}
                                  />
                                </span>
                                <div className="flex min-w-0 flex-1 flex-col">
                                  <span className="flex min-w-0 items-center gap-1 text-sm">
                                    <UserName
                                      name={user.username}
                                      fullName={user.fullName || undefined}
                                      className="min-w-0 truncate text-black/80"
                                      fullNameClassName="text-black/54"
                                    />
                                  </span>
                                  {user.bio ? (
                                    <span className="truncate text-xs text-black/45">
                                      {user.bio}
                                    </span>
                                  ) : null}
                                </div>
                                {blocked && (
                                  <span className="shrink-0 text-xs text-black/40">
                                    {t('chat.blocked')}
                                  </span>
                                )}
                              </button>
                            </li>
                          );
                        })
                      )}
                    </ul>
                  )}
                </div>
              )}
            </section>

            <section className="flex flex-col gap-2">
              <p className="px-1 text-xs font-bold uppercase tracking-wide text-[#c2185b]">
                {t('marriage.messageLabel')}
              </p>
              <div className="rounded-2xl border border-[#ffd0de] bg-white p-3 shadow-[0_2px_10px_rgba(255,77,125,0.08)] focus-within:border-[#ff4d7d] focus-within:shadow-[0_0_0_3px_rgba(255,77,125,0.15)]">
                <textarea
                  value={message}
                  onChange={(event) => setMessage(event.target.value.slice(0, MESSAGE_LIMIT))}
                  rows={6}
                  maxLength={MESSAGE_LIMIT}
                  placeholder={t('marriage.messageHint')}
                  className="w-full resize-none bg-transparent text-sm leading-relaxed outline-none"
                />
                <div className="mt-1 text-right text-xs text-black/35">
                  {message.length}/{MESSAGE_LIMIT}
                </div>
              </div>
            </section>
          </div>
        </div>
      </div>
    </div>
  );
}
