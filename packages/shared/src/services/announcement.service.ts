import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { LatestAnnouncementResult } from '../types/api/announcement.type';

export class AnnouncementService {
  static latest(): Promise<LatestAnnouncementResult> {
    return http.get<LatestAnnouncementResult>(API_PATH.announcements.latest);
  }
}
