import type {
  Story,
  StoryChapter,
  StoryChapterSummary,
  StoryKind,
  StoryStatus,
} from '../types/api/story.type';

interface MockStorySeed {
  id: string;
  slug: string;
  title: string;
  authorName: string;
  kind: StoryKind;
  genres: string[];
  tags: string[];
  intro: string;
  status: StoryStatus;
  chapterCount: number;
  viewCount: number;
  commentCount: number;
  publishedDaysAgo: number;
  lastChapterHoursAgo: number;
  hero: string;
  place: string;
  chapterTitles: string[];
}

const HOUR_MS = 60 * 60 * 1000;
const DAY_MS = 24 * HOUR_MS;
const MOCK_NOW = Date.now();

const PARAGRAPHS = [
  'Buổi sáng ở {place} bắt đầu bằng tiếng rao quen thuộc dưới con hẻm nhỏ. {hero} đứng bên cửa sổ, nhìn những vệt nắng đầu tiên trượt dài trên mái tôn còn đọng sương.',
  'Có những ngày {hero} tự hỏi mình đã đi xa đến đâu, và còn bao nhiêu con đường chưa kịp đặt chân tới. Câu hỏi ấy cứ lặng lẽ theo sau như một cái bóng.',
  '– Định đứng đó đến bao giờ nữa? – Một giọng nói vang lên từ phía sau, nửa trêu chọc, nửa sốt ruột.',
  '{hero} quay lại, bắt gặp ánh mắt quen thuộc. Không cần nói thêm điều gì, cả hai cùng bật cười, như thể mọi lo lắng vừa rồi chỉ là một giấc mơ ngắn.',
  'Gió thổi vào mang theo mùi đất ẩm và hương hoa muộn. {place} về đêm luôn có một vẻ dịu dàng rất riêng, khiến người ta muốn bước chậm lại.',
  'Trên bàn vẫn còn cuốn sổ cũ với những dòng ghi chép dang dở. {hero} lật từng trang, nhận ra nét chữ của chính mình ngày trước giờ đã xa lạ đến nhường nào.',
  'Mọi chuyện bắt đầu thay đổi từ cái hôm trời đổ mưa lớn. Không ai ngờ một chuyến đi tưởng như bình thường lại kéo theo nhiều biến cố đến vậy.',
  '– Nếu được chọn lại, vẫn sẽ đi con đường này chứ? – Câu hỏi rơi vào khoảng lặng, rất lâu sau mới có lời đáp.',
  '{hero} không trả lời ngay. Có những điều chỉ có thể hiểu khi đã đi qua, và có những vết thương chỉ lành khi người ta thôi cố quên.',
  'Phía cuối con đường, ánh đèn vàng hắt xuống mặt đường loang lổ nước. Bóng hai người đổ dài, lúc gần lúc xa, như chính những ngày tháng họ đã cùng nhau trải qua.',
  'Đêm ấy, {hero} ngủ một giấc thật sâu. Trong mơ, {place} hiện lên với những góc phố cũ, những gương mặt thân quen và một lời hứa còn bỏ ngỏ.',
  'Sáng hôm sau, tin tức lan nhanh khắp nơi. Người ta bàn tán, đoán già đoán non, nhưng chỉ {hero} biết rằng mọi chuyện mới chỉ bắt đầu.',
  'Có lẽ điều quý giá nhất không nằm ở đích đến, mà ở những người đã cùng mình bước qua từng đoạn đường. {hero} khẽ mỉm cười khi nghĩ đến điều đó.',
  'Tiếng chuông xa xa vọng lại, trầm và ấm. {hero} khép cuốn sổ, đứng dậy, chuẩn bị cho một ngày mới với nhiều điều chưa biết trước.',
];

