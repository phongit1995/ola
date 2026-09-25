'use strict';
// Counts PanelHost.render() calls while a static panel sits idle. Idle refreshes must not rebuild the panel.
const assert = require('node:assert/strict');
const { serve, launch, boot } = require('./browser-support.cjs');

(async () => {
  const server = await serve(), browser = await launch();
  try {
    const page = await browser.newPage();
    await boot(page, server.url);
    const counts = await page.evaluate(async () => {
      const wait = ms => new Promise(r => setTimeout(r, ms));
      const host = testApp.panels, original = host.render.bind(host);
      let renders = 0;
      host.render = () => { renders++; original(); };
      const sample = async view => {
        testApp.open(view);
        await wait(300);
        renders = 0;
        await wait(1500);
        const idle = renders;
        testApp.close();
        await wait(100);
        return idle;
      };
      return { help: await sample('help'), pause: await sample('pause'), inventory: await sample('inventory') };
    });
    console.log(JSON.stringify(counts));
    for (const [view, idle] of Object.entries(counts)) assert.equal(idle, 0, `${view} re-rendered ${idle} times while idle`);
  } finally {
    await browser.close(); await server.close();
  }
})();
