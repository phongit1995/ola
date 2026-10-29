import type { ReactNode } from 'react';
import { Navigate } from 'react-router-dom';
import { ROUTES } from '@constants';
import { useAuthStore } from '@/store/authStore';

interface GuardProps {
  children: ReactNode;
}

interface ProtectedRouteProps extends GuardProps {
  guestElement?: ReactNode;
}

export function ProtectedRoute({
  children,
  guestElement,
}: ProtectedRouteProps) {
  const isAuthenticated = useAuthStore((s) => s.user != null);
  if (!isAuthenticated) {
    return guestElement ?? <Navigate to={ROUTES.login} replace />;
  }
  return children;
}

export function GuestRoute({ children }: GuardProps) {
  const isAuthenticated = useAuthStore((s) => s.user != null);
  if (isAuthenticated) {
    return <Navigate to={ROUTES.home} replace />;
  }
  return children;
}
