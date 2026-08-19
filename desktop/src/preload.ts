import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('olaDesktop', {
  platform: process.platform,
  // { platform, version (shell), otaVersion (0 = dist đóng gói sẵn) }
  getInfo: () => ipcRenderer.invoke('ola-desktop:info'),
});
