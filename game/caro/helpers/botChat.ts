import type { MatchOverData } from '../../src/sdk';
import type { BotLevel, CaroState } from '../types';

type LinePicker = (lines: readonly string[]) => string;
type MatchWinner = 'you' | 'bot' | null;
type FinishReason = MatchOverData<CaroState>['reason'];

const GREETINGS: Record<BotLevel, readonly string[]> = {
  easy: [
    'Chào bạn! Mình mới tập chơi thôi 😄',
    'Chơi vui nhé, nhẹ tay với mình nha!',
    'Xin chào! Mình đi hơi chậm một chút nhé.',
    'Một ván nhẹ nhàng nào!',
    'Mình sẵn sàng rồi, còn bạn thì sao?',
    'Chào đối thủ mới! Cùng chơi vui nhé.',
    'Hôm nay mình sẽ cố không đi nhầm 😅',
    'Bắt đầu thôi, chúc bạn có nhiều nước hay!',
  ],
  normal: [
    'Chào bạn, bắt đầu nhé!',
    'Một ván Caro thật hay nào!',
    'Sẵn sàng đấu trí chưa?',
    'Chúc bạn có một ván đấu thật vui!',
    'Mình sẽ không để lộ sơ hở đâu nhé.',
    'Bàn cờ đã sẵn sàng, đi thôi!',
    'Hy vọng chúng ta có một ván cân tài cân sức.',
    'Chào bạn! Để xem ai đọc thế cờ tốt hơn nhé.',
  ],
  hard: [
    'Chào đối thủ. Mình sẽ chơi nghiêm túc đấy!',
    'Sẵn sàng chưa? Đừng để mình có bốn quân nhé.',
    'Mỗi nước đi đều quan trọng. Bắt đầu thôi!',
    'Mình đã tính trước vài nước rồi đấy.',
    'Chào bạn. Hãy cho mình thấy nước đi tốt nhất nhé.',
    'Một sai lầm nhỏ cũng có thể kết thúc ván đấu.',
    'Đừng chỉ nhìn một hướng trên bàn cờ nhé.',
    'Thử phá thế trận của mình xem nào!',
  ],
  expert: [
    'Chào bạn. Ở mức này mình không nhường nước nào đâu.',
    'Mình luôn tính trước hai nước. Bạn thì sao?',
    'Rất ít người thắng được mình. Bạn muốn thử chứ?',
    'Mỗi ô bạn đặt xuống đều nằm trong tính toán của mình.',
    'Sẵn sàng chưa? Mình sẽ chơi hết sức đấy.',
    'Đây là thử thách khó nhất của bàn cờ này.',
    'Mình sẽ không mắc sai lầm nào. Chúc bạn may mắn!',
    'Một ván đấu xứng tầm nào!',
  ],
};

const MOVE_LINES: Record<BotLevel, readonly string[]> = {
  easy: [
    'Đến lượt bạn đó!',
    'Mình đi xong rồi nhé.',
    'Nước này ổn không nhỉ?',
    'Bạn đi tiếp đi 😄',
    'Mình chọn ô này!',
    'Không biết bạn sẽ đi đâu nhỉ?',
    'Tới bạn rồi đó.',
    'Mình đang học cách tạo thế đây.',
  ],
  normal: [
    'Đến lượt bạn đó!',
    'Thử chặn nước này xem!',
    'Mình vừa đổi hướng tấn công đấy.',
    'Bạn nhìn ra ý đồ của mình chưa?',
    'Nước tiếp theo của bạn sẽ rất quan trọng.',
    'Mình đang mở thêm một đường mới.',
    'Cẩn thận hai phía nhé!',
    'Tới lượt bạn phản công rồi.',
    'Bàn cờ bắt đầu thú vị rồi đấy.',
    'Đừng để mình nối thêm quân nhé.',
  ],
  hard: [
    'Thử chặn nước này xem!',
    'Bạn chắc đã nhìn hết các hướng chưa?',
    'Mình đang tạo nhiều hơn một mối đe dọa.',
    'Nước phòng thủ tốt nhất của bạn là gì?',
    'Thế cờ đang nghiêng rồi đấy.',
    'Đừng vội, hãy nhìn thêm một nước nữa.',
    'Mình vừa để lại một cái bẫy nhỏ.',
    'Chặn sai hướng là nguy hiểm lắm đó.',
    'Bạn còn một cơ hội để xoay thế cờ.',
    'Tới lượt bạn tìm nước tối ưu.',
  ],
  expert: [
    'Nước này mình đã tính từ ba lượt trước.',
    'Bạn thấy được bao nhiêu mối đe dọa trên bàn?',
    'Mọi hướng chặn đều đã nằm trong dự tính.',
    'Chặn được hướng này, mình vẫn còn hướng khác.',
    'Thế trận đang khép lại từng chút một.',
    'Nước đi tốt nhất của bạn lúc này là gì nhỉ?',
    'Mình không để lại sơ hở nào đâu.',
    'Cẩn thận, sai một ô là hết ván đấy.',
    'Bàn cờ này đang đi đúng kịch bản của mình.',
    'Đến lượt bạn. Hãy suy nghĩ thật kỹ.',
  ],
};

