import { BrowserRouter, Navigate, Route, Routes } from 'react-router-dom';
import { ROUTES } from '@constants';
import { LoginPage } from '@/pages/login/LoginPage';
import { RegisterPage } from '@/pages/register/RegisterPage';
import { ForgotPasswordPage } from '@/pages/forgot-password/ForgotPasswordPage';
import { TermsPage } from '@/pages/terms/TermsPage';
import { HomePage } from '@/pages/home/HomePage';
import { GuestRoute, ProtectedRoute } from './guards';

export function AppRouter() {
  return (
    <BrowserRouter>
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
        <Route path="*" element={<Navigate to={ROUTES.home} replace />} />
      </Routes>
    </BrowserRouter>
  );
}
