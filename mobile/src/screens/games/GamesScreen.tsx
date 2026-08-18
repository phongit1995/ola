import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import type { MiniGame } from '@ola/shared/types';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { CachedImage } from '@components/ui/CachedImage';
import { trackEvent } from '@lib/telemetry';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { useArcadeStore } from '@store/arcadeStore';
import { GAME_ITEMS, type AppItem } from '../apps/constants';

const iconGameDefault = require('@assets/icons/apps/game.png');

interface GameTileProps {
  icon: number;
  iconUrl?: string;
  title: string;
  onPress: () => void;
}

function GameTile({ icon, iconUrl, title, onPress }: GameTileProps) {
  return (
    <View className="w-1/3 p-1.5">
      <Pressable
        onPress={onPress}
        className="items-center gap-2 rounded-xl bg-white px-1 py-3 active:opacity-70"
        style={{
          shadowColor: '#000000',
          shadowOpacity: 0.12,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 2,
        }}
      >
        <CachedImage
          uri={iconUrl}
          placeholder={icon}
          style={{ width: 56, height: 56 }}
          resizeMode="contain"
        />
        <Text
          numberOfLines={2}
          className="text-center text-xs font-bold text-black/87"
          style={{ minHeight: 32 }}
        >
          {title}
        </Text>
      </Pressable>
    </View>
  );
}

const GAME_ROUTES = {
  egg: ROOT_ROUTES.EggGame,
  pen: ROOT_ROUTES.PenGame,
  wheel: ROOT_ROUTES.SpinWheel,
} as const;

export function GamesScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation =
    useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const push = useToastStore(s => s.push);
  const miniGames = useArcadeStore(s => s.games);
  const fetchGames = useArcadeStore(s => s.fetchGames);
  const openArcade = useArcadeOverlayStore(s => s.open);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem) {
    if (item.action === 'egg' || item.action === 'pen' || item.action === 'wheel') {
      navigation.navigate(GAME_ROUTES[item.action]);
    }
  }

  function handleOpenArcade(game: MiniGame) {
    const isNewGame = useArcadeOverlayStore.getState().active == null;
    if (!openArcade(game)) {
      push('info', t('arcade.alreadyRunning'));
      return;
    }
    if (isNewGame) {
      trackEvent('arcade_open', {
        game_id: game.id,
        game_slug: game.slug,
      });
    }
  }

  return (
    <View className="flex-1 bg-ola-surface">
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 items-center justify-center px-2">
          <Text className="text-lg font-medium text-white">
            {t('home.tabGame')}
          </Text>
        </View>
      </View>
      <ScrollView className="flex-1">
        <View className="flex-row flex-wrap p-1.5">
          {GAME_ITEMS.map(item => (
            <GameTile
              key={item.titleKey}
              icon={item.icon}
              title={t(item.titleKey)}
              onPress={() => handleOpen(item)}
            />
          ))}
          {miniGames.map(game => (
            <GameTile
              key={game.id}
              icon={iconGameDefault}
              iconUrl={game.iconUrl || undefined}
              title={game.name}
              onPress={() => handleOpenArcade(game)}
            />
          ))}
        </View>
      </ScrollView>
    </View>
  );
}
