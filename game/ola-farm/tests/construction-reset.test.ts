import assert from 'node:assert/strict';
import { test } from 'node:test';
import { loadFarmCatalog } from '../tools/load-farm-catalog';
import {
  cropItemKey,
  penBuildingId,
  penPlotId,
  recipeInputs,
  recipeOutputs,
} from '../assets/farm/scripts/core/FarmCatalog';
import { FarmGame } from '../assets/farm/scripts/core/FarmGame';
import { SIMPLE_FARM_KEY } from '../assets/farm/scripts/core/constants/SaveKeys';
import { FarmSave, farmPack } from '../assets/farm/scripts/core/FarmSave';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import type { FarmState } from '../assets/farm/scripts/core/types/StateTypes';
import { GameSession } from '../assets/farm/scripts/core/GameSession';
import { xpToNext } from '../assets/farm/scripts/core/Progression';

const catalog = loadFarmCatalog();
const settings = { speed: 1, sound: false, music: false };
const copy = <T>(value: T): T => JSON.parse(JSON.stringify(value));
const ok = (result: ActionResult) => assert.equal(result.error, undefined, result.error);
const xpFor = (level: number) =>
  Array.from({ length: level - 1 }, (_, i) => xpToNext(i + 1, catalog.economy!.experience.curve)).reduce(
    (a, b) => a + b,
    0
  );

function memory(state?: FarmState) {
  const data = new Map<string, string>();
  const saver = new FarmSave(
    {
      getItem: key => data.get(key) ?? null,
      setItem: (key, value) => {
        data.set(key, value);
      },
    },
    catalog
  );
  if (state) saver.save(farmPack(state, settings));
  return { data, saver };
}

function readyToBuild() {
  const game = new FarmGame(catalog);
  game.state.coins = 1000000;
  game.state.xp = xpFor(54);
  game.state.husbandry = {
    version: 1,
    feedReceived: true,
    eggsCollected: true,
    milkCollected: true,
    burgerCollected: true,
  };
  return game;
}

function assertNoBuildings(game: FarmGame) {
  assert.deepEqual(game.state.machines, []);
  for (const site of catalog.residentPens!) {
    const plot = game.residentPlot(penPlotId(site))!;
    assert.equal(plot.unlocked, false, penBuildingId(site));
    assert.equal(plot.residents, null, penBuildingId(site));
  }
}

function buildEverySite(game: FarmGame) {
  for (const type of catalog.machineTypes!)
    for (const site of type.buildSites!) ok(game.buyMachine(type.id, site.buildingId));
  for (const site of catalog.residentPens!) ok(game.buyPen(penPlotId(site)));
  assert.equal(game.state.machines.length, 16);
  assert.equal(game.state.plots.filter(plot => plot.residents).length, 8);
  game.validate();
}

test('new farms start with no production buildings and use the approved construction levels', () => {
  const game = new FarmGame(catalog);
  assertNoBuildings(game);
  assert.equal(game.progress.level, 1);
  assert.deepEqual(catalog.initialMachines, []);
  assert.deepEqual(
    Object.fromEntries(catalog.machineTypes!.map(type => [type.key, type.buildSites!.map(site => site.requiredLevel)])),
    {
      feedmill: [1, 12],
      bakery: [5, 18],
      milk_factory: [10, 24],
      grill: [15, 30],
      sugar_processor: [20, 36],
      popcorn_factory: [25, 42],
      pie_bakery: [30, 48],
      loom: [35, 54],
    }
  );
  assert.deepEqual(Object.fromEntries(catalog.residentPens!.map(site => [penBuildingId(site), site.requiredLevel])), {
    'pen:12': 1,
    'pen:13': 10,
    'pen:14': 15,
    'pen:15': 35,
    'pen:50': 12,
    'pen:51': 24,
    'pen:52': 30,
    'pen:53': 54,
  });
  for (const type of catalog.machineTypes!)
    for (const site of type.buildSites!) {
      assert.equal(site.initial, false, site.buildingId);
      assert.ok(site.price !== null && site.price > 0, site.buildingId);
    }
  for (const site of catalog.residentPens!) {
    assert.equal(site.initial, false, penBuildingId(site));
    assert.ok(site.purchasePrice !== undefined && site.purchasePrice > 0, penBuildingId(site));
  }
  game.validate();
});

