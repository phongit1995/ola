import { Container, Graphics, Rectangle, Sprite, type Ticker } from 'pixi.js';
import { GAME_REACTION_TYPE, type GameReactionType } from '../../../src/sdk';
import { A, tex } from '../../assets';
import { HEADING, addTick, makeText, removeTick } from '../../kit';
import type { BotLevel } from '../../logic/battle';
import { pvp } from '../../pvp';
import { botReply } from './bot-chat';
import { createChatInput, type ChatInputController } from './chat-input';

export const CHAT_W = 398;
const CHAT_PAD = 12;
const BOT_NAME = '@Bot';
const REACTION_PICKER_W = 266;
const REACTION_PICKER_H = 50;

const REACTION_OPTIONS: ReadonlyArray<{
  type: GameReactionType;
  label: string;
  asset: string;
}> = [
  { type: GAME_REACTION_TYPE.Like, label: 'Thích', asset: A.chat.reactions.like },
  { type: GAME_REACTION_TYPE.Love, label: 'Yêu thích', asset: A.chat.reactions.love },
  { type: GAME_REACTION_TYPE.Haha, label: 'Haha', asset: A.chat.reactions.haha },
  { type: GAME_REACTION_TYPE.Wow, label: 'Wow', asset: A.chat.reactions.wow },
  { type: GAME_REACTION_TYPE.Sad, label: 'Buồn', asset: A.chat.reactions.sad },
  { type: GAME_REACTION_TYPE.Angry, label: 'Tức giận', asset: A.chat.reactions.angry },
];

export function pickChatLine(lines: readonly string[]): string {
  return lines[Math.floor(Math.random() * lines.length)]!;
}

interface ChatEntry {
  name: string;
  mine: boolean;
  text: string;
}

interface ReactionBalloon {
  sprite: Sprite;
  step: (ticker: Ticker) => void;
}

