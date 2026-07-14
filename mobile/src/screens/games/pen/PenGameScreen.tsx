import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Animated,
  Easing,
  Image,
  Pressable,
  Text,
  View,
  useWindowDimensions,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen, toApiError } from '@ola/shared/lib';
import { PenService, SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import {
  PEN_SHOTS_PAGE,
  PEN_SHOTS_PAGE_MOBILE,
  usePenStore,
} from '@ola/shared/stores/penStore';
import type { PenSettledEvent, PenSide, PenShotView } from '@ola/shared/types';
import type { RootStackParamList } from '../../../navigation/types';
import { ROOT_ROUTES } from '../../../navigation/routes';
import { playKenShotFailSound } from '../../../lib/sound';
import { AnimatedKen } from '../../../components/AnimatedKen';
import { PenButton } from './PenButton';
import { PenShotList } from './PenShotList';
import { PenShootModal } from './PenShootModal';
import { PenCatchModal } from './PenCatchModal';
import { PenHistoryModal } from './PenHistoryModal';
import { PenLeaderboardModal } from './PenLeaderboardModal';
import { PenWinBurst } from './PenWinBurst';
import { penAssets, penLeaderboardAssets } from './penAssets';
import { assetRatio, PenBg, penTextShadow, sizeByHeight, PEN_COLORS } from './penUi';

const PEN_START_KEN = 12_345;
const DEFAULT_BET = 1000;
const KICK_RESULT_MS = 600;

function ShakingBall({ size }: { size: number }) {
  const progress = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    const loop = Animated.loop(
      Animated.timing(progress, {
        toValue: 1,
        duration: 1500,
        easing: Easing.inOut(Easing.ease),
        useNativeDriver: true,
      })
    );
    loop.start();
    return () => loop.stop();
  }, [progress]);

  const frames = [0, 0.06, 0.14, 0.21, 0.28, 0.33, 1];
  return (
    <Animated.Image
      source={penAssets.ball}
      resizeMode="contain"
      style={{
        width: size,
        height: size,
        transform: [
          {
            translateX: progress.interpolate({
              inputRange: frames,
              outputRange: [0, -1.5, 1.5, -1, 1, 0, 0],
            }),
          },
          {
            translateY: progress.interpolate({
              inputRange: frames,
              outputRange: [0, 1, -1, -1, 1, 0, 0],
            }),
          },
          {
            rotate: progress.interpolate({
              inputRange: frames,
              outputRange: ['0deg', '-8deg', '8deg', '-5deg', '5deg', '0deg', '0deg'],
            }),
          },
        ],
      }}
    />
  );
}

function PenKickBall({ zoneWidth, zoneHeight }: { zoneWidth: number; zoneHeight: number }) {
  const progress = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    Animated.timing(progress, {
      toValue: 1,
      duration: 550,
      easing: Easing.in(Easing.ease),
      useNativeDriver: true,
    }).start();
  }, [progress]);

  const height = 56;
  const width = height * assetRatio(penAssets.ballTrail);

  return (
    <Animated.Image
      source={penAssets.ballTrail}
      resizeMode="contain"
      style={{
        position: 'absolute',
        bottom: zoneHeight * 0.26,
        left: zoneWidth / 2 - width / 2,
        width,
        height,
        opacity: progress.interpolate({ inputRange: [0, 0.7, 1], outputRange: [1, 1, 0] }),
        transform: [
          {
            translateY: progress.interpolate({ inputRange: [0, 1], outputRange: [0, -220] }),
          },
          {
            rotate: progress.interpolate({ inputRange: [0, 1], outputRange: ['0deg', '220deg'] }),
          },
          { scale: progress.interpolate({ inputRange: [0, 1], outputRange: [1, 0.4] }) },
        ],
      }}
    />
  );
}

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.PenGame>;