for (const type of catalog.machineTypes!)
  for (const site of type.buildSites!) {
    test(`${site.buildingId}: level and coins are required, and only an explicit purchase builds once`, () => {
      let game = readyToBuild();
      for (const earlier of type.buildSites!.filter(candidate => candidate.ordinal < site.ordinal))
        ok(game.buyMachine(type.id, earlier.buildingId));
      const threshold = xpFor(site.requiredLevel);
      if (site.requiredLevel > 1) {
        game.state.xp = threshold - 1;
        const before = copy(game.state),
          offer = game.machineConstructionOffer(type.id);
        assert.equal(offer.buildingId, site.buildingId);
        assert.equal(offer.unlocked, false);
        assert.match(offer.reason, new RegExp(`level ${site.requiredLevel}$`));
        assert.equal(game.buyMachine(type.id, site.buildingId).error, offer.reason);
        assert.deepEqual(game.state, before);
      }
      game.state.xp = threshold;
      game.tick(86400);
      game = new FarmGame(catalog, game.state);
      assert.equal(game.progress.level, site.requiredLevel);
      assert.equal(
        game.state.machines.some(machine => machine.buildingId === site.buildingId),
        false
      );
      assert.equal(game.machineConstructionOffer(type.id).unlocked, true);
      const price = site.price!;
      game.state.coins = price - 1;
      const tooPoor = copy(game.state);
      assert.ok(game.buyMachine(type.id, site.buildingId).error);
      assert.deepEqual(game.state, tooPoor);
      game.state.coins = price;
      const count = game.state.machines.length;
      ok(game.buyMachine(type.id, site.buildingId));
      assert.equal(game.state.coins, 0);
      assert.equal(game.state.machines.length, count + 1);
      assert.equal(game.state.machines.filter(machine => machine.buildingId === site.buildingId).length, 1);
      const built = copy(game.state);
      assert.ok(game.buyMachine(type.id, site.buildingId).error);
      assert.deepEqual(game.state, built);
      game.validate();
    });
  }

for (const site of catalog.residentPens!) {
  test(`${penBuildingId(site)}: level and the full pen/animal price are required, and explicit construction runs once`, () => {
    let game = readyToBuild();
    const feedmill = catalog.machineTypes!.find(type => type.key === 'feedmill')!;
    ok(game.buyMachine(feedmill.id, feedmill.buildSites![0].buildingId));
    for (const earlier of catalog.residentPens!.filter(
      candidate => candidate.species === site.species && candidate.ordinal! < site.ordinal!
    ))
      ok(game.buyPen(penPlotId(earlier)));
    const id = penPlotId(site),
      required = site.requiredLevel!,
      threshold = xpFor(required);
    if (required > 1) {
      game.state.xp = threshold - 1;
      const before = copy(game.state),
        offer = game.penConstructionOffer(site.species);
      assert.equal(offer.plotId, id);
      assert.equal(offer.unlocked, false);
      assert.match(offer.reason, new RegExp(`level ${required}$`));
      assert.equal(game.buyPen(id).error, offer.reason);
      assert.deepEqual(game.state, before);
    }
    game.state.xp = threshold;
    game.tick(86400);
    game = new FarmGame(catalog, game.state);
    assert.equal(game.progress.level, required);
    assert.equal(game.residentPlot(id)!.residents, null);
    assert.equal(game.residentPlot(id)!.unlocked, false);
    assert.equal(game.penConstructionOffer(site.species).unlocked, true);
    const animal = catalog.livestock!.find(candidate => candidate.key === site.species)!;
    const price = site.purchasePrice! + animal.price * game.startingAnimals(site.species);
    assert.equal(game.penPurchasePrice(id), price);
    game.state.coins = price - 1;
    const tooPoor = copy(game.state);
    assert.ok(game.buyPen(id).error);
    assert.deepEqual(game.state, tooPoor);
    game.state.coins = price;
    const count = game.state.plots.filter(plot => plot.residents).length;
    ok(game.buyPen(id));
    assert.equal(game.state.coins, 0);
    assert.equal(game.state.plots.filter(plot => plot.residents).length, count + 1);
    assert.equal(game.residentPlot(id)!.unlocked, true);
    assert.equal(game.residentPlot(id)!.residents!.animals.length, game.startingAnimals(site.species));
    const built = copy(game.state);
    assert.ok(game.buyPen(id).error);
    assert.deepEqual(game.state, built);
    game.validate();
  });
}

