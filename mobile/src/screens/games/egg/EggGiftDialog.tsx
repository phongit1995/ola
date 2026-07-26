import { useEffect, useState } from 'react';
import type { TFunction } from 'i18next';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, Text, View } from 'react-native';
import { EGG_GIFT_FIXTURE, formatKen, vipName } from '@ola/shared/lib';
import { EggService } from '@ola/shared/services';
import type { EggCategoryKind, EggGiftReward, EggGiftSection } from '@ola/shared/types';
import { Dialog } from '@components/ui/Dialog';
import { VipIconImage } from '@screens/vip/components/VipIconImage';
import { eggAssets } from './eggAssets';

interface EggGiftDialogProps {
  packId: string | null;
  onClose: () => void;
}

type SectionLabelKey =
  | 'eggGame.gifts.section.ken'
  | 'eggGame.gifts.section.vip_days'
  | 'eggGame.gifts.section.vip_icon';

interface SectionStyle {
  background: string;
  border: string;
  pill: string;
  text: string;
  labelKey: SectionLabelKey;
}

const SECTION_STYLES: Partial<Record<EggCategoryKind, SectionStyle>> = {
  ken: {
    background: '#fdf6e3',
    border: '#f0dfb4',
    pill: '#d9a326',
    text: '#4a4a4a',
    labelKey: 'eggGame.gifts.section.ken',
  },
  vip_days: {
    background: '#eef8f0',
    border: '#cde8d2',
    pill: '#2e9e4f',
    text: '#2e9e4f',
    labelKey: 'eggGame.gifts.section.vip_days',
  },
  vip_icon: {
    background: '#faf4ef',
    border: '#e3d5ca',
    pill: '#7a5230',
    text: '#4a4a4a',
    labelKey: 'eggGame.gifts.section.vip_icon',
  },
};

function rewardText(type: EggCategoryKind, reward: EggGiftReward, t: TFunction): string {
  if (type === 'vip_icon' && reward.vipTypeId != null) return vipName(reward.vipTypeId);
  if (reward.label) return reward.label;
  if (type === 'ken' && reward.kenAmount) return `${formatKen(reward.kenAmount)} Ken`;
  if (type === 'vip_days' && reward.vipDays) {
    return t('eggGame.gifts.vipDaysLabel', { days: reward.vipDays });
  }
  return '';
}

function RewardIcon({ type, reward }: { type: EggCategoryKind; reward: EggGiftReward }) {
  if (type === 'ken') {
    return <Image source={eggAssets.kenCoin} style={{ width: 36, height: 36 }} resizeMode="contain" />;
  }
  if (type === 'vip_days') {
    return <Image source={eggAssets.vipDays} style={{ width: 36, height: 36 }} resizeMode="contain" />;
  }
  if (reward.vipTypeId != null) return <VipIconImage typeId={reward.vipTypeId} size={40} rounded />;
  return null;
}

