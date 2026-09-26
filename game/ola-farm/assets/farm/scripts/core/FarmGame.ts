import { TownUnlock as TownUnlocks } from './enums/TownUnlock';
import { PlotGroup as PlotGroups } from './enums/PlotGroup';
import { legacyMachineTypes } from './legacy/LegacyMachineCatalog';
import { QUEUE_PRICES, TRAY_CAPACITY } from './constants/ProductionDefaults';
import { PEN_CAPACITY_LIMIT, PEN_CAPACITY_PRICES, PEN_SLOT_LEVELS, penNames } from './constants/HusbandryDefaults';
import { COIN_PACKS } from './constants/WalletDefaults';
import { BUILDINGS_PER_TYPE } from './constants/BuildingLimits';
import type { ActionResult } from './types/ActionTypes';
import type { FarmCatalog } from './types/CatalogTypes';
import type { FarmItem, Plot } from './types/PlotTypes';
import type { FarmState } from './types/StateTypes';
import type { Recipe, Machine } from './types/ProductionTypes';
import type { ItemAmount } from './types/ItemTypes';
import type { TownUnlock, UnlockStatus, ConstructionOffer } from './types/ConstructionTypes';
import type { BuildXP } from './types/EconomyTypes';
import {
  cropItemKey,
  recipeInputs,
  recipeOutputs,
  stockCatalog,
  machineSites,
  machineGameplay,
  penPlotId,
  penBuildingId,
  penDefinition,
} from './FarmCatalog';
import { progression } from './Progression';
import { boostGems } from './FarmTiming';
import { cropSnapshot, productionSnapshot, loadFarmState } from './FarmMigration';
import { assertFarmState } from './FarmValidation';
import type { BuildingPosition } from './types/BuildingTypes';
import { assertBuildingLayout, canMoveBuilding, movedLayout, purchaseBuildingLayout } from './BuildingPlacement';

const clone = <T>(v: T): T => JSON.parse(JSON.stringify(v));
const failure = (error: string): ActionResult => ({ error });

