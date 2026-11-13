import { useTranslation } from 'react-i18next';
import { MEGAPHONE_TYPE } from '@constants';
import { activeVipTypeId, colorForName, giftDisplayName, SmileyText } from '@lib';
import type { Megaphone, MegaphoneSender } from '@app-types';
import { AvatarWithFrame } from '../ui/AvatarWithFrame';
import { VipBadge } from '../ui/VipBadge';

const MEGAPHONE_AVATAR_SIZE = 28;

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

function MegaphoneUsername({ username }: { username: string }) {
  return <b className="font-semibold text-ola-megaphone-name">@{username}</b>;
}

function MegaphoneGiftText({ megaphone }: { megaphone: Megaphone }) {
  const { t, i18n } = useTranslation();
  const { gift, receiver, sender } = megaphone;
  if (gift == null || receiver == null) return <span className="text-black/87">{megaphone.content}</span>;
  return (
    <>
      <MegaphoneUserAvatar user={sender} />
      <MegaphoneUsername username={sender.username} />
      <span className="text-black/60">{t('megaphone.giftVerb')}</span>
      <MegaphoneUserAvatar user={receiver} />
      <MegaphoneUsername username={receiver.username} />
      <span className="font-semibold text-black/87">{giftDisplayName(gift, i18n.language)}</span>
      <img src={gift.imageUrl} alt="" className="h-5 w-5 shrink-0 object-contain" draggable={false} />
      <span className="font-semibold text-ola-error">{t('gift.quantityTimes', { count: gift.quantity })}</span>
    </>
  );
}

export function MegaphoneText({ megaphone }: { megaphone: Megaphone }) {
  if (megaphone.type === MEGAPHONE_TYPE.gift) return <MegaphoneGiftText megaphone={megaphone} />;
  const vipTypeId = activeVipTypeId(megaphone.sender.vipUsed, megaphone.sender.vipEndTime);
  return (
    <>
      <MegaphoneUserAvatar user={megaphone.sender} />
      <VipBadge typeId={vipTypeId} className="h-5 w-5" />
      <MegaphoneUsername username={megaphone.sender.username} />
      <span className="font-semibold text-ola-megaphone-name">:</span>
      <span className="text-black/87">
        <SmileyText text={megaphone.content} />
      </span>
    </>
  );
}