interface ChatDeps {
  isOver(): boolean;
  getBotLevel(): BotLevel;
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
let reactionOverlay: Container;
let reactionPicker: Container;
let reactionBalloonLayer: Container;
let input: ChatInputController;
let chatH = 150;
let reactionEndY = -400;
let contentH = 0;
let scrollBack = 0;
let pvpChat = false;
let roomChatSend: ((text: string) => void) | null = null;
const botReplyTimers = new Set<number>();
const reactionBalloons: ReactionBalloon[] = [];

function clearBotReplyTimers(): void {
  for (const timer of botReplyTimers) window.clearTimeout(timer);
  botReplyTimers.clear();
}

function closeReactionPicker(): void {
  if (reactionOverlay) reactionOverlay.visible = false;
}

function toggleReactionPicker(): void {
  if (deps.isOver() || roomChatSend) {
    closeReactionPicker();
    return;
  }
  reactionOverlay.visible = !reactionOverlay.visible;
}

function removeReactionBalloon(balloon: ReactionBalloon): void {
  removeTick(balloon.step);
  const index = reactionBalloons.indexOf(balloon);
  if (index >= 0) reactionBalloons.splice(index, 1);
  if (!balloon.sprite.destroyed) balloon.sprite.destroy();
}

function clearReactionBalloons(): void {
  for (const balloon of [...reactionBalloons]) removeReactionBalloon(balloon);
}

export function pushReaction(type: GameReactionType, mine: boolean): void {
  const reaction = REACTION_OPTIONS.find((option) => option.type === type);
  if (!reaction || !reactionBalloonLayer) return;

  for (let index = 0; index < 3; index++) {
    const sprite = new Sprite(tex[reaction.asset]);
    sprite.anchor.set(0.5);
    sprite.eventMode = 'none';
    sprite.visible = false;
    reactionBalloonLayer.addChild(sprite);

    const size = 34 + Math.random() * 12;
    const baseScale = size / Math.max(sprite.texture.width, sprite.texture.height);
    const startX = mine ? CHAT_W - 72 + Math.random() * 30 : 48 + Math.random() * 30;
    const startY = chatH - 32;
    const endY = reactionEndY + Math.random() * 18;
    const sway = (Math.random() * 2 - 1) * 30;
    const drift = (Math.random() * 2 - 1) * 42;
    const delay = index * 90 + Math.random() * 50;
    const duration = 1550 + Math.random() * 350;
    let elapsed = 0;
    const balloon = {} as ReactionBalloon;
    balloon.sprite = sprite;
    balloon.step = (ticker): void => {
      elapsed += ticker.deltaMS;
      if (elapsed < delay) return;
      sprite.visible = true;
      const progress = Math.min(1, (elapsed - delay) / duration);
      const easedRise = 1 - Math.pow(1 - progress, 1.35);
      sprite.x = startX + Math.sin(progress * Math.PI * 2) * sway + drift * progress;
      sprite.y = startY + (endY - startY) * easedRise;
      sprite.rotation = Math.sin(progress * Math.PI * 3) * 0.09;
      sprite.alpha = progress < 0.78 ? 1 : (1 - progress) / 0.22;
      sprite.scale.set(baseScale * (0.82 + Math.min(1, progress * 4) * 0.28));
      if (progress >= 1) removeReactionBalloon(balloon);
    };
    reactionBalloons.push(balloon);
    addTick(balloon.step);
  }

  while (reactionBalloons.length > 12) {
    const oldest = reactionBalloons[0];
    if (oldest) removeReactionBalloon(oldest);
  }
}

function sendReaction(type: GameReactionType): void {
  closeReactionPicker();
  if (deps.isOver() || roomChatSend) return;
  if (pvpChat) {
    pvp.sendReaction(type);
    return;
  }
  pushReaction(type, true);
}

function buildReactionOverlay(): Container {
  const overlay = new Container();
  overlay.visible = false;

  const dismiss = new Graphics();
  dismiss.rect(-1000, -1000, 2400, 2400).fill({ color: 0x000000, alpha: 0.001 });
  dismiss.eventMode = 'static';
  dismiss.on('pointertap', closeReactionPicker);
  overlay.addChild(dismiss);

  reactionPicker = new Container();
  const bg = new Graphics();
  bg.roundRect(0, 0, REACTION_PICKER_W, REACTION_PICKER_H, 18)
    .fill({ color: 0x17182e, alpha: 0.97 })
    .stroke({ color: 0xf6c445, alpha: 0.9, width: 2 });
  reactionPicker.addChild(bg);

  REACTION_OPTIONS.forEach((reaction, index) => {
    const button = new Container();
    button.x = 8 + index * 43;
    button.y = 4;
    button.hitArea = new Rectangle(0, 0, 42, 42);
    button.eventMode = 'static';
    button.cursor = 'pointer';
    button.label = reaction.label;

    const hover = new Graphics();
    hover.circle(21, 21, 20).fill({ color: 0xffffff, alpha: 0.12 });
    hover.visible = false;
    const icon = new Sprite(tex[reaction.asset]);
    icon.anchor.set(0.5);
    icon.x = 21;
    icon.y = 21;
    icon.scale.set(32 / Math.max(icon.texture.width, icon.texture.height));
    button.addChild(hover, icon);
    button.on('pointerover', () => {
      hover.visible = true;
    });
    button.on('pointerout', () => {
      hover.visible = false;
    });
    button.on('pointerdown', () => button.scale.set(0.9));
    button.on('pointerup', () => button.scale.set(1));
    button.on('pointerupoutside', () => button.scale.set(1));
    button.on('pointertap', (event) => {
      event.stopPropagation();
      button.scale.set(1);
      sendReaction(reaction.type);
    });
    reactionPicker.addChild(button);
  });

  overlay.addChild(reactionPicker);
  return overlay;
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
  const text = value.slice(0, 120);
  // Đang chờ trong bàn: chat phòng (server chỉ phát khi bàn đủ 2 người,
  // giống caro — thiếu người thì lặng lẽ bỏ qua).
  if (roomChatSend) {
    roomChatSend(text);
    return;
  }
  if (pvpChat) {
    pvp.sendChatText(text);
    return;
  }
  pushChat('@bạn', true, text);
  const timer = window.setTimeout(
    () => {
      botReplyTimers.delete(timer);
      if (!deps.isOver()) {
        pushChat(BOT_NAME, false, botReply(text, deps.getBotLevel(), pickChatLine));
      }
    },
    700 + Math.random() * 900,
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

  reactionBalloonLayer = new Container();
  reactionBalloonLayer.eventMode = 'none';
  chatBox.addChild(reactionBalloonLayer);

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
  smiley.on('pointertap', toggleReactionPicker);
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

  reactionOverlay = buildReactionOverlay();
  chatBox.addChild(reactionOverlay);

  input = createChatInput({
    onSubmit: sendChat,
    onFocusChange: (focused) => deps.onFocusChange(focused),
  });

  return chatBox;
}

export function layoutChat(
  x: number,
  y: number,
  h: number,
  rootX: number,
  scale: number,
  reactionTargetY: number,
): void {
  chatBox.x = x;
  chatBox.y = y;
  chatH = h;
  reactionEndY = reactionTargetY - y;
  const inputY = chatH - 46;
  chatBg.height = chatH;
  msgMask.clear().rect(6, 8, CHAT_W - 12, viewH()).fill(0xffffff);
  scrollZone.hitArea = new Rectangle(6, 8, CHAT_W - 12, viewH());
  inputBg.y = inputY;
  smiley.x = inputBg.x + inputBg.width - 20;
  smiley.y = inputY + 17;
  sendBtn.x = CHAT_W - CHAT_PAD - 84;
  sendBtn.y = inputY - 2;
  reactionPicker.x = inputBg.x + inputBg.width - REACTION_PICKER_W;
  reactionPicker.y = inputY - REACTION_PICKER_H - 6;

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
  closeReactionPicker();
  clearReactionBalloons();
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

export function pushBotChat(text: string): void {
  pushChat(BOT_NAME, false, text);
}

export function setRoomChatSender(sender: ((text: string) => void) | null): void {
  roomChatSend = sender;
}

export function setChatInputVisible(visible: boolean): void {
  if (!visible) closeReactionPicker();
  input.setVisible(visible);
}

export function disposeChat(): void {
  clearBotReplyTimers();
  closeReactionPicker();
  clearReactionBalloons();
  input?.dispose();
}
