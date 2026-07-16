import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  ConfirmDialog,
  FullScreenOverlay,
  ListOptionDialog,
  ScreenHeader,
  Spinner,
  UserName,
  type ListOption,
} from '@components';
import { colorForName, toast } from '@lib';
import { ClanService } from '@services';
import type { Clan, ClanMember } from '@app-types';
import { UserProfileView } from '../profile/UserProfileView';
import { CLAN_ROLE_ICONS, clanErrorText, clanRoleLabel, isClanStaff } from './clanHelpers';

interface ClanMembersViewProps {
  clanId: string;
  onClose: () => void;
}

const PAGE_SIZE = 50;

export function ClanMembersView({ clanId, onClose }: ClanMembersViewProps) {
  const { t } = useTranslation();
  const [clan, setClan] = useState<Clan | null>(null);
  const [members, setMembers] = useState<ClanMember[]>([]);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [menuTarget, setMenuTarget] = useState<ClanMember | null>(null);
  const [banTarget, setBanTarget] = useState<ClanMember | null>(null);
  const [profileTarget, setProfileTarget] = useState<string | null>(null);

  const loadFirst = useCallback(async () => {
    setLoading(true);
    try {
      const [clanResult, memberResult] = await Promise.all([
        ClanService.get(clanId),
        ClanService.members(clanId, { limit: PAGE_SIZE, offset: 0 }),
      ]);
      setClan(clanResult);
      setMembers(memberResult.items);
      setTotal(memberResult.total);
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setLoading(false);
    }
  }, [clanId]);

  useEffect(() => {
    let active = true;
    Promise.all([ClanService.get(clanId), ClanService.members(clanId, { limit: PAGE_SIZE, offset: 0 })])
      .then(([clanResult, memberResult]) => {
        if (!active) return;
        setClan(clanResult);
        setMembers(memberResult.items);
        setTotal(memberResult.total);
      })
      .catch((error) => toast.error(clanErrorText(error)))
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [clanId]);

  async function loadMore() {
    if (loadingMore || members.length >= total) return;
    setLoadingMore(true);
    try {
      const result = await ClanService.members(clanId, {
        limit: PAGE_SIZE,
        offset: members.length,
      });
      setMembers((current) => [...current, ...result.items]);
      setTotal(result.total);
    } catch (error) {
      toast.error(clanErrorText(error));
    } finally {
      setLoadingMore(false);
    }
  }

  async function toggleVerify(member: ClanMember) {
    if (member.user == null) return;
    try {
      if (member.verified) {
        await ClanService.unverify(clanId, member.user.username);
        toast.success(
          t('clan.unverifySuccess', { username: member.user.username, name: clan?.handle ?? '' })
        );
      } else {
        await ClanService.verify(clanId, member.user.username);
        toast.success(
          t('clan.verifySuccess', { username: member.user.username, name: clan?.handle ?? '' })
        );
      }
      await loadFirst();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  async function banMember() {
    const target = banTarget;
    setBanTarget(null);
    if (target?.user == null) return;
    try {
      await ClanService.ban(clanId, target.user.username);
      toast.success(t('clan.banSuccess', { username: target.user.username }));
      await loadFirst();
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  const staff = clan != null && isClanStaff(clan);

  const menuOptions: ListOption[] =
    menuTarget == null
      ? []
      : [
          {
            key: 'verify',
            label: menuTarget.verified ? t('clan.unverifyMember') : t('clan.verifyMember'),
            onSelect: () => void toggleVerify(menuTarget),
          },
          ...(menuTarget.role === 'member' || menuTarget.role === 'ambassador'
            ? [
                {
                  key: 'ban',
                  label: t('clan.banUser'),
                  danger: true,
                  onSelect: () => setBanTarget(menuTarget),
                },
              ]
            : []),
        ];

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('clan.members')} onBack={onClose} />
      {loading ? (
        <div className="flex flex-1 items-center justify-center">
          <Spinner size={28} />
        </div>
      ) : (
        <div className="flex-1 overflow-y-auto p-2">
          <div className="overflow-hidden rounded-md bg-white">
            {members.map((member, index) => {
              const username = member.user?.username ?? '';
              return (
                <div
                  key={`${username}-${index}`}
                  className={`flex items-center gap-3 px-4 py-3 ${index > 0 ? 'border-t border-black/12' : ''}`}
                >
                  <button
                    type="button"
                    onClick={() => username !== '' && setProfileTarget(username)}
                    className="flex min-w-0 flex-1 items-center gap-3 text-left"
                  >
                    <Avatar
                      name={username}
                      src={member.user?.avatar !== '' ? member.user?.avatar : undefined}
                      color={colorForName(username)}
                      size={40}
                    />
                    <span className="min-w-0 flex-1">
                      <span className="flex items-center gap-1.5">
                        <UserName
                          name={username}
                          fullName={member.user?.fullName ?? ''}
                          className="min-w-0 truncate text-sm text-black/87"
                          fullNameClassName="text-black/54"
                        />
                        {member.role !== 'member' && (
                          <img
                            src={CLAN_ROLE_ICONS[member.role]}
                            alt={clanRoleLabel(member.role)}
                            className="h-3.75 w-4.25 shrink-0 object-contain"
                          />
                        )}
                      </span>
                      <span className="block text-xs text-black/54">
                        {clanRoleLabel(member.role)}
                        {member.verified ? ` · ${t('clan.verified')}` : ''}
                      </span>
                    </span>
                  </button>
                  {staff && member.role !== 'owner' && (
                    <button
                      type="button"
                      aria-label={t('clan.manage')}
                      onClick={() => setMenuTarget(member)}
                      className="px-2 py-1 text-lg text-black/54"
                    >
                      ⋯
                    </button>
                  )}
                </div>
              );
            })}
          </div>
          {members.length < total && (
            <button
              type="button"
              onClick={() => void loadMore()}
              disabled={loadingMore}
              className="mt-2 w-full rounded-md border border-black/12 bg-white py-2 text-sm text-black/54 active:bg-black/5"
            >
              {loadingMore ? <Spinner size={16} /> : t('clan.loadMore')}
            </button>
          )}
        </div>
      )}

      <ListOptionDialog
        open={menuTarget != null}
        title={menuTarget?.user?.username != null ? `@${menuTarget.user.username}` : ''}
        options={menuOptions}
        onClose={() => setMenuTarget(null)}
      />

      <ConfirmDialog
        open={banTarget != null}
        title={t('clan.banUser')}
        message={t('clan.banConfirm', { username: banTarget?.user?.username ?? '' })}
        confirmLabel={t('dialog.accept')}
        cancelLabel={t('dialog.cancel')}
        danger
        onCancel={() => setBanTarget(null)}
        onConfirm={() => void banMember()}
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
