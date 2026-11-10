export interface DashboardTotals {
  users: number
  posts: number
  rooms: number
  kenInCirculation: number
  kisses: number
  activeMarriages: number
}

export interface DashboardUsers {
  new: number
  active: number
  verified: number
  male: number
  female: number
}

export interface DashboardRegistrations {
  today: number
  week: number
}

export interface DashboardSpendByType {
  type: string
  amount: number
  count: number
}

export interface DashboardRevenue {
  topupKen: number
  topupCount: number
  vipRevenueKen: number
  vipPurchases: number
  spendByType: DashboardSpendByType[]
}

export interface DashboardEngagement {
  newPosts: number
  likes: number
  dislikes: number
  comments: number
}

export interface DashboardSocial {
  newFollows: number
  friendRequests: number
  newFriendships: number
  newMarriages: number
}

export interface DashboardGames {
  eggDraws: number
  wheelSpins: number
  penShots: number
}

export interface DashboardTimePoint {
  date: string
  newUsers: number
  topupKen: number
  revenueKen: number
  posts: number
}

export interface DashboardOverview {
  range: { from: string; to: string }
  bucket: 'day' | 'month'
  totals: DashboardTotals
  registrations: DashboardRegistrations
  users: DashboardUsers
  revenue: DashboardRevenue
  engagement: DashboardEngagement
  social: DashboardSocial
  games: DashboardGames
  timeseries: DashboardTimePoint[]
}

export interface DashboardOverviewParams {
  from?: string
  to?: string
}
