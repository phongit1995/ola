'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, tap, observe, build } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/loading-screen');
const asset = relative => JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets', relative + '.meta'), 'utf8')).uuid;
const indexUuid = asset('resources/ported/asset-index.json');
const skinUuid = asset('farm/bundles/farm-town-ui/manifest.json');
const farmUuid = asset('farm/scenes/Farm.scene');
const loadingUuid = asset('farm/scenes/Loading.scene');
const index = JSON.parse(fs.readFileSync(path.resolve(__dirname, '../assets/resources/ported/asset-index.json'), 'utf8'));
const audioSource = 'assets/audio/Thua.wav';
const audioUuid = asset('resources/' + index[audioSource] + '.wav');
const total = Object.keys(index).length;
const matches = (url, uuid, extension) => url.includes(uuid) && new URL(url).pathname.endsWith(extension);

function builtFarmRequest() {
  // Creator may pack the scene with other assets; its real request then uses the pack's ID.
  const config = JSON.parse(fs.readFileSync(path.join(build, 'assets/main/config.json'), 'utf8'));
  const uuid = reference => typeof reference === 'number' ? config.uuids[reference] : reference;
  const scene = uuid(config.scenes['db://assets/farm/scenes/Farm.scene']);
  assert.ok(scene, 'the tested main bundle must contain the authored Farm.scene');
  const pack = Object.entries(config.packs ?? {}).find(([, members]) => members.some(member => uuid(member) === scene))?.[0];
  return { id: pack ?? scene, packed: !!pack };
}

