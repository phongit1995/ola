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
const HomePage = lazy(() => import('@/pages/home/HomePage').then((m) => ({ default: m.HomePage })));
const ProfileMePage = lazy(() =>
  import('@/pages/profile/ProfileMePage').then((m) => ({ default: m.ProfileMePage }))
);
const EditProfileMePage = lazy(() =>
  import('@/pages/profile/EditProfileMePage').then((m) => ({ default: m.EditProfileMePage }))
);
const VipStorePage = lazy(() =>
  import('@/pages/vip/VipStorePage').then((m) => ({ default: m.VipStorePage }))
);
const BuyVipPage = lazy(() =>
  import('@/pages/vip/BuyVipPage').then((m) => ({ default: m.BuyVipPage }))
);
const NotificationsPage = lazy(() =>
  import('@/pages/apps/NotificationsPage').then((m) => ({ default: m.NotificationsPage }))
);
const KenStorePage = lazy(() =>
  import('@/pages/apps/KenStorePage').then((m) => ({ default: m.KenStorePage }))
);
const MediaStorePage = lazy(() =>
  import('@/pages/apps/MediaStorePage').then((m) => ({ default: m.MediaStorePage }))
);
const NearbyPlacesPage = lazy(() =>
  import('@/pages/apps/NearbyPlacesPage').then((m) => ({ default: m.NearbyPlacesPage }))
);

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
          <Route
            path={ROUTES.profile}
            element={
              <ProtectedRoute>
                <ProfileMePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.profileEdit}
            element={
              <ProtectedRoute>
                <EditProfileMePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.vip}
            element={
              <ProtectedRoute>
                <VipStorePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.vipBuy}
            element={
              <ProtectedRoute>
                <BuyVipPage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.notifications}
            element={
              <ProtectedRoute>
                <NotificationsPage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.ken}
            element={
              <ProtectedRoute>
                <KenStorePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.media}
            element={
              <ProtectedRoute>
                <MediaStorePage />
              </ProtectedRoute>
            }
          />
          <Route
            path={ROUTES.nearby}
            element={
              <ProtectedRoute>
                <NearbyPlacesPage />
              </ProtectedRoute>
            }
          />
          <Route path={ROUTES.terms} element={<TermsPage />} />
          <Route path="*" element={<Navigate to={ROUTES.home} replace />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}
