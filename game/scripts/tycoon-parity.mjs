import { build } from 'esbuild';
import { mkdtempSync, readFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const fixturePath = resolve(process.argv[2] ?? join(here, '../../server/internal/game/games/tycoon/testdata/parity.json'));

const outDir = mkdtempSync(join(tmpdir(), 'tycoon-parity-'));
const bundle = join(outDir, 'engine.mjs');
await build({
  entryPoints: [join(here, '../tycoon/logic/engine.ts')],
  bundle: true,
  format: 'esm',
  platform: 'node',
  outfile: bundle,
  loader: { '.json': 'json' },
  logLevel: 'warning',
});
const { newGame, applyMove, quitPlayer } = await import(pathToFileURL(bundle).href);
rmSync(outDir, { recursive: true, force: true });

function canon(value) {
  if (typeof value === 'bigint') return value.toString();
  if (Array.isArray(value)) return value.map(canon);
  if (value && typeof value === 'object') {
    const out = {};
    for (const key of Object.keys(value).sort()) {
      if (value[key] !== undefined) out[key] = canon(value[key]);
    }
    return out;
  }
  return value;
}

function comparable(state) {
  const copy = canon(state);
  delete copy.startedAt;
  return copy;
}

function firstDiff(a, b, path) {
  if (JSON.stringify(a) === JSON.stringify(b)) return null;
  if (a && b && typeof a === 'object' && typeof b === 'object') {
    for (const key of new Set([...Object.keys(a), ...Object.keys(b)])) {
      const diff = firstDiff(a[key], b[key], `${path}.${key}`);
      if (diff) return diff;
    }
  }
  return `${path}: ts=${JSON.stringify(a)} go=${JSON.stringify(b)}`;
}

const fixture = JSON.parse(readFileSync(fixturePath, 'utf8'));
const totals = { games: 0, turns: 0, rejected: 0, quits: 0, mismatches: 0 };

for (const game of fixture.games) {
  totals.games++;
  const label = game.name ?? `seed ${game.seed}`;
  let state = game.initial ? { ...game.initial, rng: BigInt(game.initial.rng) } : newGame(game.seed, game.players);
  let failure = null;
  for (const [i, turn] of game.turns.entries()) {
    totals.turns++;
    let next;
    if (turn.quit) {
      totals.quits++;
      next = quitPlayer(state, turn.seat);
    } else {
      try {
        next = applyMove(state, turn.seat, turn.move);
      } catch (error) {
        if (error.code === turn.error) {
          totals.rejected++;
          continue;
        }
        failure = `turn ${i}: ts error ${error.code ?? error.message}, go ${turn.error ?? 'ok'}`;
        break;
      }
      if (turn.error) {
        failure = `turn ${i}: go rejected with ${turn.error}, ts accepted`;
        break;
      }
    }
    failure = firstDiff(canon(next.steps), canon(turn.steps ?? []), `turn ${i} steps`);
    if (!failure && turn.state) failure = firstDiff(comparable(next), comparable(turn.state), `turn ${i} state`);
    if (failure) break;
    state = next;
  }
  if (!failure) failure = firstDiff(comparable(state), comparable(game.final), 'final');
  if (failure) {
    totals.mismatches++;
    console.error(`${label}: ${failure}`);
  }
}

console.log(JSON.stringify(totals));
process.exit(totals.mismatches === 0 ? 0 : 1);