/** Shared farm, factory and livestock domain. All quantities use a single item-key inventory. */
export class FarmGame {
  state: FarmState;
  readonly items;
  readonly machineTypes;
  constructor(
    readonly catalog: FarmCatalog,
    saved: unknown = null
  ) {
    this.items = stockCatalog(catalog);
    this.machineTypes = catalog.machineTypes ?? legacyMachineTypes;
    this.state = loadFarmState(catalog, saved);
    this.validate();
    this.advanceMachines(this.state.time);
  }
  get simple(): boolean {
    return this.catalog.contentProfile === 'simple-1';
  }
  get progress() {
    return progression(this.state.xp, this.catalog.economy?.experience.curve);
  }
  get coinPacks() {
    return this.catalog.economy?.coinPacks ?? COIN_PACKS;
  }
  get animalPurchasingReady(): boolean {
    return this.catalog.gameplay?.requireFeedMill === false || this.state.machines.some(m => m.type === 5);
  }
  penLimit(species: string): number {
    return this.catalog.gameplay?.animals[species]?.maxPens ?? BUILDINGS_PER_TYPE;
  }
  penCapacityLimit(species: string): number {
    return this.catalog.gameplay?.animals[species]?.maxCapacity ?? PEN_CAPACITY_LIMIT;
  }
  startingAnimals(species: string): number {
    return this.catalog.gameplay?.animals[species]?.startingAnimals ?? 1;
  }
  feedPerAnimal(species: string): number {
    return this.catalog.gameplay?.animals[species]?.feedPerAnimal ?? 1;
  }
  private machineConfig(type: number) {
    return machineGameplay(this.catalog, type);
  }
  machineLimit(type: number): number {
    return this.machineConfig(type)?.maxBuildings ?? BUILDINGS_PER_TYPE;
  }
  queueCapacityLimit(type: number): number {
    return this.machineConfig(type)?.maxQueueCapacity ?? 5;
  }
  trayCapacity(type: number): number {
    return this.machineConfig(type)?.trayCapacity ?? TRAY_CAPACITY;
  }
  isActivePlot(p: Plot): boolean {
    return !this.simple || p.group === PlotGroups.Crop || !!penDefinition(this.catalog, p);
  }
  private unlockStatus(unlock?: TownUnlock): UnlockStatus {
    const p = this.state.husbandry;
    if (!unlock) return { unlocked: true, reason: '' };
    const gate = this.catalog.gameplay?.gates[unlock];
    if (gate) {
      const legacy: Record<string, boolean> = {
        'farm40:chicken-feed|farm40:cow-feed': !!p?.feedReceived,
        'farm40:egg': !!p?.eggsCollected,
        'raw:7': !!p?.milkCollected,
        'town:burger': !!p?.burgerCollected,
      };
      const met = gate.requirements.map(
        r =>
          r.items.reduce((sum, key) => sum + (this.state.produced[key] ?? 0), 0) >= r.quantity ||
          (r.quantity === 1 && !!legacy[[...r.items].sort().join('|')])
      );
      const unlocked = !met.length || (gate.mode === 'all' ? met.every(Boolean) : met.some(Boolean));
      const missing = gate.requirements.filter((_, i) => !met[i]).map(r => `${r.label} ×${r.quantity}`);
      return { unlocked, reason: unlocked ? '' : 'Cần ' + missing.join(gate.mode === 'all' ? ', ' : ' hoặc ') + '.' };
    }
    if (unlock === TownUnlocks.Crafts)
      return {
        unlocked: !!p?.burgerCollected,
        reason: p?.burgerCollected ? '' : 'Nhận burger đầu tiên để mở cừu và bàn đan.',
      };
    const missing = [
      !p?.feedReceived && 'nhận cám',
      !p?.eggsCollected && 'thu trứng',
      !p?.milkCollected && 'thu sữa',
    ].filter(Boolean);
    return {
      unlocked: missing.length === 0,
      reason: missing.length ? 'Mở heo: ' + missing.join(', ') + ' lần đầu.' : '',
    };
  }
  penUnlockStatus(id: number): UnlockStatus {
    const plot = this.state.plots.find(p => p.id === id),
      pen = penDefinition(this.catalog, plot);
    if (!pen) return { unlocked: false, reason: 'Vị trí này chưa có chuồng.' };
    if (plot?.residents) return { unlocked: true, reason: '' };
    const limit = this.penLimit(pen.species);
    if (
      (pen.ordinal ?? 1) > limit ||
      this.state.plots.filter(p => p.residents?.species === pen.species).length >= limit
    )
      return { unlocked: false, reason: `Đã đủ ${limit} nhà` };
    const access = this.unlockStatus(pen.unlock);
    if (!access.unlocked) return access;
    const earlier = this.catalog.residentPens!.filter(
      site => site.species === pen.species && (site.ordinal ?? 1) < (pen.ordinal ?? 1)
    );
    if (earlier.some(site => !this.state.plots.find(p => p.id === penPlotId(site))?.residents))
      return { unlocked: false, reason: 'Xây nhà trước đó trước.' };
    const required = pen.requiredLevel ?? 1;
    return this.progress.level >= required
      ? { unlocked: true, reason: '' }
      : { unlocked: false, reason: `Cần level ${required}` };
  }
  penName(id: number): string {
    const site = penDefinition(this.catalog, { id });
    return site ? `${penNames[site.species] ?? site.species} ${site.ordinal ?? 1}` : 'Chuồng vật nuôi';
  }
  machineName(machine: Machine): string {
    const type = this.machineTypes.find(t => t.id === machine.type);
    return `${type?.name ?? 'Nhà máy'} ${Math.max(0, type ? machineSites(type).indexOf(machine.buildingId!) : 0) + 1}`;
  }
  penConstructionOffer(species: string): ConstructionOffer {
    const sites = (this.catalog.residentPens ?? [])
      .filter(site => site.species === species)
      .sort((a, b) => (a.ordinal ?? 1) - (b.ordinal ?? 1));
    const count = sites.filter(site => this.state.plots.find(p => p.id === penPlotId(site))?.residents).length;
    const next = sites.find(site => !this.state.plots.find(p => p.id === penPlotId(site))?.residents);
    const limit = this.penLimit(species);
    const base = {
      count,
      limit,
      requiredLevel: next?.requiredLevel ?? 1,
      price: next ? this.penPurchasePrice(penPlotId(next)) : null,
      buildingId: next ? penBuildingId(next) : null,
      plotId: next ? penPlotId(next) : undefined,
    };
    if (count >= limit || !next) return { ...base, unlocked: false, reason: `Đã đủ ${limit} nhà` };
    const access = this.penUnlockStatus(penPlotId(next));
    return {
      ...base,
      ...(access.unlocked && !this.animalPurchasingReady ? { unlocked: false, reason: 'Cần máy thức ăn.' } : access),
    };
  }
  machineConstructionOffer(type: number): ConstructionOffer {
    const definition = this.machineTypes.find(t => t.id === type),
      count = this.state.machines.filter(m => m.type === type).length;
    const site = definition?.buildSites?.[count],
      price = site ? site.price : (definition?.purchasePrices?.[count] ?? null);
    const buildingId =
      site?.buildingId ??
      (definition
        ? (machineSites(definition).find(id => !this.state.machines.some(m => m.buildingId === id)) ?? null)
        : null);
    const limit = this.machineLimit(type);
    const base = { count, limit, requiredLevel: site?.requiredLevel ?? 1, price, buildingId };
    if ((this.simple && count >= limit) || price === null || !buildingId)
      return {
        ...base,
        unlocked: false,
        reason: count >= limit ? `Đã đủ ${limit} nhà` : 'Không còn vị trí mua máy này.',
      };
    const access = this.machineUnlockStatus(type);
    if (!access.unlocked) return { ...base, ...access };
    return {
      ...base,
      ...(this.progress.level < base.requiredLevel
        ? { unlocked: false, reason: `Cần level ${base.requiredLevel}` }
        : { unlocked: true, reason: '' }),
    };
  }
  recipeUnlockStatus(id: number): UnlockStatus {
    const recipe = this.product(id);
    if (!recipe) return { unlocked: false, reason: 'Công thức không hợp lệ.' };
    const level = recipe.requiredLevel ?? 1;
    if (this.progress.level < level) return { unlocked: false, reason: `Cần level ${level}` };
    return this.unlockStatus(recipe.unlock);
  }
  machineUnlockStatus(type: number): UnlockStatus {
    const machine = this.machineTypes.find(m => m.id === type);
    return machine ? this.unlockStatus(machine.unlock) : { unlocked: false, reason: 'Máy không hợp lệ.' };
  }
  private recordCollected(outputs: ItemAmount[]): void {
    const p = this.state.husbandry;
    for (const o of outputs) {
      this.state.produced[o.key] = (this.state.produced[o.key] ?? 0) + o.quantity;
      if (o.key === 'farm40:tortilla') this.state.guide.collectedTortilla = true;
      if (!p) continue;
      if (o.key === 'farm40:chicken-feed' || o.key === 'farm40:cow-feed') p.feedReceived = true;
      if (o.key === 'farm40:egg') p.eggsCollected = true;
      if (o.key === 'raw:7') p.milkCollected = true;
      if (o.key === 'town:burger') p.burgerCollected = true;
    }
  }
  private canRecordCollected(outputs: ItemAmount[], xp: number): boolean {
    return (
      Number.isFinite(this.state.xp + xp) &&
      outputs.every(o => Number.isSafeInteger((this.state.produced[o.key] ?? 0) + o.quantity))
    );
  }
  dismissGuide(): ActionResult {
    this.state.guideDismissed = true;
    return { message: 'Vào Shop xây máy thức ăn và chuồng gà, rồi trồng lúa mì/ngô để làm cám nhé!' };
  }
  validate(): void {
    assertFarmState(this.state, this.catalog);
  }
  moveBuilding(id: string, position: BuildingPosition): ActionResult {
    if (!canMoveBuilding(this.state, id)) return failure('Chọn công trình đã xây để di chuyển.');
    try {
      const layout = movedLayout(this.state.buildingLayout!, id, position);
      assertBuildingLayout(layout, this.state);
      this.state.buildingLayout = layout;
      return { message: 'Đã lưu vị trí công trình.' };
    } catch (e) {
      return failure((e as Error).message);
    }
  }
  farm(id: number): FarmItem | undefined {
    return this.catalog.farm.find(f => f.id === id);
  }
  cropUnlockStatus(id: number): UnlockStatus & { requiredLevel: number } {
    const crop = this.farm(id),
      requiredLevel = crop?.requiredLevel ?? 1;
    if (!crop) return { unlocked: false, requiredLevel, reason: 'Giống không hợp lệ.' };
    const unlocked = this.progress.level >= requiredLevel;
    return { unlocked, requiredLevel, reason: unlocked ? '' : `Cần level ${requiredLevel}` };
  }
  product(id: number): Recipe | undefined {
    return this.catalog.products.find(p => p.id === id);
  }
  item(key: string) {
    return this.items.find(i => i.key === key);
  }
  quantity(key: string): number {
    return this.state.inventory[key] ?? 0;
  }
  stock(tab: 'raw' | 'goods') {
    return this.items.filter(i => i.tab === tab);
  }
  has(inputs: ItemAmount[]): boolean {
    return inputs.every(i => this.quantity(i.key) >= i.quantity);
  }
  private canAdd(outputs: ItemAmount[]): boolean {
    return outputs.every(i => Number.isSafeInteger(this.quantity(i.key) + i.quantity));
  }
  private add(outputs: ItemAmount[]): void {
    for (const i of outputs) this.state.inventory[i.key] = this.quantity(i.key) + i.quantity;
  }
  private take(inputs: ItemAmount[]): void {
    for (const i of inputs) this.state.inventory[i.key] = this.quantity(i.key) - i.quantity;
  }
  private allocate(): number {
    if (this.state.nextId >= Number.MAX_SAFE_INTEGER) throw Error('Đã đạt giới hạn ID.');
    return this.state.nextId++;
  }
  isReady(p: Plot): boolean {
    return p.crop !== null && p.ready <= this.state.time;
  }
  growthStage(p: Plot): number {
    return p.crop === null
      ? 0
      : this.isReady(p)
        ? 3
        : this.state.time - p.started >=
            (p.snapshot?.duration ?? this.farm(p.crop)!.duration) * (this.catalog.gameplay?.growthStageFraction ?? 0.5)
          ? 2
          : 1;
  }
  plant(id: number, crop: number): ActionResult {
    return this.plantCrop(id, crop, false);
  }
  private plantCrop(id: number, crop: number, rescue: boolean): ActionResult {
    const p = this.state.plots.find(p => p.id === id),
      f = this.farm(crop);
    if (
      !p ||
      !this.isActivePlot(p) ||
      !p.unlocked ||
      !f ||
      p.crop !== null ||
      p.residents !== null ||
      p.group !== f.group
    )
      return failure('Chọn ô trống đúng loại: ruộng, chuồng hoặc ao.');
    const access = this.cropUnlockStatus(crop);
    if (!access.unlocked) return failure(access.reason);
    const snap = cropSnapshot(this.catalog, crop, p.level, rescue);
    if (this.state.coins < snap.paidCoins) return failure('Chưa đủ xu. Bán nông sản trong kho để có thêm vốn.');
    const key = cropItemKey(f),
      planted = (this.state.planted[key] ?? 0) + 1;
    const xp = rescue ? 0 : (this.catalog.plantingXP ?? 2);
    if (!Number.isSafeInteger(planted) || !Number.isFinite(this.state.xp + xp))
      return failure('Thống kê đã đạt giới hạn.');
    this.state.coins -= snap.paidCoins;
    Object.assign(p, {
      crop,
      started: this.state.time,
      ready: this.state.time + snap.duration,
      boosted: false,
      snapshot: snap,
    });
    this.state.planted[key] = planted;
    const levelUp = this.gainXP(xp);
    if (f.id > 9) this.state.guide.plantedNew = true;
    return {
      message:
        (rescue
          ? 'Đã gieo lúa hỗ trợ. Chờ thu rồi bán để có vốn.'
          : (f.group === PlotGroups.Crop ? 'Đã gieo ' : 'Đã nuôi ') + f.name.toLowerCase()) + levelUp,
      plot: p,
    };
  }
  canRescue(): boolean {
    if (this.catalog.gameplay?.rescueEnabled === false) return false;
    const s = this.state,
      cheapest = Math.min(
        ...this.catalog.farm
          .filter(f => f.group === PlotGroups.Crop && this.cropUnlockStatus(f.id).unlocked)
          .map(f => f.price)
      );
    return (
      s.coins < cheapest &&
      Object.values(s.inventory).every(n => n === 0) &&
      !s.plots.some(p => p.crop !== null || p.residents?.animals.some(a => a.job !== null)) &&
      !s.machines.some(m => m.job || m.waiting.length || m.tray.length) &&
      s.plots.some(p => p.group === PlotGroups.Crop && p.unlocked && p.crop === null)
    );
  }
  rescue(): ActionResult {
    if (!this.canRescue()) return failure('Hãy bán hàng trong kho hoặc nhận sản phẩm đang chờ trước.');
    return this.plantCrop(
      this.state.plots.find(p => p.group === PlotGroups.Crop && p.unlocked && p.crop === null)!.id,
      1,
      true
    );
  }
  /** Diamonds to ripen a crop now, priced by the timing.json tier that covers its remaining time. */
  boostPrice(p: Plot): number {
    if (p.crop === null || this.isReady(p)) return 0;
    return boostGems(this.catalog, p.ready - this.state.time);
  }
  boost(id: number): ActionResult {
    const p = this.state.plots.find(p => p.id === id);
    if (!p?.crop || this.isReady(p)) return failure('Ô này không cần làm chín nhanh.');
    const price = this.boostPrice(p);
    if (this.state.diamonds < price) return failure(`Cần ${price} kim cương.`);
    this.state.diamonds -= price;
    p.ready = this.state.time;
    p.boosted = true;
    return { message: `Xong ngay · −${price} kim cương`, plot: p };
  }
  cancel(id: number): ActionResult {
    const p = this.state.plots.find(p => p.id === id);
    if (!p?.crop || this.isReady(p)) return failure('Chọn cây hoặc vật nuôi đang lớn để hủy.');
    const refund = p.snapshot!.refundCoins;
    this.state.coins += refund;
    Object.assign(p, { crop: null, started: 0, ready: 0, boosted: false, snapshot: null });
    return { message: `Đã hủy · hoàn ${refund} xu`, coins: refund, plot: p };
  }
  improve(id: number): ActionResult {
    if (this.simple) {
      const p = this.state.plots.find(p => p.id === id),
        offer = this.fieldUnlockOffer(id);
      if (!offer.unlocked || offer.price === null || !p) return failure(offer.reason);
      if (this.state.coins < offer.price) return failure(`Cần ${offer.price} xu để mở ô đất.`);
      this.state.coins -= offer.price;
      p.unlocked = true;
      return { message: `Đã mở ô đất · −${offer.price} xu${this.gainBuildXP('field')}`, plot: p };
    }
    const p = this.state.plots.find(p => p.id === id);
    if (!p || p.unlocked) return failure('Ô này đã được cải tạo.');
    if (this.state.diamonds < 1) return failure('Cần 1 kim cương.');
    this.state.diamonds--;
    p.unlocked = true;
    return { message: 'Đã cải tạo ô · −1 kim cương', plot: p };
  }
  nextLockedCrop(): Plot | undefined {
    return orderedCrops(this.state.plots).find(plot => !plot.unlocked);
  }
  fieldUnlockOffer(id: number): UnlockStatus & { price: number | null; requiredLevel: number } {
    const p = this.state.plots.find(p => p.id === id),
      config = this.catalog.economy?.fields[id];
    const base = { price: config?.unlockPrice ?? null, requiredLevel: config?.requiredLevel ?? 1 };
    if (!p || p.group !== 'crop' || !config)
      return { ...base, unlocked: false, reason: 'Ô đất không nằm trong cấu hình hiện tại.' };
    if (p.unlocked) return { ...base, unlocked: false, reason: 'Ô đất đã mở.' };
    if (this.nextLockedCrop()?.id !== id) return { ...base, unlocked: false, reason: 'Mở ô đất trước đó trước.' };
    const unlocked = this.progress.level >= base.requiredLevel;
    return { ...base, unlocked, reason: unlocked ? '' : `Cần level ${base.requiredLevel}` };
  }
  harvest(id: number): ActionResult {
    const p = this.state.plots.find(p => p.id === id);
    if (!p || !this.isReady(p)) return failure('Nông sản vẫn đang lớn.');
    const f = this.farm(p.crop!)!,
      snap = p.snapshot!;
    if (!this.canAdd([snap.output])) return failure('Số lượng trong kho đã đạt giới hạn.');
    if (
      !Number.isFinite(this.state.harvested + snap.output.quantity) ||
      !this.canRecordCollected([snap.output], snap.harvestXP)
    )
      return failure('Thống kê đã đạt giới hạn.');
    this.add([snap.output]);
    this.state.harvested += snap.output.quantity;
    const levelUp = this.gainXP(snap.harvestXP);
    this.recordCollected([snap.output]);
    if (f.id > 9) this.state.guide.harvestedNew = true;
    Object.assign(p, { crop: null, boosted: false, ready: 0, started: 0, snapshot: null });
    return {
      message: `+${snap.output.quantity} ${f.name.toLowerCase()}${levelUp}`,
      amount: snap.output.quantity,
      item: f,
      plot: p,
    };
  }
  canQueue(m: Machine): boolean {
    return m.waiting.length + (m.job ? 1 : 0) < m.capacity;
  }
  produce(id: number, machineId?: number): ActionResult {
    const r = this.product(id),
      s = this.state;
    if (!r) return failure('Công thức không hợp lệ.');
    const access = this.recipeUnlockStatus(id);
    if (!access.unlocked) return failure(access.reason);
    const m =
      machineId === undefined
        ? s.machines.find(m => m.type === r.machine && this.canQueue(m))
        : s.machines.find(m => m.id === machineId && m.type === r.machine);
    if (!m || !this.canQueue(m)) return failure('Máy đã đầy hàng đợi. Nhận hàng hoặc mở thêm ô.');
    const inputs = recipeInputs(r);
    if (!this.has(inputs)) return failure('Chưa đủ nguyên liệu. Thu hoạch hoặc chế biến thêm nhé!');
    const job = productionSnapshot(this.catalog, id, this.allocate(), s.time);
    this.take(inputs);
    m.waiting.push(job);
    this.startNext(m, s.time);
    if (recipeOutputs(r).some(o => o.key === 'farm40:tortilla')) s.guide.cookedTortilla = true;
    return { message: 'Đã xếp ' + r.name.toLowerCase(), machine: m };
  }
  private startNext(m: Machine, time: number): void {
    if (m.job || m.tray.length >= this.trayCapacity(m.type) || !m.waiting.length) return;
    m.job = m.waiting.shift()!;
    m.job.started = time;
    m.job.ready = time + m.job.duration;
  }
  private advanceMachines(now: number): void {
    for (const m of this.state.machines) {
      this.startNext(m, now);
      while (m.job && m.job.ready <= now && m.tray.length < this.trayCapacity(m.type)) {
        const j = m.job,
          finished = j.ready;
        m.tray.push({ id: j.id, product: j.product, outputs: j.outputs, xp: j.xp });
        m.job = null;
        this.startNext(m, finished);
      }
    }
  }
  collect(id: number, batchId?: number): ActionResult {
    const m = this.state.machines.find(m => m.id === id),
      batch = m?.tray.find(b => batchId === undefined || b.id === batchId);
    if (!m || !batch) return failure('Chưa có sản phẩm trong khay nhận.');
    if (!this.canAdd(batch.outputs)) return failure('Số lượng trong kho đã đạt giới hạn.');
    if (!this.canRecordCollected(batch.outputs, batch.xp)) return failure('Thống kê đã đạt giới hạn.');
    this.add(batch.outputs);
    const levelUp = this.gainXP(batch.xp);
    this.recordCollected(batch.outputs);
    m.tray.splice(m.tray.indexOf(batch), 1);
    this.startNext(m, this.state.time);
    return {
      message: batch.outputs.map(o => `+${o.quantity} ${this.item(o.key)!.name.toLowerCase()}`).join(', ') + levelUp,
      machine: m,
    };
  }
  /** One transaction for the selected machine's existing tray, never its running/waiting jobs. */
  collectAll(id: number): ActionResult {
    const m = this.state.machines.find(m => m.id === id);
    if (!m?.tray.length) return failure('Chưa có sản phẩm trong khay nhận.');
    const totals: Record<string, number> = {};
    for (const batch of m.tray) for (const o of batch.outputs) totals[o.key] = (totals[o.key] ?? 0) + o.quantity;
    const outputs = Object.entries(totals).map(([key, quantity]) => ({ key, quantity }));
    if (!this.canAdd(outputs)) return failure('Số lượng trong kho đã đạt giới hạn.');
    const count = m.tray.length,
      xp = m.tray.reduce((sum, b) => sum + b.xp, 0);
    if (!this.canRecordCollected(outputs, xp)) return failure('Thống kê đã đạt giới hạn.');
    this.add(outputs);
    const levelUp = this.gainXP(xp);
    this.recordCollected(outputs);
    m.tray = [];
    this.startNext(m, this.state.time);
    return {
      message:
        `Đã nhận ${count} mẻ · ` +
        outputs.map(o => `+${o.quantity} ${this.item(o.key)!.name.toLowerCase()}`).join(', ') +
        levelUp,
      amount: count,
      machine: m,
    };
  }
  /** Diamonds to finish a machine's running job now; waiting jobs keep their place in the queue. */
  machineBoostPrice(id: number): number {
    const job = this.state.machines.find(m => m.id === id)?.job;
    return job && job.ready > this.state.time ? boostGems(this.catalog, job.ready - this.state.time) : 0;
  }
  boostMachine(id: number): ActionResult {
    const m = this.state.machines.find(m => m.id === id),
      price = this.machineBoostPrice(id);
    if (!m?.job || !price) return failure('Máy không có món đang làm để làm xong ngay.');
    if (this.state.diamonds < price) return failure(`Cần ${price} kim cương.`);
    this.state.diamonds -= price;
    m.job.ready = this.state.time;
    this.advanceMachines(this.state.time);
    return { message: `Xong ngay · −${price} kim cương`, machine: m };
  }
  cancelQueued(id: number, jobId: number): ActionResult {
    const m = this.state.machines.find(m => m.id === id),
      job = m?.waiting.find(j => j.id === jobId);
    if (!m || !job) return failure('Chỉ hủy được việc chưa bắt đầu.');
    if (!this.canAdd(job.inputs)) return failure('Kho không đủ chỗ hoàn nguyên liệu.');
    this.add(job.inputs);
    m.waiting.splice(m.waiting.indexOf(job), 1);
    return { message: 'Đã hủy việc chờ và hoàn đủ nguyên liệu.', machine: m };
  }
  expandQueue(id: number): ActionResult {
    const m = this.state.machines.find(m => m.id === id);
    if (!m || m.capacity >= this.queueCapacityLimit(m.type)) return failure('Máy đã đạt sức chứa tối đa.');
    const access = this.queueSlotUnlockStatus(id, m.capacity);
    if (!access.unlocked) return failure(access.reason);
    const price = this.queueSlotPrice(id, m.capacity);
    if (this.state.coins < price) return failure(`Cần ${price} xu để mở ô.`);
    this.state.coins -= price;
    m.capacity++;
    return { message: `Đã mở ô thứ ${m.capacity} · −${price} xu${this.gainBuildXP('queueSlot')}`, machine: m };
  }
  queueSlotPrice(id: number, slot: number): number {
    const machine = this.state.machines.find(m => m.id === id),
      type = this.machineTypes.find(t => t.id === machine?.type);
    return (type && this.catalog.economy?.machines[type.key].queueSlots[slot - 1]?.price) ?? QUEUE_PRICES[slot] ?? 0;
  }
  queueSlotUnlockStatus(id: number, slot: number): UnlockStatus & { requiredLevel: number } {
    const machine = this.state.machines.find(m => m.id === id),
      type = this.machineTypes.find(t => t.id === machine?.type);
    if (
      !machine ||
      !type ||
      !Number.isInteger(slot) ||
      slot < 0 ||
      slot >= Math.max(machine.capacity, this.queueCapacityLimit(machine.type))
    )
      return { unlocked: false, requiredLevel: 0, reason: 'Ô máy không hợp lệ.' };
    const requiredLevel = this.catalog.economy?.machines[type.key].queueSlots[slot - 1]?.requiredLevel ?? 1;
    const unlocked = slot < machine.capacity || this.progress.level >= requiredLevel;
    return { unlocked, requiredLevel, reason: unlocked ? '' : `Cần level ${requiredLevel}` };
  }
  machinePurchasePrice(type: number): number | null {
    return this.machineConstructionOffer(type).price;
  }
  buyMachine(type: number, expectedBuildingId?: string): ActionResult {
    const access = this.machineConstructionOffer(type);
    if (!access.unlocked) return failure(access.reason);
    const price = access.price;
    const definition = this.machineTypes.find(t => t.id === type);
    if (price === null || !definition) return failure('Không còn vị trí mua máy này.');
    if (this.state.coins < price) return failure(`Cần ${price} xu để mua máy.`);
    const id = Math.max(-1, ...this.state.machines.map(m => m.id)) + 1;
    const buildingId = access.buildingId;
    if (expectedBuildingId !== undefined && expectedBuildingId !== buildingId)
      return failure('Nhà này đã được xây hoặc chưa đến lượt xây.');
    if (!buildingId || !Number.isSafeInteger(id)) return failure('Không còn vị trí hợp lệ.');
    const layout = this.simple ? purchaseBuildingLayout(this.state, buildingId) : this.state.buildingLayout;
    if (this.simple && !layout) return failure('Chưa có chỗ trống để xây máy. Di chuyển công trình rồi thử lại.');
    const m: Machine = {
      id,
      type,
      capacity: this.machineConfig(type)?.startingCapacity ?? 1,
      job: null,
      waiting: [],
      tray: [],
      buildingId,
    };
    if (layout) this.state.buildingLayout = layout;
    this.state.coins -= price;
    this.state.machines.push(m);
    return {
      message: `Đã mua ${definition.name.toLowerCase()} · −${price} xu${this.gainBuildXP('machine')}`,
      machine: m,
    };
  }
  /** Trade diamonds for a fixed coin pack; no XP, and `earned` stays a sales figure. */
  buyCoins(pack: number): ActionResult {
    const p = this.coinPacks[pack];
    if (!p) return failure('Gói xu không hợp lệ.');
    if (this.state.diamonds < p.diamonds) return failure(`Cần ${p.diamonds} kim cương.`);
    this.state.diamonds -= p.diamonds;
    this.state.coins += p.coins;
    return { message: `+${p.coins.toLocaleString('en-US')} xu · −${p.diamonds} kim cương`, coins: p.coins };
  }
  sellItem(key: string, quantity = 1): ActionResult {
    const item = this.item(key),
      s = this.state;
    if (!item || !Number.isSafeInteger(quantity) || quantity <= 0 || this.quantity(key) < quantity)
      return failure('Không đủ sản phẩm trong kho.');
    const coins = item.sellPrice * quantity;
    if (!Number.isFinite(s.coins + coins) || !Number.isFinite(s.earned + coins)) return failure('Số dư đạt giới hạn.');
    // Lifetime revenue carries fractional XP across sales, so splitting a sale cannot award extra XP.
    const unit = this.catalog.saleXpCoins ?? 10;
    const xp = Math.floor((s.earned + coins) / unit) - Math.floor(s.earned / unit);
    if (
      !Number.isFinite(s.xp + xp) ||
      !Number.isFinite(s.sold + quantity) ||
      (item.tab === 'goods' && !Number.isSafeInteger((s.soldProducts[key] ?? 0) + quantity))
    )
      return failure('Thống kê đã đạt giới hạn.');
    s.inventory[key] -= quantity;
    s.coins += coins;
    s.earned += coins;
    const levelUp = this.gainXP(xp);
    s.sold += quantity;
    if (item.tab === 'goods') s.soldProducts[key] = (s.soldProducts[key] ?? 0) + quantity;
    if (key === 'farm40:tortilla') s.guide.soldTortilla = true;
    return { message: `Đã bán ${quantity} ${item.name.toLowerCase()} · +${coins} xu${levelUp}`, coins };
  }
  setPenSpecies(id: number, species: string | null): ActionResult {
    if (this.simple) return failure('Mỗi chuồng giữ loài vật nuôi riêng.');
    const p = this.state.plots.find(p => p.id === id),
      type = this.catalog.livestock?.find(a => a.key === species);
    if (!p || p.group !== 'pen' || !p.unlocked || p.crop !== null || p.residents?.animals.length)
      return failure('Chuồng phải trống, không còn lứa hoặc con vật.');
    if (species !== null && !type) return failure('Loài vật nuôi không hợp lệ.');
    p.residents = species === null ? null : { species, capacity: 1, animals: [] };
    return {
      message: species === null ? 'Đã chọn nuôi theo lứa.' : 'Đã chuẩn bị chuồng. Mua con rồi cho ăn.',
      plot: p,
    };
  }
  residentPlot(id: number): Plot | undefined {
    return this.state.plots.find(p => p.id === id && this.isActivePlot(p));
  }
  penPurchasePrice(id: number): number | null {
    const p = this.residentPlot(id),
      definition = penDefinition(this.catalog, p);
    const type = this.catalog.livestock?.find(a => a.key === definition?.species);
    return p && !p.unlocked && !p.residents && definition?.purchasePrice !== undefined && type
      ? definition.purchasePrice + this.startingAnimals(type.key) * type.price
      : null;
  }
  buyPen(id: number): ActionResult {
    const p = this.residentPlot(id),
      price = this.penPurchasePrice(id),
      access = this.penUnlockStatus(id);
    if (!p || price === null) return failure('Chuồng đã được xây hoặc vị trí không hợp lệ.');
    if (!access.unlocked) return failure(access.reason);
    if (!this.animalPurchasingReady) return failure('Mua máy thức ăn trước để có thể nuôi con vật.');
    if (this.state.coins < price) return failure(`Cần ${price} xu để xây chuồng.`);
    const definition = penDefinition(this.catalog, p)!;
    if (
      this.state.plots.filter(plot => plot.residents?.species === definition.species).length >=
      this.penLimit(definition.species)
    )
      return failure(`Đã đủ ${this.penLimit(definition.species)} nhà`);
    const layout = purchaseBuildingLayout(this.state, penBuildingId(definition));
    if (!layout) return failure('Chưa có chỗ trống để xây chuồng. Di chuyển công trình rồi thử lại.');
    const animals = Array.from({ length: this.startingAnimals(definition.species) }, (_, slot) => ({
      id: this.allocate(),
      slot,
      job: null,
    }));
    this.state.buildingLayout = layout;
    this.state.coins -= price;
    p.unlocked = true;
    p.residents = {
      species: definition.species,
      capacity: this.catalog.gameplay?.animals[definition.species].startingCapacity ?? 1,
      animals,
    };
    return { message: `Đã xây chuồng kèm ${animals.length} con · −${price} xu${this.gainBuildXP('pen')}`, plot: p };
  }
  buyAnimal(id: number, expectedSlot?: number): ActionResult {
    const p = this.residentPlot(id),
      pen = p?.residents,
      type = this.catalog.livestock?.find(a => a.key === pen?.species);
    if (!p || !pen || !type || pen.animals.length >= pen.capacity)
      return failure('Chuồng chưa sẵn sàng hoặc đã đủ con.');
    const slot =
      expectedSlot === undefined
        ? Array.from({ length: pen.capacity }, (_, slot) => slot).find(slot => !pen.animals.some(a => a.slot === slot))!
        : expectedSlot;
    if (!Number.isInteger(slot) || slot < 0 || slot >= pen.capacity || pen.animals.some(a => a.slot === slot))
      return failure('Chỗ này đã thay đổi. Chọn lại chỗ trống để mua con.');
    if (!this.animalPurchasingReady) return failure('Mua máy thức ăn trước để có thể nuôi con vật.');
    if (this.state.coins < type.price) return failure(`Cần ${type.price} xu để mua con.`);
    const animal = { id: this.allocate(), slot, job: null };
    this.state.coins -= type.price;
    pen.animals.push(animal);
    return { message: `Đã mua ${type.name.toLowerCase()} · −${type.price} xu`, plot: p };
  }
  penExpansionPrice(id: number): number | null {
    const pen = this.residentPlot(id)?.residents,
      type = this.catalog.livestock?.find(a => a.key === pen?.species);
    return pen && type && pen.capacity < this.penCapacityLimit(pen.species)
      ? this.penSlotPrice(id, pen.capacity)
      : null;
  }
  penSlotPrice(id: number, slot: number): number {
    const pen = this.residentPlot(id)?.residents,
      type = this.catalog.livestock?.find(t => t.key === pen?.species);
    if (!pen || !type || slot < 1 || slot >= Math.max(pen.capacity, this.penCapacityLimit(pen.species))) return 0;
    return (
      (this.catalog.economy?.animals[pen.species].slots[slot - 1]?.price ?? PEN_CAPACITY_PRICES[slot]) + type.price
    );
  }
  penSlotUnlockStatus(id: number, slot: number): UnlockStatus & { requiredLevel: number } {
    const pen = this.residentPlot(id)?.residents;
    if (
      !pen ||
      !Number.isInteger(slot) ||
      slot < 0 ||
      slot >= Math.max(pen.capacity, this.penCapacityLimit(pen.species))
    )
      return { unlocked: false, requiredLevel: 0, reason: 'Ô chuồng không hợp lệ.' };
    const requiredLevel =
      this.catalog.economy?.animals[pen.species].slots[slot - 1]?.requiredLevel ??
      (pen.species === 'layer' || pen.species === 'dairy-cow' ? PEN_SLOT_LEVELS[slot] : 1);
    // Already purchased slots remain available in older saves, even below the new level requirement.
    const unlocked = slot < pen.capacity || this.progress.level >= requiredLevel;
    return { unlocked, requiredLevel, reason: unlocked ? '' : `Cần level ${requiredLevel}` };
  }
  expandPen(id: number, expectedSlot?: number): ActionResult {
    const p = this.residentPlot(id),
      pen = p?.residents,
      price = this.penExpansionPrice(id);
    if (!p || !pen || price === null) return failure('Chuồng đã đạt sức chứa tối đa.');
    if (expectedSlot !== undefined && expectedSlot !== pen.capacity)
      return failure('Chỗ này đã được mở hoặc chưa đến lượt mở.');
    const access = this.penSlotUnlockStatus(id, pen.capacity);
    if (!access.unlocked) return failure(access.reason);
    if (!this.animalPurchasingReady) return failure('Mua máy thức ăn trước để có thể nuôi con vật.');
    if (this.state.coins < price) return failure(`Cần ${price} xu để mở chỗ và mua con.`);
    const animal = { id: this.allocate(), slot: pen.capacity, job: null };
    this.state.coins -= price;
    pen.capacity++;
    pen.animals.push(animal);
    return {
      message: `Đã mở chỗ ${pen.capacity} và mua thêm một con · −${price} xu${this.gainBuildXP('penSlot')}`,
      plot: p,
    };
  }
  sellAnimal(id: number, animalId: number): ActionResult {
    const p = this.residentPlot(id),
      pen = p?.residents,
      type = this.catalog.livestock?.find(t => t.key === pen?.species),
      animal = pen?.animals.find(a => a.id === animalId);
    if (!p || !pen || !type || !animal || animal.job)
      return failure('Chỉ bán con đang chờ ăn; nhận hết sản phẩm trước.');
    const coins = Math.floor(type.price * (this.catalog.economy?.refunds.animalSaleRate ?? 0.5));
    if (!Number.isFinite(this.state.coins + coins)) return failure('Số dư đã đạt giới hạn.');
    pen.animals.splice(pen.animals.indexOf(animal), 1);
    this.state.coins += coins;
    return { message: `Đã bán ${type.name.toLowerCase()} · +${coins} xu`, plot: p };
  }
  feedAnimals(id: number, animalId?: number): ActionResult {
    const p = this.residentPlot(id),
      pen = p?.residents,
      type = this.catalog.livestock?.find(a => a.key === pen?.species);
    const animals = pen?.animals.filter(a => a.job === null && (animalId === undefined || a.id === animalId)) ?? [];
    if (!p || !type || !animals.length) return failure('Không có con đang chờ ăn.');
    const feed = animals.length * this.feedPerAnimal(type.key);
    if (this.quantity(type.feed) < feed)
      return failure(`Thiếu thức ăn: cần ${feed} ${this.item(type.feed)!.name.toLowerCase()}.`);
    this.state.inventory[type.feed] -= feed;
    for (const a of animals)
      a.job = {
        started: this.state.time,
        ready: this.state.time + type.duration,
        output: { key: type.output, quantity: type.quantity },
        xp: type.xp ?? 3 * type.quantity,
      };
    return { message: `Đã cho ${animals.length} con ăn.`, plot: p };
  }
  /** Same finish-now price list as crops, from the selected animal's remaining time. */
  animalBoostPrice(id: number, animalId: number): number {
    const job = this.residentPlot(id)?.residents?.animals.find(a => a.id === animalId)?.job;
    return job && job.ready > this.state.time ? boostGems(this.catalog, job.ready - this.state.time) : 0;
  }
  boostAnimal(id: number, animalId: number): ActionResult {
    const p = this.residentPlot(id),
      animal = p?.residents?.animals.find(a => a.id === animalId);
    const price = this.animalBoostPrice(id, animalId);
    if (!p || !animal?.job || !price) return failure('Chỉ tăng tốc con đang chờ sản phẩm.');
    if (this.state.diamonds < price) return failure(`Cần ${price} kim cương để tăng tốc.`);
    this.state.diamonds -= price;
    animal.job.ready = this.state.time;
    return { message: `Sản phẩm sẵn sàng nhận · −${price} kim cương`, plot: p };
  }
  collectAnimals(id: number, animalId?: number): ActionResult {
    const p = this.residentPlot(id),
      animals =
        p?.residents?.animals.filter(
          a => a.job && a.job.ready <= this.state.time && (animalId === undefined || a.id === animalId)
        ) ?? [];
    if (!p || !animals.length) return failure('Vật nuôi chưa có sản phẩm sẵn nhận.');
    const totals: Record<string, number> = {};
    for (const a of animals) {
      const o = a.job!.output;
      totals[o.key] = (totals[o.key] ?? 0) + o.quantity;
    }
    const outputs = Object.entries(totals).map(([key, quantity]) => ({ key, quantity }));
    if (!this.canAdd(outputs)) return failure('Kho đã đạt giới hạn.');
    if (
      !this.canRecordCollected(
        outputs,
        animals.reduce((xp, a) => xp + a.job!.xp, 0)
      )
    )
      return failure('Thống kê đã đạt giới hạn.');
    if (!Number.isFinite(this.state.harvested + outputs.reduce((amount, o) => amount + o.quantity, 0)))
      return failure('Thống kê đã đạt giới hạn.');
    this.add(outputs);
    let amount = 0,
      xp = 0;
    for (const a of animals) {
      amount += a.job!.output.quantity;
      xp += a.job!.xp;
      a.job = null;
    }
    const levelUp = this.gainXP(xp);
    this.state.harvested += amount;
    this.recordCollected(outputs);
    return {
      message: outputs.map(o => `+${o.quantity} ${this.item(o.key)!.name.toLowerCase()}`).join(', ') + levelUp,
      amount,
      plot: p,
    };
  }
  /**
   * Adds earned XP and returns the level-up note for the result message. Each level pays its configured diamonds
   * once: levels already rewarded, or skipped by a later curve change without XP, pay nothing.
   */
  private gainXP(xp: number): string {
    const before = this.progress.level;
    this.state.xp += xp;
    const level = this.progress.level;
    if (level <= before) return '';
    const reward = this.catalog.economy?.experience.levelUpDiamonds ?? 0,
      paid = Math.max(this.state.rewardedLevel ?? 0, before);
    let gems = 0;
    if (reward > 0 && level > paid) {
      gems = (level - paid) * reward;
      this.state.diamonds += gems;
      this.state.rewardedLevel = level;
    }
    return ` · Lên level ${level}${gems ? ` · +${gems} kim cương` : ''}`;
  }
  /** One-time construction XP from `experience.buildXP`; buying back a sold animal is not construction. */
  private gainBuildXP(kind: keyof BuildXP): string {
    const xp = this.catalog.economy?.experience.buildXP[kind] ?? 0;
    return xp > 0 ? ` · +${xp} EXP${this.gainXP(xp)}` : '';
  }
  tick(seconds: number): void {
    if (!Number.isFinite(seconds) || seconds <= 0 || !Number.isFinite(this.state.time + seconds)) return;
    this.state.time += seconds;
    this.advanceMachines(this.state.time);
  }
}
export function orderedCrops(plots: Plot[]): Plot[] {
  return plots
    .filter(p => p.group === PlotGroups.Crop)
    .sort((a, b) => (a.cell === null ? 1000 : a.cell) - (b.cell === null ? 1000 : b.cell) || a.id - b.id);
}
