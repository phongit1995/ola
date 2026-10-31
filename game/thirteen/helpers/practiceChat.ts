import { GAME_REACTION_TYPE, type GameReactionType } from '../../src/sdk/protocol';

export type BotChatEvent = 'greet' | 'chop' | 'chopped' | 'pass' | 'finishFirst' | 'youFirst' | 'twoPlayed';

export const BOT_CHAT_LINES: Record<BotChatEvent, readonly string[]> = {
  greet: ['Chào cả nhà, chia bài thôi!', 'Ván này mình quyết về Nhất 😄', 'Nhẹ tay với mình nha!', 'Sẵn sàng chưa nào?'],
  chop: ['Chặt nè!', 'Heo đâu, chặt hết 😎', 'Không thoát được đâu!', 'Tới công chuyện rồi!'],
  chopped: ['Ối!', 'Đau quá trời 😭', 'Bị chặt mất rồi…', 'Ván sau trả thù nha!'],
  pass: ['Qua', 'Thôi, qua nha', 'Nhường đó', 'Để dành bài 😏'],
  finishFirst: ['Về Nhất rồi nha 😎', 'Hết bài! Dễ mà', 'Nhất rồi, cảm ơn cả nhà!'],
  youFirst: ['Hay quá, chúc mừng nha!', 'Bạn đánh khá ghê 👏', 'Lần sau mình không nhường đâu!'],
  twoPlayed: ['Ra heo luôn kìa!', 'Heo kìa, ai chặt không?', 'Mạnh tay ghê!'],
};

export const BOT_REACTIONS: Partial<Record<BotChatEvent, readonly GameReactionType[]>> = {
  chop: [GAME_REACTION_TYPE.Haha, GAME_REACTION_TYPE.Love],
  chopped: [GAME_REACTION_TYPE.Sad, GAME_REACTION_TYPE.Angry],
  finishFirst: [GAME_REACTION_TYPE.Haha, GAME_REACTION_TYPE.Like],
  youFirst: [GAME_REACTION_TYPE.Wow, GAME_REACTION_TYPE.Like],
  twoPlayed: [GAME_REACTION_TYPE.Wow],
};

export const BOT_CHAT_CHANCE: Record<BotChatEvent, number> = {
  greet: 0.7,
  chop: 0.8,
  chopped: 0.6,
  pass: 0.12,
  finishFirst: 0.9,
  youFirst: 0.8,
  twoPlayed: 0.3,
};

const REPLIES: { match: RegExp; lines: readonly string[] }[] = [
  { match: /chào|hello|hi\b/i, lines: ['Chào bạn nha!', 'Hi hi, chơi vui nhé!'] },
  { match: /nhanh|lẹ|lâu/i, lines: ['Từ từ, đang tính bài 🤔', 'Đánh liền đây!'] },
  { match: /gà|non|dở|ngu/i, lines: ['Để xem ai gà nha 😤', 'Ván sau biết tay!'] },
  { match: /hay|giỏi|đỉnh|pro/i, lines: ['Cảm ơn nha 😊', 'Bạn cũng đỉnh lắm!'] },
  { match: /chặt/i, lines: ['Chặt được thì chặt đi 😏', 'Mình còn heo đó nha!'] },
];

const FALLBACK_REPLIES = ['Hi hi 😄', 'Tập trung đánh bài nào!', 'Ừa ừa', 'Ván này căng nha!'];

export function botReplyLines(text: string): readonly string[] {
  return REPLIES.find((reply) => reply.match.test(text))?.lines ?? FALLBACK_REPLIES;
}

export function pickLine(lines: readonly string[], random: () => number, avoid = ''): string {
  const choices = lines.length > 1 ? lines.filter((line) => line !== avoid) : lines;
  return choices[Math.floor(random() * choices.length)] ?? lines[0];
}
