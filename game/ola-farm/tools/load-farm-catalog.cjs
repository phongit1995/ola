'use strict';
// Let plain Node asset/browser tools use the same TypeScript loader and validation as Cocos.
module.exports = require('tsx/cjs/api').require('./load-farm-catalog.ts', __filename);
if (require.main === module) {
  const catalog = module.exports.loadFarmCatalog();
  console.log(`catalog.json + economy.json + timing.json + gameplay.json + runtime.json hợp lệ: ${catalog.farm.length} cây, ${catalog.livestock.length} loài, ${catalog.products.length} công thức; ${catalog.boostSecondsPerGem} giây/kim cương.`);
}
