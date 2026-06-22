import type { MePost } from '../me/types';
import type { ProfileFriend, UserProfile } from './types';

const MEDIA_COLORS = ['#7cb342', '#ef5350', '#5c6bc0', '#26a69a', '#ec407a', '#ffa726'];

const FOLLOWING_SAMPLE: ProfileFriend[] = [
  { name: 'linhchi92', color: '#7cb342' },
  { name: 'tuananh', color: '#5d4037' },
  { name: 'maiphuong', color: '#6d4c41' },
  { name: 'quanghuy', color: '#4dd0e1' },
  { name: 'thuhuong', color: '#5d4037' },
  { name: 'minhduc', color: '#ef6c00' },
];

function hashIndex(text: string, max: number) {
  let sum = 0;
  for (let i = 0; i < text.length; i += 1) sum += text.charCodeAt(i);
  return sum % max;
}

function buildPosts(nick: string, color: string): MePost[] {
  return [
    {
      id: `${nick}-post-1`,
      authorId: nick,
      author: nick,
      fullName: '',
      visibility: 'public',
      color,
      time: '2 giờ trước',
      content: 'Một ngày thật nhiều năng lượng 🌟',
      image: '🌅',
      comments: 5,
      likes: 18,
      liked: false,
      disliked: false,
      mention: false,
      pinned: false,
    },
    {
      id: `${nick}-post-2`,
      authorId: nick,
      author: nick,
      fullName: '',
      visibility: 'public',
      color,
      time: 'hôm qua',
      content: 'Cảm ơn mọi người đã ghé thăm trang của mình nhé 💚',
      image: null,
      comments: 2,
      likes: 9,
      liked: false,
      disliked: false,
      mention: false,
      pinned: false,
    },
  ];
}

export function buildMockProfile(nick: string, color: string, isSelf = false): UserProfile {
  return {
    nick,
    username: nick,
    fullName: '',
    color,
    coverColor: '#33691e',
    verified: hashIndex(nick, 2) === 0,
    vipTypeId: hashIndex(nick, 3) === 0 ? 1 : null,
    fans: 40 + hashIndex(nick, 260),
    kisses: hashIndex(nick, 30),
    bio: 'Sống hết mình với đam mê 🌸 Yêu âm nhạc và những chuyến đi.',
    gender: hashIndex(nick, 2) === 0 ? 'female' : 'male',
    marriage: 'Độc thân',
    birthday: '12/08',
    joinDate: 'Tham gia Ola từ 2014',
    isSelf,
  };
}

export function buildMockSecondary(
  nick: string,
  color: string
): { media: string[]; following: ProfileFriend[]; posts: MePost[] } {
  const following = FOLLOWING_SAMPLE.filter((c) => c.name !== nick)
    .slice(0, 5)
    .map((c) => ({ name: c.name, color: c.color }));
  return { media: MEDIA_COLORS, following, posts: buildPosts(nick, color) };
}
