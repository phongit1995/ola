import { Image, Text } from 'react-native';
import { useTranslation } from 'react-i18next';
import { MEGAPHONE_SENDER_DISPLAY, MEGAPHONE_TYPE } from '@ola/shared/constants';
import { selectMegaphoneSenderDisplay, useMegaphoneConfigStore } from '@ola/shared/stores/megaphone/megaphoneConfigStore';
import { activeVipTypeId, giftDisplayName, megaphoneLuckyRewardText, megaphoneLuckyVerb } from '@ola/shared/lib';
import type { Megaphone, MegaphoneLucky, MegaphoneSender } from '@ola/shared/types';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { CachedImage } from '@components/ui/CachedImage';
import { VipBadge } from '@components/ui/VipBadge';
import { VipIcon } from '@components/ui/VipIcon';
import { SmileyText } from '@lib/richText';

const GIFT_IMAGE_STYLE = { width: 20, height: 20 };
const LUCKY_REWARD_ICON_SIZE = 20;
const kenCoinIcon = require('@assets/icons/apps/ken.png');
const vipDaysIcon = require('@assets/games/egg/day_vip.png');
const CONTENT_FONT_SIZE = 14;
const MEGAPHONE_AVATAR_SIZE = 24;

function MegaphoneUserAvatar({ user }: { user: MegaphoneSender }) {
  return (
    <AvatarWithFrame
      name={user.username}
      uri={user.avatar || undefined}
      size={MEGAPHONE_AVATAR_SIZE}
      frameId={user.avatarFrameId}
    />
  );
}

function MegaphoneUserMark({ user }: { user: MegaphoneSender }) {
  const display = useMegaphoneConfigStore(selectMegaphoneSenderDisplay);
  if (display === MEGAPHONE_SENDER_DISPLAY.avatar) return <MegaphoneUserAvatar user={user} />;
  return <VipBadge typeId={activeVipTypeId(user.vipUsed, user.vipEndTime)} size={20} />;
}

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
      <MegaphoneUserMark user={sender} />
      <MegaphoneUsername username={sender.username} />
      <Text className="text-sm text-ola-ink-soft">{t('megaphone.giftVerb')}</Text>
      <MegaphoneUserMark user={receiver} />
      <MegaphoneUsername username={receiver.username} />
      <Text className="text-sm font-semibold text-ola-ink">{giftDisplayName(gift, i18n.language)}</Text>
      <CachedImage uri={gift.imageUrl} style={GIFT_IMAGE_STYLE} resizeMode="contain" />
      <Text className="text-sm font-semibold text-ola-error">
        {t('gift.quantityTimes', { count: gift.quantity })}
      </Text>
    </>
  );
}

function MegaphoneLuckyRewardIcon({ lucky }: { lucky: MegaphoneLucky }) {
  if (lucky.kenAmount != null && lucky.kenAmount > 0) {
    return <Image source={kenCoinIcon} style={GIFT_IMAGE_STYLE} resizeMode="contain" />;
  }
  if (lucky.vipTypeId != null) return <VipIcon typeId={lucky.vipTypeId} size={LUCKY_REWARD_ICON_SIZE} fallback="placeholder" />;
  if (lucky.vipDays != null && lucky.vipDays > 0) {
    return <Image source={vipDaysIcon} style={GIFT_IMAGE_STYLE} resizeMode="contain" />;
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
        <Text className="text-sm font-semibold text-ola-megaphone-ink">{megaphone.content}</Text>
      ) : (
        <>
          <Text className="text-sm text-ola-ink-soft">{megaphoneLuckyVerb(t, lucky)}</Text>
          <MegaphoneLuckyRewardIcon lucky={lucky} />
          <Text className="text-sm font-semibold text-ola-megaphone-ink">{megaphoneLuckyRewardText(lucky)} 🎉</Text>
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
      <Text className="text-sm font-semibold text-ola-megaphone-name">:</Text>
      <Text className="text-sm text-ola-ink">
        <SmileyText text={megaphone.content} fontSize={CONTENT_FONT_SIZE} />
      </Text>
    </>
  );
}