export function EggGiftDialog({ packId, onClose }: EggGiftDialogProps) {
  const { t } = useTranslation();
  const [sections, setSections] = useState<EggGiftSection[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(false);

  useEffect(() => {
    let alive = true;
    const applyItems = (items: EggGiftSection[]) => {
      if (!alive) return;
      if (items.length === 0 && __DEV__) {
        setSections(EGG_GIFT_FIXTURE);
        return;
      }
      setSections(items);
    };
    if (!packId) {
      applyItems([]);
      setLoading(false);
      return;
    }
    EggService.listGifts(packId)
      .then((result) => applyItems(result?.items ?? []))
      .catch(() => {
        if (!alive) return;
        if (__DEV__) {
          setSections(EGG_GIFT_FIXTURE);
        } else {
          setError(true);
        }
      })
      .finally(() => {
        if (alive) setLoading(false);
      });
    return () => {
      alive = false;
    };
  }, [packId]);

  return (
    <Dialog visible onClose={onClose} bare maxWidth={448}>
      <View style={{ paddingTop: 30 }}>
        <View
          style={{
            borderRadius: 24,
            backgroundColor: '#ffffff',
            paddingTop: 40,
            paddingHorizontal: 12,
            paddingBottom: 12,
            shadowColor: '#000000',
            shadowOpacity: 0.35,
            shadowRadius: 24,
            shadowOffset: { width: 0, height: 6 },
            elevation: 8,
          }}
        >
          <ScrollView style={{ maxHeight: 500, minHeight: 160 }}>
            {error ? (
              <Text className="py-8 text-center text-sm" style={{ color: '#9a2b20' }}>
                {t('eggGame.error')}
              </Text>
            ) : loading ? (
              <View className="items-center justify-center" style={{ height: 160 }}>
                <ActivityIndicator color="#5e3c20" />
              </View>
            ) : sections.length === 0 ? (
              <Text className="py-8 text-center text-sm" style={{ color: '#8a8a8c' }}>
                {t('eggGame.gifts.empty')}
              </Text>
            ) : (
              sections.map((section) => {
                const style = SECTION_STYLES[section.type];
                if (!style) return null;
                return (
                  <View
                    key={section.type}
                    style={{
                      marginTop: 20,
                      marginBottom: 8,
                      borderRadius: 16,
                      borderWidth: 1,
                      borderColor: style.border,
                      backgroundColor: style.background,
                      paddingTop: 20,
                      paddingHorizontal: 10,
                      paddingBottom: 10,
                    }}
                  >
                    <View
                      style={{
                        position: 'absolute',
                        top: -14,
                        alignSelf: 'center',
                        borderRadius: 999,
                        paddingHorizontal: 24,
                        paddingVertical: 4,
                        backgroundColor: style.pill,
                      }}
                    >
                      <Text className="text-sm font-bold" style={{ color: '#ffffff' }}>
                        {t(style.labelKey)}
                      </Text>
                    </View>
                    <View style={{ gap: 8 }}>
                      {Array.from(
                        { length: Math.ceil(section.rewards.length / 3) },
                        (_, rowIndex) => {
                          const rowRewards = section.rewards.slice(
                            rowIndex * 3,
                            rowIndex * 3 + 3,
                          );
                          return (
                            <View key={rowIndex} style={{ flexDirection: 'row', gap: 8 }}>
                              {rowRewards.map((reward) => {
                                const label = rewardText(section.type, reward, t);
                                return (
                                  <View
                                    key={`${section.type}-${label}`}
                                    style={{
                                      flex: 1,
                                      borderRadius: 12,
                                      borderWidth: 1,
                                      borderColor: 'rgba(0,0,0,0.05)',
                                      backgroundColor: '#ffffff',
                                      alignItems: 'center',
                                      justifyContent: 'center',
                                      paddingVertical: 10,
                                      paddingHorizontal: 4,
                                      gap: 4,
                                    }}
                                  >
                                    <RewardIcon type={section.type} reward={reward} />
                                    <Text
                                      className="text-center text-xs font-semibold"
                                      style={{ color: style.text }}
                                    >
                                      {label}
                                    </Text>
                                  </View>
                                );
                              })}
                              {Array.from({ length: 3 - rowRewards.length }, (_filler, fillerIndex) => (
                                <View key={`filler-${fillerIndex}`} style={{ flex: 1 }} />
                              ))}
                            </View>
                          );
                        },
                      )}
                    </View>
                  </View>
                );
              })
            )}
          </ScrollView>
        </View>

        <View
          style={{
            position: 'absolute',
            top: 0,
            left: 40,
            right: 40,
            zIndex: 2,
            borderRadius: 16,
            borderWidth: 2,
            borderColor: '#f2c14e',
            backgroundColor: '#6f4e2d',
            paddingVertical: 8,
            paddingHorizontal: 16,
            alignItems: 'center',
            shadowColor: '#000000',
            shadowOpacity: 0.3,
            shadowRadius: 10,
            shadowOffset: { width: 0, height: 3 },
            elevation: 9,
          }}
        >
          <Text
            className="text-xl font-extrabold"
            style={{ color: '#ffffff', letterSpacing: 0.5 }}
          >
            {t('eggGame.gifts.heading')}
          </Text>
          <Text className="text-sm font-bold" style={{ color: '#ffca28' }}>
            {t('eggGame.gifts.subtitle')}
          </Text>
        </View>

        <Pressable
          accessibilityLabel={t('dialog.close')}
          onPress={onClose}
          style={{
            position: 'absolute',
            top: 12,
            right: -8,
            width: 36,
            height: 36,
            zIndex: 3,
            elevation: 10,
          }}
        >
          <Image
            source={eggAssets.closeCircle}
            style={{ position: 'absolute', top: 0, left: 0, width: 36, height: 36 }}
            resizeMode="contain"
          />
          <Image
            source={eggAssets.closeX}
            style={{ position: 'absolute', top: 10, left: 10, width: 16, height: 16 }}
            resizeMode="contain"
          />
        </Pressable>
      </View>
    </Dialog>
  );
}
