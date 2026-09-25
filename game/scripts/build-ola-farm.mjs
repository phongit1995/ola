// Build Ola Farm (Cocos Creator 3.8.8) bản release rồi chép vào public/ola-farm,
// để `vite build` đưa sang dist/ola-farm cùng các game khác. CI Linux không có
// Cocos Creator nên phải chạy lệnh này trên máy macOS/Windows và commit output.
//
//   pnpm -C game build:farm            (COCOS_CREATOR=<đường dẫn> để đổi bản Creator)
import { spawnSync } from 'node:child_process';
import { cpSync, existsSync, rmSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, resolve } from 'node:path';

const GAME_DIR = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const PROJECT_DIR = resolve(GAME_DIR, 'ola-farm');
const BUILD_CONFIG = resolve(PROJECT_DIR, 'build-configs/ola-web-mobile.json');
const BUILD_OUTPUT = resolve(PROJECT_DIR, 'build/ola-farm');
const PUBLIC_OUTPUT = resolve(GAME_DIR, 'public/ola-farm');
// Creator CLI trả 36 khi build thành công.
const CREATOR_BUILD_SUCCESS = 36;

const CREATOR_CANDIDATES = [
  process.env.COCOS_CREATOR,
  '/Applications/Cocos/Creator/3.8.8/CocosCreator.app/Contents/MacOS/CocosCreator',
  'C:/ProgramData/cocos/editors/Creator/3.8.8/CocosCreator.exe',
].filter(Boolean);

const creator = CREATOR_CANDIDATES.find((path) => existsSync(path));
if (!creator) {
  console.error('Không tìm thấy Cocos Creator 3.8.8, đặt COCOS_CREATOR=<đường dẫn file chạy>.');
  process.exit(1);
}

// VSCode/Claude Code set biến này, làm Creator (Electron) chạy như Node rồi thoát.
const env = { ...process.env };
delete env.ELECTRON_RUN_AS_NODE;

rmSync(BUILD_OUTPUT, { recursive: true, force: true });
const result = spawnSync(creator, ['--project', PROJECT_DIR, '--build', `configPath=${BUILD_CONFIG}`], {
  env,
  stdio: 'inherit',
});
if (result.status !== CREATOR_BUILD_SUCCESS || !existsSync(resolve(BUILD_OUTPUT, 'index.html'))) {
  console.error(`Build Cocos lỗi (exit ${result.status ?? result.signal}), xem log Creator ở trên.`);
  process.exit(1);
}

rmSync(PUBLIC_OUTPUT, { recursive: true, force: true });
cpSync(BUILD_OUTPUT, PUBLIC_OUTPUT, { recursive: true });
console.log(`Đã chép bản build vào ${PUBLIC_OUTPUT}`);
