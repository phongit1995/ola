'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, observe, build } = require('./browser-support.cjs');
const out = process.env.COCOS_SHOP_PREFAB_OUT ? path.resolve(process.env.COCOS_SHOP_PREFAB_OUT)
  : path.resolve(__dirname, '../artifacts/golden-island-shop/standalone-prefabs');

function beforeLaunch(cc) {
  cc.director.once(cc.Director.EVENT_BEFORE_SCENE_LAUNCH, scene => {
    const canvas = scene.getChildByName('Canvas'), app = canvas.getComponent('GameApp');
    app.onLoad = () => {}; app.onDestroy = () => {};
    app.root.active = false;
    const source = app.shopPrefab, sourceView = source.data.getComponent('ShopView');
    const stage = new cc.Node('StandaloneShopAuthoring'); stage.layer = canvas.layer;
    stage.addComponent(cc.UITransform).setContentSize(1920, 1080);
    const shop = cc.instantiate(source), view = shop.getComponent('ShopView');
    const card = cc.instantiate(sourceView.cardPrefab); card.setPosition(0, 240);
    const proof = globalThis.authoredShop = { app, stage, shop, card, renderCalls: 0, cc,
      shopAsset: source._uuid, cardAsset: sourceView.cardPrefab._uuid };
    // The Editor preview must already contain its artwork; calling the gameplay render adapter is forbidden.
    view.render = () => { proof.renderCalls++; throw Error('Standalone Shop preview called the gameplay render adapter'); };
    card.getComponent('ShopCardView').render = () => { proof.renderCalls++; throw Error('Standalone ShopCard preview called the gameplay render adapter'); };
    stage.addChild(shop); stage.addChild(card); canvas.addChild(stage);
    const bounds = canvas.getComponent(cc.UITransform);
    const fit = Math.min(bounds.width / 1920, bounds.height / 1080);
    stage.setScale(fit, fit, 1);
  });
}

