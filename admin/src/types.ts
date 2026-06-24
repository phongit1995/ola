export interface ApiResponse<T> {
  success: boolean
  status: number
  traceId: string
  timestamp: string
  path: string
  data: T
  error?: string
}

export interface ApiErrorBody {
  success: false
  status: number
  traceId?: string
  timestamp?: string
  path?: string
  error: string
}

export interface AdminAccount {
  id: string
  username: string
  fullName?: string
  email?: string
  avatar?: string
  role: string
}

export interface AdminLoginRequest {
  username: string
  password: string
}

export interface AdminLoginResult {
  token: string
  refreshToken: string
  admin: AdminAccount
}

export interface AdminRefreshResult {
  token: string
  refreshToken: string
}

export interface MessageResult {
  message: string
}

export interface ListParams {
  q?: string
  limit?: number
  offset?: number
}

export interface ListResult<T> {
  items: T[]
  total: number
  limit: number
  offset: number
}

export interface AdminUserListItem {
  id: string
  username: string
  fullName?: string
  email?: string
  avatar?: string
  gender?: string
  ken: number
  isVip: boolean
  isActive: boolean
  createdAt: string
  lastLoginAt?: string | null
}

export interface AdminUserDetail extends AdminUserListItem {
  phone?: string
  bio?: string
  dateOfBirth?: string
  vipUsed?: string
  vipEndTime?: string
  followerCount?: number
  followingCount?: number
  lastLoginIp?: string
  updatedAt?: string
}

export interface UserListParams {
  q?: string
  limit?: number
  offset?: number
  isActive?: boolean
  gender?: string
  vip?: boolean
  sortBy?: string
  sortDir?: string
}

export interface KenTransaction {
  id: string
  direction: 'credit' | 'debit'
  type: string
  amount: number
  balanceBefore: number
  balanceAfter: number
  description?: string
  refType?: string
  refId?: string
  actorType?: string
  actorId?: string
  createdAt: string
}

export interface KenAdjustRequest {
  action: 'grant' | 'deduct'
  amount: number
  description?: string
}

export interface KenAdjustResult {
  transactionId: string
  userId: string
  action: string
  direction: string
  type: string
  amount: number
  balanceBefore: number
  balanceAfter: number
}

export interface VipPackage {
  id: string
  name: string
  days: number
  kenPrice: number
  isActive: boolean
  sortOrder: number
}

export interface CreateVipPackageRequest {
  name: string
  days: number
  kenPrice: number
  isActive?: boolean
  sortOrder?: number
}

export interface UpdateVipPackageRequest {
  name?: string
  days?: number
  kenPrice?: number
  isActive?: boolean
  sortOrder?: number
}

export interface VipShopItem {
  id: string
  vipTypeId: number
  kenPrice: number
  isActive: boolean
  sortOrder: number
}

export interface CreateVipShopItemRequest {
  vipTypeId: number
  kenPrice: number
  isActive?: boolean
  sortOrder?: number
}

export interface UpdateVipShopItemRequest {
  kenPrice?: number
  isActive?: boolean
  sortOrder?: number
}

export interface Room {
  id: string
  name: string
  description?: string
  imageUrl?: string
  maxMembers: number
  index: number
  memberCount: number
  enabled: boolean
  createdBy: string
  createdAt: string
}

export interface CreateRoomRequest {
  name: string
  description?: string
  imageUrl?: string
  maxMembers?: number
  index?: number
}

export interface UpdateRoomRequest {
  name?: string
  description?: string
  imageUrl?: string
  maxMembers?: number
  index?: number
  enabled?: boolean
}

export interface RoomMessage {
  id: string
  roomId: string
  senderId: string
  senderName?: string
  senderAvatar?: string
  senderGender?: string
  content: string
  createdAt: string
}

export interface RoomMessagesList {
  items: RoomMessage[]
  hasMore: boolean
  nextBefore?: string
}

