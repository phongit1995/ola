export interface ViewedProfile {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  vipTypeId?: number | null;
}

export interface MeLocalState {
  hiddenPostIds: string[];
  blockedAuthorIds: string[];
  viewedProfiles: ViewedProfile[];
  hidePost: (id: string) => void;
  blockAuthor: (authorId: string) => void;
  recordViewedProfile: (profile: ViewedProfile) => void;
  clearViewedProfiles: () => void;
}
