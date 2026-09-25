'use strict';
const assert = require('node:assert/strict'), fs = require('node:fs'), path = require('node:path');
const { serve, launch, boot, tap, observe } = require('./browser-support.cjs');
const out = path.resolve(__dirname, '../artifacts/factory-dialog-frame');
const near = (a, b, message) => assert.ok(Math.abs(a - b) < .2, `${message}: ${a} vs ${b}`);
async function inspect(page) {
  return page.evaluate(() => {
    const a = testApp, cc = testCc, shell = a.panels.card.parent.getComponent('DialogShellView');
    const frame = shell.factoryDialogView, unit = a.width / cc.view.getFrameSize().width;
    const rect = n => { const t = n.getComponent(cc.UITransform), p = n.worldPosition, s = n.worldScale;
      return { x: (p.x - t.width * t.anchorX * s.x) / unit, y: (p.y - t.height * t.anchorY * s.y) / unit,
        w: t.width * s.x / unit, h: t.height * s.y / unit }; };
    return { id: frame.node.uuid, source: frame.node.prefab?.asset?.uuid, title: frame.title.string,
      frame: rect(frame.node), card: rect(shell.card), close: rect(frame.closeButton), label: rect(frame.title.node),
      collect: rect(a.ui.controls.get('collect-' + a.panels.machineId)), background: rect(frame.background.node),
      font: frame.title.fontSize, color: [frame.background.color.r, frame.background.color.g, frame.background.color.b],
      backgroundAsset: frame.background.spriteFrame.uuid, closeAsset: frame.closeFace.spriteFrame.uuid,
      visible: frame.node.activeInHierarchy, legacyHidden: !shell.factoryFrame.node.active && !shell.title.node.active && !shell.closeButton.active,
      registeredClose: a.ui.controls.get('close-panel') === frame.closeButton,
      graphics: frame.node.getComponentsInChildren(cc.Graphics).length, sprites: frame.node.getComponentsInChildren(cc.Sprite).length };
  });
}
function geometry(s, right = 0, top = 18) {
  assert.ok(s.source && s.visible && s.legacyHidden && s.registeredClose);
  assert.equal(s.graphics, 0); assert.equal(s.sprites, 2);
  for (const k of ['x', 'y', 'w', 'h']) {
    near(s.frame[k], s.card[k], 'Frame fills host ' + k);
    near(s.background[k], s.frame[k], 'Sliced background fits authored root ' + k);
  }
  near(s.card.x + s.card.w - s.close.x - s.close.w, right, 'Right Widget inset');
  near(s.card.y + s.card.h - s.close.y - s.close.h, top, 'Top Widget inset');
  assert.ok(s.close.w >= 43.9 && s.close.h >= 43.9);
  assert.ok(s.close.x >= s.label.x + s.label.w, 'X clears title');
  assert.ok(s.close.y >= s.collect.y + s.collect.h - .1, 'X clears collection action');
}
(async () => {
  fs.mkdirSync(out, { recursive: true });
  const external = process.env.COCOS_TEST_URL;
  const server = external ? { url: external, close: async () => {} } : await serve();
  const browser = await launch(), results = [];
  try {
    const cases = [[393, 585], [568, 320], [1280, 720]].filter(([w,h]) => !process.env.COCOS_UI_VIEWPORT || process.env.COCOS_UI_VIEWPORT === `${w}x${h}`);
    for (const [width, height] of cases) {
      const context = await browser.newContext({ viewport: { width, height }, hasTouch: true });
      try {
        const page = await context.newPage(), observed = observe(page);
        await boot(page, server.url);
        if (external && await page.locator('#view-select').count()) {
          await page.locator('#view-select').click(); await page.locator('[data-device="FullScreen"]').click();
        }
        await page.waitForTimeout(250);
        assert.deepEqual(await page.evaluate(() => ({ width: testCc.view.getFrameSize().width, height: testCc.view.getFrameSize().height })), { width, height });
        await page.evaluate(() => { testApp.game.dismissGuide(); testApp.close(); testApp.panels.machineId = 0; testApp.open('factory'); });
        await page.waitForTimeout(200);
        const shown = await inspect(page); geometry(shown); assert.equal(shown.title, 'Lò bánh 1');
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `factory-${width}x${height}.png`) });
        // Render the source prefab without present(), at the same root size as the game.
        // This is the Editor's native Sprite/Label/Widget layout, before any runtime styling.
        const parity = await page.evaluate(() => {
          const cc = testCc, shell = testApp.panels.card.parent.getComponent('DialogShellView'), live = shell.factoryDialogView;
          const node = cc.instantiate(shell.factoryDialogPrefab); shell.card.addChild(node);
          node.getComponent(cc.UITransform).setContentSize(live.node.getComponent(cc.UITransform).contentSize);
          node.setScale(live.node.scale);
          node.getComponentsInChildren(cc.Widget).forEach(w => w.updateAlignment());
          const snapshot = v => {
            const pose = n => { const t = n.getComponent(cc.UITransform); return { position: n.position, scale: n.scale, size: t.contentSize }; };
            return { background: pose(v.background.node), title: pose(v.title.node), close: pose(v.closeButton), icon: pose(v.closeFace.node),
              backgroundAsset: v.background.spriteFrame.uuid, closeAsset: v.closeFace.spriteFrame.uuid,
              font: v.title.fontSize, fontAsset: v.title.font.uuid, color: v.title.color, text: v.title.string };
          };
          globalThis.framePreview = node;
          globalThis.framePreviewState = { frame: live.node, body: shell.body };
          live.node.active = false; shell.body.active = false;
          return { source: snapshot(node.getComponent('FactoryDialogFrameView')), runtime: snapshot(live) };
        });
        assert.deepEqual(parity.source, parity.runtime, 'Prefab and game share artwork, font, color and child geometry');
        await page.waitForTimeout(80);
        await page.locator('#GameCanvas').screenshot({ path: path.join(out, `prefab-${width}x${height}.png`) });
        await page.evaluate(() => { framePreview.destroy(); framePreviewState.frame.active = true; framePreviewState.body.active = true; });
        await tap(page, 'choose-recipe', true); geometry(await inspect(page));
        await page.evaluate(() => { for (let i = 0; i < 3; i++) testApp.panels.render(); });
        assert.equal((await inspect(page)).id, shown.id, 'Refreshing content reuses the same frame');
        await tap(page, 'close-panel', true); assert.equal(await page.evaluate(() => testApp.panels.view), '');

        // Source edits, followed by a fresh instantiation, exercise the same serialized fields as the Inspector.
        await page.evaluate(() => {
          const a = testApp, cc = testCc, source = a.ui.prefabs.dialogShell.data.getComponent('DialogShellView').factoryDialogPrefab;
          const frame = source.data.getComponent('FactoryDialogFrameView');
          const anchor = frame.closeButton.getComponent(cc.Widget); anchor.right = 18; anchor.top = 8;
          frame.title.fontSize = 24; frame.background.color = new cc.Color(250, 245, 230);
          source.compileCreateFunction(); a.ui.prefabs.dialogShell.compileCreateFunction();
          globalThis.frameSource = source;
          a.panels.machineId = 1; a.open('factory');
        });
        await page.waitForTimeout(150);
        const edited = await inspect(page); geometry(edited, 18, 8);
        assert.equal(edited.title, await page.evaluate(() => testApp.game.machineName(testApp.game.state.machines.find(m => m.id === 1))));
        assert.notEqual(edited.title, shown.title); assert.equal(edited.font, 24);
        assert.deepEqual(edited.color, [250, 245, 230]);
        await page.evaluate(() => testApp.panels.render()); geometry(await inspect(page), 18, 8);
        await tap(page, 'close-panel', true);
        await page.evaluate(() => testApp.open('inventory')); await tap(page, 'close-panel', true);
        await page.evaluate(() => { testApp.panels.penId = 12; testApp.open('livestock'); }); await tap(page, 'close-panel', true);

        assert.deepEqual(observed.errors, []);
        results.push({ width, height, shown, edited, parity, passed: true });
        console.log(`PASS ${width}x${height}: original artwork, prefab/game parity, source edits, reuse and close`);
      } finally { await context.close(); }
    }
  } finally { fs.writeFileSync(path.join(out, 'results.json'), JSON.stringify(results, null, 2)); await browser.close(); await server.close(); }
})().catch(error => { console.error(error); process.exitCode = 1; });
