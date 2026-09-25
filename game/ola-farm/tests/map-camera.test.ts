import assert from 'node:assert/strict';
import test from 'node:test';
import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';
import vm from 'node:vm';
import ts from 'typescript';

// Exercise the actual camera math with only Cocos' vector/world-node boundary replaced.
const cameraFile = path.resolve(__dirname, '../assets/farm/scripts/map/camera/MapCamera.ts');
const source = fs.readFileSync(cameraFile, 'utf8');
const requireCamera = createRequire(cameraFile);
const compiled = ts.transpileModule(source, {
  compilerOptions: { target: ts.ScriptTarget.ES2020, module: ts.ModuleKind.CommonJS },
}).outputText;
const cameraModule: Record<string, any> = {};
vm.runInNewContext(compiled, {
  exports: cameraModule,
  require: (name: string) => {
    if (name !== 'cc') return requireCamera(name);
    return {
      Vec2: class {
        x = 0;
        y = 0;
        set(x: number, y: number) {
          this.x = x;
          this.y = y;
        }
      },
    };
  },
});
function camera() {
  const world = {
    scale: 0,
    position: { x: 0, y: 0 },
    setScale(x: number) {
      this.scale = x;
    },
    setPosition(x: number, y: number) {
      this.position = { x, y };
    },
  };
  const camera = new cameraModule.MapCamera(world, { x: 325, y: -132.5 });
  camera.width = 720;
  camera.height = 1280;
  camera.scale = 0.2;
  camera.minZoom = 2;
  camera.reach = { left: -10000, right: 10000, bottom: -10000, top: 10000 };
  return { camera, world };
}
const snapshot = (camera: any) => JSON.parse(JSON.stringify(camera.state()));
const close = (a: number, b: number) => assert.ok(Math.abs(a - b) < 1e-8, `${a} ≈ ${b}`);

test('repeated zoom-out at the central-home limit keeps its exact fit and automatic resize mode', () => {
  const { camera: c, world } = camera();
  c.lookAt(80, 260, c.minZoom, 'home', 46);
  const before = snapshot(c),
    position = { ...world.position };
  for (let i = 0; i < 100; i++) c.setZoom(c.zoom / 1.12);
  assert.equal(c.zoom, c.minZoom);
  assert.equal(c.mode, 'home');
  assert.deepEqual(snapshot(c), before);
  assert.deepEqual(world.position, position);
});

test('wheel-sized changes and an extreme pinch clamp at both limits, then zoom back in normally', () => {
  const { camera: c } = camera();
  c.lookAt(80, 260, c.minZoom, 'home');
  c.setZoom(c.zoom * 1.12);
  assert.equal(c.mode, 'manual');
  assert.ok(c.zoom > c.minZoom);
  c.setZoom(0);
  assert.equal(c.zoom, c.minZoom);
  c.setZoom(c.zoom * 1.12);
  assert.ok(c.zoom > c.minZoom);
  c.setZoom(1e12);
  assert.equal(c.zoom, c.maxZoom);
  c.setZoom(c.zoom / 1.12);
  assert.ok(c.zoom < c.maxZoom);
});

test('manual resize preserves the viewed map point and world scale when they fit the new limits', () => {
  const { camera: c, world } = camera();
  c.lookAt(900, 300, 5, 'manual');
  const before = snapshot(c);
  c.width = 1280;
  c.height = 720;
  c.scale = 0.15;
  c.minZoom = 3;
  c.restoreManual(before);
  close(c.displayScale, before.displayScale);
  close(c.state().x, before.x);
  close(c.state().y, before.y);
  assert.equal(c.mode, 'manual');
  close(world.position.x, -before.x * c.displayScale);
  close(world.position.y, -before.y * c.displayScale);
});

test('resize lifts a too-distant manual zoom to the new home limit without changing its map focus', () => {
  const { camera: c } = camera();
  c.lookAt(900, 300, 2.2, 'manual');
  const before = snapshot(c);
  c.width = 1280;
  c.height = 720;
  c.scale = 0.3;
  c.minZoom = 2;
  c.restoreManual(before);
  assert.equal(c.zoom, c.minZoom);
  close(c.displayScale, 0.6);
  close(c.state().x, before.x);
  close(c.state().y, before.y);
  assert.equal(c.mode, 'manual');
  c.mode = 'home';
  c.restoreManual(snapshot(c));
  assert.equal(c.mode, 'manual');
});
