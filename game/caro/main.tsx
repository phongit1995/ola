import { createRoot } from 'react-dom/client';
import { App } from './App';

const nativeAndroidSafeAreaHandled =
  'ReactNativeWebView' in window && /Android/i.test(navigator.userAgent);
if (nativeAndroidSafeAreaHandled) {
  document.documentElement.dataset.olaNativeSafeArea = 'handled';
}

createRoot(document.getElementById('root')!).render(<App />);
