import { POST_VISIBILITY } from '@ola/shared/constants';
import { MeService } from '@ola/shared/services/me.service';
import { useMeFeedStore } from '@ola/shared/stores/feed/meFeedStore';
import { belongsToMeFeed } from '@ola/shared/stores/feed/postHelpers';
import type { Post, PostVisibility } from '@ola/shared/types';

jest.mock('@ola/shared/services/me.service', () => ({
  MeService: {
    feed: jest.fn(),
    update: jest.fn(),
    uploadImages: jest.fn(),
    resolveAudios: jest.fn(),
    cleanupRejectedUploads: jest.fn(),
  },
}));

jest.mock('@ola/shared/stores/socialLimit', () => ({
  showSocialLimitNotice: jest.fn(() => false),
}));

jest.mock('@ola/shared/stores/feed/selfLiker', () => ({
  selfLiker: jest.fn(() => undefined),
}));

const feed = MeService.feed as jest.Mock;
const update = MeService.update as jest.Mock;

function post(id: string, visibility: PostVisibility): Post {
  return { id, visibility, images: [], audios: [], commentCount: 0 } as unknown as Post;
}

async function openFeed(filter?: 'following', items: Post[] = []) {
  feed.mockResolvedValueOnce({ items, nextCursor: null });
  await useMeFeedStore.getState().loadFeed(filter);
}

describe('profile-only posts in the Me feed', () => {
  beforeEach(() => {
    feed.mockReset();
    update.mockReset();
  });

  it('keeps profile posts only in the personal feed', () => {
    expect(belongsToMeFeed(post('a', POST_VISIBILITY.profile))).toBe(false);
    expect(belongsToMeFeed(post('a', POST_VISIBILITY.private))).toBe(true);
    expect(belongsToMeFeed(post('a', POST_VISIBILITY.profile), 'following')).toBe(true);
    expect(belongsToMeFeed(post('a', POST_VISIBILITY.profile), 'media')).toBe(false);
  });

  it('does not prepend a new profile post on the community tab', async () => {
    await openFeed();
    useMeFeedStore.getState().prependPost(post('profile', POST_VISIBILITY.profile));
    useMeFeedStore.getState().prependPost(post('public', POST_VISIBILITY.public));
    expect(useMeFeedStore.getState().posts.map((item) => item.id)).toEqual(['public']);
  });

  it('prepends a new profile post on the personal tab', async () => {
    await openFeed('following');
    useMeFeedStore.getState().prependPost(post('profile', POST_VISIBILITY.profile));
    expect(useMeFeedStore.getState().posts.map((item) => item.id)).toEqual(['profile']);
  });

  it('drops a post from the community tab once it is edited to profile only', async () => {
    await openFeed(undefined, [post('a', POST_VISIBILITY.public), post('b', POST_VISIBILITY.public)]);
    update.mockResolvedValueOnce(post('a', POST_VISIBILITY.profile));
    await useMeFeedStore.getState().updatePost('a', { visibility: POST_VISIBILITY.profile }, [], []);
    expect(useMeFeedStore.getState().posts.map((item) => item.id)).toEqual(['b']);
  });

  it('drops a post from the community tab when it is synced as profile only', async () => {
    await openFeed(undefined, [post('a', POST_VISIBILITY.public), post('b', POST_VISIBILITY.public)]);
    useMeFeedStore.getState().syncPost(post('b', POST_VISIBILITY.profile));
    expect(useMeFeedStore.getState().posts.map((item) => item.id)).toEqual(['a']);
  });
});
