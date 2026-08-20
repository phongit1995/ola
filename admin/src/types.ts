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

export interface KenClaimHistoryItem {
  id: string
  kenAmount: number
  isEmpty: boolean
  chestSource: 'manual' | 'auto'
  createdAt: string
  user: { id: string; username: string; fullName?: string; avatar?: string }
}

export interface AdminAuditLog {
  id: string
  adminId: string
  adminUsername?: string
  adminFullName?: string
  method: string
  resource: string
  path: string
  route?: string
  status: number
  ip?: string
  detail?: Record<string, unknown>
  createdAt: string
}

export interface AuditLogListParams {
  adminId?: string
  resource?: string
  method?: string
  route?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface VipPurchaseHistory {
  id: string
  packageName: string
  days: number
  kenPrice: number
  kenBalanceAfter: number
  vipEndTime: string
  source: string
  createdAt: string
}

export interface ListResult<T> {
  items: T[]
  total: number
  limit: number
  offset: number
}

export type KenChestRewardMode = 'fixed' | 'random'

export interface KenChest {
  id: string
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  claimedRecipients: number
  durationSeconds: number
  status: string
  startedAt: string
  expiresAt: string
  claimsCount: number
  totalKenGiven: number
  source: 'manual' | 'auto'
  autoJobId?: string
  createdAt: string
}

export type KenChestScheduleType = 'interval' | 'daily'

export interface KenChestAutoJob {
  id: string
  name: string
  enabled: boolean
  scheduleType: KenChestScheduleType
  intervalMinMinutes?: number
  intervalMaxMinutes?: number
  dailyTimes?: string[]
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
  remainingRuns?: number
  runCount: number
  nextRunAt?: string
  lastRunAt?: string
  createdAt: string
}

export interface KenChestAutoJobRequest {
  name: string
  enabled: boolean
  scheduleType: KenChestScheduleType
  intervalMinMinutes?: number
  intervalMaxMinutes?: number
  dailyTimes?: string[]
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
  remainingRuns?: number
}

export interface KenChestAutoSettings {
  enabled: boolean
  updatedAt: string
}

export interface CreateKenChestRequest {
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
}

export interface KenChestClaim {
  id: string
  kenAmount: number
  isEmpty: boolean
  createdAt: string
  user: {
    id: string
    username: string
    fullName?: string
    avatar?: string
  }
}

export type KenChestSource = 'manual' | 'auto'

export interface KenChestStatsOverview {
  totalChests: number
  manualChests: number
  autoChests: number
  activeChests: number
  expiredChests: number
  totalClaims: number
  emptyClaims: number
  emptyRate: number
  totalKenGiven: number
  uniqueUsers: number
}

export interface KenChestStatsSourceRow {
  source: KenChestSource
  chests: number
  claims: number
  kenGiven: number
}

export interface KenChestStatsTimePoint {
  date: string
  claims: number
  empty: number
  kenGiven: number
}

export interface KenChestStatsResponse {
  overview: KenChestStatsOverview
  bySource: KenChestStatsSourceRow[]
  timeseries: KenChestStatsTimePoint[]
  bucket: 'day' | 'month'
}

export interface KenChestStatsParams {
  source?: KenChestSource
  userId?: string
  from?: string
  to?: string
}

export type KenChestUserStatsSortBy = 'kenTotal' | 'claims' | 'empty'

export interface KenChestUserStatsItem {
  user: KenChestClaim['user']
  claims: number
  chests: number
  emptyClaims: number
  emptyRate: number
  kenTotal: number
  lastClaimAt: string
}

export interface KenChestUserStatsParams extends KenChestStatsParams {
  sortBy?: KenChestUserStatsSortBy
  limit?: number
  offset?: number
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
  emailVerified: boolean
  createdAt: string
  lastLoginAt?: string | null
}

export interface AdminUserDetail extends AdminUserListItem {
  phone?: string
  bio?: string
  dateOfBirth?: string
  vipUsed?: string
  vipEndTime?: string
  emailVerifiedAt?: string
  followerCount?: number
  followingCount?: number
  lastLoginIp?: string
  updatedAt?: string
}

export interface AdminUserSession {
  id: string
  deviceName?: string
  platform?: string
  appVersion?: string
  ipAddress?: string
  userAgent?: string
  isActive: boolean
  lastActiveAt?: string
  createdAt: string
  revokedAt?: string
}

export interface AdminUserVipIcon {
  instanceId: string
  typeId: number
  isLocked: boolean
  isUsing: boolean
  source?: string
  acquiredAt?: string
}

export interface GrantVipRequest {
  vipTypeId: number
}

export interface AddVipDaysRequest {
  action?: 'add' | 'subtract'
  days: number
}

export interface AddVipDaysResult {
  days: number
  vipEndTime: string
}

export interface UserListParams {
  q?: string
  ip?: string
  limit?: number
  offset?: number
  isActive?: boolean
  gender?: string
  vip?: boolean
  emailVerified?: boolean
  sortBy?: string
  sortDir?: string
}

export interface KenCounterparty {
  id: string
  username: string
  fullName?: string
  avatar?: string
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
  counterparty?: KenCounterparty
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

export interface KenTransferItem {
  id: string
  from: KenCounterparty
  to: KenCounterparty
  amount: number
  description?: string
  createdAt: string
}

export interface KenTransferListParams {
  senderId?: string
  receiverId?: string
  userId?: string
  minAmount?: number
  maxAmount?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type KenTransferUserStatsSortBy = 'sentTotal' | 'receivedTotal' | 'netKen' | 'transfers'

export interface KenTransferUserStatsItem {
  user: KenCounterparty
  sentCount: number
  sentTotal: number
  receivedCount: number
  receivedTotal: number
  netKen: number
  partners: number
  lastTransferAt: string
}

export interface KenTransferUserStatsParams {
  userId?: string
  minAmount?: number
  maxAmount?: number
  from?: string
  to?: string
  sortBy?: KenTransferUserStatsSortBy
  limit?: number
  offset?: number
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

export interface AdminVipTransfer {
  id: string
  fromUserId: string
  fromUsername: string
  fromFullName: string
  toUserId: string
  toUsername: string
  toFullName: string
  vipIconId: number
  createdAt: string
}

export interface VipTransferListParams {
  q?: string
  userId?: string
  limit?: number
  offset?: number
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

export interface RoomReplySnapshot {
  messageId: string
  senderId: string
  senderName?: string
  excerpt: string
  type?: string
  imageUrl?: string
}

export interface RoomReactor {
  userId: string
  username: string
}

export interface RoomMessage {
  id: string
  roomId: string
  senderId: string
  senderName?: string
  senderAvatar?: string
  senderGender?: string
  senderVip?: string
  senderVipEnd?: string
  type?: string
  content: string
  imageUrl?: string
  createdAt: string
  replyTo?: RoomReplySnapshot
  reactions?: Record<string, RoomReactor[]>
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

export type EggUserStatsSortBy = 'kenSpent' | 'kenWon' | 'netKen' | 'draws' | 'vipDays'

export interface EggUserStatsItem {
  user: EggDrawUser
  draws: number
  winDraws: number
  winRate: number
  kenSpent: number
  kenWon: number
  netKen: number
  vipDays: number
  vipIcons: number
  lastDrawAt: string
}

export interface EggUserStatsParams {
  packId?: string
  userId?: string
  from?: string
  to?: string
  sortBy?: EggUserStatsSortBy
  limit?: number
  offset?: number
}

export interface EggVipStatsRow {
  vipTypeId: number
  iconWins: number
  dayWins: number
  vipDays: number
}

export interface EggVipStatsParams {
  packId?: string
  userId?: string
  from?: string
  to?: string
}

export type WheelSegmentKind =
  | 'miss'
  | 'ken_fixed'
  | 'ken_random'
  | 'vip_days'
  | 'vip_item'
  | 'vip_random'

export interface WheelSegmentOption {
  id: string
  label: string
  weight: number
  vipTypeId?: number
  vipDays?: number
  kenAmount?: number
  isActive: boolean
  sortOrder: number
}

export interface WheelSegment {
  id: string
  kind: WheelSegmentKind
  label: string
  weight: number
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
  options: WheelSegmentOption[]
}

export interface Wheel {
  id: string
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  sortOrder: number
  segments: WheelSegment[]
}

export interface WheelSegmentOptionInput {
  label: string
  weight: number
  vipTypeId?: number
  vipDays?: number
  kenAmount?: number
  isActive: boolean
  sortOrder: number
}

export interface WheelSegmentInput {
  kind: WheelSegmentKind
  label: string
  weight: number
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  isActive: boolean
  sortOrder: number
  options: WheelSegmentOptionInput[]
}

export interface CreateWheelRequest {
  name: string
  kenCost: number
  freeDailyEnabled: boolean
  isEnabled: boolean
  sortOrder: number
  segments?: WheelSegmentInput[]
}

export interface UpdateWheelRequest {
  name?: string
  kenCost?: number
  freeDailyEnabled?: boolean
  isEnabled?: boolean
  sortOrder?: number
}

export interface SaveWheelConfigRequest {
  segments: WheelSegmentInput[]
}

export interface WheelSpin {
  id: string
  wheelId: string
  wheelName: string
  kenCost: number
  isFree: boolean
  segmentKind: WheelSegmentKind
  rewardLabel?: string
  kenAmount?: number
  vipDays?: number
  vipTypeId?: number
  isSuperLucky: boolean
  createdAt: string
}

export interface WheelSpinUser {
  id: string
  username: string
  fullName: string
  avatar: string
}

export interface AdminWheelSpin extends WheelSpin {
  user: WheelSpinUser
}

export interface WheelSpinListParams {
  q?: string
  userId?: string
  segmentKind?: WheelSegmentKind
  outcome?: 'win' | 'miss'
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface WheelStatsOverview {
  totalSpins: number
  uniquePlayers: number
  kenIn: number
  kenOut: number
  vipDaysOut: number
  vipItemsOut: number
  freeSpins: number
  winSpins: number
  winRate: number
  netKen: number
}

export interface WheelStatsKind {
  segmentKind: WheelSegmentKind
  spins: number
  percent: number
}

export interface WheelStatsReward {
  segmentKind: WheelSegmentKind
  rewardLabel: string
  count: number
}

export interface WheelStatsWheel {
  wheelId: string
  wheelName: string
  spins: number
  kenIn: number
  kenOut: number
  rtp: number
}

export interface WheelStatsTimePoint {
  date: string
  spins: number
  kenIn: number
  kenOut: number
}

export interface WheelStatsPlayer {
  user: WheelSpinUser
  spins: number
  kenSpent: number
}

export interface WheelStatsResponse {
  overview: WheelStatsOverview
  byKind: WheelStatsKind[]
  topRewards: WheelStatsReward[]
  byWheel: WheelStatsWheel[]
  timeseries: WheelStatsTimePoint[]
  topPlayers: WheelStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface WheelStatsParams {
  wheelId?: string
  from?: string
  to?: string
}

export type WheelUserStatsSortBy = 'kenSpent' | 'kenWon' | 'netKen' | 'spins' | 'vipDays'

export interface WheelUserStatsItem {
  user: WheelSpinUser
  spins: number
  winSpins: number
  winRate: number
  freeSpins: number
  kenSpent: number
  kenWon: number
  netKen: number
  vipDays: number
  vipItems: number
  lastSpinAt: string
}

export interface WheelUserStatsParams {
  wheelId?: string
  userId?: string
  from?: string
  to?: string
  sortBy?: WheelUserStatsSortBy
  limit?: number
  offset?: number
}

export interface WheelVipStatsRow {
  vipTypeId: number
  itemWins: number
  dayWins: number
  vipDays: number
}

export interface WheelVipStatsParams {
  wheelId?: string
  userId?: string
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

export type PenUserStatsSortBy = 'staked' | 'netKen' | 'shots' | 'catches'

export interface PenUserStatsItem {
  user: PenUserBrief
  shots: number
  shooterSettled: number
  shooterWins: number
  shooterWinRate: number
  catches: number
  keeperWins: number
  keeperSaveRate: number
  cancelled: number
  cancelRate: number
  staked: number
  netKen: number
  lastPlayAt: string
}

export interface PenUserStatsParams {
  userId?: string
  from?: string
  to?: string
  sortBy?: PenUserStatsSortBy
  limit?: number
  offset?: number
}

export interface PenSideStatsResponse {
  shooterLeft: number
  shooterRight: number
  keeperLeft: number
  keeperRight: number
}

export interface PenSideStatsParams {
  userId?: string
  from?: string
  to?: string
}

export type GameMatchStatus = 'playing' | 'finished'
export type GameMatchReason = 'win' | 'forfeit' | 'timeout' | 'draw' | 'disconnect' | 'void'
export type GameMatchMode = 'queue' | 'room'

export interface GameMatchUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminGameMatch {
  id: string
  matchId: string
  gameId: string
  player0?: GameMatchUserBrief
  player1?: GameMatchUserBrief
  winnerId?: string
  status: GameMatchStatus
  reason?: GameMatchReason
  mode: GameMatchMode
  bet: number
  kenDelta: number
  houseTake: number
  moveCount: number
  startedAt: string
  finishedAt?: string
}

export interface GameMatchListParams {
  gameId?: string
  userId?: string
  winnerId?: string
  status?: GameMatchStatus
  reason?: GameMatchReason
  mode?: GameMatchMode
  minBet?: number
  maxBet?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface GameMatchStatsOverview {
  totalMatches: number
  playingMatches: number
  finishedMatches: number
  decidedMatches: number
  drawMatches: number
  voidMatches: number
  uniquePlayers: number
  totalVolume: number
  totalPayout: number
  houseTake: number
}

export interface GameMatchStatsGameRow {
  gameId: string
  matches: number
  finished: number
  volume: number
  houseTake: number
}

export interface GameMatchStatsReasonRow {
  reason: GameMatchReason
  count: number
  percent: number
}

export interface GameMatchStatsTimePoint {
  date: string
  matches: number
  finished: number
  volume: number
  houseTake: number
}

export interface GameMatchStatsPlayer {
  user: GameMatchUserBrief
  matches: number
  wins: number
  losses: number
  winRate: number
  staked: number
  netKen: number
}

export interface GameMatchStatsResponse {
  overview: GameMatchStatsOverview
  byGame: GameMatchStatsGameRow[]
  byReason: GameMatchStatsReasonRow[]
  timeseries: GameMatchStatsTimePoint[]
  topPlayers: GameMatchStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface GameMatchStatsParams {
  gameId?: string
  mode?: GameMatchMode
  from?: string
  to?: string
}

export interface GameMatchSuspectPair {
  userA: GameMatchUserBrief
  userB: GameMatchUserBrief
  matches: number
  decided: number
  aWins: number
  bWins: number
  oneSidedRate: number
  totalBet: number
  netA: number
}

export interface GameMatchSuspectsResponse {
  minMatches: number
  minPairMatches: number
  players: GameMatchStatsPlayer[]
  pairs: GameMatchSuspectPair[]
}

export interface GameMatchSuspectsParams {
  gameId?: string
  from?: string
  to?: string
  minMatches?: number
  minPairMatches?: number
}

export interface AppSetting {
  key: string
  value: Record<string, unknown>
  updatedAt: string
}

export interface TopupBankSetting {
  bankName: string
  bankBin: string
  accountNumber: string
  accountName: string
  memoTemplate: string
}

export interface TopupSetting {
  enabled: boolean
  minAmount: number
  stepAmount: number
  presetAmounts: number[]
  kenPerVnd: number
}

export interface UsernameChangeTierSetting {
  minLength: number
  cost: number
}

export interface UsernameChangeSetting {
  enabled: boolean
  tiers: UsernameChangeTierSetting[]
}

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

export interface MiniGame {
  id: string
  slug: string
  name: string
  description: string
  iconUrl: string
  gameUrl: string
  isEnabled: boolean
  sortOrder: number
  createdAt: string
  updatedAt: string
}

export interface CreateMiniGameRequest {
  slug: string
  name: string
  description?: string
  iconUrl?: string
  gameUrl: string
  isEnabled?: boolean
  sortOrder?: number
}

export interface UpdateMiniGameRequest {
  name?: string
  description?: string
  iconUrl?: string
  gameUrl?: string
  isEnabled?: boolean
  sortOrder?: number
}

export interface ClanUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface Clan {
  id: string
  handle: string
  description?: string
  avatar?: string
  cover?: string
  policy: number
  memberPublicPost: boolean
  memberCount: number
  visitCount: number
  roomId?: string
  owner?: ClanUser
  createdAt: string
}

export interface ClanMember {
  user?: ClanUser
  role: 'owner' | 'deputy' | 'ambassador' | 'member'
  verified: boolean
  joinedAt: string
}

export interface MarriageUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface MarriageStatsParams {
  from?: string
  to?: string
}

export interface MarriageStats {
  proposals: {
    total: number
    pending: number
    accepted: number
    rejected: number
    cancelled: number
  }
  marriages: {
    total: number
    active: number
    divorced: number
  }
}

export type MarriageStatus = 'active' | 'divorced'

export interface MarriageItem {
  id: string
  userA: MarriageUser
  userB: MarriageUser
  status: MarriageStatus
  marriedAt: string
  divorcedAt?: string
  divorcedBy?: string
}

export interface MarriageListParams {
  status?: MarriageStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type MarriageProposalStatus = 'pending' | 'accepted' | 'rejected' | 'cancelled'

export interface MarriageProposalItem {
  id: string
  proposer: MarriageUser
  addressee: MarriageUser
  message?: string
  status: MarriageProposalStatus
  createdAt: string
  respondedAt?: string
}

export interface MarriageProposalListParams {
  status?: MarriageProposalStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface RelationshipUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface RelationshipStatsParams {
  from?: string
  to?: string
}

export interface RelationshipStats {
  relationships: {
    total: number
    pending: number
    accepted: number
    rejected: number
    blocked: number
  }
  follows: {
    total: number
  }
}

export type RelationshipStatus = 'pending' | 'accepted' | 'rejected' | 'blocked'

export interface RelationshipItem {
  id: string
  requester: RelationshipUser
  addressee: RelationshipUser
  status: RelationshipStatus
  createdAt: string
  actionedAt?: string
}

export interface RelationshipListParams {
  status?: RelationshipStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface FollowItem {
  id: string
  follower: RelationshipUser
  followee: RelationshipUser
  createdAt: string
}

export interface FollowListParams {
  followerId?: string
  followeeId?: string
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type RelationshipUserStatsSortBy = 'friends' | 'blocked' | 'followers' | 'following'

export interface RelationshipUserStatsItem {
  user: RelationshipUser
  friends: number
  blocked: number
  followers: number
  following: number
}

export interface RelationshipUserStatsParams {
  userId?: string
  from?: string
  to?: string
  sortBy?: RelationshipUserStatsSortBy
  limit?: number
  offset?: number
}
