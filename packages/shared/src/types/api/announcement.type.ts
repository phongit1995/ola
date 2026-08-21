export interface Announcement {
  id: string;
  title: string;
  content: string;
  link: string;
  isActive: boolean;
  startsAt: string | null;
  endsAt: string | null;
  createdAt: string;
  updatedAt: string;
}

export interface LatestAnnouncementResult {
  announcement: Announcement | null;
}
