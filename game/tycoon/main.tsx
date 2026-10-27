import { createRoot } from 'react-dom/client';
import { App } from './App';
import { useTycoon } from './store/useTycoon';

const preview = import.meta.env.DEV ? new URLSearchParams(window.location.search).get('preview') : null;

if (preview === 'loading') {
  useTycoon.setState({ profile: null });
}

if (preview === 'rooms') {
  useTycoon.setState({ roomsOpen: true });
}

if (window.ReactNativeWebView && /android/i.test(navigator.userAgent)) {
  document.documentElement.dataset.olaNativeSafeArea = 'handled';
}

createRoot(document.getElementById('root')!).render(<App />);
