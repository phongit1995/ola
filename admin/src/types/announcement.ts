export interface Announcement {
  id: string
  title: string
  content: string
  link: string
  isActive: boolean
  startsAt: string | null
  endsAt: string | null
  createdAt: string
  updatedAt: string
}

export interface CreateAnnouncementRequest {
  title: string
  content?: string
  link?: string
  isActive?: boolean
  startsAt?: string
  endsAt?: string
}

export interface UpdateAnnouncementRequest {
  title?: string
  content?: string
  link?: string
  isActive?: boolean
  startsAt?: string
  endsAt?: string
}
