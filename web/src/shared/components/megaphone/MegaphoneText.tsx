import { useTranslation } from 'react-i18next';
import { MEGAPHONE_TYPE } from '@constants';
import { activeVipTypeId, giftDisplayName, SmileyText } from '@lib';
import type { Megaphone } from '@app-types';
import { VipBadge } from '../ui/VipBadge';

function MegaphoneUsername({ username }: { username: string }) {
  return <b className="font-semibold text-ola-megaphone-name">@{username}</b>;
}

function MegaphoneGiftText({ megaphone }: { megaphone: Megaphone }) {
  const { t, i18n } = useTranslation();
  const { gift, receiver, sender } = megaphone;
  if (gift == null || receiver == null) return <span className="text-black/87">{megaphone.content}</span>;
  return (
    <>
      <MegaphoneUsername username={sender.username} />
      <span className="text-black/60">{t('megaphone.giftVerb')}</span>
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
      <VipBadge typeId={vipTypeId} className="h-5 w-5" />
      <MegaphoneUsername username={megaphone.sender.username} />
      <span className="font-semibold text-ola-megaphone-name">:</span>
      <span className="text-black/87">
        <SmileyText text={megaphone.content} />
      </span>
    </>
  );
}