function gate() {
  let release, arrived;
  const released = new Promise(resolve => { release = resolve; });
  const requested = new Promise(resolve => { arrived = resolve; });
  return { released, requested, release, arrived };
}
async function within(promise, message, timeout = 120000) {
  let timer;
  try { return await Promise.race([promise, new Promise((_, reject) => { timer = setTimeout(() => reject(Error(message)), timeout); })]); }
  finally { clearTimeout(timer); }
}
async function failureEvidence(page, name, error, pending) {
  console.error(`FAIL ${name}: ${error.stack ?? error}`);
  const diagnostic = await within(page.evaluate(() => {
    const cc = globalThis.testCc, scene = cc?.director.getScene();
    const canvas = scene?.getChildByName('LoadingCanvas'), controller = canvas?.getComponent('LoadingSceneController');
    const app = scene?.getChildByName('Canvas')?.getComponent('GameApp');
    return { scene: scene?.name, children: scene?.children.map(node => ({ name: node.name, active: node.active, valid: node.isValid })),
      controllerValid: controller?.isValid, labels: controller?.screen.node.getComponentsInChildren(cc.Label).map(label => ({ name: label.node.name, text: label.string })),
      initialized: app?.initialized, session: !!app?.session, opacity: app?.root?.getComponent(cc.UIOpacity)?.opacity,
      panel: app?.panels?.view, transitions: globalThis.loadingTransitions, writes: globalThis.loadingSaveWrites?.length,
      gamePaused: cc?.game.isPaused(), directorPaused: cc?.director.isPaused(), documentHidden: document.hidden };
  }), 'The page did not answer the bounded diagnostic', 5000).catch(diagnosticError => ({ diagnosticError: diagnosticError.message }));
  const evidence = { error: error.stack ?? String(error), diagnostic, pending: [...pending] };
  console.error(`DIAGNOSTIC ${name}: ${JSON.stringify(evidence)}`);
  fs.writeFileSync(path.join(out, `failure-${name}.json`), JSON.stringify(evidence, null, 2));
}
async function closeContext(context) {
  await within(context.close(), 'Browser context cleanup exceeded 10 seconds', 10000);
}
async function attach(page, gatePackedPreload = false) {
  await page.evaluate(async gatePackedPreload => {
    globalThis.testCc = await System.import('cc');
    const cc = testCc, scene = cc.director.getScene();
    globalThis.testLoadingController = scene.getChildByName('LoadingCanvas')?.getComponent('LoadingSceneController');
    if (!testLoadingController) throw Error('Expected the authored Loading.scene and LoadingSceneController before Art loads');
    globalThis.testArt = testLoadingController.art;
    if (gatePackedPreload) {
      // A shared pack can arrive for town artwork before Farm is preloaded. Let its bytes flow,
      // then hold the real preload invocation so the same loading/handoff assertions stay observable.
      let release;
      const released = new Promise(resolve => { release = resolve; });
      globalThis.testFarmPreloadGate = { calls: 0, release };
      const preload = cc.director.preloadScene;
      cc.director.preloadScene = function (...args) {
        if (args[0] !== 'Farm') return preload.apply(this, args);
        if (!testArt.townUi || !testArt.plotUi || !testArt.islandUi)
          throw Error('Farm.scene preload was requested before required Art stages finished');
        globalThis.testFarmPreloadGate.calls++;
        released.then(() => preload.apply(this, args));
      };
    }
    globalThis.loadingTransitions = [];
    // Observe Cocos' real handoff after persistent roots move, before GameApp.onLoad runs.
    cc.director.on(cc.Director.EVENT_BEFORE_SCENE_LAUNCH, incoming => {
      const canvas = incoming.getChildByName('LoadingCanvas');
      const controller = canvas?.getComponent('LoadingSceneController');
      globalThis.loadingTransitions.push({ event: 'before', scene: incoming.name,
        loadingCanvas: !!canvas, loadingActive: canvas?.active, screenActive: controller?.screen.node.active,
        persistent: !!canvas && cc.director.isPersistRootNode(canvas), writes: globalThis.loadingSaveWrites.length });
    });
    cc.director.on(cc.Director.EVENT_AFTER_SCENE_LAUNCH, incoming => {
      const app = incoming.getChildByName('Canvas')?.getComponent('GameApp');
      globalThis.loadingTransitions.push({ event: 'after', scene: incoming.name, initialized: !!app?.initialized,
        sharedArt: app?.art === globalThis.testArt, writes: globalThis.loadingSaveWrites.length });
    });
  }, gatePackedPreload);
}
async function inspect(page) {
  return page.evaluate(() => {
    const cc = testCc, scene = cc.director.getScene(), canvas = scene.getChildByName('LoadingCanvas');
    const controller = canvas?.getComponent('LoadingSceneController'), loading = controller?.screen?.node;
    const app = scene.getChildByName('Canvas')?.getComponent('GameApp');
    const art = globalThis.testArt;
    const rect = node => { const r = node.getComponent(cc.UITransform).getBoundingBoxToWorld(); return { x: r.x, y: r.y, width: r.width, height: r.height }; };
    const labels = loading?.getComponentsInChildren(cc.Label) ?? [];
    const renderers = loading ? [...loading.getComponentsInChildren(cc.Sprite), ...loading.getComponentsInChildren(cc.Graphics)] : [];
    const entries = Object.keys(art.index);
    const loaded = entries.filter(source => source.endsWith('.png') ? art.textures.has(source) : source.endsWith('.wav') ? art.audio.has(source) : source.endsWith('.ttf') ? !!art.font : false);
    return {
      scene: scene.name, loadingCanvas: !!canvas, gameApp: !!app, farmCanvas: !!scene.getChildByName('Canvas'),
      loading: !!loading?.activeInHierarchy, initialized: !!app?.initialized, session: !!app?.session, debug: !!globalThis.farmCocos,
      rootOpacity: app ? app.root.getComponent(cc.UIOpacity)?.opacity ?? 255 : null,
      rootActive: app?.root.activeInHierarchy ?? false,
      blocker: !!loading?.getComponent(cc.BlockInputEvents)?.enabledInHierarchy,
      canvas: rect(canvas ?? app.node), cover: loading ? rect(loading) : null,
      graphics: loading?.getComponentsInChildren(cc.Graphics).length ?? 0,
      sprites: loading?.getComponentsInChildren(cc.Sprite).length ?? 0,
      opaque: renderers.filter(renderer => renderer.enabledInHierarchy && (renderer.color?.a ?? renderer.fillColor?.a) === 255).map(renderer => ({ name: renderer.node.name, ...rect(renderer.node) })),
      labels: Object.fromEntries(labels.map(label => [label.node.name, label.string])),
      portedTotal: entries.length, portedLoaded: loaded.length, missingPorted: entries.filter(source => !loaded.includes(source)),
      skins: { town: !!art.townUi, plot: !!art.plotUi, island: !!art.islandUi },
      frame: { width: cc.view.getFrameSize().width, height: cc.view.getFrameSize().height },
      writes: globalThis.loadingSaveWrites.slice(), selected: app?.selected ?? null, controls: app?.ui.controls.size ?? 0,
      sharedArt: !!app && app.art === art, transitions: globalThis.loadingTransitions.slice(),
      farmPreloadCalls: globalThis.testFarmPreloadGate?.calls ?? null,
    };
  });
}
function covers(outer, inner) {
  return outer.x <= inner.x + 1 && outer.y <= inner.y + 1 && outer.x + outer.width >= inner.x + inner.width - 1 && outer.y + outer.height >= inner.y + inner.height - 1;
}
function covered(snapshot) {
  assert.equal(snapshot.loading, true, 'the standalone loading screen is visible');
  assert.equal(snapshot.scene, 'Loading', 'assets load in the real Loading.scene');
  assert.equal(snapshot.loadingCanvas, true);
  assert.equal(snapshot.gameApp, false, 'Farm and GameApp do not exist during loading or preloading');
  assert.equal(snapshot.farmCanvas, false);
  assert.equal(snapshot.initialized, false);
  assert.equal(snapshot.session, false, 'no session exists before every Art stage succeeds');
  assert.equal(snapshot.debug, false);
  assert.equal(snapshot.rootActive, false, 'gameplay has not been instantiated');
  assert.equal(snapshot.blocker, true);
  assert.equal(snapshot.graphics, 0, 'the native loading scene uses editable sprites without runtime Graphics drawing');
  assert.ok(snapshot.sprites > 0);
  assert.ok(covers(snapshot.cover, snapshot.canvas), 'input cover fills the canvas');
  assert.ok(snapshot.opaque.some(renderer => covers(renderer, snapshot.canvas)), 'an opaque background fills the canvas');
  assert.equal(snapshot.labels.Title, 'Ola Farm');
  assert.ok(snapshot.labels.Status?.trim());
  assert.deepEqual(snapshot.writes, [], 'loading cannot write or replace a farm save');
}
async function inputWhileCovered(page) {
  const canvas = await page.locator('#GameCanvas').boundingBox();
  for (const [x, y] of [[.5, .5], [.1, .9], [.9, .1]]) await page.touchscreen.tap(canvas.x + canvas.width * x, canvas.y + canvas.height * y);
  await page.mouse.move(canvas.x + canvas.width * .3, canvas.y + canvas.height * .6);
  await page.mouse.down();
  await page.mouse.move(canvas.x + canvas.width * .7, canvas.y + canvas.height * .4, { steps: 5 });
  await page.mouse.up();
  await page.mouse.wheel(0, 250);
  await page.keyboard.press('Escape');
  await page.keyboard.press('Space');
  const after = await inspect(page);
  covered(after);
  assert.equal(after.selected, null);
  assert.equal(after.controls, 0);
}
async function sizing(page, external, width, height) {
  if (external && await page.locator('#view-select').count()) {
    await page.locator('#view-select').click();
    await page.locator('[data-device="FullScreen"]').click();
  }
  await page.waitForFunction(({ width, height }) => testCc.view.getFrameSize().width === width && testCc.view.getFrameSize().height === height, { width, height }, { timeout: 15000 });
  await page.waitForTimeout(100);
}
async function contextFor(browser, width, height) {
  const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
  // Observe real writes while forwarding the original Storage implementation unchanged.
  await context.addInitScript(() => {
    globalThis.loadingSaveWrites = [];
    const original = Storage.prototype.setItem;
    Storage.prototype.setItem = function (key, value) {
      if (this === localStorage && /^(?:ola|happy)-farm-cocos/.test(String(key))) globalThis.loadingSaveWrites.push({ key, value });
      return original.call(this, key, value);
    };
  });
  return context;
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  assert.equal(total, 201, 'the counter represents the actual legacy asset index');
  const external = process.env.COCOS_TEST_URL;
  const farmRequest = external ? { id: farmUuid, packed: false } : builtFarmRequest();
  const onlyError = process.env.COCOS_LOADING_CASE === 'error';
  const onlyDirectFarm = process.env.COCOS_LOADING_CASE === 'direct-farm';
  const viewport = process.env.COCOS_UI_VIEWPORT;
  assert.ok(!process.env.COCOS_LOADING_CASE || onlyError || onlyDirectFarm, 'COCOS_LOADING_CASE accepts error or direct-farm; omit it to run every case');
  assert.ok(!viewport || ['393x585', '1280x720'].includes(viewport), 'COCOS_UI_VIEWPORT accepts 393x585 or 1280x720; omit it to run both viewports');
  assert.ok(!viewport || (!onlyError && !onlyDirectFarm), 'COCOS_UI_VIEWPORT cannot be combined with COCOS_LOADING_CASE');
  assert.ok(!onlyDirectFarm || external, 'COCOS_LOADING_CASE=direct-farm requires COCOS_TEST_URL pointing to the Creator preview');
  const server = external ? { url: external, close: async () => {} } : await serve();
  try {
    // Creator's supported scene query opens the authored scene without changing its data or the user's Editor tab.
    const entry = new URL(server.url);
    if (external) entry.searchParams.set('scene', loadingUuid);
    const browser = await launch(), results = [];
    const reportName = onlyError ? 'error-results.json' : onlyDirectFarm ? 'direct-farm-results.json' : viewport ? `results-${viewport}.json` : 'results.json';
    const saveResults = () => fs.writeFileSync(path.join(out, reportName), JSON.stringify(results, null, 2));
    try {
      const sizes = (onlyError || onlyDirectFarm ? [] : [[393, 585], [1280, 720]]).filter(([width, height]) => !viewport || viewport === `${width}x${height}`);
      for (const [width, height] of sizes) {
        const context = await contextFor(browser, width, height), page = await context.newPage(), events = observe(page);
        const pending = new Set();
        page.on('request', request => pending.add(request.url()));
        page.on('requestfinished', request => pending.delete(request.url()));
        page.on('requestfailed', request => pending.delete(request.url()));
        let rejectStartup;
        const startupError = new Promise((_, reject) => { rejectStartup = reject; });
        startupError.catch(() => {});
        page.on('pageerror', error => { console.error(`PAGEERROR ${width}x${height}: ${error.message}`); rejectStartup(error); });
        page.on('console', message => {
          if (message.type() === 'error') { console.error(`CONSOLE ${width}x${height}: ${message.text()}`); rejectStartup(Error(message.text())); }
        });
        const early = gate(), middle = gate(), skin = gate(), farm = gate();
        const requests = []; let enteredLoading = false;
        try {
          await page.route('**/*', async route => {
            const url = route.request().url();
            if (farmRequest.packed && matches(url, farmRequest.id, '.json')) {
              requests.push(url);
              await route.continue();
              return;
            }
            const hold = matches(url, indexUuid, '.json') ? early : matches(url, audioUuid, '.wav') ? middle : matches(url, skinUuid, '.json') ? skin : matches(url, farmRequest.id, '.json') ? farm : null;
            if (hold === early) enteredLoading = true;
            if (hold === farm && !enteredLoading) rejectStartup(Error('Farm.scene was requested before Loading.scene initialized; refresh the configured entry scene'));
            if (hold) { console.log(`GATE ${width}x${height}: ${url}`); requests.push(url); hold.arrived(url); await hold.released; }
            await route.continue();
          });
          await page.goto(entry.href);
          console.log(`NAVIGATED ${width}x${height}`);
          await within(Promise.race([early.requested, startupError]), 'No asset-index request; the tested build must use current source asset UUIDs');
          console.log(`INDEX ${width}x${height}: attaching and sizing`);
          await attach(page, farmRequest.packed); await sizing(page, external, width, height);
          const start = await inspect(page); covered(start);
          console.log(`INITIAL ${width}x${height}: covered`);
          assert.equal(start.portedTotal, 0);
          await inputWhileCovered(page);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `initial-${width}x${height}.png`) });
          const resized = width < 600 ? { width: height, height: width } : { width: 1024, height: 768 };
          await page.setViewportSize(resized); await sizing(page, false, resized.width, resized.height);
          const rotated = await inspect(page); covered(rotated);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `resized-${width}x${height}.png`) });
          await page.setViewportSize({ width, height }); await sizing(page, false, width, height);
          early.release();

          await within(Promise.race([middle.requested, startupError]), 'No native ported audio request reached the midpoint gate');
          await page.waitForFunction(total => {
            const node = testLoadingController.screen.node, label = node?.getComponentsInChildren(testCc.Label).find(label => label.node.name === 'ProgressText');
            const match = label?.string.replace(/\s/g, '').match(/(\d+)\/(\d+)/);
            return match && Number(match[1]) === total - 1 && Number(match[2]) === total;
          }, total, { timeout: 120000 });
          const during = await inspect(page); covered(during);
          assert.equal(during.portedLoaded, total - 1);
          assert.deepEqual(during.missingPorted, [audioSource]);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `ported-${width}x${height}.png`) });
          middle.release();

          await within(Promise.race([skin.requested, startupError]), 'No skin manifest request followed the completed ported index');
          const finishing = await inspect(page); covered(finishing);
          assert.equal(finishing.portedTotal, total); assert.equal(finishing.portedLoaded, total);
          assert.equal(finishing.skins.town, false);
          assert.notEqual(finishing.labels.Status, during.labels.Status, 'the phase advances beyond loading the numbered asset list');
          assert.equal(finishing.labels.ProgressText, '', 'skin loading uses its real stage rather than a completed asset counter');
          await inputWhileCovered(page);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `all-ported-still-loading-${width}x${height}.png`) });
          skin.release();
          const farmPreload = farmRequest.packed
            ? page.waitForFunction(() => globalThis.testFarmPreloadGate.calls > 0, undefined, { timeout: 120000 })
            : farm.requested;
          await within(Promise.race([farmPreload, startupError]), 'Art must finish before the real Farm.scene preload request');
          const preloading = await inspect(page); covered(preloading);
          assert.equal(preloading.portedLoaded, total);
          assert.deepEqual(preloading.skins, { town: true, plot: true, island: true });
          assert.equal(preloading.transitions.length, 0, 'Farm has not launched during its preload');
          await inputWhileCovered(page);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `preloading-farm-${width}x${height}.png`) });
          if (farmRequest.packed) await page.evaluate(() => globalThis.testFarmPreloadGate.release());
          else farm.release();
          console.log(`FARM RELEASED ${width}x${height}: waiting for the ready scene`);
          await page.waitForFunction(() => {
            const scene = testCc.director.getScene(), app = scene?.getChildByName('Canvas')?.getComponent('GameApp');
            return scene?.name === 'Farm' && globalThis.farmCocos && app?.initialized && !scene.getChildByName('LoadingCanvas');
          }, undefined, { timeout: 120000 });
          console.log(`FARM READY ${width}x${height}`);
          await page.evaluate(() => { globalThis.testApp = testCc.director.getScene().getChildByName('Canvas').getComponent('GameApp'); });
          const ready = await inspect(page);
          console.log(`READY INSPECTED ${width}x${height}: verifying handoff and input`);
          assert.equal(ready.scene, 'Farm'); assert.equal(ready.loadingCanvas, false); assert.equal(ready.gameApp, true);
          assert.equal(ready.rootOpacity, 255); assert.equal(ready.session, true); assert.equal(ready.loading, false);
          assert.equal(ready.sharedArt, true, 'Farm uses the same Art instance prepared in Loading.scene');
          assert.deepEqual(ready.skins, { town: true, plot: true, island: true });
          const handoff = ready.transitions.filter(transition => transition.scene === 'Farm');
          assert.equal(handoff.length, 2);
          assert.deepEqual(handoff[0], { event: 'before', scene: 'Farm', loadingCanvas: true, loadingActive: true, screenActive: true, persistent: true, writes: 0 }, 'the real persistent LoadingCanvas covers the handoff before GameApp boots');
          assert.equal(handoff[1].event, 'after'); assert.equal(handoff[1].initialized, true); assert.equal(handoff[1].sharedArt, true);
          if (farmRequest.packed) assert.equal(ready.farmPreloadCalls, 1, 'Loading forwards exactly one real Farm preload');
          for (const [uuid, extension] of [[indexUuid, '.json'], [audioUuid, '.wav'], [skinUuid, '.json'], [farmRequest.id, '.json']]) {
            assert.equal(requests.filter(url => matches(url, uuid, extension)).length, 1, 'Loading to Farm does not download or initialize the same gated asset again');
          }
          assert.ok(ready.writes.length > 0, 'the completed boot persists its fresh session');
          assert.equal(await page.evaluate(() => testApp.panels.view), 'welcome');
          await tap(page, 'welcome-start', true);
          console.log(`WELCOME CLOSED ${width}x${height}`);
          assert.equal(await page.evaluate(() => testApp.panels.view), '', 'real gameplay input works after the cover is removed');
          assert.equal(await page.evaluate(() => testApp.game.state.guideDismissed), true);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, `ready-${width}x${height}.png`) });
          assert.deepEqual(events.errors, []);
          results.push({ width, height, requests, start, rotated, during, finishing, preloading, ready, passed: true });
          saveResults();
          console.log(`PASS ${width}x${height}: real Loading.scene, native screen, resize/input, 200/201, skins, Farm preload and persistent handoff`);
        } catch (error) { await failureEvidence(page, `${width}x${height}`, error, pending); throw error; }
        finally {
          early.release(); middle.release(); skin.release(); farm.release();
          if (farmRequest.packed) await page.evaluate(() => globalThis.testFarmPreloadGate?.release()).catch(() => {});
          console.log(`CLOSING ${width}x${height}`); await closeContext(context);
        }
      }

      if (!onlyDirectFarm) {
        const context = await contextFor(browser, 393, 585), page = await context.newPage(), events = observe(page);
        const pageErrors = [];
        page.on('pageerror', error => { pageErrors.push(error.message); console.error(`ERROR CASE PAGEERROR: ${error.message}`); });
        const failureStarted = gate();
        let failedRequests = 0, failedUrl = '';
        try {
          await page.route('**/*', async route => {
            if (matches(route.request().url(), skinUuid, '.json')) { failedUrl = route.request().url(); console.log('FAILING real skin manifest: ' + failedUrl); failedRequests++; failureStarted.arrived(failedUrl); await route.abort('failed'); }
            else await route.continue();
          });
          await page.goto(entry.href);
          await within(failureStarted.requested, 'The real skin asset request must start before observing its failure');
          await attach(page); await sizing(page, external, 393, 585);
          await page.waitForFunction(() => {
            const loading = testLoadingController.screen.node;
            return loading?.getComponentsInChildren(testCc.Label).some(label => /không|lỗi|thử lại/i.test(label.string));
          }, undefined, { timeout: 120000 });
          const failure = await inspect(page); covered(failure);
          assert.ok(failedRequests > 0, 'a real required skin asset request failed');
          assert.equal(failure.portedLoaded, total);
          assert.equal(failure.skins.town, false);
          await inputWhileCovered(page);
          await page.waitForTimeout(300);
          covered(await inspect(page));
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, 'error-393x585.png') });
          assert.deepEqual(pageErrors, [], 'the handled asset failure must not cause an uncaught runtime error');
          const expectedDownloadError = message => {
            // Creator also logs console.error(error.message, error); both URLs must be the deliberate failure.
            const match = message.match(/^Error: download failed: (.+), status: 0\(error\)(?:\r?\n|$)/)
              ?? message.match(/^download failed: (.+), status: 0\(error\) Error: download failed: \1, status: 0\(error\)(?:\r?\n|$)/);
            return !!match && new URL(match[1], entry).href === failedUrl;
          };
          assert.ok(events.errors.some(expectedDownloadError), 'the deliberately failed manifest is reported instead of booting incomplete art');
          assert.deepEqual(events.errors.filter(message => message !== 'Failed to load resource: net::ERR_FAILED' && !expectedDownloadError(message)), [], 'only the deliberate asset failure may be logged');
          results.push({ errorCase: true, failedRequests, failure, errors: events.errors, passed: true });
          saveResults();
          console.log('PASS error: failed real skin manifest keeps gameplay covered and writes no save');
        } catch (error) { await failureEvidence(page, 'error', error, []); throw error; }
        finally { await closeContext(context); }
      }

      if (external && !onlyError) {
        const context = await contextFor(browser, 393, 585), page = await context.newPage(), events = observe(page);
        const direct = new URL(server.url); direct.searchParams.set('scene', farmUuid);
        const initialFarm = gate(), redirected = gate(); let indexRequests = 0;
        let rejectStartup;
        const startupError = new Promise((_, reject) => { rejectStartup = reject; }); startupError.catch(() => {});
        page.on('pageerror', error => { console.error('DIRECT FARM PAGEERROR: ' + error.message); rejectStartup(error); });
        page.on('console', message => { if (message.type() === 'error') { console.error('DIRECT FARM CONSOLE: ' + message.text()); rejectStartup(Error(message.text())); } });
        try {
          await page.route('**/*', async route => {
            const url = route.request().url();
            if (new URL(url).pathname === '/scene/' + farmUuid + '.json') {
              initialFarm.arrived(url); await initialFarm.released;
            } else if (matches(url, indexUuid, '.json')) {
              indexRequests++; redirected.arrived(url); await redirected.released;
            }
            await route.continue();
          });
          await page.goto(direct.href);
          await within(Promise.race([initialFarm.requested, startupError]), 'Direct Farm preview must request the authored Farm scene');
          await page.evaluate(async () => {
            const cc = await System.import('cc'); globalThis.directFarmScenes = [];
            cc.director.on(cc.Director.EVENT_AFTER_SCENE_LAUNCH, scene => globalThis.directFarmScenes.push(scene.name));
          });
          initialFarm.release();
          await within(Promise.race([redirected.requested, startupError]), 'Direct Farm play must redirect to Loading before Art initialization');
          await attach(page); await sizing(page, external, 393, 585);
          const redirectedLoading = await inspect(page); covered(redirectedLoading);
          assert.deepEqual(await page.evaluate(() => globalThis.directFarmScenes), ['Farm', 'Loading']);
          await page.locator('#GameCanvas').screenshot({ path: path.join(out, 'direct-farm-redirect-393x585.png') });
          redirected.release();
          await page.waitForFunction(() => {
            const scene = testCc.director.getScene(), app = scene?.getChildByName('Canvas')?.getComponent('GameApp');
            return scene?.name === 'Farm' && app?.initialized && globalThis.farmCocos && !scene.getChildByName('LoadingCanvas');
          }, undefined, { timeout: 120000 });
          const ready = await inspect(page), scenes = await page.evaluate(() => globalThis.directFarmScenes);
          assert.deepEqual(scenes, ['Farm', 'Loading', 'Farm']);
          assert.equal(ready.sharedArt, true); assert.equal(ready.session, true); assert.equal(ready.loadingCanvas, false);
          assert.equal(indexRequests, 1, 'the direct-Farm fallback prepares Art once after redirecting');
          assert.deepEqual(events.errors, []);
          results.push({ directFarm: true, scenes, indexRequests, redirectedLoading, ready, passed: true });
          saveResults();
          console.log('PASS direct Farm preview: Farm -> Loading -> Farm, no early session/save and one shared Art load');
        } catch (error) { await failureEvidence(page, 'direct-farm', error, []); throw error; }
        finally { initialFarm.release(); redirected.release(); await closeContext(context); }
      }
    } finally {
      try { saveResults(); }
      finally { await within(browser.close(), 'Browser cleanup exceeded 10 seconds', 10000); }
    }
  } finally { await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