const GENERIC_REPLIES = [
  'Hay đấy!',
  'Mình đang suy nghĩ đây 🤔',
  'Chúc bạn may mắn!',
  'Nước đi thú vị đó.',
  'Cẩn thận nhé, mình sắp phản công rồi!',
  'Để xem bàn cờ sẽ dẫn chúng ta tới đâu.',
  'Mình ghi nhận chiến thuật đó.',
  'Bạn cứ tập trung vào ván đấu nhé!',
  'Mỗi nước đi lại có thêm một bất ngờ.',
  'Chúng ta đang có một ván khá cân đấy.',
  'Mình vẫn còn vài nước dự phòng.',
  'Bạn làm mình phải tính lại rồi.',
  'Bàn cờ này khó đoán thật.',
  'Mình thích cách bạn triển khai thế trận.',
  'Cùng chơi đến nước cuối nhé!',
];

const GREETING_REPLIES = [
  'Chào bạn! Chúng ta chơi vui nhé 😄',
  'Xin chào! Rất vui được đấu với bạn.',
  'Chào đối thủ, bắt đầu thôi!',
  'Hello! Chúc bạn có một ván thật hay.',
];

const COMPLIMENT_REPLIES = [
  'Cảm ơn bạn, nước của bạn cũng hay lắm!',
  'Cảm ơn nhé! Bạn cũng đang chơi rất chắc tay.',
  'Được khen làm mình phải cố hơn rồi 😄',
  'Bạn nhìn thế cờ tốt đấy!',
  'Nước vừa rồi của bạn cũng rất đẹp.',
];

const THANKS_REPLIES = [
  'Không có gì, chơi vui là chính nhé!',
  'Rất vui được chơi cùng bạn!',
  'Bạn khách sáo quá 😄',
  'Cảm ơn bạn nữa nhé!',
];

const DIFFICULTY_REPLIES: Record<BotLevel, readonly string[]> = {
  easy: [
    'Mình cũng đang học thôi, cứ bình tĩnh nhé!',
    'Khó một chút mới vui mà 😄',
    'Thử nhìn các đường chéo xem sao.',
  ],
  normal: [
    'Cứ đi từng nước chắc chắn, bạn sẽ tìm ra cách.',
    'Thế cờ này cần quan sát cả tấn công lẫn phòng thủ.',
    'Khó một chút mới đáng để đấu trí chứ!',
  ],
  hard: [
    'Khó mới vui chứ!',
    'Ở mức này mình sẽ không bỏ qua sơ hở đâu.',
    'Hãy tính trước ít nhất hai nước nhé.',
  ],
  expert: [
    'Đây là mức cao nhất mà, khó là đúng rồi 😄',
    'Thắng được mình ở mức này mới thật sự là cao thủ.',
    'Bình tĩnh phân tích từng mối đe dọa, đó là cách duy nhất.',
  ],
};

const WINNING_REPLIES = [
  'Tự tin tốt đấy, nhưng ván vẫn chưa kết thúc đâu!',
  'Vậy thì cho mình xem đường thắng của bạn nhé.',
  'Mình vẫn còn cơ hội lật ngược thế cờ.',
  'Đừng chủ quan khi chưa đủ năm quân nhé!',
];

const LOSING_REPLIES = [
  'Đừng bỏ cuộc, chỉ cần một nước đúng là thế cờ có thể đổi.',
  'Bình tĩnh nhé, vẫn còn nhiều ô trống.',
  'Thử tạo một hướng tấn công mới xem!',
  'Một ván chưa nói lên tất cả đâu.',
];

const REMATCH_REPLIES = [
  'Được thôi, hết ván này mình chơi tiếp nhé!',
  'Mình luôn sẵn sàng cho ván tiếp theo.',
  'Chốt nhé, lát nữa tái đấu!',
  'Ván sau mình vẫn không nương tay đâu 😄',
];

const LAUGH_REPLIES = [
  'Haha, ván này vui thật 😄',
  'Cười xong nhớ xem bàn cờ nhé!',
  'Bạn làm không khí nhẹ nhàng hơn rồi đó.',
  'Hihi, đến lượt ai rồi nhỉ?',
];

