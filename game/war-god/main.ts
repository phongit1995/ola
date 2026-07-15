import { Application, Container, Graphics, Text } from 'pixi.js';
import { bridge } from '../src/sdk';

const GRID = 8;
const COLORS = [0xf87171, 0xfbbf24, 0x34d399, 0x60a5fa, 0xc084fc, 0x94a3b8];

async function main(): Promise<void> {
  const root = document.getElementById('app')!;
  const app = new Application();
  await app.init({ resizeTo: root, background: 0x0f172a, antialias: true });
  root.appendChild(app.canvas);
  bridge.ready();

  const board = new Container();
  app.stage.addChild(board);

  const cellSize = Math.min(window.innerWidth, window.innerHeight * 0.7) / GRID;
  const tiles: Graphics[] = [];

  for (let y = 0; y < GRID; y++) {
    for (let x = 0; x < GRID; x++) {
      const color = COLORS[Math.floor(Math.random() * COLORS.length)];
      const tile = new Graphics()
        .roundRect(3, 3, cellSize - 6, cellSize - 6, cellSize * 0.22)
        .fill(color);
      tile.x = x * cellSize;
      tile.y = y * cellSize;
      board.addChild(tile);
      tiles.push(tile);
    }
  }

  board.x = (app.screen.width - GRID * cellSize) / 2;
  board.y = (app.screen.height - GRID * cellSize) / 2;

  const title = new Text({
    text: 'WAR GOD',
    style: { fill: 0xe2e8f0, fontSize: 28, fontWeight: '800', fontFamily: 'system-ui' },
  });
  title.anchor.set(0.5);
  title.x = app.screen.width / 2;
  title.y = board.y - 48;
  app.stage.addChild(title);

  const subtitle = new Text({
    text: 'Match-3 battle — coming soon',
    style: { fill: 0x94a3b8, fontSize: 14, fontFamily: 'system-ui' },
  });
  subtitle.anchor.set(0.5);
  subtitle.x = app.screen.width / 2;
  subtitle.y = board.y + GRID * cellSize + 32;
  app.stage.addChild(subtitle);

  let t = 0;
  app.ticker.add((ticker) => {
    t += ticker.deltaMS / 1000;
    tiles.forEach((tile, i) => {
      tile.alpha = 0.75 + 0.25 * Math.sin(t * 2 + i * 0.35);
    });
  });
}

void main();
