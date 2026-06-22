import { useCallback, useMemo, useState } from 'react';
import type { RelationshipInfo } from '@app-types';
import { buildMockProfile, buildMockSecondary } from './data';
import type {
  ProfileActions,
  ProfileController,
  ProfilePostActions,
  ProfileSecondary,
  UserProfile,
} from './types';
import { MOCK_RELATIONSHIP } from './constants';

export function useMockUserProfile(nick: string, color: string): ProfileController {
  const [profile, setProfile] = useState<UserProfile>(() => buildMockProfile(nick, color));
  const [relationship, setRelationship] = useState<RelationshipInfo>(MOCK_RELATIONSHIP);
  const secondary = useMemo<ProfileSecondary>(
    () => ({ ...buildMockSecondary(nick, color), loading: false }),
    [nick, color]
  );

  const kiss = useCallback(() => setProfile((p) => ({ ...p, kisses: p.kisses + 1 })), []);

  const toggleFollow = useCallback(() => {
    setProfile((p) => ({ ...p, fans: Math.max(0, p.fans + (relationship.isFollowing ? -1 : 1)) }));
    setRelationship((r) => ({ ...r, isFollowing: !r.isFollowing }));
  }, [relationship.isFollowing]);

  const friendAction = useCallback(() => {
    setRelationship((r) => ({ ...r, status: r.status === 'friend' ? 'none' : 'friend' }));
  }, []);

  const blockAction = useCallback(() => {
    setRelationship((r) => ({ ...r, status: r.status === 'blocked_by_me' ? 'none' : 'blocked_by_me' }));
  }, []);

  const actions = useMemo<ProfileActions>(
    () => ({ kiss, toggleFollow, friendAction, blockAction, message: () => {}, changeCover: async () => {} }),
    [kiss, toggleFollow, friendAction, blockAction]
  );

  const postActions = useMemo<ProfilePostActions>(
    () => ({
      toggleReaction: () => {},
      adjustCommentCount: () => {},
      editPost: () => Promise.resolve(false),
      deletePost: () => {},
      togglePin: () => {},
    }),
    []
  );

  return {
    profile,
    loading: false,
    notFound: false,
    relationship,
    busy: false,
    actions,
    secondary,
    postActions,
  };
}
