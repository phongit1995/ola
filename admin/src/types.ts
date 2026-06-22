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
  limit?: number
  offset?: number
}
