import { useEffect, useRef, useState } from 'react';
import { Animated, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useAppTypography } from '@components/AppFontProvider';
import { AnimatedKen } from './AnimatedKen';

const SHOW_MS = 3200;
const TWEEN_MS = 1100;
const FADE_MS = 300;

export function KenBalanceBadge() {
  const insets = useSafeAreaInsets();
  const { multiplier: fontMultiplier } = useAppTypography();
  const ken = useAuthStore((s) => s.user?.ken);
  const [prevKen, setPrevKen] = useState(ken);
  const [visible, setVisible] = useState(false);
  const opacity = useRef(new Animated.Value(0)).current;

  if (ken !== prevKen) {
    setPrevKen(ken);
    if (typeof prevKen === 'number' && typeof ken === 'number') setVisible(true);
  }

  useEffect(() => {
    if (!visible) return;
    const id = setTimeout(() => setVisible(false), SHOW_MS);
    return () => clearTimeout(id);
  }, [visible, ken]);

  useEffect(() => {
    Animated.timing(opacity, {
      toValue: visible ? 1 : 0,
      duration: FADE_MS,
      useNativeDriver: true,
    }).start();
  }, [visible, opacity]);

  if (typeof ken !== 'number') return null;

  return (
    <Animated.View
      pointerEvents="none"
      style={{
        position: 'absolute',
        right: 8,
        top: insets.top + 8,
        zIndex: 55,
        opacity,
      }}
    >
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          borderRadius: 999,
          borderWidth: 1,
          borderColor: '#7cb342',
          backgroundColor: 'rgba(255,255,255,0.92)',
          paddingHorizontal: 14,
          paddingVertical: 6,
          elevation: 4,
          shadowColor: '#000',
          shadowOpacity: 0.2,
          shadowRadius: 5,
          shadowOffset: { width: 0, height: 2 },
        }}
      >
        <AnimatedKen
          value={ken}
          tweenMs={TWEEN_MS}
          iconSize={24}
          textStyle={{
            color: '#f57f17',
            fontSize: 18 * fontMultiplier,
            fontWeight: '800',
          }}
        />
      </View>
    </Animated.View>
  );
}
