import { Container, Graphics, Rectangle, Sprite } from 'pixi.js';
import { A, tex } from '../../assets';
import { HEADING, makeText } from '../../kit';
import { pvp } from '../../pvp';
import { createChatInput, type ChatInputController } from './chat-input';

export const CHAT_W = 492;
const CHAT_PAD = 12;
const BOT_NAME = '@Bot';
const BOT_LINES = [
  'Hihi 😄',
  'Cẩn thận nhé!',
  'Xem chiêu này!',
  'Bạn chơi hay đấy 👍',
  'Tới lượt ta!',
  'Không dễ đâu! 😤',
  'Trận này gay cấn thật!',
];

interface ChatEntry {
  name: string;
  mine: boolean;
  text: string;
}

interface ChatDeps {
  isOver(): boolean;
  onFocusChange(focused: boolean): void;
}

const chatLog: ChatEntry[] = [];
let deps: ChatDeps;
let chatBox: Container;
let chatBg: Sprite;
let msgLayer: Container;
let msgMask: Graphics;
let scrollZone: Container;
let inputBg: Sprite;
let sendBtn: Container;
let smiley: Sprite;
let input: ChatInputController;
let chatH = 150;
let contentH = 0;
let scrollBack = 0;
let pvpChat = false;
const botReplyTimers = new Set<number>();

function clearBotReplyTimers(): void {
  for (const timer of botReplyTimers) window.clearTimeout(timer);
  botReplyTimers.clear();
}

function viewH(): number {
  return chatH - 62;
}

function applyScroll(): void {
  const v = viewH();
  const maxBack = Math.max(0, contentH - v);
  scrollBack = Math.max(0, Math.min(maxBack, scrollBack));
  msgLayer.y = 8 + Math.min(0, v - contentH) + scrollBack;
}

function renderChat(): void {
  msgLayer.removeChildren().forEach((c) => c.destroy({ children: true }));
  let y = 0;
  for (const entry of chatLog) {
    const name = makeText(`${entry.name}:`, 12, entry.mine ? 0xffd75e : 0x6fd3ff, '800');
    name.anchor.set(0, 0);
    const content = makeText(entry.text, 12, 0xffffff, '700');
    content.anchor.set(0, 0);
    content.style.wordWrap = true;
    content.style.wordWrapWidth = CHAT_W - CHAT_PAD * 2 - name.width - 8;
    name.x = CHAT_PAD;
    name.y = y;
    content.x = CHAT_PAD + name.width + 6;
    content.y = y;
    msgLayer.addChild(name, content);
    y += Math.max(name.height, content.height) + 4;
  }
  contentH = y;
  applyScroll();
}

function pushChat(name: string, mine: boolean, text: string): void {
  chatLog.push({ name, mine, text });
  if (chatLog.length > 50) chatLog.shift();
  scrollBack = 0;
  renderChat();
}

function sendChat(): void {
  const value = input.takeValue();
  if (!value) return;
  if (pvpChat) {
    pvp.sendChatText(value.slice(0, 120));
    return;
  }
  pushChat('@bạn', true, value.slice(0, 120));
  const timer = window.setTimeout(
    () => {
      botReplyTimers.delete(timer);
      if (!deps.isOver() && Math.random() < 0.75) {
        pushChat(BOT_NAME, false, BOT_LINES[Math.floor(Math.random() * BOT_LINES.length)]);
      }
    },
    900 + Math.random() * 1200,
  );
  botReplyTimers.add(timer);
}

