const { contextBridge } = require('electron');

contextBridge.exposeInMainWorld('olaDesktop', {
  platform: process.platform,
  version: process.env.npm_package_version ?? '',
});
