import type { RoomListItem, RoomFilters } from './types';

export const ROOMS: RoomListItem[] = [
  { id: 'sg', title: 'Sài Gòn vui vẻ', subtitle: 'Phòng tám chuyện 24/7', members: 235, color: '#ef5350' },
  { id: 'love', title: 'Kết bạn bốn phương', subtitle: 'Làm quen bạn mới khắp nơi', members: 312, color: '#ec407a' },
  { id: 'hn', title: 'Hà Nội thân yêu', subtitle: 'Giao lưu kết bạn thủ đô', members: 142, color: '#5c6bc0' },
  { id: 'music', title: 'Nghe nhạc cùng nhau', subtitle: 'Yêu cầu bài hát mỗi tối', members: 199, color: '#26a69a' },
  { id: 'tns', title: 'Tâm sự đêm khuya', subtitle: 'Nơi trút bầu tâm sự', members: 88, color: '#7e57c2' },
  { id: 'game', title: 'Hội game thủ', subtitle: 'Tìm đồng đội chơi game', members: 47, color: '#ffa726' },
];

export const DEFAULT_ROOM_FILTERS: RoomFilters = {
  showAll: true,
  media: false,
  female: false,
  male: false,
  flexible: false,
};
