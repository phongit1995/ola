import { Text } from 'react-native';
import { useTranslation } from 'react-i18next';
import { MEGAPHONE_TYPE } from '@ola/shared/constants';
import { activeVipTypeId, giftDisplayName } from '@ola/shared/lib';
import type { Megaphone } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import { VipBadge } from '@components/ui/VipBadge';

const GIFT_IMAGE_STYLE = { width: 20, height: 20 };

function MegaphoneUsername({ username }: { username: string }) {
  return <Text className="text-sm font-semibold text-ola-megaphone-name">@{username}</Text>;
}

function MegaphoneGiftText({ megaphone }: { megaphone: Megaphone }) {
  const { t, i18n } = useTranslation();
  const { gift, receiver, sender } = megaphone;
  if (gift == null || receiver == null) {
    return <Text className="text-sm text-ola-ink">{megaphone.content}</Text>;
  }
  return (
    <>
      <MegaphoneUsername username={sender.username} />
      <Text className="text-sm text-ola-ink-soft">{t('megaphone.giftVerb')}</Text>
      <MegaphoneUsername username={receiver.username} />
      <Text className="text-sm font-semibold text-ola-ink">{giftDisplayName(gift, i18n.language)}</Text>
      <CachedImage uri={gift.imageUrl} style={GIFT_IMAGE_STYLE} resizeMode="contain" />
      <Text className="text-sm font-semibold text-ola-error">
        {t('gift.quantityTimes', { count: gift.quantity })}
      </Text>
    </>
  );
}

export function MegaphoneText({ megaphone }: { megaphone: Megaphone }) {
  if (megaphone.type === MEGAPHONE_TYPE.gift) return <MegaphoneGiftText megaphone={megaphone} />;
  const vipTypeId = activeVipTypeId(megaphone.sender.vipUsed, megaphone.sender.vipEndTime);
  return (
    <>
      <VipBadge typeId={vipTypeId} size={20} />
      <MegaphoneUsername username={megaphone.sender.username} />
      <Text className="text-sm font-semibold text-ola-megaphone-name">:</Text>
      <Text className="text-sm text-ola-ink">{megaphone.content}</Text>
    </>
  );
}
