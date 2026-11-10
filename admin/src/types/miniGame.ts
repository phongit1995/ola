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
