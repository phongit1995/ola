import { lazy, Suspense } from 'react';
import { useAppOverlayStore, type AppOverlayEntry } from '@/store/appOverlayStore';

const NotificationsPage = lazy(() =>
  import('./NotificationsPage').then((m) => ({ default: m.NotificationsPage }))
);
const KenStorePage = lazy(() =>
  import('./KenStorePage').then((m) => ({ default: m.KenStorePage }))
);
const BuyKenPage = lazy(() => import('./BuyKenPage').then((m) => ({ default: m.BuyKenPage })));
const MediaStorePage = lazy(() =>
  import('./MediaStorePage').then((m) => ({ default: m.MediaStorePage }))
);
const NearbyPlacesPage = lazy(() =>
  import('./NearbyPlacesPage').then((m) => ({ default: m.NearbyPlacesPage }))
);
const SettingsPage = lazy(() =>
  import('../settings/SettingsPage').then((m) => ({ default: m.SettingsPage }))
);
const EditProfileMePage = lazy(() =>
  import('../profile/EditProfileMePage').then((m) => ({ default: m.EditProfileMePage }))
);
const VipStorePage = lazy(() =>
  import('../vip/VipStorePage').then((m) => ({ default: m.VipStorePage }))
);
const BuyVipPage = lazy(() => import('../vip/BuyVipPage').then((m) => ({ default: m.BuyVipPage })));

function renderEntry(entry: AppOverlayEntry, onClose: () => void) {
  switch (entry.kind) {
    case 'notifications':
      return <NotificationsPage onClose={onClose} />;
    case 'profile':
      return <EditProfileMePage onClose={onClose} />;
    case 'vip':
      return <VipStorePage onClose={onClose} />;
    case 'vipBuy':
      return <BuyVipPage mode={entry.mode} onClose={onClose} />;
    case 'ken':
      return <KenStorePage onClose={onClose} />;
    case 'kenBuy':
      return <BuyKenPage onClose={onClose} />;
    case 'media':
      return <MediaStorePage onClose={onClose} />;
    case 'nearby':
      return <NearbyPlacesPage onClose={onClose} />;
    case 'settings':
      return <SettingsPage onClose={onClose} />;
    default:
      return null;
  }
}

export function AppOverlay() {
  const stack = useAppOverlayStore((s) => s.stack);
  const back = useAppOverlayStore((s) => s.back);
  const current = stack[stack.length - 1];

  if (current == null) return null;

  return <Suspense fallback={null}>{renderEntry(current, back)}</Suspense>;
}
