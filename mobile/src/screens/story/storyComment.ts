import type { StoryComment } from '@ola/shared/types';

export function storyCommentAuthorName(comment: StoryComment): string {
  return comment.author?.fullName || comment.author?.username || '';
}
