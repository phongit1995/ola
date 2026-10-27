import { createBrowserRouter, Navigate } from 'react-router-dom'
import { LoginPage } from '@/pages/auth/LoginPage'
import { DashboardPage } from '@/pages/dashboard/DashboardPage'
import { UsersPage } from '@/pages/users/UsersPage'
import { MarriagesPage } from '@/pages/social/MarriagesPage'
import { RelationshipsPage } from '@/pages/social/RelationshipsPage'
import { RoomsPage } from '@/pages/rooms/RoomsPage'
import { WordChainPage } from '@/pages/word-chain/WordChainPage'
import { ClansPage } from '@/pages/clans/ClansPage'
import { VipPackagesPage } from '@/pages/vip/VipPackagesPage'
import { VipShopPage } from '@/pages/vip/VipShopPage'
import { VipPurchasesPage } from '@/pages/vip/VipPurchasesPage'
import { VipTransfersPage } from '@/pages/vip/VipTransfersPage'
import { EggRewardsPage } from '@/pages/games/egg/EggRewardsPage'
import { EggStatsPage } from '@/pages/games/egg/EggStatsPage'
import { WheelRewardsPage } from '@/pages/games/wheel/WheelRewardsPage'
import { WheelStatsPage } from '@/pages/games/wheel/WheelStatsPage'
import { PenShotsPage } from '@/pages/games/pen/PenShotsPage'
import { PenStatsPage } from '@/pages/games/pen/PenStatsPage'
import { GameMatchStatsPage } from '@/pages/games/mini-game/GameMatchStatsPage'
import { KenChestsPage } from '@/pages/games/ken-chest/KenChestsPage'
import { KenTransfersPage } from '@/pages/ken-transfers/KenTransfersPage'
import { MiniGamePage } from '@/pages/games/mini-game/MiniGamePage'
import { PostsPage } from '@/pages/posts/PostsPage'
import { ReportsPage } from '@/pages/reports/ReportsPage'
import { PushCampaignPage } from '@/pages/settings/PushCampaignPage'
import { ChatBotSettingsPage } from '@/pages/settings/ChatBotSettingsPage'
import { TopupSettingsPage } from '@/pages/topup/TopupSettingsPage'
import { TopupTransactionsPage } from '@/pages/topup/TopupTransactionsPage'
import { UsernameChangeSettingsPage } from '@/pages/username-change/UsernameChangeSettingsPage'
import { UsernameChangesPage } from '@/pages/username-change/UsernameChangesPage'
import { AnnouncementPage } from '@/pages/settings/AnnouncementPage'
import { NotificationSettingsPage } from '@/pages/settings/NotificationSettingsPage'
import { AuditLogsPage } from '@/pages/audit-logs/AuditLogsPage'
import { StoriesPage } from '@/pages/stories/StoriesPage'
import { StorySettingsPage } from '@/pages/stories/StorySettingsPage'
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
      { path: 'rooms/word-chain', element: <WordChainPage /> },
      { path: 'clans', element: <ClansPage /> },
      { path: 'vip-packages', element: <VipPackagesPage /> },
      { path: 'vip-shop', element: <VipShopPage /> },
      { path: 'vip-purchases', element: <VipPurchasesPage /> },
      { path: 'vip-transfers', element: <VipTransfersPage /> },
      { path: 'games/egg', element: <EggRewardsPage /> },
      { path: 'games/egg/stats', element: <EggStatsPage /> },
      { path: 'games/wheel', element: <WheelRewardsPage /> },
      { path: 'games/wheel/stats', element: <WheelStatsPage /> },
      { path: 'games/pen', element: <PenShotsPage /> },
      { path: 'games/pen/stats', element: <PenStatsPage /> },
      { path: 'games/matches', element: <Navigate to="/games/mini-game?tab=history" replace /> },
      { path: 'games/matches/stats', element: <GameMatchStatsPage /> },
      { path: 'games/ken-treasure', element: <KenChestsPage /> },
      { path: 'games/mini-game', element: <MiniGamePage /> },
      { path: 'users/ken-transfers', element: <KenTransfersPage /> },
      { path: 'users/topups', element: <TopupTransactionsPage /> },
      { path: 'users/username-changes', element: <UsernameChangesPage /> },
      { path: 'ken-transfers', element: <Navigate to="/users/ken-transfers" replace /> },
      { path: 'posts', element: <PostsPage /> },
      { path: 'me', element: <Navigate to="/posts" replace /> },
      { path: 'reports', element: <ReportsPage /> },
      { path: 'stories', element: <StoriesPage /> },
      { path: 'stories/settings', element: <StorySettingsPage /> },
      { path: 'settings/topup', element: <TopupSettingsPage /> },
      { path: 'settings/username-change', element: <UsernameChangeSettingsPage /> },
      { path: 'settings/announcements', element: <AnnouncementPage /> },
      { path: 'settings/notification', element: <NotificationSettingsPage /> },
      { path: 'settings/push-campaigns', element: <PushCampaignPage /> },
      { path: 'settings/chat-bot', element: <ChatBotSettingsPage /> },
      { path: 'audit-logs', element: <AuditLogsPage /> },
    ],
  },
  {
    path: '*',
    element: <Navigate to="/" replace />,
  },
])