const SEEDS: MockStorySeed[] = [
  {
    id: '101',
    slug: 'tiem-sach-cuoi-pho',
    title: 'Tiệm Sách Cuối Phố',
    authorName: 'Lam Nhiên',
    kind: 'long',
    genres: ['Tình Cảm', 'Tiểu Thuyết'],
    tags: ['chữa lành', 'hiện đại'],
    intro:
      'Vy tiếp quản tiệm sách cũ của bà ngoại ở cuối một con phố nhỏ. Giữa những kệ sách phủ bụi, cô tìm thấy một xấp thư tay chưa từng được gửi đi, và một người khách lạ ngày nào cũng ghé qua lúc trời chạng vạng.\n\nNhững lá thư dẫn cô quay về quá khứ của bà, còn người khách lạ thì dường như biết nhiều hơn những gì anh ta nói.',
    status: 'ongoing',
    chapterCount: 14,
    viewCount: 128_430,
    commentCount: 312,
    publishedDaysAgo: 60,
    lastChapterHoursAgo: 2,
    hero: 'Vy',
    place: 'phố Mai Lâm',
    chapterTitles: [
      'Chiếc chìa khoá cũ',
      'Người khách lúc chạng vạng',
      'Xấp thư không địa chỉ',
      'Mưa đầu mùa',
      'Tấm bản đồ trong sách',
      'Hẹn ở bến xe',
      'Ký ức của bà',
    ],
  },
  {
    id: '102',
    slug: 'kiem-khach-phuong-nam',
    title: 'Kiếm Khách Phương Nam',
    authorName: 'Trần Phong Vũ',
    kind: 'long',
    genres: ['Kiếm Hiệp'],
    tags: ['giang hồ', 'báo thù'],
    intro:
      'Mười năm sau đêm trấn Bạch Vân chìm trong biển lửa, chàng thiếu niên năm nào trở lại với thanh kiếm gãy và một lời thề chưa trọn. Giang hồ dậy sóng khi những bí mật bị chôn vùi lần lượt được khơi lên.',
    status: 'completed',
    chapterCount: 24,
    viewCount: 96_420,
    commentCount: 207,
    publishedDaysAgo: 210,
    lastChapterHoursAgo: 40 * 24,
    hero: 'Thiên Lãng',
    place: 'trấn Bạch Vân',
    chapterTitles: [
      'Thanh kiếm gãy',
      'Quán trọ ven sông',
      'Lời thề năm cũ',
      'Đêm trăng máu',
      'Cao thủ áo xám',
      'Đỉnh Vọng Phong',
    ],
  },
  {
    id: '103',
    slug: 'thanh-pho-khong-ngu',
    title: 'Thành Phố Không Ngủ',
    authorName: 'Minh Khải',
    kind: 'long',
    genres: ['Viễn Tưởng - Kỳ Ảo'],
    tags: ['tương lai', 'trí tuệ nhân tạo'],
    intro:
      'Ở thành phố Lumen, đèn không bao giờ tắt và con người không còn cần ngủ. Kha là kỹ sư bảo trì duy nhất vẫn còn mơ, và giấc mơ của anh bắt đầu trùng khớp với những sự cố bí ẩn trong hệ thống.',
    status: 'ongoing',
    chapterCount: 9,
    viewCount: 45_210,
    commentCount: 98,
    publishedDaysAgo: 30,
    lastChapterHoursAgo: 20,
    hero: 'Kha',
    place: 'thành phố Lumen',
    chapterTitles: [
      'Ca trực thứ một nghìn',
      'Giấc mơ lỗi',
      'Tầng hầm số 0',
      'Người không có mã định danh',
      'Cơn mưa nhân tạo',
    ],
  },
  {
    id: '104',
    slug: 'mua-ha-nam-ay',
    title: 'Mùa Hạ Năm Ấy',
    authorName: 'Hạ Linh',
    kind: 'short',
    genres: ['Truyện Ngắn', 'Tình Cảm'],
    tags: ['tuổi học trò'],
    intro:
      'Một mùa hè ở thị trấn ven biển, một chiếc xe đạp cũ và lời tạm biệt chưa kịp nói. Truyện ngắn về những rung động đầu đời.',
    status: 'completed',
    chapterCount: 1,
    viewCount: 23_870,
    commentCount: 54,
    publishedDaysAgo: 200,
    lastChapterHoursAgo: 200 * 24,
    hero: 'Nam',
    place: 'thị trấn ven biển',
    chapterTitles: ['Mùa Hạ Năm Ấy'],
  },
  {
    id: '105',
    slug: 'nguoi-gac-den-bien',
    title: 'Người Gác Đèn Biển',
    authorName: 'Đỗ Quân',
    kind: 'long',
    genres: ['Trinh Thám'],
    tags: ['bí ẩn', 'hải đảo'],
    intro:
      'Ngọn hải đăng trên đảo Sương Mù đột ngột tắt vào đêm bão, người gác đèn biến mất không dấu vết. Thanh tra Huy được cử ra đảo và nhận ra mỗi người dân ở đây đều đang che giấu một điều gì đó.',
    status: 'ongoing',
    chapterCount: 15,
    viewCount: 61_540,
    commentCount: 145,
    publishedDaysAgo: 75,
    lastChapterHoursAgo: 30,
    hero: 'thanh tra Huy',
    place: 'đảo Sương Mù',
    chapterTitles: [
      'Đêm bão',
      'Ngọn đèn tắt',
      'Cuốn nhật ký ướt',
      'Lời khai thứ ba',
      'Dấu chân trên cát',
      'Căn phòng khoá trái',
    ],
  },
  {
    id: '106',
    slug: 'xuyen-ve-lam-trang-nguyen',
    title: 'Xuyên Về Làm Trạng Nguyên',
    authorName: 'Mộc Miên',
    kind: 'long',
    genres: ['Xuyên Không', 'Tiểu Thuyết'],
    tags: ['cổ đại', 'hài hước'],
    intro:
      'Một sinh viên năm cuối ngủ quên trong thư viện và tỉnh dậy ở kinh thành nghìn năm trước, trong thân phận một thư sinh nghèo sắp bước vào kỳ thi Hội. Kiến thức hiện đại liệu có giúp được gì giữa chốn quan trường?',
    status: 'ongoing',
    chapterCount: 31,
    viewCount: 152_300,
    commentCount: 486,
    publishedDaysAgo: 120,
    lastChapterHoursAgo: 5,
    hero: 'Tiểu An',
    place: 'kinh thành',
    chapterTitles: [
      'Tỉnh dậy ở nơi xa lạ',
      'Thư sinh nghèo',
      'Kỳ thi Hương',
      'Vị khách ở trà lâu',
      'Bài văn gây chấn động',
      'Âm mưu chốn quan trường',
      'Đêm trước kỳ thi Hội',
    ],
  },
  {
    id: '107',
    slug: 'can-nha-so-13',
    title: 'Căn Nhà Số 13',
    authorName: 'Bóng Đêm',
    kind: 'long',
    genres: ['Truyện Ma - Kinh Dị'],
    tags: ['nhà hoang'],
    intro:
      'Căn nhà cuối con hẻm bỏ trống đã hai mươi năm. Đêm Quân dọn vào, chiếc đồng hồ treo tường đã chết máy bỗng điểm mười ba tiếng.',
    status: 'completed',
    chapterCount: 7,
    viewCount: 38_900,
    commentCount: 121,
    publishedDaysAgo: 150,
    lastChapterHoursAgo: 120 * 24,
    hero: 'Quân',
    place: 'con hẻm số 13',
    chapterTitles: [
      'Mười ba tiếng chuông',
      'Căn phòng trên gác',
      'Bức ảnh không người',
      'Tiếng bước chân',
      'Người hàng xóm cũ',
    ],
  },
  {
    id: '108',
    slug: 'la-thu-khong-gui',
    title: 'Lá Thư Không Gửi',
    authorName: 'An Nhiên',
    kind: 'short',
    genres: ['Truyện Ngắn'],
    tags: ['gia đình'],
    intro:
      'Lá thư con gái viết cho mẹ vào đêm trước ngày rời nhà, cất trong ngăn kéo suốt mười năm.',
    status: 'completed',
    chapterCount: 1,
    viewCount: 15_420,
    commentCount: 37,
    publishedDaysAgo: 15,
    lastChapterHoursAgo: 15 * 24,
    hero: 'Mai',
    place: 'Đà Lạt',
    chapterTitles: ['Lá Thư Không Gửi'],
  },
  {
    id: '109',
    slug: 'thien-ha-lac-loi',
    title: 'Thiên Hà Lạc Lối',
    authorName: 'Vũ Thần',
    kind: 'long',
    genres: ['Huyền Huyễn'],
    tags: ['tu tiên', 'phiêu lưu'],
    intro:
      'Lạc Thiên vốn là phế vật của tông môn, cho đến khi một mảnh tinh thạch rơi từ trời xuống ngay trước mặt cậu. Con đường tu luyện mở ra, kéo theo những kẻ thù đến từ tận cùng Thiên Vực.',
    status: 'ongoing',
    chapterCount: 40,
    viewCount: 83_200,
    commentCount: 233,
    publishedDaysAgo: 160,
    lastChapterHoursAgo: 9,
    hero: 'Lạc Thiên',
    place: 'Thiên Vực',
    chapterTitles: [
      'Phế vật của tông môn',
      'Mảnh tinh thạch',
      'Đột phá',
      'Bí cảnh ngàn năm',
      'Kẻ thù từ Thiên Vực',
      'Đại hội tông môn',
      'Thiên kiếp',
    ],
  },
  {
    id: '110',
    slug: 'pho-cu-mua-phun',
    title: 'Phố Cũ Mưa Phùn',
    authorName: 'Thu Hà',
    kind: 'long',
    genres: ['Tiểu Thuyết', 'Tình Cảm'],
    tags: ['hoài niệm'],
    intro:
      'Linh trở về phố cũ sau mười năm xa quê để bán căn nhà của gia đình. Những ngày mưa phùn kéo dài, những người bạn cũ và một mối tình dang dở khiến cô bắt đầu do dự.',
    status: 'completed',
    chapterCount: 18,
    viewCount: 54_800,
    commentCount: 176,
    publishedDaysAgo: 240,
    lastChapterHoursAgo: 70 * 24,
    hero: 'Linh',
    place: 'phố cũ',
    chapterTitles: [
      'Trở về',
      'Căn nhà có giàn hoa giấy',
      'Người bạn cũ',
      'Mưa phùn tháng Ba',
      'Quán cà phê góc phố',
      'Lời hẹn',
    ],
  },
];

