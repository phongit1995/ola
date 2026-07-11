import { useEffect, useRef, useState } from 'react';
import { Animated, View } from 'react-native';

const COLORS = ['#ffd54f', '#ff6f61', '#4fc3f7', '#81c784', '#ba68c8', '#fff176', '#ff8a65'];
const GRAVITY = 520;
const PER_BURST = 64;
const VOLLEY_NORMAL = 3;
const VOLLEY_SUPER = 5;
const GAP_NORMAL = 350;
const GAP_SUPER = 200;
const BURST_DUR_S = 1.5;

interface Particle {
  vx: number;
  vy: number;
  r: number;
  color: string;
  life: number;
}

interface Burst {
  cx: number;
  cy: number;
  particles: Particle[];
}

function pick<T>(list: T[]): T {
  return list[Math.floor(Math.random() * list.length)] ?? list[0]!;
}

function makeBurst(cx: number, cy: number): Burst {
  const base = pick(COLORS);
  const particles: Particle[] = [];
  for (let i = 0; i < PER_BURST; i += 1) {
    const angle = (Math.PI * 2 * i) / PER_BURST + Math.random() * 0.18;
    const speed = 200 + Math.random() * 260;
    particles.push({
      vx: Math.cos(angle) * speed,
      vy: Math.sin(angle) * speed,
      r: 2.5 + Math.random() * 2.5,
      color: Math.random() < 0.5 ? base : pick(COLORS),
      life: 0.9 + Math.random() * 0.6,
    });
  }
  return { cx, cy, particles };
}

function makeVolley(width: number, height: number, count: number): Burst[] {
  const bursts: Burst[] = [];
  for (let b = 0; b < count; b += 1) {
    bursts.push(
      makeBurst(width * (0.16 + Math.random() * 0.68), height * (0.14 + Math.random() * 0.4))
    );
  }
  return bursts;
}

function ParticleDot({ particle, progress }: { particle: Particle; progress: Animated.Value }) {
  const steps = [0, 0.25, 0.5, 0.75, 1];
  const yOutput = steps.map((f) => {
    const t = f * BURST_DUR_S;
    return particle.vy * t + 0.5 * GRAVITY * t * t;
  });
  const fadeAt = Math.min(1, particle.life / BURST_DUR_S);
  const opacityRange = fadeAt >= 1 ? [0, 1] : [0, fadeAt, 1];
  const opacityOutput = fadeAt >= 1 ? [1, 0] : [1, 0, 0];
  return (
    <Animated.View
      style={{
        position: 'absolute',
        left: -particle.r,
        top: -particle.r,
        width: particle.r * 2,
        height: particle.r * 2,
        borderRadius: particle.r,
        backgroundColor: particle.color,
        opacity: progress.interpolate({ inputRange: opacityRange, outputRange: opacityOutput }),
        transform: [
          {
            translateX: progress.interpolate({
              inputRange: [0, 1],
              outputRange: [0, particle.vx * BURST_DUR_S],
            }),
          },
          {
            translateY: progress.interpolate({ inputRange: steps, outputRange: yOutput }),
          },
        ],
      }}
    />
  );
}

function Volley({ bursts, onDone }: { bursts: Burst[]; onDone: () => void }) {
  const progress = useRef(new Animated.Value(0)).current;
  const onDoneRef = useRef(onDone);
  onDoneRef.current = onDone;

  useEffect(() => {
    const anim = Animated.timing(progress, {
      toValue: 1,
      duration: BURST_DUR_S * 1000,
      easing: (v) => v,
      useNativeDriver: true,
    });
    anim.start(({ finished }) => {
      if (finished) onDoneRef.current();
    });
    return () => anim.stop();
  }, [progress]);

  return (
    <>
      {bursts.map((burst, bi) => (
        <View
          key={bi}
          pointerEvents="none"
          style={{ position: 'absolute', left: burst.cx, top: burst.cy }}
        >
          {burst.particles.map((particle, pi) => (
            <ParticleDot key={pi} particle={particle} progress={progress} />
          ))}
        </View>
      ))}
    </>
  );
}

interface FireworksProps {
  active: boolean;
  big: boolean;
  width: number;
  height: number;
}

export function Fireworks({ active, big, width, height }: FireworksProps) {
  const [volley, setVolley] = useState<{ id: number; bursts: Burst[] } | null>(null);
  const idRef = useRef(0);
  const paramsRef = useRef({ width, height, big });
  paramsRef.current = { width, height, big };
  const activeRef = useRef(active);
  const gapRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    activeRef.current = active;
    if (!active) {
      if (gapRef.current != null) clearTimeout(gapRef.current);
      return;
    }
    const { width: w, height: h, big: superLucky } = paramsRef.current;
    idRef.current += 1;
    setVolley({
      id: idRef.current,
      bursts: makeVolley(w, h, superLucky ? VOLLEY_SUPER : VOLLEY_NORMAL),
    });
    return () => {
      if (gapRef.current != null) clearTimeout(gapRef.current);
    };
  }, [active]);

  function handleVolleyDone() {
    if (!activeRef.current) {
      setVolley(null);
      return;
    }
    const { big: superLucky } = paramsRef.current;
    gapRef.current = setTimeout(() => {
      if (!activeRef.current) {
        setVolley(null);
        return;
      }
      const { width: w, height: h, big: superNow } = paramsRef.current;
      idRef.current += 1;
      setVolley({
        id: idRef.current,
        bursts: makeVolley(w, h, superNow ? VOLLEY_SUPER : VOLLEY_NORMAL),
      });
    }, superLucky ? GAP_SUPER : GAP_NORMAL);
  }

  if (!active || volley == null) return null;

  return (
    <View pointerEvents="none" style={{ position: 'absolute', left: 0, top: 0, width, height }}>
      <Volley key={volley.id} bursts={volley.bursts} onDone={handleVolleyDone} />
    </View>
  );
}
