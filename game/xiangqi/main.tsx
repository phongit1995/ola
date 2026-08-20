import { createRoot } from 'react-dom/client';
import { App } from './App';

if (window.ReactNativeWebView && /android/i.test(navigator.userAgent)) {
  document.documentElement.dataset.olaNativeSafeArea = 'handled';
}

createRoot(document.getElementById('root')!).render(<App />);