export interface MeAuthor {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface MeImage {
  url: string
  width?: number
  height?: number
  mimeType?: string
}

export interface MeCheckIn {
  name: string
  address?: string
  lat?: number
  lng?: number
  action?: string
  actionIcon?: string
}

export interface MeListItem {
  id: string
  content?: string
  images: MeImage[]
  checkIn?: MeCheckIn
  sticker?: string
  visibility: string
  enabled: boolean
  likeCount: number
  dislikeCount: number
  commentCount: number
  author?: MeAuthor
  createdAt: string
}

export interface MeDetail {
  id: string
  content?: string
  images: MeImage[]
  mentions?: string[]
  checkIn?: MeCheckIn
  sticker?: string
  visibility: string
  enabled: boolean
  likeCount: number
  dislikeCount: number
  commentCount: number
  author?: MeAuthor
  createdAt: string
  updatedAt: string
}

export interface MeComment {
  id: string
  postId: string
  content: string
  author?: MeAuthor
  createdAt: string
}

export interface MeListParams {
  q?: string
  limit?: number
  offset?: number
  authorId?: string
  enabled?: boolean
  visibility?: string
  hasImages?: boolean
  hasCheckin?: boolean
  sortBy?: string
  sortDir?: string
}

export type EggCategoryType = 'nothing' | 'vip_icon' | 'ken' | 'vip_days'

export interface EggReward {
  id: string
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export interface EggCategory {
  id: string
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
  sortOrder: number
  rewards: EggReward[]
}

export interface EggPack {
  id: string
  name: string
  kenCost: number
  isEnabled: boolean
  sortOrder: number
  categories: EggCategory[]
}

export interface CreateEggPackRequest {
  name: string
  kenCost: number
  isEnabled: boolean
  sortOrder: number
  categories?: EggCategoryInput[]
}

export interface UpdateEggPackRequest {
  name?: string
  kenCost?: number
  isEnabled?: boolean
  sortOrder?: number
}

export interface EggRewardInput {
  label: string
  weight: number
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
}

export interface EggCategoryInput {
  type: EggCategoryType
  label: string
  weight: number
  isActive: boolean
  sortOrder: number
  rewards: EggRewardInput[]
}

export interface SaveEggConfigRequest {
  categories: EggCategoryInput[]
}

export interface EggDraw {
  id: string
  packId: string
  packName: string
  kenCost: number
  categoryType: EggCategoryType
  rewardType?: EggCategoryType
  rewardLabel?: string
  vipTypeId?: number
  kenAmount?: number
  vipDays?: number
  isSuperLucky: boolean
  createdAt: string
}

export interface EggDrawUser {
  id: string
  username: string
  fullName: string
  avatar: string
}

export interface AdminEggDraw extends EggDraw {
  user: EggDrawUser
}

export interface EggDrawListParams {
  userId?: string
  categoryType?: EggCategoryType
  outcome?: 'win' | 'miss'
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface EggStatsOverview {
  totalDraws: number
  uniquePlayers: number
  kenIn: number
  kenOut: number
  vipDaysOut: number
  vipIconsOut: number
  winDraws: number
  winRate: number
  netKen: number
}

export interface EggStatsCategory {
  categoryType: EggCategoryType
  draws: number
  percent: number
}

export interface EggStatsReward {
  categoryType: EggCategoryType
  rewardLabel: string
  count: number
}

export interface EggStatsPack {
  packId: string
  packName: string
  draws: number
  kenIn: number
  kenOut: number
  rtp: number
}

export interface EggStatsTimePoint {
  date: string
  draws: number
  kenIn: number
  kenOut: number
}

export interface EggStatsPlayer {
  user: EggDrawUser
  draws: number
  kenSpent: number
}

export interface EggStatsResponse {
  overview: EggStatsOverview
  byCategory: EggStatsCategory[]
  topRewards: EggStatsReward[]
  byPack: EggStatsPack[]
  timeseries: EggStatsTimePoint[]
  topPlayers: EggStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface EggStatsParams {
  packId?: string
  from?: string
  to?: string
}

export type PenStatus = 'open' | 'settled' | 'cancelled'
export type PenResult = 'saved' | 'goal'
export type PenSide = 'left' | 'right'

export interface PenUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminPenShot {
  id: string
  shooter?: PenUserBrief
  keeper?: PenUserBrief
  betAmount: number
  status: PenStatus
  shooterSide?: PenSide
  keeperSide?: PenSide
  result?: PenResult
  winnerId?: string
  pot?: number
  commission?: number
  payout?: number
  createdAt: string
  settledAt?: string
  cancelledAt?: string
}

export interface PenShotListParams {
  shooterId?: string
  keeperId?: string
  status?: PenStatus
  result?: PenResult
  minBet?: number
  maxBet?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface PenStatsOverview {
  totalShots: number
  settledShots: number
  openShots: number
  cancelledShots: number
  uniqueShooters: number
  uniqueKeepers: number
  totalVolume: number
  houseTake: number
  totalPayout: number
  savedCount: number
  goalCount: number
  keeperWinRate: number
}

export interface PenStatsResult {
  result: PenResult
  count: number
  percent: number
}

export interface PenStatsStatus {
  status: PenStatus
  count: number
  percent: number
}

export interface PenStatsTimePoint {
  date: string
  shots: number
  settled: number
  volume: number
  houseTake: number
}

export interface PenStatsPlayer {
  user: PenUserBrief
  shots: number
  staked: number
  won: number
}

export interface PenStatsResponse {
  overview: PenStatsOverview
  byResult: PenStatsResult[]
  byStatus: PenStatsStatus[]
  timeseries: PenStatsTimePoint[]
  topPlayers: PenStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface PenStatsParams {
  from?: string
  to?: string
}