(async () => {
  fs.mkdirSync(out, { recursive: true });
  const server = await serve(); let browser;
  const report = { buildPath: build, testedAt: new Date().toISOString(), passed: false, cleanup: { serverClosed: false, browserClosed: false } };
  const save = () => fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(report, null, 2) + '\n');
  save();
  try {
    browser = await launch();
    const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } }), observed = observe(page);
    try {
      await page.route('**/application.js', async route => {
        const response = await route.fetch(), text = await response.text();
        assert.ok(text.includes('return cc.game.run();'), 'Creator launch hook is present');
        await route.fulfill({ response, body: text.replace('return cc.game.run();', `(${beforeLaunch.toString()})(cc); return cc.game.run();`) });
      });
      await page.goto(server.url);
      await page.waitForFunction(() => globalThis.authoredShop?.card.getComponentsInChildren(authoredShop.cc.Sprite)
        .filter(s => s.node.activeInHierarchy && s.spriteFrame).length > 30, undefined, { timeout: 60000 });
      await page.evaluate(async () => {
        const { cc } = authoredShop; cc.profiler.hideStats();
        // Active nodes can exist before the first submitted frame. Wait for actual draws before checking pixels.
        for (let i = 0; i < 3; i++) await new Promise(resolve => cc.director.once(cc.Director.EVENT_AFTER_DRAW, resolve));
      });
      const inspect = () => page.evaluate(() => {
        const { app, shop, card, cc, renderCalls, shopAsset, cardAsset } = authoredShop;
        const nodes = n => [n, ...n.children.flatMap(nodes)];
        const view = shop.getComponent('ShopView'), cardView = card.getComponent('ShopCardView'), model = cardView.model;
        const camera = app.node.getComponent(cc.Canvas).cameraComponent;
        const rect = n => {
          const box = n.getComponent(cc.UITransform).getBoundingBoxToWorld();
          const lower = camera.worldToScreen(new cc.Vec3(box.xMin, box.yMin, n.worldPosition.z));
          const upper = camera.worldToScreen(new cc.Vec3(box.xMax, box.yMax, n.worldPosition.z));
          const canvas = document.querySelector('#GameCanvas').getBoundingClientRect(), pixels = cc.view.getCanvasSize();
          return { x: canvas.x + lower.x / pixels.width * canvas.width, y: canvas.y + (1 - upper.y / pixels.height) * canvas.height,
            width: (upper.x - lower.x) / pixels.width * canvas.width, height: (upper.y - lower.y) / pixels.height * canvas.height };
        };
        return { initialized: app.initialized, storage: localStorage.length, gameplayApi: typeof globalThis.farmCocos,
          renderCalls, shopAsset, cardAsset, shopActive: shop.activeInHierarchy, cardActive: card.activeInHierarchy,
          staticNodes: nodes(shop).map(n => ({ name: n.name, id: n.uuid })),
          shopSprites: shop.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame).length,
          cardSprites: card.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame).length,
          yardSprites: model.getComponentsInChildren(cc.Sprite).filter(s => s.node.activeInHierarchy && s.spriteFrame).length,
          labels: card.getComponentsInChildren(cc.Label).filter(l => l.node.activeInHierarchy).map(l => ({ text: l.string, font: l.font?.name })),
          price: { text: cardView.priceLabel.string, fontSize: cardView.priceLabel.fontSize,
            coinVisible: cardView.coin.node.activeInHierarchy, coinUuid: cardView.coin.spriteFrame?._uuid },
          cardWidth: card.getComponent(cc.UITransform).width, cardHeight: card.getComponent(cc.UITransform).height,
          screenRects: { card: rect(card), yard: rect(model), title: rect(cardView.title.node), price: rect(cardView.priceButton),
            priceText: rect(cardView.priceLabel.node), coin: rect(cardView.coin.node), drawer: rect(view.drawer) },
          camera: { active: camera.enabledInHierarchy, visibility: camera.visibility, stageLayer: authoredShop.stage.layer,
            stageScale: authoredShop.stage.scale.x, canvas: { width: app.node.getComponent(cc.UITransform).width, height: app.node.getComponent(cc.UITransform).height } },
          scroll: { horizontal: view.scroll.horizontal, vertical: view.scroll.vertical, masked: !!view.scroll.content.parent.getComponent(cc.Mask) } };
      });
      report.preview = await inspect();
      assert.equal(report.preview.initialized, false); assert.equal(report.preview.storage, 0);
      assert.equal(report.preview.gameplayApi, 'undefined'); assert.equal(report.preview.renderCalls, 0);
      assert.equal(report.preview.shopActive, true); assert.equal(report.preview.cardActive, true);
      assert.ok(report.preview.shopSprites >= 5, 'Shop drawer has authored native artwork');
      assert.ok(report.preview.cardSprites > 30 && report.preview.yardSprites > 25, 'ShopCard displays the linked layered yard without gameplay');
      assert.ok(report.preview.labels.some(l => l.text === 'Chuồng gà'));
      assert.match(report.preview.price.text, /^\d+$/, 'Numeric price is readable before data binding');
      assert.equal(report.preview.price.coinVisible, true);
      assert.equal(report.preview.price.coinUuid, '944e84bc-66e4-4bde-b6ff-43975d0d8c07@f9941', 'Standalone card uses the actual HUD coin');
      assert.ok(report.preview.price.fontSize > 0 && report.preview.price.fontSize <= 16, 'Smaller price typography is authored in the prefab');
      assert.ok(report.preview.labels.every(l => /Poetsen/i.test(l.font)), 'Editor preview uses serialized fonts');
      assert.deepEqual(report.preview.scroll, { horizontal: true, vertical: false, masked: true });
      assert.ok(report.preview.cardWidth > 0 && report.preview.cardHeight > 0);
      for (const [name, rect] of Object.entries(report.preview.screenRects)) {
        assert.ok(name === 'coin' ? rect.width >= 16 && rect.height >= 16 : rect.width > 20 && rect.height > 10,
          name + ': rendered bounds have a useful nonzero area');
        assert.ok(rect.x >= -1 && rect.y >= -1 && rect.x + rect.width <= 1921 && rect.y + rect.height <= 1081,
          name + ': authored preview is actually inside the camera viewport');
      }
      const textRect = report.preview.screenRects.priceText, coinRect = report.preview.screenRects.coin;
      assert.ok(textRect.x + textRect.width <= coinRect.x + .5 || coinRect.x + coinRect.width <= textRect.x + .5
        || textRect.y + textRect.height <= coinRect.y + .5 || coinRect.y + coinRect.height <= textRect.y + .5,
        'Authored coin and numeric text remain separate before gameplay layout');
      const screenshot = await page.screenshot({ path: path.join(out, 'shop-and-card-without-gameplay.png') });
      // Decode the captured browser image, rather than inferring visibility from scene-tree state.
      report.pixels = await page.evaluate(async ({ png, regions }) => {
        const image = new Image(); image.src = 'data:image/png;base64,' + png; await image.decode();
        const canvas = document.createElement('canvas'); canvas.width = image.width; canvas.height = image.height;
        const ctx = canvas.getContext('2d'); ctx.drawImage(image, 0, 0);
        const results = {};
        for (const [name, region] of Object.entries(regions)) {
          const x = Math.max(0, Math.ceil(region.x)), y = Math.max(0, Math.ceil(region.y));
          const width = Math.min(image.width - x, Math.floor(region.width)), height = Math.min(image.height - y, Math.floor(region.height));
          const data = ctx.getImageData(x, y, width, height).data, colors = new Set();
          let painted = 0, ink = 0;
          for (let i = 0; i < data.length; i += 4) {
            const r = data[i], g = data[i + 1], b = data[i + 2];
            colors.add((r >> 4) * 256 + (g >> 4) * 16 + (b >> 4));
            if (Math.abs(r - 77) + Math.abs(g - 111) + Math.abs(b - 51) > 40) painted++;
            if (r > 80 && r > g * 1.2 && g < 145 && b < 130) ink++;
          }
          results[name] = { pixels: width * height, colorBins: colors.size, paintedRatio: painted / (width * height), inkRatio: ink / (width * height) };
        }
        return results;
      }, { png: screenshot.toString('base64'), regions: report.preview.screenRects });
      for (const [name, pixels] of Object.entries(report.pixels)) {
        assert.ok(pixels.colorBins >= (name === 'title' || name === 'priceText' ? 8 : 16), name + ': screenshot contains visible detailed artwork/text');
        assert.ok(pixels.paintedRatio > .25, name + ': screenshot is not the empty camera background');
      }
      assert.ok(report.pixels.title.inkRatio > .01, 'Authored card title is visibly drawn in its screenshot region');
      assert.ok(report.pixels.price.inkRatio > .01, 'Authored purchase label is visibly drawn in its screenshot region');
      assert.ok(report.pixels.priceText.inkRatio > .01, 'Numeric text itself is painted alongside the coin');
      await page.waitForTimeout(200); const after = await inspect();
      assert.deepEqual(after, report.preview, 'No gameplay render, save access, or authored node rebuild occurs while previewing');
      assert.deepEqual(observed.errors, []); report.errors = []; report.passed = true; save();
      console.log('Standalone Shop + ShopCard: authored sprites, labels, linked yard, no GameApp/save/render PASS');
    } catch (error) {
      report.error = String(error); report.errors = observed.errors; save();
      await page.screenshot({ path: path.join(out, 'failure.png') }); throw error;
    } finally { await page.close(); }
  } finally {
    await server.close(); report.cleanup.serverClosed = true; save();
    await browser?.close(); report.cleanup.browserClosed = true; save();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