function isoAgo(ms: number): string {
  return new Date(MOCK_NOW - ms).toISOString();
}

function capitalizeSentences(text: string): string {
  return text.replace(
    /(^|[.!?]\s+)(\p{Ll})/gu,
    (_, lead: string, letter: string) => lead + letter.toUpperCase()
  );
}

function fillPlaceholders(text: string, seed: MockStorySeed): string {
  return capitalizeSentences(
    text.replaceAll('{hero}', seed.hero).replaceAll('{place}', seed.place)
  );
}

function chapterParagraphs(seed: MockStorySeed, position: number): string[] {
  const count = seed.kind === 'short' ? PARAGRAPHS.length : 7;
  return Array.from({ length: count }, (_, index) =>
    fillPlaceholders(PARAGRAPHS[(position * 3 + index) % PARAGRAPHS.length] ?? '', seed)
  );
}

function countWords(text: string): number {
  return text.split(/\s+/).filter(Boolean).length;
}

function chapterTitle(seed: MockStorySeed, position: number): string {
  if (seed.kind === 'short') return seed.title;
  const name = seed.chapterTitles[(position - 1) % seed.chapterTitles.length] ?? '';
  return `Chương ${position}: ${name}`;
}

function chapterPublishedAt(seed: MockStorySeed, position: number): string {
  const first = seed.publishedDaysAgo * DAY_MS;
  const last = seed.lastChapterHoursAgo * HOUR_MS;
  if (seed.chapterCount <= 1) return isoAgo(last);
  const step = (first - last) / (seed.chapterCount - 1);
  return isoAgo(first - step * (position - 1));
}

