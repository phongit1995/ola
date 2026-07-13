import { createBrowserRouter, Navigate } from 'react-router-dom'
import { LoginPage } from '@/pages/LoginPage'
import { DashboardPage } from '@/pages/DashboardPage'
import { UsersPage } from '@/pages/UsersPage'
import { RoomsPage } from '@/pages/RoomsPage'
import { VipPackagesPage } from '@/pages/VipPackagesPage'
import { VipShopPage } from '@/pages/VipShopPage'
import { VipTransfersPage } from '@/pages/VipTransfersPage'
import { EggRewardsPage } from '@/pages/EggRewardsPage'
import { EggStatsPage } from '@/pages/EggStatsPage'
import { WheelRewardsPage } from '@/pages/WheelRewardsPage'
import { WheelStatsPage } from '@/pages/WheelStatsPage'
import { PenShotsPage } from '@/pages/PenShotsPage'
import { PenStatsPage } from '@/pages/PenStatsPage'
import { KenChestsPage } from '@/pages/KenChestsPage'
import { MePage } from '@/pages/MePage'
import { TopupSettingsPage } from '@/pages/TopupSettingsPage'
import { AuditLogsPage } from '@/pages/AuditLogsPage'
import { AdminLayout } from '@/layout/AdminLayout'
import { RedirectIfAuthed, RequireAuth } from './RequireAuth'

export const router = createBrowserRouter([
  {
    path: '/login',
    element: (
      <RedirectIfAuthed>
        <LoginPage />
      </RedirectIfAuthed>
    ),
  },
  {
    path: '/',
    element: (
      <RequireAuth>
        <AdminLayout />
      </RequireAuth>
    ),
    children: [
      { index: true, element: <DashboardPage /> },
      { path: 'users', element: <UsersPage /> },
      { path: 'rooms', element: <RoomsPage /> },
      { path: 'vip-packages', element: <VipPackagesPage /> },
      { path: 'vip-shop', element: <VipShopPage /> },
      { path: 'vip-transfers', element: <VipTransfersPage /> },
      { path: 'games/egg', element: <EggRewardsPage /> },
      { path: 'games/egg/stats', element: <EggStatsPage /> },
      { path: 'games/wheel', element: <WheelRewardsPage /> },
      { path: 'games/wheel/stats', element: <WheelStatsPage /> },
      { path: 'games/pen', element: <PenShotsPage /> },
      { path: 'games/pen/stats', element: <PenStatsPage /> },
      { path: 'games/ken-treasure', element: <KenChestsPage /> },
      { path: 'me', element: <MePage /> },
      { path: 'settings/topup', element: <TopupSettingsPage /> },
      { path: 'audit-logs', element: <AuditLogsPage /> },
    ],
  },
  {
    path: '*',
    element: <Navigate to="/" replace />,
  },
])
