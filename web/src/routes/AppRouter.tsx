import { lazy, Suspense } from 'react';
import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import { ROUTES } from '@constants';
import { LoginPage } from '@/pages/login/LoginPage';
import { GuestRoute, ProtectedRoute } from './guards';

const RegisterPage = lazy(() =>
  import('@/pages/register/RegisterPage').then((m) => ({ default: m.RegisterPage }))
);
const ForgotPasswordPage = lazy(() =>
  import('@/pages/forgot-password/ForgotPasswordPage').then((m) => ({ default: m.ForgotPasswordPage }))
);
const TermsPage = lazy(() =>
  import('@/pages/terms/TermsPage').then((m) => ({ default: m.TermsPage }))
);
const DownloadAppPage = lazy(() =>
  import('@/pages/download/DownloadAppPage').then((m) => ({ default: m.DownloadAppPage }))
);
const HomePage = lazy(() => import('@/pages/home/HomePage').then((m) => ({ default: m.HomePage })));

export function AppRouter() {
  return (
    <BrowserRouter>
      <Suspense fallback={<div className="h-dvh bg-white" />}>
        <Routes>
          <Route
            path={ROUTES.home}
            element={
              <ProtectedRoute>
                <HomePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.login}
            element={
              <GuestRoute>
                <LoginPage />
              </GuestRoute>
            }
          />
          <Route
            path={ROUTES.register}
            element={
              <GuestRoute>
                <RegisterPage />
              </GuestRoute>
            }
          />
          <Route
            path={ROUTES.forgotPassword}
            element={
              <GuestRoute>
                <ForgotPasswordPage />
              </GuestRoute>
            }
          />
          <Route path={ROUTES.terms} element={<TermsPage />} />
          <Route path={ROUTES.downloadApp} element={<DownloadAppPage />} />
          <Route path="*" element={<Navigate to={ROUTES.home} replace />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
