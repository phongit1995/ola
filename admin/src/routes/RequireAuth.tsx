import type { ReactNode } from 'react'
import { Navigate } from 'react-router-dom'
import { useAuthStore } from '@/store/authStore'

export function RequireAuth({ children }: { children: ReactNode }) {
  const admin = useAuthStore((s) => s.admin)
  if (!admin) {
    return <Navigate to="/login" replace />
  }
  return children
}

export function RedirectIfAuthed({ children }: { children: ReactNode }) {
  const admin = useAuthStore((s) => s.admin)
  if (admin) {
    return <Navigate to="/" replace />
  }
  return children
}
