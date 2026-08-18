import type { BotLevel } from '../../logic/battle';

// Cùng khung hội thoại với bot caro (chào theo độ khó, nói sau nước đi,
// trả lời theo từ khóa, chốt trận) nhưng lời thoại riêng cho Chiến Thần.
type LinePicker = (lines: readonly string[]) => string;
type MatchWinner = 'you' | 'bot' | null;
type FinishReason = 'win' | 'forfeit' | 'timeout' | 'draw';

const GREETINGS: Record<BotLevel, readonly string[]> = {
  easy: [
    'Chào bạn! Mình mới học ghép kiếm thôi 😄',
    'Chơi vui nhé, nhẹ tay với mình nha!',
    'Xin chào! Mình còn đang tập gom giáp.',
    'Một trận nhẹ nhàng nào!',
    'Mình sẵn sàng rồi, xuất chiêu thôi!',
    'Chào chiến hữu mới! Cùng chơi vui nhé.',
    'Hôm nay mình sẽ cố không ghép hụt 😅',
    'Bắt đầu thôi, chúc bạn nhiều combo đẹp!',
  ],
  normal: [
    'Chào bạn, khai chiến nhé!',
    'Một trận Chiến Thần thật hay nào!',
    'Sẵn sàng đấu trí chưa?',
    'Chúc bạn một trận thật vui!',
    'Mình sẽ không để hở khiên đâu nhé.',
    'Sa trường đã sẵn sàng, xuất quân!',
    'Hy vọng một trận cân tài cân sức.',
    'Chào bạn! Xem ai đọc bàn ngọc tốt hơn nhé.',
  ],
  hard: [
    'Chào đối thủ. Mình sẽ đánh nghiêm túc đấy!',
    'Sẵn sàng chưa? Đừng để mình gom đủ nộ nhé.',
    'Mỗi lượt đều đáng giá. Khai chiến!',
    'Mình đã nhắm sẵn mấy đường kiếm rồi đấy.',
    'Chào bạn. Cho mình xem combo đẹp nhất của bạn đi.',
    'Một lượt phí là mất cả trận đấy.',
    'Đừng chỉ chăm chăm ghép kiếm nhé.',
    'Thử phá thế trận của mình xem nào!',
  ],
  expert: [
    'Siêu khó đã mở. Mình sẽ tính cả đường phản công của bạn!',
    'Khai chiến nhé — từng viên ngọc đều có thể đổi cục diện.',
    'Mình sẽ không bỏ phí mana, nộ hay lượt thưởng nào đâu.',
    'Hãy chuẩn bị combo tốt nhất của bạn nhé!',
  ],
};

const MOVE_LINES: Record<BotLevel, readonly string[]> = {
  easy: [
    'Đến lượt bạn đó!',
    'Mình đi xong rồi nhé.',
    'Nước này ổn không nhỉ?',
    'Bạn đi tiếp đi 😄',
    'Mình chọn đường này!',
    'Không biết bạn sẽ ghép gì nhỉ?',
    'Tới bạn rồi đó.',
    'Mình đang học cách gom đào đây.',
  ],
  normal: [
    'Đến lượt bạn đó!',
    'Đỡ đòn này xem!',
    'Mình vừa đổi hướng tấn công đấy.',
    'Bạn thấy ý đồ của mình chưa?',
    'Lượt sau của bạn sẽ rất quan trọng.',
    'Mình đang tích nội lực đây.',
    'Coi chừng thanh nộ của mình nhé!',
    'Tới lượt bạn phản công rồi.',
    'Bàn ngọc bắt đầu thú vị rồi đấy.',
    'Đừng để mình ghép thêm kiếm nhé.',
  ],
  hard: [
    'Đỡ đòn này xem!',
    'Bạn chắc đã nhìn hết bàn ngọc chưa?',
    'Mình đang mở nhiều hơn một mũi tấn công.',
    'Nước phòng thủ tốt nhất của bạn là gì?',
    'Thế trận đang nghiêng rồi đấy.',
    'Đừng vội, nhìn thêm một nhịp nữa.',
    'Mình vừa gài lại một thế ngọc đấy.',
    'Bỏ khiên lúc này là nguy hiểm lắm đó.',
    'Bạn còn một cơ hội xoay chuyển thế trận.',
    'Tới lượt bạn tìm combo tối ưu.',
  ],
  expert: [
    'Mình đã tính cả nước đáp trả mạnh nhất của bạn.',
    'Lượt thưởng này nằm trong kế hoạch rồi.',
    'Thử tìm một đường tốt hơn xem nào!',
    'Mỗi tài nguyên trên bàn đều đã được cân nhắc.',
    'Đến lượt bạn phá thế trận này đấy.',
  ],
};

