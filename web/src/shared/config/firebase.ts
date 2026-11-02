import { initializeApp } from 'firebase/app';
import {
  getAnalytics,
  isSupported,
  logEvent,
  type Analytics,
} from 'firebase/analytics';

const firebaseConfig = {
  apiKey: 'AIzaSyDCaj1CkQrJtuscR5-vw-sXNCt407pvoTQ',
  authDomain: 'ola-me-67e75.firebaseapp.com',
  projectId: 'ola-me-67e75',
  storageBucket: 'ola-me-67e75.firebasestorage.app',
  messagingSenderId: '372046068923',
  appId: '1:372046068923:web:06b4321e84b35456e67d9e',
  measurementId: 'G-G9V5NELCHY',
};

let analytics: Analytics | null = null;

export async function initAnalytics() {
  if (!(await isSupported())) return;
  const app = initializeApp(firebaseConfig);
  analytics = getAnalytics(app);
}

export function getAppAnalytics() {
  return analytics;
}

export function trackEvent(
  name: string,
  params?: Record<string, string | number>
) {
  if (analytics == null) return;
  logEvent(analytics, name, params);
}
