import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, ConfirmDialog, FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import { colorForName, toast } from '@lib';
import { ClanService } from '@services';
import type { ClanCheckNameResult } from '@app-types';
import { useClanStore } from '@ola/shared/stores/clanStore';
import { UserProfileView } from '../profile/UserProfileView';
import {
  CLAN_HANDLE_PATTERN,
  CLAN_ROLE_ICONS,
  clanErrorText,
  clanRoleLabel,
  normalizeClanHandle,
} from './clanHelpers';
import memberIcon from '@/assets/icons/clan/ic_clan_member.png';
import visitIcon from '@/assets/icons/clan/ic_clan_visit.png';

interface ClanHomeViewProps {
  onClose: () => void;
  onOpenClan: (handle: string) => void;
}

interface PreviewRowProps {
  icon: string;
  text: string;
  onClick?: () => void;
}

function PreviewRow({ icon, text, onClick }: PreviewRowProps) {
  const content = (
    <>
      <img src={icon} alt="" className="h-3.75 w-4.25 object-contain" />
      <span>{text}</span>
    </>
  );
  if (onClick == null) {
    return <div className="mt-1 flex items-center gap-1 text-xs text-[#636363]">{content}</div>;
  }
  return (
    <button
      type="button"
      onClick={onClick}
      className="mt-1 flex items-center gap-1 text-xs text-[#636363] hover:underline"
    >
      {content}
    </button>
  );
}

