import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { EGG_START_KEN } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useEggGameStore } from '@ola/shared/stores/eggGameStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { AnimatedKen } from '@components/ui/AnimatedKen';
import { EggScene } from './EggScene';
import { EggHistoryDialog } from './EggHistoryDialog';
import { EggGiftDialog } from './EggGiftDialog';
import { useEggGame } from './useEggGame';
import { eggAssets } from './eggAssets';

const backIcon = require('@assets/icons/ic_back.png');

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.EggGame>;

export function EggGameScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const userKen = useAuthStore((s) => s.user?.ken);
  const syncKen = useEggGameStore((s) => s.syncKen);
  const loadPacks = useEggGameStore((s) => s.loadPacks);
  const { ken, cost, packId, packsStatus, play } = useEggGame();
  const [historyOpen, setHistoryOpen] = useState(false);
  const [giftsOpen, setGiftsOpen] = useState(false);

  useEffect(() => {
    void loadPacks();
  }, [loadPacks]);

  useEffect(() => {
    syncKen(userKen ?? EGG_START_KEN);
  }, [syncKen, userKen]);

  useEffect(() => {
    useEggGameStore.setState({
      smashing: false,
      drawing: false,
      winReward: null,
      suppressKenSync: false,
    });
    const off = SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken === 'number') useEggGameStore.getState().syncKen(data.ken);
    });
    return () => {
      off();
      useEggGameStore.setState({ suppressKenSync: false, smashing: false });
    };
  }, []);

  return (
    <View className="flex-1 items-center bg-white">
      <View className="h-full w-full" style={{ maxWidth: 645, overflow: 'hidden' }}>
        <View style={{ backgroundColor: '#5e3c20', paddingTop: insets.top }}>
          <View className="flex-row items-center px-2 py-2" style={{ gap: 8 }}>
            <Pressable
              accessibilityLabel={t('chat.back')}
              onPress={() => navigation.goBack()}
              className="h-9 w-9 items-center justify-center rounded-full"
            >
              <Image
                source={backIcon}
                style={{ width: 24, height: 24, tintColor: '#fff' }}
                resizeMode="contain"
              />
            </Pressable>
            <AnimatedKen value={ken} />
            <View className="flex-1" />
            <Pressable
              onPress={() => setHistoryOpen(true)}
              className="flex-row items-center rounded-full px-3 py-1.5"
              style={{ gap: 6, backgroundColor: 'rgba(255,255,255,0.15)' }}
            >
              <Image
                source={eggAssets.history}
                style={{ width: 16, height: 16, tintColor: '#fff' }}
                resizeMode="contain"
              />
              <Text className="text-sm font-semibold text-white">
                {t('eggGame.history.title')}
              </Text>
            </Pressable>
          </View>
        </View>

        <View className="flex-1" style={{ backgroundColor: '#2c1f12' }}>
          {packsStatus === 'error' ? (
            <View className="flex-1 items-center justify-center px-8">
              <Text className="text-center text-sm" style={{ color: 'rgba(255,255,255,0.85)' }}>
                {t('eggGame.contactAdmin')}
              </Text>
            </View>
          ) : packsStatus === 'ready' ? (
            <EggScene hint={t('eggGame.hint', { cost })} play={play} />
          ) : (
            <View className="flex-1 items-center justify-center">
              <Text className="text-sm" style={{ color: 'rgba(255,255,255,0.8)' }}>
                {t('eggGame.loading')}
              </Text>
            </View>
          )}
        </View>

        <View
          className="flex-row items-center justify-between px-4"
          style={{
            backgroundColor: '#3e2a18',
            paddingTop: 10,
            paddingBottom: 10 + insets.bottom,
          }}
        >
          <Text className="text-sm" style={{ color: 'rgba(255,255,255,0.9)' }}>
            {t('eggGame.cost')}: <Text className="font-bold" style={{ color: '#ffca28' }}>{cost}</Text> KEN
          </Text>
          <Pressable
            onPress={() => setGiftsOpen(true)}
            className="flex-row items-center rounded-full px-3 py-1.5"
            style={{ gap: 6, backgroundColor: 'rgba(255,255,255,0.15)' }}
          >
            <Image
              source={eggAssets.gift}
              style={{ width: 16, height: 16, tintColor: '#fff' }}
              resizeMode="contain"
            />
            <Text className="text-sm font-semibold text-white">{t('eggGame.gifts.title')}</Text>
          </Pressable>
        </View>
      </View>

      {historyOpen && <EggHistoryDialog onClose={() => setHistoryOpen(false)} />}
      {giftsOpen && <EggGiftDialog packId={packId} onClose={() => setGiftsOpen(false)} />}
    </View>
  );
}