const GENERIC_REPLIES = [
  'Hay đấy!',
  'Mình đang tính đường đi đây 🤔',
  'Chúc bạn may mắn!',
  'Combo thú vị đó.',
  'Cẩn thận nhé, mình sắp phản công rồi!',
  'Để xem trận này dẫn tới đâu.',
  'Mình ghi nhận chiến thuật đó.',
  'Bạn cứ tập trung vào bàn ngọc nhé!',
  'Mỗi lượt lại có thêm một bất ngờ.',
  'Trận này khá cân đấy chứ.',
  'Mình vẫn còn vài đường dự phòng.',
  'Bạn làm mình phải tính lại rồi.',
  'Bàn ngọc này khó đoán thật.',
  'Mình thích cách bạn xoay thế trận.',
  'Đánh tới nhịp cuối cùng nhé!',
];

const GREETING_REPLIES = [
  'Chào bạn! Chúng ta chơi vui nhé 😄',
  'Xin chào! Rất vui được giao đấu với bạn.',
  'Chào chiến hữu, khai chiến thôi!',
  'Hello! Chúc bạn một trận thật hay.',
];

const COMPLIMENT_REPLIES = [
  'Cảm ơn bạn, combo của bạn cũng đẹp lắm!',
  'Cảm ơn nhé! Bạn đánh cũng rất chắc tay.',
  'Được khen làm mình phải cố hơn rồi 😄',
  'Bạn đọc bàn ngọc tốt đấy!',
  'Đòn vừa rồi của bạn cũng rất hiểm.',
];

const THANKS_REPLIES = [
  'Không có gì, chơi vui là chính nhé!',
  'Rất vui được giao đấu cùng bạn!',
  'Bạn khách sáo quá 😄',
  'Cảm ơn bạn nữa nhé!',
];

const DIFFICULTY_REPLIES: Record<BotLevel, readonly string[]> = {
  easy: [
    'Mình cũng đang học thôi, cứ bình tĩnh nhé!',
    'Khó một chút mới vui mà 😄',
    'Thử gom nước hồi máu trước xem sao.',
  ],
  normal: [
    'Cứ đánh từng lượt chắc chắn, bạn sẽ tìm ra cách.',
    'Trận này cần cân cả tấn công lẫn khiên đỡ.',
    'Khó một chút mới đáng đấu trí chứ!',
  ],
  hard: [
    'Khó mới vui chứ!',
    'Ở mức này mình sẽ không bỏ qua sơ hở đâu.',
    'Hãy tính trước ít nhất hai lượt nhé.',
  ],
  expert: [
    'Đây là mức siêu khó — hãy để ý cả nước phản công sau combo nhé.',
    'Mình đang cân đồng thời máu, giáp, mana, nộ và lượt thưởng.',
    'Một nước mạnh trước mắt chưa chắc là nước tốt nhất đâu.',
  ],
};

const WINNING_REPLIES = [
  'Tự tin tốt đấy, nhưng trận chưa kết thúc đâu!',
  'Vậy cho mình xem đòn kết liễu của bạn nhé.',
  'Mình vẫn còn cơ hội lật kèo.',
  'Đừng chủ quan khi máu mình còn nhé!',
];

const LOSING_REPLIES = [
  'Đừng bỏ cuộc, một combo lớn là đổi thế trận ngay.',
  'Bình tĩnh nhé, gom nước hồi máu đi.',
  'Thử tích nộ tung đòn kiếm đôi xem!',
  'Một trận chưa nói lên tất cả đâu.',
];

const REMATCH_REPLIES = [
  'Được thôi, hết trận này mình chiến tiếp nhé!',
  'Mình luôn sẵn sàng cho trận tiếp theo.',
  'Chốt nhé, lát nữa tái đấu!',
  'Trận sau mình vẫn không nương tay đâu 😄',
];

const LAUGH_REPLIES = [
  'Haha, trận này vui thật 😄',
  'Cười xong nhớ nhìn bàn ngọc nhé!',
  'Bạn làm không khí nhẹ nhàng hẳn đó.',
  'Hihi, đến lượt ai rồi nhỉ?',
];

