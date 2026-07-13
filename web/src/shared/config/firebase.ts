import { initializeApp } from 'firebase/app';
import { getAnalytics, isSupported, type Analytics } from 'firebase/analytics';

const firebaseConfig = {
  apiKey: 'AIzaSyCMrFALsexFmHSLhtDvovjJp3ZjkMc-5RY',
  authDomain: 'ola-chat-net.firebaseapp.com',
  projectId: 'ola-chat-net',
  storageBucket: 'ola-chat-net.firebasestorage.app',
  messagingSenderId: '380249924077',
  appId: '1:380249924077:web:1541375a200563180e47e4',
  measurementId: 'G-BK44FYX684',
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
