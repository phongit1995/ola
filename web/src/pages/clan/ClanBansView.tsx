import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Avatar,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
  UserName,
} from '@components';
import { colorForName, toast } from '@lib';
import { ClanService } from '@services';
import type { ClanBan } from '@app-types';
import { clanErrorText } from './clanHelpers';

const BANS_PAGE_SIZE = 100;

interface ClanBansViewProps {
  clanId: string;
  onClose: () => void;
}

export function ClanBansView({ clanId, onClose }: ClanBansViewProps) {
  const { t } = useTranslation();
  const [bans, setBans] = useState<ClanBan[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let active = true;
    ClanService.bans(clanId, { limit: BANS_PAGE_SIZE, offset: 0 })
      .then((result) => {
        if (active) setBans(result.items);
      })
      .catch((error) => toast.error(clanErrorText(error)))
      .finally(() => {
        if (active) setLoading(false);
      });
    return () => {
      active = false;
    };
  }, [clanId]);

  async function unban(ban: ClanBan) {
    if (ban.user == null) return;
    try {
      await ClanService.unban(clanId, ban.user.id);
      toast.success(t('clan.unbanSuccess'));
      setBans((current) =>
        current.filter((item) => item.user?.id !== ban.user?.id)
      );
    } catch (error) {
      toast.error(clanErrorText(error));
    }
  }

  return (
    <FullScreenOverlay>
      <ScreenHeader title={t('clan.banList')} onBack={onClose} />
      {loading ? (
        <div className="flex flex-1 items-center justify-center">
          <Spinner size={28} />
        </div>
      ) : bans.length === 0 ? (
        <p className="px-6 py-10 text-center text-sm text-black/45">
          {t('clan.emptyBans')}
        </p>
      ) : (
        <div className="flex-1 overflow-y-auto p-2">
          <div className="overflow-hidden rounded-md bg-white">
            {bans.map((ban, index) => {
              const username = ban.user?.username ?? '';
              return (
                <div
                  key={`${username}-${index}`}
                  className={`flex items-center gap-3 px-4 py-3 ${
                    index > 0 ? 'border-t border-black/12' : ''
                  }`}
                >
                  <Avatar
                    name={username}
                    src={ban.user?.avatar !== '' ? ban.user?.avatar : undefined}
                    color={colorForName(username)}
                    size={40}
                  />
                  <UserName
                    name={username}
                    fullName={ban.user?.fullName ?? ''}
                    className="min-w-0 flex-1 truncate text-sm text-black/87"
                    fullNameClassName="text-black/54"
                  />
                  <button
                    type="button"
                    onClick={() => void unban(ban)}
                    className="shrink-0 rounded-sm border border-black/12 bg-white px-3 py-1.5 text-xs text-[#4c4c4c] active:bg-black/5"
                  >
                    {t('clan.unban')}
                  </button>
                </div>
              );
            })}
          </div>
        </div>
      )}
    </FullScreenOverlay>
  );
}