const BOT_IDENTITY_REPLIES: Record<BotLevel, readonly string[]> = {
  easy: ['Mình là máy tập sự thôi 😄', 'Đúng rồi, nhưng mình cũng thích đánh đẹp nhé!'],
  normal: [
    'Mình là máy, nhiệm vụ là cho bạn một trận thật hay.',
    'Là bot nhưng mình vẫn biết tung bất ngờ đấy!',
  ],
  hard: ['Đúng, và mình đang phân tích từng lượt của bạn.', 'Máy cũng có binh pháp riêng nhé.'],
  expert: [
    'Đúng, ở mức này mình còn mô phỏng cả những cascade có thể xảy ra.',
    'Mình là bot SIÊU KHÓ — sơ hở nhỏ cũng có thể thành combo lớn đấy.',
  ],
};

const CALM_REPLIES = [
  'Chơi vui thôi nhé, mình tập trung đánh nào.',
  'Bình tĩnh nhé, một trận đấu không đáng để cáu đâu.',
  'Mình tiếp tục bằng những combo đẹp nhé.',
];

const FINISH_LINES = {
  botWin: [
    'Trận hay lắm! Mình thắng sát nút thôi.',
    'Cảm ơn bạn, một trận rất đã tay!',
    'Chưởng cuối vừa kịp nổ. Tái đấu nhé?',
    'Bạn làm mình phải dốc hết nội lực đấy!',
    'Một trận nghẹt thở! Hẹn bạn trận sau.',
  ],
  playerWin: [
    'Bạn thắng xứng đáng, đòn cuối rất đẹp!',
    'Chúc mừng nhé! Mình sẽ cố hơn ở trận sau.',
    'Hay lắm, mình đỡ không kịp.',
    'Bạn điều binh tốt thật. Tái đấu nhé?',
    'Mình thua rồi 😄 Một trận rất đáng đánh!',
  ],
  draw: [
    'Hòa rồi! Hai bên đều thủ rất chắc.',
    'Không ai nhường ai cả. Một trận hay!',
    'Cân sức thật đấy, tái đấu nhé?',
  ],
  forfeit: [
    'Bạn rút quân rồi. Khi nào sẵn sàng mình chiến tiếp nhé!',
    'Không sao, hẹn bạn ở một trận khác!',
    'Mình sẽ chờ bạn tái đấu.',
  ],
  timeout: [
    'Hết giờ rồi! Lần sau nhớ để ý đồng hồ nhé.',
    'Bạn nghĩ lâu quá rồi 😄 Tái đấu nhé?',
    'Đồng hồ đã quyết định trận này mất rồi.',
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
  if (/(chơi lại|ván nữa|trận nữa|tái đấu|rematch)/u.test(normalized)) return pick(REMATCH_REPLIES);
  if (/(haha|hehe|hihi|lol)/u.test(normalized)) return pick(LAUGH_REPLIES);
  if (/(khó|căng|đau đầu)/u.test(normalized)) return pick(DIFFICULTY_REPLIES[level]);
  if (/(hay|giỏi|đỉnh|tuyệt|đẹp)/u.test(normalized)) return pick(COMPLIMENT_REPLIES);
  if (/(tôi|mình|tao|tớ).*(sắp|sẽ)?\s*thắng/u.test(normalized)) return pick(WINNING_REPLIES);
  if (/(tôi|mình|tao|tớ).*(sắp|chắc)?\s*thua/u.test(normalized)) return pick(LOSING_REPLIES);
  if (/(ngu|gà|dở|tệ)/u.test(normalized)) return pick(CALM_REPLIES);
  if (/(bot|máy)/u.test(normalized)) return pick(BOT_IDENTITY_REPLIES[level]);
  return pick(GENERIC_REPLIES);
}

export function botFinishLine(winner: MatchWinner, reason: FinishReason, pick: LinePicker): string {
  if (reason === 'forfeit') return pick(FINISH_LINES.forfeit);
  if (reason === 'timeout') return pick(FINISH_LINES.timeout);
  if (winner === 'bot') return pick(FINISH_LINES.botWin);
  if (winner === 'you') return pick(FINISH_LINES.playerWin);
  return pick(FINISH_LINES.draw);
}