test('reaching every construction level, opening offers, ticking and offline reload never grant buildings', () => {
  const game = readyToBuild();
  const levels = [
    ...new Set([
      ...catalog.machineTypes!.flatMap(type => type.buildSites!.map(site => site.requiredLevel)),
      ...catalog.residentPens!.map(site => site.requiredLevel!),
    ]),
  ].sort((a, b) => a - b);
  for (const level of levels) {
    game.state.xp = xpFor(level);
    for (const type of catalog.machineTypes!) game.machineConstructionOffer(type.id);
    for (const animal of catalog.livestock!) game.penConstructionOffer(animal.key);
    game.tick(86400);
    assertNoBuildings(game);
  }
  const store = memory(game.state),
    session = new GameSession(catalog, store.saver, () => 0);
  assert.equal(session.save(), true);
  const resumed = new GameSession(catalog, store.saver, () => 86400000);
  assertNoBuildings(resumed.game);
  const imported = new GameSession(catalog, memory().saver, () => 86400000);
  imported.importText(resumed.exportText());
  assertNoBuildings(imported.game);
  assert.equal(imported.game.state.coins, game.state.coins);
});

test('all manually built sites survive reload/import, while restart persists an empty level-one farm', () => {
  const game = readyToBuild();
  buildEverySite(game);
  // Owning a saved building is separate from permission to construct a new one.
  game.state.xp = 0;
  const built = copy(game.state),
    store = memory(built);
  const session = new GameSession(catalog, store.saver, () => 0);
  assert.deepEqual(session.game.state, built);
  const imported = new GameSession(catalog, memory().saver, () => 0);
  imported.importText(session.exportText());
  assert.deepEqual(imported.game.state, built);
  assert.equal(session.restart(), true);
  const fresh = new FarmGame(catalog).state;
  assert.deepEqual(session.game.state, fresh);
  assertNoBuildings(session.game);
  assert.equal(session.game.progress.level, 1);
  assert.equal(session.game.state.coins, catalog.economy!.startingWallet.coins);
  assert.equal(session.game.state.diamonds, catalog.economy!.startingWallet.diamonds);
  assert.deepEqual(JSON.parse(store.data.get(SIMPLE_FARM_KEY)!).free, fresh);
  assert.deepEqual(new GameSession(catalog, store.saver, () => 0).game.state, fresh);
});

test('a fresh level-one farm can buy its chicken buildings and produce feed and eggs using only normal actions', () => {
  const game = new FarmGame(catalog),
    wheat = game.farm(1)!,
    corn = game.farm(10)!;
  const feedmill = catalog.machineTypes!.find(type => type.key === 'feedmill')!;
  const harvest = (crop: typeof wheat) => {
    ok(game.plant(0, crop.id));
    game.tick(crop.duration);
    ok(game.harvest(0));
  };

  assertNoBuildings(game);
  assert.equal(game.progress.level, 1);
  assert.equal(game.state.coins, 700);
  assert.deepEqual(game.state.inventory, { 'raw:1': 4, 'farm40:corn': 2 }, 'enough for two batches of chicken feed');
  assert.equal(game.machineConstructionOffer(feedmill.id).unlocked, true);
  assert.equal(game.machinePurchasePrice(feedmill.id), 200);
  ok(game.buyMachine(feedmill.id, 'feed-1'));
  assert.equal(game.penPurchasePrice(12), 220);
  ok(game.buyPen(12));
  assert.equal(game.state.coins, 280, 'both starter buildings leave coins to plant every open field');
  harvest(wheat);
  harvest(wheat);
  harvest(corn);
  assert.equal(game.state.coins, 210);
  assert.equal(game.progress.level, 3, 'build XP reaches level 2, the corn harvest level 3');

  const recipe = game.product(24)!,
    machine = game.state.machines[0],
    output = recipeOutputs(recipe)[0];
  assert.equal(game.recipeUnlockStatus(recipe.id).unlocked, true);
  assert.equal(game.quantity(output.key), 0);
  ok(game.produce(recipe.id, machine.id));
  game.tick(recipe.duration);
  assert.equal(game.quantity(output.key), 0, 'finished production still needs collection');
  ok(game.collect(machine.id));
  assert.equal(game.quantity(output.key), 3);
  const chicken = catalog.livestock!.find(animal => animal.key === 'layer')!;
  for (let batch = 0; batch < 3; batch++) {
    ok(game.feedAnimals(12));
    assert.equal(game.quantity(chicken.feed), 2 - batch);
    game.tick(chicken.duration);
    assert.equal(game.quantity(chicken.output), batch * chicken.quantity);
    ok(game.collectAnimals(12));
    assert.equal(game.quantity(chicken.output), (batch + 1) * chicken.quantity);
  }
  ok(game.sellItem(chicken.output, game.quantity(chicken.output)));
  assert.equal(game.state.coins, 306, 'selling the first three eggs funds another planting cycle');
  assert.equal(game.progress.level, 3, 'the first feed and egg cycle stays on level 3');
  assert.deepEqual(
    game.state.machines.map(candidate => candidate.buildingId),
    ['feed-1']
  );
  assert.deepEqual(
    game.state.plots.filter(plot => plot.residents).map(plot => plot.id),
    [12]
  );
  assert.equal(game.state.husbandry!.feedReceived, true);
  assert.equal(game.state.husbandry!.eggsCollected, true);
  assert.equal(
    game.state.diamonds,
    catalog.economy!.startingWallet.diamonds + 2 * catalog.economy!.experience.levelUpDiamonds,
    'only the level-2 and level-3 rewards; no boosts or coin packs were needed'
  );
  game.validate();
});

