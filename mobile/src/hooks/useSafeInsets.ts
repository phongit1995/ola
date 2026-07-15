import { initialWindowMetrics, useSafeAreaInsets, type EdgeInsets } from 'react-native-safe-area-context';

export function useSafeInsets(): EdgeInsets {
  const live = useSafeAreaInsets();
  const init = initialWindowMetrics?.insets;
  return {
    top: Math.max(live.top, init?.top ?? 0),
    bottom: Math.max(live.bottom, init?.bottom ?? 0),
    left: Math.max(live.left, init?.left ?? 0),
    right: Math.max(live.right, init?.right ?? 0),
  };
}
