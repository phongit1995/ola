import { loadFarmCatalog } from './load-farm-catalog';
/** Fresh-save balance probe. Run from cocos: node --import tsx tools/simulate-real-time-economy.ts */
import fs from 'node:fs';
import path from 'node:path';
import assert from 'node:assert/strict';
import { FarmGame, orderedCrops } from '../assets/farm/scripts/core/FarmGame';
import type { FarmCatalog } from '../assets/farm/scripts/core/types/CatalogTypes';
import type { ActionResult } from '../assets/farm/scripts/core/types/ActionTypes';
import { cropItemKey, recipeInputs } from '../assets/farm/scripts/core/FarmCatalog';
const catalog: FarmCatalog = loadFarmCatalog();
const gateSeeds = [1, 1, 10, 11, 11, 1128];
const targetRecipes = [
  [24, 1],
  [25, 1],
  [7, 2],
  [22, 1],
  [105003, 1],
  [101604, 1],
];
const reserveStock: Record<string, number> = { 'raw:1': 6, 'farm40:corn': 3, 'farm40:cabbage': 4, 'town:potato': 2 };
function run(
  visits: number[],
  minutesPerVisit: number,
  fit: 'arrival' | 'visit-window' = 'arrival',
  strategy: 'profit' | 'active-wheat' = 'profit',
  maxDays = 3000
) {
  const g = new FarmGame(catalog),
    fields = orderedCrops(g.state.plots),
    gatePlanted = new Set<number>(),
    queued: Record<number, number> = {},
    events: Record<string, number> = {};
  const initialCoins = g.state.coins,
    initialGems = g.state.diamonds;
  let actions = 0,
    activeSeconds = 0,
    spending = 0,
    seedCosts = 0;
  const record = () => {
    const mark = (key: string) => {
      if (events[key] === undefined) events[key] = +(g.state.time / 86400).toFixed(3);
    };
    for (const crop of catalog.farm) if (g.cropUnlockStatus(crop.id).unlocked) mark('crop:' + crop.name);
    if (g.progress.level >= 10) mark('level:10');
    if (g.state.husbandry!.burgerCollected) mark('burger');
    const pens = g.state.plots.filter(p => p.residents);
    if (
      new Set(g.state.machines.map(m => m.type)).size === g.machineTypes.length &&
      new Set(pens.map(p => p.residents!.species)).size === catalog.livestock!.length
    )
      mark('allTypes');
    if (
      g.state.machines.length === g.machineTypes.reduce((n, t) => n + g.machineLimit(t.id), 0) &&
      pens.length === catalog.livestock!.reduce((n, t) => n + g.penLimit(t.key), 0)
    )
      mark('allBuildings');
    if (
      events.allBuildings !== undefined &&
      pens.every(
        p =>
          p.residents!.capacity >= g.penCapacityLimit(p.residents!.species) &&
          p.residents!.animals.length >= g.penCapacityLimit(p.residents!.species)
      )
    )
      mark('allAnimals');
    if (fields.every(p => p.unlocked)) mark('allFields');
    if (
      events.allAnimals !== undefined &&
      events.allFields !== undefined &&
      g.state.machines.every(m => m.capacity >= g.queueCapacityLimit(m.type))
    )
      mark('maxed');
  };
  for (let day = 0; day < maxDays && events.maxed === undefined; day++)
    for (let visit = 0; visit < visits.length && events.maxed === undefined; visit++) {
      const start = day * 86400 + visits[visit] * 3600;
      if (start > g.state.time) g.tick(start - g.state.time);
      const end = start + minutesPerVisit * 60,
        next =
          visit + 1 < visits.length ? day * 86400 + visits[visit + 1] * 3600 : (day + 1) * 86400 + visits[0] * 3600,
        away = next - (fit === 'arrival' ? end : start);
      const act = (kind: 'plant' | 'harvest' | 'other' | 'purchase', cost: number, fn: () => ActionResult): boolean => {
        if (g.state.time + cost > end) return false;
        const before = g.state.coins,
          r = fn();
        assert.equal(r.error, undefined, r.error);
        if (kind === 'plant') seedCosts += before - g.state.coins;
        if (kind === 'purchase') spending += before - g.state.coins;
        actions++;
        activeSeconds += cost;
        g.tick(cost);
        record();
        return true;
      };
      while (g.state.time < end && events.maxed === undefined) {
        const before = actions;
        for (const p of fields) if (g.isReady(p)) act('harvest', 1, () => g.harvest(p.id));
        for (const m of g.state.machines) if (m.tray.length) act('other', 3, () => g.collectAll(m.id));
        for (const [id, output, needed] of [
          [12, 'farm40:egg', 1],
          [13, 'raw:7', 2],
          [14, 'town:beacon', 1],
        ] as const) {
          const p = g.residentPlot(id)!;
          if (!p.residents) continue;
          if (p.residents.animals.some(a => a.job && a.job.ready <= g.state.time))
            act('other', 3, () => g.collectAnimals(id));
          let a = p.residents.animals[0];
          const type = catalog.livestock!.find(t => t.key === p.residents!.species)!;
          if (
            !a &&
            g.animalPurchasingReady &&
            g.state.coins >= type.price + fields.filter(f => f.unlocked).length * g.farm(1)!.price
          ) {
            act('purchase', 3, () => g.buyAnimal(id));
            a = p.residents.animals[0];
          }
          if (
            a &&
            (g.state.produced[output] ?? 0) < needed &&
            !a.job &&
            g.quantity(type.feed) >= g.feedPerAnimal(type.key)
          )
            act('other', 3, () => g.feedAnimals(id, a.id));
        }
        for (const [id, count] of targetRecipes) {
          const r = g.product(id)!,
            m = g.state.machines.find(m => m.type === r.machine && g.canQueue(m));
          if ((queued[id] ?? 0) < count && m && g.recipeUnlockStatus(id).unlocked && g.has(recipeInputs(r)))
            if (act('other', 4, () => g.produce(id, m.id))) queued[id] = (queued[id] ?? 0) + 1;
        }
        for (const f of catalog.farm) {
          const key = cropItemKey(f),
            excess = g.quantity(key) - (g.state.husbandry!.burgerCollected ? 0 : (reserveStock[key] ?? 0));
          if (excess > 0) act('other', 5, () => g.sellItem(key, excess));
        }
        const candidates = catalog.farm.filter(f => g.cropUnlockStatus(f.id).unlocked && f.duration <= away);
        const awayCrop = (
          candidates.length ? candidates : catalog.farm.filter(f => g.cropUnlockStatus(f.id).unlocked)
        ).sort(
          (a, b) =>
            g.item(cropItemKey(b))!.sellPrice * b.yields[0] -
            b.price -
            (g.item(cropItemKey(a))!.sellPrice * a.yields[0] - a.price)
        )[0];
        // An active grinder can repeat wheat within a long session, then plant for the absence.
        const crop =
          strategy === 'active-wheat' && (next <= end || g.farm(1)!.duration + 2 + fields.length <= end - g.state.time)
            ? g.farm(1)!
            : awayCrop;
        for (let i = 0; i < fields.length; i++) {
          const p = fields[i];
          if (!p.unlocked || p.crop !== null) continue;
          const special = i < gateSeeds.length && !gatePlanted.has(i) && g.cropUnlockStatus(gateSeeds[i]).unlocked;
          const seed = g.farm(special ? gateSeeds[i] : crop.id)!;
          if (g.state.coins >= seed.price && act('plant', 2, () => g.plant(p.id, seed.id)) && special)
            gatePlanted.add(i);
        }
        const buffer = fields.filter(p => p.unlocked).length * crop.price;
        for (const p of fields.filter(p => !p.unlocked)) {
          const offer = g.fieldUnlockOffer(p.id);
          if (offer.unlocked && offer.price !== null && g.state.coins >= offer.price + buffer)
            act('purchase', 3, () => g.improve(p.id));
        }
        for (const type of g.machineTypes) {
          const offer = g.machineConstructionOffer(type.id);
          if (offer.count === 0 && offer.unlocked && offer.price !== null && g.state.coins >= offer.price + buffer)
            act('purchase', 4, () => g.buyMachine(type.id, offer.buildingId!));
        }
        for (const type of catalog.livestock!) {
          const offer = g.penConstructionOffer(type.key);
          if (offer.count === 0 && offer.unlocked && offer.price !== null && g.state.coins >= offer.price + buffer)
            act('purchase', 4, () => g.buyPen(offer.plotId!));
        }
        if (events.allTypes !== undefined) {
          for (const type of catalog.livestock!) {
            const offer = g.penConstructionOffer(type.key);
            if (offer.unlocked && offer.price !== null && g.state.coins >= offer.price + buffer)
              act('purchase', 4, () => g.buyPen(offer.plotId!));
          }
          for (const type of g.machineTypes) {
            const offer = g.machineConstructionOffer(type.id);
            if (offer.unlocked && offer.price !== null && g.state.coins >= offer.price + buffer)
              act('purchase', 4, () => g.buyMachine(type.id));
          }
        }
        if (events.allBuildings !== undefined)
          for (const p of g.state.plots.filter(p => p.residents)) {
            const type = catalog.livestock!.find(t => t.key === p.residents!.species)!;
            if (
              p.residents!.animals.length < p.residents!.capacity &&
              g.animalPurchasingReady &&
              g.state.coins >= type.price + buffer
            )
              act('purchase', 2, () => g.buyAnimal(p.id));
            const price = g.penExpansionPrice(p.id);
            if (
              price !== null &&
              g.penSlotUnlockStatus(p.id, p.residents!.capacity).unlocked &&
              g.state.coins >= price + buffer
            )
              act('purchase', 2, () => g.expandPen(p.id));
          }
        if (events.allAnimals !== undefined)
          for (const m of g.state.machines)
            if (
              m.capacity < g.queueCapacityLimit(m.type) &&
              g.queueSlotUnlockStatus(m.id, m.capacity).unlocked &&
              g.state.coins >= g.queueSlotPrice(m.id, m.capacity) + buffer
            )
              act('purchase', 2, () => g.expandQueue(m.id));
        if (actions === before) {
          const ready = [
            ...fields.filter(p => p.crop !== null).map(p => p.ready),
            ...g.state.machines.filter(m => m.job).map(m => m.job!.ready),
            ...g.state.plots.flatMap(p => p.residents?.animals.filter(a => a.job).map(a => a.job!.ready) ?? []),
          ].filter(t => t > g.state.time);
          const to = Math.min(end, ...ready);
          activeSeconds += to - g.state.time;
          g.tick(to - g.state.time);
        }
      }
      g.validate();
    }
  assert.equal(g.state.coins, initialCoins + g.state.earned - spending - seedCosts);
  // Never spends diamonds; every new level pays its configured reward once.
  assert.equal(
    g.state.diamonds,
    initialGems + (catalog.economy?.experience.levelUpDiamonds ?? 0) * (g.progress.level - 1)
  );
  return {
    visits,
    minutesPerVisit,
    fit,
    strategy,
    completed: events.maxed !== undefined,
    events,
    actions,
    activeHours: +(activeSeconds / 3600).toFixed(2),
    finalLevel: g.progress.level,
    finalCoins: g.state.coins,
    spending,
    seedCosts,
    recipesMade: queued,
  };
}
const output =
  process.env.REAL_TIME_SIM_OUTPUT ??
  process.env.TOWN_HUSBANDRY_SIM_OUTPUT ??
  path.join(__dirname, '../artifacts/real-time-economy/simulation.json');