export function PenGameScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const { width: windowWidth } = useWindowDimensions();
  const push = useToastStore((s) => s.push);
  const user = useAuthStore((s) => s.user);
  const setUser = useAuthStore((s) => s.setUser);
  const ken = user?.ken ?? PEN_START_KEN;
  const containerWidth = Math.min(windowWidth, 645);

  const shots = usePenStore((s) => s.shots);
  const loadingShots = usePenStore((s) => s.loading);
  const shotsPage = usePenStore((s) => s.page);
  const shotsTotal = usePenStore((s) => s.total);
  const shotsPageSize = usePenStore((s) => s.pageSize);
  const loadShots = usePenStore((s) => s.loadShots);
  const setPageSize = usePenStore((s) => s.setPageSize);
  const shotsPageCount = Math.max(1, Math.ceil(shotsTotal / (shotsPageSize || PEN_SHOTS_PAGE)));

  const [kickId, setKickId] = useState(0);
  const [kicking, setKicking] = useState(false);
  const [shootOpen, setShootOpen] = useState(false);
  const [historyOpen, setHistoryOpen] = useState(false);
  const [leaderboardOpen, setLeaderboardOpen] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [catchShot, setCatchShot] = useState<PenShotView | null>(null);
  const [catching, setCatching] = useState(false);
  const [winFx, setWinFx] = useState<{ id: number; amount: number } | null>(null);
  const winFxTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    setPageSize(windowWidth >= 448 ? PEN_SHOTS_PAGE : PEN_SHOTS_PAGE_MOBILE);
  }, [windowWidth, setPageSize]);

  const closeCatch = useCallback(() => setCatchShot(null), []);

  useEffect(
    () => () => {
      if (winFxTimer.current != null) clearTimeout(winFxTimer.current);
    },
    []
  );

  const playKick = () => {
    setKickId((n) => n + 1);
    setKicking(true);
    setTimeout(() => setKicking(false), KICK_RESULT_MS);
  };

  const triggerWinFx = (amount: number) => {
    setWinFx((prev) => ({ id: (prev?.id ?? 0) + 1, amount }));
    if (winFxTimer.current != null) clearTimeout(winFxTimer.current);
    winFxTimer.current = setTimeout(() => setWinFx(null), 1600);
  };

  const onShotSettled = useRef<(e: PenSettledEvent) => void>(() => {});
  useEffect(() => {
    onShotSettled.current = (e) => {
      if (user == null || e.shooterId !== user.id) return;
      void loadShots();
      if (e.winnerId === user.id) {
        triggerWinFx(Math.max(0, e.payout - e.betAmount));
        push('success', t('penGame.shotWon', { payout: formatKen(e.payout) }));
      } else {
        playKenShotFailSound();
        push('error', t('penGame.shotLost'));
      }
    };
  });

  useEffect(() => {
    const offKen = SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      const current = useAuthStore.getState().user;
      if (current && typeof data?.ken === 'number') {
        useAuthStore.getState().setUser({ ...current, ken: data.ken });
      }
    });
    const offSettled = SocketService.on<PenSettledEvent>('PEN_SETTLED', (data) => {
      if (data) onShotSettled.current(data);
    });
    return () => {
      offKen();
      offSettled();
    };
  }, []);

  const handleCreateShot = async ({ side, betAmount }: { side: PenSide; betAmount: number }) => {
    if (submitting) return;
    setSubmitting(true);
    try {
      const res = await PenService.createShot({ side, betAmount });
      if (user) setUser({ ...user, ken: res.kenBalance });
      setShootOpen(false);
      playKick();
      push('success', t('penGame.shotCreated'));
    } catch (e) {
      push('error', toApiError(e).message);
    } finally {
      setSubmitting(false);
    }
  };

  const handleCatch = async (side: PenSide) => {
    if (catching || catchShot == null) return;
    setCatching(true);
    try {
      const res = await PenService.catchShot(catchShot.id, { side });
      if (user) setUser({ ...user, ken: res.kenBalance });
      setCatchShot(null);
      playKick();
      if (res.win) {
        triggerWinFx(Math.max(0, res.payout - res.betAmount));
        push('success', t('penGame.catchWin', { payout: formatKen(res.payout) }));
      } else {
        playKenShotFailSound();
        push('error', t('penGame.catchLose'));
      }
      void loadShots();
    } catch (e) {
      push('error', toApiError(e).message);
    } finally {
      setCatching(false);
    }
  };

  const handleRefresh = () => {
    void loadShots();
    push('info', t('penGame.refreshed'));
  };

  const handleTopUp = () => {
    setShootOpen(false);
    setCatchShot(null);
    navigation.navigate(ROOT_ROUTES.BuyKen);
  };

  return (
    <View style={{ flex: 1, backgroundColor: PEN_COLORS.screenBg, paddingTop: insets.top }}>
      <View
        style={{
          flex: 1,
          width: '100%',
          maxWidth: 645,
          alignSelf: 'center',
          overflow: 'hidden',
          backgroundColor: PEN_COLORS.screenBg,
        }}
      >
        <View
          pointerEvents="none"
          style={{ position: 'absolute', top: 0, left: 0, right: 0 }}
        >
          <Image
            source={penAssets.scene}
            style={{ width: containerWidth, height: (containerWidth * 1536) / 1024 }}
            resizeMode="stretch"
          />
        </View>

        <View
          style={{
            position: 'absolute',
            top: 0,
            left: 0,
            right: 0,
            zIndex: 20,
            flexDirection: 'row',
            alignItems: 'center',
            gap: 8,
            paddingHorizontal: 12,
            paddingVertical: 8,
          }}
        >
          <PenButton
            bg={penAssets.backBtn}
            icon={penAssets.backIcon}
            iconSize={20}
            onPress={() => navigation.goBack()}
            style={{ width: 36, height: 36 }}
          />
          <View
            style={{
              flex: 1,
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'flex-end',
              gap: 6,
            }}
          >
            <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }} pointerEvents="none">
              <Text
                style={[
                  {
                    color: '#ffffff',
                    fontSize: 24,
                    fontWeight: '800',
                    fontStyle: 'italic',
                    letterSpacing: 1,
                  },
                  penTextShadow,
                ]}
              >
                {t('penGame.title')}
              </Text>
              <Image
                source={penAssets.ballTrail}
                style={sizeByHeight(penAssets.ballTrail, 24)}
                resizeMode="contain"
              />
            </View>
            <View
              style={{
                flexDirection: 'row',
                alignItems: 'center',
                gap: 2,
                borderRadius: 999,
                backgroundColor: 'rgba(0,0,0,0.35)',
                paddingHorizontal: 6,
                paddingVertical: 2,
              }}
            >
              <Image
                source={penAssets.kenIcon}
                style={{ width: 14, height: 14 }}
                resizeMode="contain"
              />
              <AnimatedKen
                value={ken}
                showIcon={false}
                textStyle={{ fontSize: 12, fontWeight: '700', color: '#ffffff' }}
              />
            </View>
            <PenButton
              bg={penAssets.plusBtn}
              icon={penAssets.plusIcon}
              iconSize={16}
              onPress={handleTopUp}
              style={{ width: 32, height: 32 }}
            />
            <PenButton
              bg={penAssets.helpBtn}
              icon={penAssets.helpIcon}
              iconSize={16}
              onPress={() => push('info', t('penGame.help'))}
              style={{ width: 32, height: 32 }}
            />
          </View>
        </View>

        <View
          pointerEvents="box-none"
          style={{
            position: 'absolute',
            left: 0,
            right: 12,
            top: 44,
            zIndex: 30,
            alignItems: 'flex-end',
          }}
        >
          <Pressable
            accessibilityLabel={t('penGame.leaderboard.title')}
            onPress={() => setLeaderboardOpen(true)}
            style={{ }}
          >
            <View
              style={{
                height: 36,
                flexDirection: 'row',
                alignItems: 'center',
                gap: 4,
                paddingLeft: 6,
                paddingRight: 16,
              }}
            >
              <PenBg source={penLeaderboardAssets.frame} />
              <Image
                source={penLeaderboardAssets.cup}
                style={sizeByHeight(penLeaderboardAssets.cup, 20)}
                resizeMode="contain"
              />
              <Text
                numberOfLines={1}
                style={[
                  {
                    color: '#ffffff',
                    fontSize: 16,
                    fontWeight: '800',
                    fontStyle: 'italic',
                    letterSpacing: 1,
                  },
                  penTextShadow,
                ]}
              >
                {t('penGame.leaderboard.short')}
              </Text>
            </View>
          </Pressable>
        </View>

        <View
          style={{
            width: '100%',
            height: (containerWidth * 650) / 1024,
            zIndex: 10,
            flexDirection: 'row',
            alignItems: 'flex-end',
            justifyContent: 'flex-end',
            paddingBottom: 8,
            paddingLeft: 16,
            paddingRight: 32,
          }}
        >
          {kickId > 0 && (
            <PenKickBall
              key={kickId}
              zoneWidth={containerWidth}
              zoneHeight={(containerWidth * 650) / 1024}
            />
          )}
          <PenButton
            bg={penAssets.shootBtn}
            iconNode={<ShakingBall size={44} />}
            label={t('penGame.shoot')}
            onPress={() => setShootOpen(true)}
            disabled={kicking}
            gap={12}
            style={{ height: 64, width: '40%', maxWidth: 176 }}
            labelStyle={{ fontSize: 24, letterSpacing: 1 }}
          />
        </View>

        <PenShotList
          shots={shots}
          loading={loadingShots}
          page={shotsPage}
          pageCount={shotsPageCount}
          onPage={(p) => void loadShots(p)}
          onSelect={(shot) => setCatchShot(shot)}
          style={{ flex: 1, marginHorizontal: 16, marginBottom: 4, zIndex: 10 }}
        />

        <View
          style={{
            zIndex: 20,
            flexDirection: 'row',
            alignItems: 'center',
            gap: 12,
            paddingHorizontal: 16,
            paddingVertical: 12,
            paddingBottom: Math.max(insets.bottom, 12),
          }}
        >
          <PenButton
            bg={penAssets.refreshBtn}
            icon={penAssets.refreshIcon}
            label={t('penGame.refresh')}
            onPress={handleRefresh}
            style={{ height: 48, flex: 1 }}
            labelStyle={{ fontSize: 14 }}
          />
          <PenButton
            bg={penAssets.historyBtn}
            icon={penAssets.historyIcon}
            label={t('penGame.history')}
            onPress={() => setHistoryOpen(true)}
            style={{ height: 48, flex: 1 }}
            labelStyle={{ fontSize: 14 }}
          />
        </View>

        {winFx && <PenWinBurst key={winFx.id} amount={winFx.amount} />}

        {shootOpen && (
          <PenShootModal
            ken={ken}
            amount={DEFAULT_BET}
            submitting={submitting}
            onTopUp={handleTopUp}
            onConfirm={handleCreateShot}
            onClose={() => setShootOpen(false)}
          />
        )}

        {catchShot != null && (
          <PenCatchModal
            ken={ken}
            betAmount={catchShot.betAmount}
            submitting={catching}
            onTopUp={handleTopUp}
            onConfirm={handleCatch}
            onClose={closeCatch}
          />
        )}

        {historyOpen && <PenHistoryModal userId={user?.id} onClose={() => setHistoryOpen(false)} />}

        {leaderboardOpen && <PenLeaderboardModal onClose={() => setLeaderboardOpen(false)} />}
      </View>
    </View>
  );
}