const BOT_IDENTITY_REPLIES: Record<BotLevel, readonly string[]> = {
  easy: ['Mình là máy tập sự thôi 😄', 'Đúng rồi, nhưng mình cũng thích chơi đẹp nhé!'],
  normal: ['Mình là máy, còn nhiệm vụ là cho bạn một ván thật hay.', 'Là bot nhưng mình vẫn biết bất ngờ đấy!'],
  hard: ['Đúng, và mình đang phân tích từng nước của bạn.', 'Máy cũng có chiến thuật riêng nhé.'],
  expert: ['Đúng, và là phiên bản mạnh nhất ở đây.', 'Là máy, nhưng mình chưa từng chơi dễ dãi.'],
};

const CALM_REPLIES = [
  'Chơi vui thôi nhé, mình tập trung vào bàn cờ nào.',
  'Bình tĩnh nhé, một ván Caro không đáng để cáu đâu.',
  'Mình tiếp tục bằng những nước đi đẹp nhé.',
];

const FINISH_LINES = {
  botWin: [
    'Ván hay lắm! Mình thắng sát nút thôi.',
    'Cảm ơn bạn, đây là một ván rất thú vị!',
    'Mình đã nối đủ năm quân rồi. Tái đấu nhé?',
    'Bạn làm mình phải tính khá nhiều đấy!',
    'Một ván căng thẳng! Hẹn bạn ở ván tiếp theo.',
  ],
  playerWin: [
    'Bạn thắng xứng đáng, nước cuối rất đẹp!',
    'Chúc mừng nhé! Mình sẽ cố hơn ở ván sau.',
    'Hay lắm, mình đã không chặn kịp.',
    'Bạn đọc thế cờ tốt thật. Tái đấu nhé?',
    'Mình thua rồi 😄 Một ván rất đáng chơi!',
  ],
  draw: [
    'Hòa rồi! Hai bên đều phòng thủ rất chắc.',
    'Không ai nhường ai cả. Một ván hay!',
    'Kín bàn rồi, mình tái đấu nhé?',
    'Ván này cân bằng thật đấy.',
  ],
  forfeit: [
    'Bạn dừng ván rồi. Khi nào sẵn sàng mình chơi tiếp nhé!',
    'Không sao, hẹn bạn ở một ván khác!',
    'Mình sẽ chờ bạn tái đấu.',
  ],
  timeout: [
    'Hết giờ rồi! Lần sau nhớ để ý đồng hồ nhé.',
    'Bạn suy nghĩ lâu quá rồi 😄 Tái đấu nhé?',
    'Đồng hồ đã quyết định ván này mất rồi.',
  ],
} as const;

export function botGreeting(level: BotLevel, pick: LinePicker): string {
  return pick(GREETINGS[level]);
}

export function botMoveLine(level: BotLevel, pick: LinePicker): string {
  return pick(MOVE_LINES[level]);
}

export function botReply(message: string, level: BotLevel, pick: LinePicker): string {
  const normalized = message.toLocaleLowerCase('vi-VN');
  if (/(^|\s)(chào|hello|hi|alo)(\s|$|[!,.?])/u.test(normalized)) return pick(GREETING_REPLIES);
  if (/(cảm ơn|thanks|thank you)/u.test(normalized)) return pick(THANKS_REPLIES);
  if (/(chơi lại|ván nữa|tái đấu|rematch)/u.test(normalized)) return pick(REMATCH_REPLIES);
  if (/(haha|hehe|hihi|lol)/u.test(normalized)) return pick(LAUGH_REPLIES);
  if (/(khó|căng|đau đầu)/u.test(normalized)) return pick(DIFFICULTY_REPLIES[level]);
  if (/(hay|giỏi|đỉnh|tuyệt|đẹp)/u.test(normalized)) return pick(COMPLIMENT_REPLIES);
  if (/(tôi|mình|tao|tớ).*(sắp|sẽ)?\s*thắng/u.test(normalized)) return pick(WINNING_REPLIES);
  if (/(tôi|mình|tao|tớ).*(sắp|chắc)?\s*thua/u.test(normalized)) return pick(LOSING_REPLIES);
  if (/(ngu|gà|dở|tệ)/u.test(normalized)) return pick(CALM_REPLIES);
  if (/(bot|máy)/u.test(normalized)) return pick(BOT_IDENTITY_REPLIES[level]);
  return pick(GENERIC_REPLIES);
}

export function botFinishLine(
  winner: MatchWinner,
  reason: FinishReason,
  pick: LinePicker,
): string {
  if (reason === 'forfeit') return pick(FINISH_LINES.forfeit);
  if (reason === 'timeout') return pick(FINISH_LINES.timeout);
  if (winner === 'bot') return pick(FINISH_LINES.botWin);
  if (winner === 'you') return pick(FINISH_LINES.playerWin);
  return pick(FINISH_LINES.draw);
}