const runs = [
  run([7, 15, 23], 10),
  run([7, 19], 15),
  run([7, 11, 15, 19, 23], 12),
  run([7, 15, 23], 10, 'visit-window'),
  run([7, 19], 15, 'visit-window'),
  run([7, 11, 15, 19, 23], 12, 'visit-window'),
];
const stressRuns = [run([8], 480, 'visit-window', 'active-wheat'), run([0], 1440, 'visit-window', 'active-wheat')];
const report = {
  testedAt: new Date().toISOString(),
  rulesVersion: catalog.rulesVersion,
  method:
    'Deterministic scheduled operator using the current FarmGame, authored fields, configured capacities and fresh configured wallet/stock. All waits are real seconds, including between sessions; no XP/items/currency grants, no gems. Keeps seed capital; selects the most profitable unlocked crop fitting the next absence. Arrival policy makes every crop ready before returning; visit-window policy also permits ripening during the next visit. Stress cases repeat wheat during 8-hour and 24-hour sessions. Minimal feed/burger route opens species, then purchases houses and slots; extra animals remain idle. The feed/burger route remains a fixed strategy; custom recipe/gate/feed changes may require a different operator. This probe models unlimited offline progress and does not forecast capped/disabled offline settings. Action costs are assumed, not measured; these sampled strategies and login schedules are not a retention forecast or a guarantee that faster strategies do not exist.',
  runs,
  stressRuns,
};
fs.mkdirSync(path.dirname(output), { recursive: true });
fs.writeFileSync(output, JSON.stringify(report, null, 2) + '\n');
console.log(JSON.stringify(report, null, 2));