function seedById(storyId: string): MockStorySeed | undefined {
  return SEEDS.find((seed) => seed.id === storyId);
}

function buildSummary(seed: MockStorySeed, position: number): StoryChapterSummary {
  return {
    id: `${seed.id}-${position}`,
    storyId: seed.id,
    position,
    title: chapterTitle(seed, position),
    wordCount: countWords(chapterParagraphs(seed, position).join(' ')),
    publishedAt: chapterPublishedAt(seed, position),
  };
}

function buildStory(seed: MockStorySeed): Story {
  const chapters = Array.from({ length: seed.chapterCount }, (_, index) =>
    buildSummary(seed, index + 1)
  );
  return {
    id: seed.id,
    slug: seed.slug,
    title: seed.title,
    authorName: seed.authorName,
    kind: seed.kind,
    genres: seed.genres,
    tags: seed.tags,
    intro: seed.intro,
    coverUrl: null,
    status: seed.status,
    chapterCount: seed.chapterCount,
    wordCount: chapters.reduce((sum, chapter) => sum + chapter.wordCount, 0),
    viewCount: seed.viewCount,
    commentCount: seed.commentCount,
    publishedAt: isoAgo(seed.publishedDaysAgo * DAY_MS),
    updatedAt: isoAgo(seed.lastChapterHoursAgo * HOUR_MS),
    lastChapterAt: chapters.at(-1)?.publishedAt ?? null,
  };
}

export const MOCK_STORIES: Story[] = SEEDS.map(buildStory);

export function mockChapterSummaries(storyId: string): StoryChapterSummary[] | null {
  const seed = seedById(storyId);
  if (!seed) return null;
  return Array.from({ length: seed.chapterCount }, (_, index) => buildSummary(seed, index + 1));
}

export function mockChapter(storyId: string, position: number): StoryChapter | null {
  const seed = seedById(storyId);
  if (!seed || position < 1 || position > seed.chapterCount) return null;
  return {
    ...buildSummary(seed, position),
    content: chapterParagraphs(seed, position).join('\n\n'),
    prevPosition: position > 1 ? position - 1 : null,
    nextPosition: position < seed.chapterCount ? position + 1 : null,
  };
}