export function ClanHomeView({ onClose, onOpenClan }: ClanHomeViewProps) {
  const { t } = useTranslation();
  const myClans = useClanStore((s) => s.myClans);
  const mineLoading = useClanStore((s) => s.mineLoading);
  const ensureMine = useClanStore((s) => s.ensureMine);

  const [name, setName] = useState('');
  const [checking, setChecking] = useState(false);
  const [result, setResult] = useState<ClanCheckNameResult | null>(null);
  const [freshCheck, setFreshCheck] = useState(false);
  const [confirmOpen, setConfirmOpen] = useState(false);
  const [creating, setCreating] = useState(false);
  const [profileTarget, setProfileTarget] = useState<string | null>(null);

  useEffect(() => {
    void ensureMine();
  }, [ensureMine]);

  function handleNameChange(value: string) {
    setName(value);
    setFreshCheck(false);
  }

  async function check() {
    if (checking) return;
    const handle = normalizeClanHandle(name);
    if (!CLAN_HANDLE_PATTERN.test(handle)) {
      toast.error(t('clan.nameHint'));
      return;
    }
    setChecking(true);
    try {
      const checked = await ClanService.checkName(handle);
      setResult(checked);
      setFreshCheck(true);
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setChecking(false);
    }
  }

  async function create() {
    if (result == null || creating) return;
    setCreating(true);
    try {
      const clan = await ClanService.create({ name: result.name });
      toast.success(t('clan.createSuccess', { name: clan.handle }));
      void useClanStore.getState().refreshMine();
      setResult(null);
      setName('');
      onOpenClan(clan.handle);
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setCreating(false);
      setConfirmOpen(false);
    }
  }

  const takenVisible =
    result != null && !result.available && normalizeClanHandle(name) === result.name;
  const availableVisible = result != null && result.available && freshCheck;
  const preview = takenVisible ? result.clan : undefined;

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('clan.title')} onBack={onClose} />
      <div className="flex-1 overflow-y-auto p-2">
        <div className="rounded-md border border-black/12 bg-white p-4">
          <div className="flex items-center gap-2">
            <input
              value={name}
              onChange={(event) => handleNameChange(event.target.value)}
              onKeyDown={(event) => {
                if (event.key === 'Enter') void check();
              }}
              placeholder={t('clan.searchPlaceholder')}
              className="min-w-0 flex-1 rounded border border-ola-primary px-4 py-3 text-base text-black/87 outline-none"
            />
            <button
              type="button"
              onClick={() => void check()}
              disabled={checking}
              className="shrink-0 rounded-sm border border-black/12 bg-white px-3 py-2 text-sm text-[#4c4c4c] active:bg-black/5"
            >
              {checking ? <Spinner size={16} /> : t('clan.validate')}
            </button>
          </div>
          <p className="mt-2 text-xs text-black/45">{t('clan.nameHint')}</p>
        </div>

        {takenVisible && (
          <p className="mt-2 px-1 text-xs font-bold text-ola-error italic">
            {t('clan.nameTaken', { name: result.name })}
          </p>
        )}
        {availableVisible && result != null && (
          <>
            <p className="mt-2 px-1 text-xs font-bold text-blue-700 italic">
              {t('clan.nameAvailable')}
            </p>
            <button
              type="button"
              onClick={() => setConfirmOpen(true)}
              className="mt-4 w-full rounded-sm border border-ola-primary-dark bg-ola-button py-3 text-sm text-white active:brightness-95"
            >
              {t('clan.create')}
            </button>
          </>
        )}

        {preview != null && (
          <div className="mt-4 rounded-md border border-black/12 bg-white p-4">
            <div className="text-center text-sm font-bold text-black/87">#{preview.handle}</div>
            {preview.owner != null && preview.owner !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.owner}
                text={preview.owner}
                onClick={() => setProfileTarget(preview.owner!)}
              />
            )}
            {preview.deputy != null && preview.deputy !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.deputy}
                text={preview.deputy}
                onClick={() => setProfileTarget(preview.deputy!)}
              />
            )}
            {preview.ambassador != null && preview.ambassador !== '' && (
              <PreviewRow
                icon={CLAN_ROLE_ICONS.ambassador}
                text={preview.ambassador}
                onClick={() => setProfileTarget(preview.ambassador!)}
              />
            )}
            <PreviewRow
              icon={memberIcon}
              text={t('clan.membersCount', { count: preview.memberCount })}
            />
            <PreviewRow icon={visitIcon} text={t('clan.visits', { count: preview.visitCount })} />
            <button
              type="button"
              onClick={() => onOpenClan(preview.handle)}
              className="mt-4 w-full rounded-sm border border-black/12 bg-white py-2 text-sm text-[#4c4c4c] active:bg-black/5"
            >
              {t('clan.openClan')}
            </button>
          </div>
        )}

        <h2 className="mt-6 px-1 text-base text-black/87">{t('clan.myClans')}</h2>
        {mineLoading && myClans.length === 0 ? (
          <div className="flex justify-center py-6">
            <Spinner size={24} />
          </div>
        ) : myClans.length === 0 ? (
          <p className="px-1 py-4 text-sm text-black/45">{t('clan.noClans')}</p>
        ) : (
          <div className="mt-2 overflow-hidden rounded-md border border-black/12 bg-white">
            {myClans.map((clan, index) => (
              <button
                key={clan.id}
                type="button"
                onClick={() => onOpenClan(clan.handle)}
                className={`flex w-full items-center gap-3 px-4 py-3 text-left active:bg-black/5 ${
                  index > 0 ? 'border-t border-black/12' : ''
                }`}
              >
                <Avatar
                  name={clan.handle}
                  src={clan.avatar !== '' ? clan.avatar : undefined}
                  color={colorForName(clan.handle)}
                  size={40}
                />
                <span className="min-w-0 flex-1">
                  <span className="block truncate text-base text-black/87">#{clan.handle}</span>
                  <span className="block text-xs text-black/54">
                    {clanRoleLabel(clan.myRole ?? 'member')} ·{' '}
                    {t('clan.membersCount', { count: clan.memberCount })}
                  </span>
                </span>
              </button>
            ))}
          </div>
        )}
      </div>

      <ConfirmDialog
        open={confirmOpen}
        title={t('clan.create')}
        message={t('clan.createConfirm', {
          cost: (result?.cost ?? 0).toLocaleString(),
          name: result?.name ?? '',
        })}
        confirmLabel={creating ? '...' : t('clan.create')}
        cancelLabel={t('dialog.cancel')}
        onCancel={() => setConfirmOpen(false)}
        onConfirm={() => void create()}
      />

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget}
          z={50}
          username={profileTarget}
          color={colorForName(profileTarget)}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget(friend.name)}
        />
      )}
    </FullScreenOverlay>
  );
}
