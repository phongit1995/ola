import { loadFarmCatalog } from '../tools/load-farm-catalog';
import assert from 'node:assert/strict';
import { test } from 'node:test';
import { accountFromToken, accountStorage } from '../assets/farm/scripts/core/AccountStorage';
import { DEVICE_FARM_OWNER_KEY, SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave } from '../assets/farm/scripts/core/FarmSave';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import type { StoragePort } from '../assets/farm/scripts/core/types/SaveTypes';

const catalog = loadFarmCatalog();
const A = '0b6a2c1e-7d4f-4a51-9e3c-2f8d1b7a6c50',
  B = 'f3c9e2a1-5b6d-4c7e-8f90-1a2b3c4d5e6f';
const base64url = (value: string) =>
  Buffer.from(value).toString('base64').replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
const jwt = (payload: unknown) => `${base64url('{"alg":"HS256"}')}.${base64url(JSON.stringify(payload))}.signature`;
function device() {
  const data = new Map<string, string>();
  const storage: StoragePort = {
    getItem: key => data.get(key) ?? null,
    setItem: (key, value) => void data.set(key, value),
  };
  return { data, storage };
}

test('the account id comes from the Ola token payload; anything else plays the device farm', () => {
  assert.equal(accountFromToken(jwt({ data: { id: A, sid: 'x' }, exp: 1 })), A);
  assert.equal(accountFromToken(jwt({ data: { id: A.toUpperCase() } })), A, 'ids are normalised to lower case');
  for (const token of [
    null,
    undefined,
    '',
    'guest:alice',
    'a.b',
    'a.%%%.c',
    jwt({ id: A }),
    jwt({ data: { id: 'not-a-uuid' } }),
    jwt({ data: { id: 42 } }),
  ])
    assert.equal(accountFromToken(token), null, String(token));
});

test('the first account inherits the device farm; a second account on the same device starts fresh', () => {
  const { data, storage } = device();
  assert.equal(accountStorage(storage, null), storage, 'without an account nothing changes');
  data.set(SIMPLE_FARM_KEY, 'device farm');
  data.set(SIMPLE_FARM_KEY + '.backup', 'device backup');

  const a = accountStorage(storage, A);
  assert.equal(a.getItem(SIMPLE_FARM_KEY), 'device farm');
  a.setItem(SIMPLE_FARM_KEY, 'farm of A');
  assert.equal(data.get(DEVICE_FARM_OWNER_KEY), A);
  assert.equal(data.get(`${SIMPLE_FARM_KEY}@${A}`), 'farm of A');
  assert.equal(data.get(SIMPLE_FARM_KEY), 'device farm', 'the device copy is never overwritten');

  const b = accountStorage(storage, B);
  assert.equal(b.getItem(SIMPLE_FARM_KEY), null);
  assert.equal(b.getItem(SIMPLE_FARM_KEY + '.backup'), null, 'recovery copies stay with their owner too');
  b.setItem(SIMPLE_FARM_KEY, 'farm of B');
  assert.equal(data.get(DEVICE_FARM_OWNER_KEY), A, 'ownership is claimed once');

  const again = accountStorage(storage, A);
  assert.equal(again.getItem(SIMPLE_FARM_KEY), 'farm of A');
  assert.equal(
    again.getItem(SIMPLE_FARM_KEY + '.backup'),
    'device backup',
    'the owner keeps the older recovery copies'
  );
  assert.equal(accountStorage(storage, B).getItem(SIMPLE_FARM_KEY), 'farm of B');
});

test('two accounts on one device keep separate farms through real sessions', () => {
  const { storage } = device();
  const open = (account: string | null) =>
    new GameSession(catalog, new FarmSave(accountStorage(storage, account), catalog), () => 0);
  const local = open(null);
  assert.equal(local.dispatch({ type: 'plant', plot: 0, crop: 1 }).ok, true);
  const coins = local.game.state.coins;

  const a = open(A);
  assert.equal(a.game.state.coins, coins, 'the first account adopts the farm played before sign-in');
  assert.equal(a.dispatch({ type: 'plant', plot: 1, crop: 1 }).ok, true);

  const b = open(B);
  assert.equal(b.game.state.coins, catalog.economy!.startingWallet.coins, 'another account gets a new farm');
  assert.equal(b.game.state.plots[0].crop, null);

  assert.equal(open(A).game.state.plots[1].crop, 1);
  assert.equal(open(B).game.state.plots[1].crop, null);
});
