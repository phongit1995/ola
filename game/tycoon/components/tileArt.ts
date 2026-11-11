import { BOARD } from '../logic/board';

const ART_FILES = import.meta.glob('../assets/tiles/art/*.webp', { eager: true, import: 'default', query: '?url' }) as Record<string, string>;

// Tra ảnh theo tên ô (không theo số ô) để đổi thứ tự bàn (constants.gen.ts) không làm lệch ảnh.
const ART_BY_NAME: Record<string, string> = {
  'Thanh Hóa': 'thanh-hoa',
  Vinh: 'vinh',
  'Buôn Ma Thuột': 'buon-ma-thuot',
  'Đà Lạt': 'da-lat',
  'Cần Thơ': 'can-tho',
  'Phú Quốc': 'phu-quoc',
  'Quy Nhơn': 'quy-nhon',
  'Nha Trang': 'nha-trang',
  'Hội An': 'hoi-an',
  Huế: 'hue',
  'Hạ Long': 'ha-long',
  'Hải Phòng': 'hai-phong',
  'Vũng Tàu': 'vung-tau',
  'Đà Nẵng': 'da-nang',
  'Hà Nội': 'ha-noi',
  'TP. Hồ Chí Minh': 'ho-chi-minh',
  'Sân bay': 'san-bay',
  'Nhà tù': 'nha-tu',
  'Lễ hội': 'le-hoi',
  'Du lịch': 'du-lich',
};

function artForName(name: string): string | undefined {
  const slug = ART_BY_NAME[name];
  return slug ? ART_FILES[`../assets/tiles/art/${slug}.webp`] : undefined;
}

export const TILE_ART: (string | undefined)[] = BOARD.map((tile) => artForName(tile.name));
