import { useEffect } from 'react';
import { setOnUnauthorized } from '@api';
import { ToastViewport } from '@components';
import { AppRouter } from '@/routes';
import { useAuthStore } from '@/store/authStore';

function App() {
  useEffect(() => {
    setOnUnauthorized(() => useAuthStore.getState().clearUser());
    return () => setOnUnauthorized(null);
  }, []);

  useEffect(() => {
    useAuthStore.getState().refreshUser();
  }, []);

  return (
    <>
      <AppRouter />
      <ToastViewport />
    </>
  );
}

export default App;
