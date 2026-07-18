import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  StyleSheet,
  Text,
  View,
  useWindowDimensions,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { SPIN_START_KEN } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useSpinWheelStore } from '@ola/shared/stores/spinWheelStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { AnimatedKen } from '@components/ui/AnimatedKen';
import { assetRatio, sizeByHeight } from '@screens/games/pen/penUi';
import { wheelAssets } from './spinWheelAssets';
import { SpinWheel } from './SpinWheel';
import { SpinResultDialog } from './SpinResultDialog';
import { SpinHistoryDialog } from './SpinHistoryDialog';
import { WheelActionButton } from './WheelActionButton';
import { CHIP_TEXT_STYLE, SPIN_TEXT_STYLE, TEXT_SHADOW, TITLE_STYLE } from './spinWheelStyles';
import { playSpinSound, stopSpinSound } from './spinWheelSound';

type Props = NativeStackScreenProps<RootStackParamList, typeof ROOT_ROUTES.SpinWheel>;

export function SpinWheelGameScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const { width: windowWidth } = useWindowDimensions();
  const push = useToastStore((s) => s.push);
  const userKen = useAuthStore((s) => s.user?.ken);
  const ken = useSpinWheelStore((s) => s.ken);
  const muted = useSpinWheelStore((s) => s.muted);
  const rotation = useSpinWheelStore((s) => s.rotation);
  const spinning = useSpinWheelStore((s) => s.spinning);
  const result = useSpinWheelStore((s) => s.result);
  const config = useSpinWheelStore((s) => s.config);
  const configStatus = useSpinWheelStore((s) => s.configStatus);
  const loadConfig = useSpinWheelStore((s) => s.loadConfig);
  const [historyOpen, setHistoryOpen] = useState(false);

  useEffect(() => {
    void loadConfig();
  }, [loadConfig]);

  useEffect(() => {
    useSpinWheelStore.getState().syncKen(userKen ?? SPIN_START_KEN);
  }, [userKen]);

  useEffect(() => {
    useSpinWheelStore.setState({ spinning: false, suppressKenSync: false, pendingResult: null });
    const off = SocketService.on<{ ken?: number }>('KEN_UPDATED', (data) => {
      if (typeof data?.ken === 'number') useSpinWheelStore.getState().syncKen(data.ken);
    });
    return () => {
      off();
      stopSpinSound();
      useSpinWheelStore.setState({ spinning: false, suppressKenSync: false });
    };
  }, []);

  const kenCost = config?.kenCost ?? 0;
  const freeAvailable = config?.freeAvailable ?? false;
  const ready = configStatus === 'ready' && config != null;
  const affordable = freeAvailable || ken >= kenCost;
  const canSpin = ready && !spinning && affordable;

  const handleSpin = async () => {
    const state = useSpinWheelStore.getState();
    if (state.spinning || !ready) return;
    if (!freeAvailable && ken < kenCost) {
      push('info', t('wheelGame.outOfKen'));
      return;
    }
    const ok = await state.spin();
    if (!ok) {
      push('error', t('wheelGame.error'));
      return;
    }
    if (!useSpinWheelStore.getState().muted) playSpinSound();
  };

  const headerHeight = insets.top + (windowWidth * 360) / 1906;
  const wheelSize = Math.min(windowWidth * 0.84, 360);
  const barWidth = Math.min(260, windowWidth - 32);
  const barHeight = (barWidth * 521) / 2014;
  const spinButtonHeight = barWidth / assetRatio(wheelAssets.spinButton);
  const noteSize = sizeByHeight(wheelAssets.spinCountNote, 24);

  return (
    <View style={{ flex: 1, backgroundColor: '#2b0a4e' }}>
      <View style={StyleSheet.absoluteFill} pointerEvents="none">
        <Image
          source={wheelAssets.background}
          style={{ width: '100%', height: '100%' }}
          resizeMode="cover"
        />
      </View>
      <View style={{ flex: 1 }}>
        <View
          style={{
            width: windowWidth,
            height: headerHeight,
            paddingTop: insets.top,
            justifyContent: 'center',
          }}
        >
          <Image
            source={wheelAssets.titleBanner}
            style={{ position: 'absolute', left: 0, top: 0, width: windowWidth, height: headerHeight }}
            resizeMode="stretch"
          />
          <Text
            numberOfLines={1}
            style={[
              {
                paddingHorizontal: 56,
                textAlign: 'center',
                fontSize: 24,
                fontWeight: '800',
              },
              TITLE_STYLE,
            ]}
          >
            {t('wheelGame.title')}
          </Text>
          <Pressable
            accessibilityLabel={t('wheelGame.close')}
            onPress={() => navigation.goBack()}
            style={{
              position: 'absolute',
              right: 16,
              top: insets.top + (headerHeight - insets.top) / 2 - 16,
              width: 32,
              height: 32,
            }}
          >
            <Image
              source={wheelAssets.closeButton}
              style={{ width: 32, height: 32 }}
              resizeMode="contain"
            />
          </Pressable>
        </View>

        <View
          style={{
            flex: 1,
            alignItems: 'center',
            justifyContent: 'space-evenly',
            paddingHorizontal: 16,
            paddingTop: 16,
            paddingBottom: 16 + insets.bottom,
          }}
        >
          <View style={{ width: barWidth, height: barHeight }}>
            <Image
              source={wheelAssets.kenBar}
              style={{ position: 'absolute', left: 0, top: 0, width: barWidth, height: barHeight }}
              resizeMode="stretch"
            />
            <View
              style={{
                flex: 1,
                flexDirection: 'row',
                alignItems: 'center',
                gap: 8,
                paddingHorizontal: 10,
              }}
            >
              <Image
                source={wheelAssets.coin}
                style={{ width: 44, height: 44 }}
                resizeMode="contain"
              />
              <View style={{ flex: 1, alignItems: 'center' }}>
                <AnimatedKen
                  value={ken}
                  showIcon={false}
                  textStyle={[{ fontSize: 20, fontWeight: '800' }, CHIP_TEXT_STYLE]}
                />
              </View>
              <Pressable
                accessibilityLabel={t('wheelGame.buyKen')}
                onPress={() => navigation.navigate(ROOT_ROUTES.KenStore)}
                style={{
                  width: 44,
                  height: 44,
                  alignItems: 'center',
                  justifyContent: 'center',
                }}
              >
                <Image
                  source={wheelAssets.plusFrame}
                  style={{ position: 'absolute', left: 0, top: 0, width: 44, height: 44 }}
                  resizeMode="stretch"
                />
                <Image
                  source={wheelAssets.plusIcon}
                  style={{ width: 20, height: 20 }}
                  resizeMode="contain"
                />
              </Pressable>
            </View>
          </View>

          {ready ? (
            <SpinWheel
              segments={config.segments}
              rotation={rotation}
              spinning={spinning}
              size={wheelSize}
              onSettle={() => {
                stopSpinSound();
                useSpinWheelStore.getState().settle();
              }}
            />
          ) : (
            <View
              style={{
                width: wheelSize,
                height: wheelSize,
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              {configStatus === 'error' ? (
                <Text style={[{ fontSize: 14, fontWeight: '700', color: '#ffffff' }, TEXT_SHADOW]}>
                  {t('wheelGame.error')}
                </Text>
              ) : (
                <ActivityIndicator color="#ffffff" />
              )}
            </View>
          )}

          <Pressable
            disabled={!canSpin}
            onPress={() => void handleSpin()}
            style={{ width: barWidth, height: spinButtonHeight, opacity: canSpin ? 1 : 0.6 }}
          >
            <Image
              source={wheelAssets.spinButton}
              style={{ width: barWidth, height: spinButtonHeight }}
              resizeMode="stretch"
            />
            <View
              style={{
                position: 'absolute',
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                alignItems: 'center',
                justifyContent: 'center',
              }}
            >
              <Text
                style={[
                  { fontSize: 30, fontWeight: '800', textTransform: 'uppercase' },
                  SPIN_TEXT_STYLE,
                ]}
              >
                {t('wheelGame.spin')}
              </Text>
            </View>
          </Pressable>

          <View
            style={{
              flexDirection: 'row',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 6,
            }}
          >
            <Image source={wheelAssets.spinCountNote} style={noteSize} resizeMode="contain" />
            <Text style={[{ fontSize: 14, fontWeight: '700', color: '#ffffff' }, TEXT_SHADOW]}>
              {freeAvailable ? t('wheelGame.freeToday') : t('wheelGame.spinCost', { n: kenCost })}
            </Text>
          </View>

          <View style={{ width: '100%', maxWidth: 300, flexDirection: 'row', gap: 12 }}>
            <WheelActionButton
              icon={muted ? wheelAssets.soundOff : wheelAssets.soundOn}
              label={t('wheelGame.sound')}
              onPress={() => {
                useSpinWheelStore.getState().toggleMute();
                if (useSpinWheelStore.getState().muted) stopSpinSound();
              }}
            />
            <WheelActionButton
              icon={wheelAssets.historyIcon}
              label={t('wheelGame.history')}
              onPress={() => setHistoryOpen(true)}
            />
          </View>
        </View>
      </View>

      {result != null && (
        <SpinResultDialog
          result={result}
          onClose={() => useSpinWheelStore.getState().closeResult()}
        />
      )}
      {historyOpen && <SpinHistoryDialog onClose={() => setHistoryOpen(false)} />}
    </View>
  );
}
