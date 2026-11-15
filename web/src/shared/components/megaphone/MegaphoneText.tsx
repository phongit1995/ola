import { useTranslation } from 'react-i18next';
import { MEGAPHONE_SENDER_DISPLAY, MEGAPHONE_TYPE } from '@constants';
import {
  selectMegaphoneSenderDisplay,
  useMegaphoneConfigStore,
} from '@ola/shared/stores/megaphone/megaphoneConfigStore';
import {
  activeVipTypeId,
  colorForName,
  giftDisplayName,
  megaphoneLuckyRewardText,
  megaphoneLuckyVerb,
  SmileyText,
} from '@lib';
import type { Megaphone, MegaphoneLucky, MegaphoneSender } from '@app-types';
import kenCoinUrl from '@/assets/icons/apps/ken.png';
import vipDaysIconUrl from '@/assets/games/egg/day_vip.png';
import { AvatarWithFrame } from '../ui/AvatarWithFrame';
import { VipBadge } from '../ui/VipBadge';
import { VipIcon } from '../ui/VipIcon';

const MEGAPHONE_AVATAR_SIZE = 24;

function MegaphoneUserAvatar({ user }: { user: MegaphoneSender }) {
  return (
    <AvatarWithFrame
      name={user.username}
      color={colorForName(user.username)}
      size={MEGAPHONE_AVATAR_SIZE}
      src={user.avatar}
      frameId={user.avatarFrameId}
    />
  );
}

function MegaphoneUserMark({ user }: { user: MegaphoneSender }) {
  const display = useMegaphoneConfigStore(selectMegaphoneSenderDisplay);
  if (display === MEGAPHONE_SENDER_DISPLAY.avatar) return <MegaphoneUserAvatar user={user} />;
  return <VipBadge typeId={activeVipTypeId(user.vipUsed, user.vipEndTime)} className="h-5 w-5" />;
}

function MegaphoneUsername({ username }: { username: string }) {
  return <b className="font-semibold text-ola-megaphone-name">@{username}</b>;
}

function MegaphoneGiftText({ megaphone }: { megaphone: Megaphone }) {
  const { t, i18n } = useTranslation();
  const { gift, receiver, sender } = megaphone;
  if (gift == null || receiver == null) return <span className="text-black/87">{megaphone.content}</span>;
  return (
    <>
      <MegaphoneUserMark user={sender} />
      <MegaphoneUsername username={sender.username} />
      <span className="text-black/60">{t('megaphone.giftVerb')}</span>
      <MegaphoneUserMark user={receiver} />
      <MegaphoneUsername username={receiver.username} />
      <span className="font-semibold text-black/87">{giftDisplayName(gift, i18n.language)}</span>
      <img src={gift.imageUrl} alt="" className="h-5 w-5 shrink-0 object-contain" draggable={false} />
      <span className="font-semibold text-ola-error">{t('gift.quantityTimes', { count: gift.quantity })}</span>
    </>
  );
}

function MegaphoneLuckyRewardIcon({ lucky }: { lucky: MegaphoneLucky }) {
  if (lucky.kenAmount != null && lucky.kenAmount > 0) {
    return <img src={kenCoinUrl} alt="" className="h-5 w-5 shrink-0 object-contain" draggable={false} />;
  }
  if (lucky.vipTypeId != null) return <VipIcon typeId={lucky.vipTypeId} className="h-5 w-5" />;
  if (lucky.vipDays != null && lucky.vipDays > 0) {
    return <img src={vipDaysIconUrl} alt="" className="h-5 w-5 shrink-0 object-contain" draggable={false} />;
  }
  return null;
}

function MegaphoneLuckyText({ megaphone }: { megaphone: Megaphone }) {
  const { t } = useTranslation();
  const { lucky } = megaphone;
  return (
    <>
      <MegaphoneUserMark user={megaphone.sender} />
      <MegaphoneUsername username={megaphone.sender.username} />
      {lucky == null ? (
        <span className="font-semibold text-ola-megaphone-ink">{megaphone.content}</span>
      ) : (
        <>
          <span className="text-black/60">{megaphoneLuckyVerb(t, lucky)}</span>
          <MegaphoneLuckyRewardIcon lucky={lucky} />
          <span className="font-semibold text-ola-megaphone-ink">{megaphoneLuckyRewardText(lucky)} 🎉</span>
        </>
      )}
    </>
  );
}

export function MegaphoneText({ megaphone }: { megaphone: Megaphone }) {
  if (megaphone.type === MEGAPHONE_TYPE.gift) return <MegaphoneGiftText megaphone={megaphone} />;
  if (megaphone.type === MEGAPHONE_TYPE.lucky) return <MegaphoneLuckyText megaphone={megaphone} />;
  return (
    <>
      <MegaphoneUserMark user={megaphone.sender} />
      <MegaphoneUsername username={megaphone.sender.username} />
      <span className="font-semibold text-ola-megaphone-name">:</span>
      <span className="text-black/87">
        <SmileyText text={megaphone.content} />
      </span>
    </>
  );
}
