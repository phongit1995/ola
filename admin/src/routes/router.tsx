import { createBrowserRouter, Navigate } from 'react-router-dom'
import { LoginPage } from '@/pages/LoginPage'
import { DashboardPage } from '@/pages/DashboardPage'
import { UsersPage } from '@/pages/UsersPage'
import { MarriagesPage } from '@/pages/MarriagesPage'
import { RelationshipsPage } from '@/pages/RelationshipsPage'
import { RoomsPage } from '@/pages/RoomsPage'
import { ClansPage } from '@/pages/ClansPage'
import { VipPackagesPage } from '@/pages/VipPackagesPage'
import { VipShopPage } from '@/pages/VipShopPage'
import { VipTransfersPage } from '@/pages/VipTransfersPage'
import { EggRewardsPage } from '@/pages/EggRewardsPage'
import { EggStatsPage } from '@/pages/EggStatsPage'
import { WheelRewardsPage } from '@/pages/WheelRewardsPage'
import { WheelStatsPage } from '@/pages/WheelStatsPage'
import { PenShotsPage } from '@/pages/PenShotsPage'
import { PenStatsPage } from '@/pages/PenStatsPage'
import { GameMatchesPage } from '@/pages/GameMatchesPage'
import { GameMatchStatsPage } from '@/pages/GameMatchStatsPage'
import { KenChestsPage } from '@/pages/KenChestsPage'
import { KenTransfersPage } from '@/pages/KenTransfersPage'
import { MiniGamePage } from '@/pages/MiniGamePage'
import { MePage } from '@/pages/MePage'
import { TopupSettingsPage } from '@/pages/TopupSettingsPage'
import { UsernameChangeSettingsPage } from '@/pages/UsernameChangeSettingsPage'
import { UsernameChangesPage } from '@/pages/UsernameChangesPage'
import { AnnouncementPage } from '@/pages/AnnouncementPage'
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
      { path: 'users/marriages', element: <MarriagesPage /> },
      { path: 'users/relationships', element: <RelationshipsPage /> },
      { path: 'rooms', element: <RoomsPage /> },
      { path: 'clans', element: <ClansPage /> },
      { path: 'vip-packages', element: <VipPackagesPage /> },
      { path: 'vip-shop', element: <VipShopPage /> },
      { path: 'vip-transfers', element: <VipTransfersPage /> },
      { path: 'games/egg', element: <EggRewardsPage /> },
      { path: 'games/egg/stats', element: <EggStatsPage /> },
      { path: 'games/wheel', element: <WheelRewardsPage /> },
      { path: 'games/wheel/stats', element: <WheelStatsPage /> },
      { path: 'games/pen', element: <PenShotsPage /> },
      { path: 'games/pen/stats', element: <PenStatsPage /> },
      { path: 'games/matches', element: <GameMatchesPage /> },
      { path: 'games/matches/stats', element: <GameMatchStatsPage /> },
      { path: 'games/ken-treasure', element: <KenChestsPage /> },
      { path: 'games/mini-game', element: <MiniGamePage /> },
      { path: 'users/ken-transfers', element: <KenTransfersPage /> },
      { path: 'users/username-changes', element: <UsernameChangesPage /> },
      { path: 'ken-transfers', element: <Navigate to="/users/ken-transfers" replace /> },
      { path: 'me', element: <MePage /> },
      { path: 'settings/topup', element: <TopupSettingsPage /> },
      { path: 'settings/username-change', element: <UsernameChangeSettingsPage /> },
      { path: 'settings/announcements', element: <AnnouncementPage /> },
      { path: 'audit-logs', element: <AuditLogsPage /> },
    ],
  },
  {
    path: '*',
    element: <Navigate to="/" replace />,
  },
])