export function buildChat(chatDeps: ChatDeps): Container {
  deps = chatDeps;
  chatBox = new Container();
  chatBg = new Sprite(tex[A.chat.frame]);
  chatBg.width = CHAT_W;
  chatBg.height = chatH;
  chatBox.addChild(chatBg);

  msgLayer = new Container();
  chatBox.addChild(msgLayer);

  msgMask = new Graphics();
  chatBox.addChild(msgMask);
  msgLayer.mask = msgMask;

  scrollZone = new Container();
  scrollZone.eventMode = 'static';
  let dragY: number | null = null;
  scrollZone.on('pointerdown', (e) => {
    dragY = e.global.y;
  });
  scrollZone.on('pointermove', (e) => {
    if (dragY == null) return;
    const scale = chatBox.worldTransform.a || 1;
    scrollBack += (e.global.y - dragY) / scale;
    dragY = e.global.y;
    applyScroll();
  });
  const endDrag = (): void => {
    dragY = null;
  };
  scrollZone.on('pointerup', endDrag);
  scrollZone.on('pointerupoutside', endDrag);
  scrollZone.on('wheel', (e) => {
    scrollBack -= e.deltaY / 3;
    applyScroll();
  });
  chatBox.addChild(scrollZone);

  inputBg = new Sprite(tex[A.chat.input]);
  inputBg.width = CHAT_W - CHAT_PAD * 2 - 92;
  inputBg.height = 34;
  inputBg.x = CHAT_PAD;
  chatBox.addChild(inputBg);

  smiley = new Sprite(tex[A.chat.icSmiley]);
  smiley.anchor.set(0.5);
  smiley.scale.set(22 / Math.max(smiley.texture.width, smiley.texture.height));
  smiley.eventMode = 'static';
  smiley.cursor = 'pointer';
  smiley.on('pointertap', () => {
    input.append(' 🙂');
  });
  chatBox.addChild(smiley);

  sendBtn = new Container();
  const sendBg = new Sprite(tex[A.chat.btnSend]);
  sendBg.width = 84;
  sendBg.height = 38;
  sendBtn.addChild(sendBg);
  const sendLabel = makeText('GỬI', 14, 0xffffff, '700', HEADING);
  sendLabel.x = 42;
  sendLabel.y = 19;
  sendBtn.addChild(sendLabel);
  sendBtn.eventMode = 'static';
  sendBtn.cursor = 'pointer';
  sendBtn.on('pointertap', () => sendChat());
  sendBtn.on('pointerdown', () => sendBtn.scale.set(0.95));
  sendBtn.on('pointerup', () => sendBtn.scale.set(1));
  sendBtn.on('pointerupoutside', () => sendBtn.scale.set(1));
  chatBox.addChild(sendBtn);

  input = createChatInput({
    onSubmit: sendChat,
    onFocusChange: (focused) => deps.onFocusChange(focused),
  });

  return chatBox;
}

export function layoutChat(x: number, y: number, h: number, rootX: number, scale: number): void {
  chatBox.x = x;
  chatBox.y = y;
  chatH = h;
  const inputY = chatH - 46;
  chatBg.height = chatH;
  msgMask.clear().rect(6, 8, CHAT_W - 12, viewH()).fill(0xffffff);
  scrollZone.hitArea = new Rectangle(6, 8, CHAT_W - 12, viewH());
  inputBg.y = inputY;
  smiley.x = inputBg.x + inputBg.width - 20;
  smiley.y = inputY + 17;
  sendBtn.x = CHAT_W - CHAT_PAD - 84;
  sendBtn.y = inputY - 2;

  input.layout(
    rootX + (x + CHAT_PAD + 6) * scale,
    (y + inputY) * scale,
    (inputBg.width - 46) * scale,
    34 * scale,
    13 * scale,
  );
  renderChat();
}

export function resetChat(greeting?: string): void {
  clearBotReplyTimers();
  chatLog.length = 0;
  input.clear();
  if (greeting) {
    pushChat(BOT_NAME, false, greeting);
    return;
  }
  renderChat();
}

export function setChatPvp(on: boolean): void {
  pvpChat = on;
  if (on) clearBotReplyTimers();
}

export function pushPvpChat(name: string, mine: boolean, text: string): void {
  pushChat(name, mine, text);
}

export function setChatInputVisible(visible: boolean): void {
  input.setVisible(visible);
}

export function disposeChat(): void {
  clearBotReplyTimers();
  input?.dispose();
}
