import { useEffect, useRef, useState } from 'react';
import { Animated, Image, type StyleProp, type TextStyle } from 'react-native';
import { formatKen } from '@ola/shared/lib';

const kenIcon = require('@assets/icons/apps/ken.png');

const SETTLE_MS = 700;

interface AnimatedKenProps {
  value: number;
  textStyle?: StyleProp<TextStyle>;
  iconSize?: number;
  showIcon?: boolean;
  bounce?: boolean;
  tweenMs?: number;
}

export function AnimatedKen({
  value,
  textStyle,
  iconSize = 20,
  showIcon = true,
  bounce = true,
  tweenMs = 500,
}: AnimatedKenProps) {
  const [display, setDisplay] = useState(value);
  const [settled, setSettled] = useState(false);
  const displayRef = useRef(value);
  const rafRef = useRef<number | null>(null);
  const scale = useRef(new Animated.Value(1)).current;

  useEffect(() => {
    displayRef.current = display;
  });

  useEffect(() => {
    const id = setTimeout(() => setSettled(true), SETTLE_MS);
    return () => clearTimeout(id);
  }, []);

  useEffect(() => {
    const from = displayRef.current;
    const to = value;
    if (from === to) return;
    if (!settled) {
      rafRef.current = requestAnimationFrame(() => setDisplay(to));
      return () => {
        if (rafRef.current != null) cancelAnimationFrame(rafRef.current);
      };
    }
    if (bounce) {
      scale.setValue(1);
      Animated.sequence([
        Animated.timing(scale, { toValue: 1.25, duration: 120, useNativeDriver: true }),
        Animated.timing(scale, { toValue: 1, duration: 180, useNativeDriver: true }),
      ]).start();
    }
    let start: number | null = null;
    const step = (now: number) => {
      if (start == null) start = now;
      const progress = Math.min(1, (now - start) / tweenMs);
      const eased = 1 - (1 - progress) ** 3;
      setDisplay(Math.round(from + (to - from) * eased));
      if (progress < 1) rafRef.current = requestAnimationFrame(step);
    };
    rafRef.current = requestAnimationFrame(step);
    return () => {
      if (rafRef.current != null) cancelAnimationFrame(rafRef.current);
    };
  }, [value, settled, tweenMs, bounce, scale]);

  return (
    <Animated.View
      style={{
        flexDirection: 'row',
        alignItems: 'center',
        gap: 6,
        transform: [{ scale }],
      }}
    >
      <Animated.Text style={[{ color: '#ffca28', fontSize: 20, fontWeight: '700' }, textStyle]}>
        {formatKen(display)}
      </Animated.Text>
      {showIcon && (
        <Image source={kenIcon} style={{ width: iconSize, height: iconSize }} resizeMode="contain" />
      )}
    </Animated.View>
  );
}