test('levels one and three offer only the first feed mill and chicken pen even with abundant coins and completed milestones', () => {
  for (const level of [1, 3]) {
    const game = readyToBuild();
    game.state.xp = xpFor(level);
    assertNoBuildings(game);
    assert.deepEqual(
      game.machineTypes.filter(type => game.machineConstructionOffer(type.id).unlocked).map(type => type.key),
      ['feedmill']
    );
    assert.deepEqual(
      catalog.residentPens!.filter(site => game.penUnlockStatus(penPlotId(site)).unlocked).map(penBuildingId),
      ['pen:12']
    );
    assert.deepEqual(
      catalog.products.filter(recipe => game.recipeUnlockStatus(recipe.id).unlocked).map(recipe => recipe.id),
      [24]
    );
    for (const type of game.machineTypes.filter(candidate => candidate.key !== 'feedmill')) {
      const before = copy(game.state);
      assert.ok(game.buyMachine(type.id, type.buildSites![0].buildingId).error);
      assert.deepEqual(game.state, before);
    }
    const feedmill = game.machineTypes.find(type => type.key === 'feedmill')!;
    ok(game.buyMachine(feedmill.id, 'feed-1'));
    assert.deepEqual(
      catalog.livestock!.filter(animal => game.penConstructionOffer(animal.key).unlocked).map(animal => animal.key),
      ['layer']
    );
    for (const site of catalog.residentPens!.filter(candidate => penPlotId(candidate) !== 12)) {
      const before = copy(game.state);
      assert.ok(game.buyPen(penPlotId(site)).error);
      assert.deepEqual(game.state, before);
    }
    ok(game.buyPen(12));
    assert.equal(game.machineConstructionOffer(feedmill.id).unlocked, false);
    assert.equal(game.penConstructionOffer('layer').unlocked, false);
    game.validate();
  }
});

test('recipes unlock no earlier than their first building and every source needed for their ingredients', () => {
  const game = new FarmGame(catalog);
  assert.equal(game.farm(10)!.requiredLevel, 1, 'corn is available for the starter chicken-feed recipe');
  assert.deepEqual(
    [24, 25, 105003, 105004].map(id => game.product(id)!.requiredLevel),
    [1, 10, 15, 35]
  );
  const sourceLevels = (key: string): number[] => [
    ...catalog.farm.filter(crop => cropItemKey(crop) === key).map(crop => crop.requiredLevel ?? 1),
    ...catalog.products
      .filter(recipe => recipeOutputs(recipe).some(output => output.key === key))
      .map(recipe => recipe.requiredLevel ?? 1),
    ...catalog
      .livestock!.filter(animal => animal.output === key)
      .map(animal => {
        const pen = catalog.residentPens!.find(site => site.species === animal.key && site.ordinal === 1)!;
        const feedLevels = catalog.products
          .filter(recipe => recipeOutputs(recipe).some(output => output.key === animal.feed))
          .map(recipe => recipe.requiredLevel ?? 1);
        assert.ok(feedLevels.length, `${animal.key} must have a source of feed`);
        return Math.max(pen.requiredLevel!, Math.min(...feedLevels));
      }),
  ];
  for (const recipe of catalog.products) {
    const building = catalog.machineTypes!.find(type => type.id === recipe.machine)!.buildSites![0];
    assert.ok(
      recipe.requiredLevel! >= building.requiredLevel,
      `recipe ${recipe.id} is advertised before ${building.buildingId}`
    );
    for (const input of recipeInputs(recipe)) {
      const sources = sourceLevels(input.key);
      assert.ok(sources.length, `recipe ${recipe.id} needs an obtainable ${input.key}`);
      assert.ok(
        recipe.requiredLevel! >= Math.min(...sources),
        `recipe ${recipe.id} is advertised before its ${input.key} can be made`
      );
    }
  }
});
