import { _decorator, BitmapFont, Component, director, game, Game, macro, profiler, sys, view } from 'cc';
import { Art } from '../../render/Art';
import { applyDesignResolution } from '../layout/Layout';
import { clearPreparedFarm, stagePreparedFarm } from './PreparedFarm';
import { LoadingScreenView } from '../../ui/loading/LoadingScreenView';
import { accountFromToken } from '../../core/AccountStorage';
import { requestOlaToken, watchOlaKen } from '../services/OlaBridge';

const { ccclass, property } = _decorator;

/** Loads resources from the authored Loading scene, then hands them to Farm exactly once. */
@ccclass('LoadingSceneController')
export class LoadingSceneController extends Component {
  @property(LoadingScreenView) screen: LoadingScreenView = null!;
  @property(BitmapFont) plotFont: BitmapFont = null!;
  @property(BitmapFont) walletFont: BitmapFont = null!;
  @property gameScene = 'Farm';

  readonly art = new Art();
  private hidden = false;
  private transferred = false;

  onLoad(): void {
    try {
      if (!this.screen || !this.plotFont || !this.walletFont)
        throw Error('Loading.scene thiếu liên kết màn hình tải hoặc font.');
      profiler.hideStats();
      if (sys.isBrowser) view.setOrientation(macro.ORIENTATION_AUTO);
      applyDesignResolution();
      view.on('canvas-resize', this.resize, this);
      game.on(Game.EVENT_HIDE, this.onHide, this);
      game.on(Game.EVENT_SHOW, this.onShow, this);
      this.screen.setup(this.node);
      void this.loadFarm().catch(error => this.fail(error));
    } catch (error: unknown) {
      this.fail(error);
    }
  }

  private async loadFarm(): Promise<void> {
    watchOlaKen();
    // The token arrives while assets load; it only picks which account's save the farm opens.
    const account = requestOlaToken()
      .then(accountFromToken)
      .catch(() => null);
    await this.art.initialize({ plot: this.plotFont, wallet: this.walletFont }, progress => {
      if (this.isValid && this.screen.isValid) this.screen.setProgress(progress);
    });
    if (!this.isValid) return;
    // Preloading resolves the authored map's dependencies without activating its GameApp or reading saves.
    await new Promise<void>((resolve, reject) => {
      director.preloadScene(
        this.gameScene,
        () => {},
        error => (error ? reject(error) : resolve())
      );
    });
    const owner = await account;
    if (!this.isValid) return;
    stagePreparedFarm({
      art: this.art,
      account: owner,
      isHidden: () => this.hidden,
      complete: () => this.complete(),
      fail: error => this.fail(error),
    });
    // This existing Canvas covers the scene switch until Farm has bound the saved data to its views.
    director.addPersistRootNode(this.node);
    if (
      !director.loadScene(this.gameScene, error => {
        if (error) this.fail(error);
      })
    ) {
      this.fail(new Error(`Không thể mở scene ${this.gameScene}.`));
    }
  }

  private complete(): void {
    this.transferred = true;
    director.removePersistRootNode(this.node);
    this.node.active = false;
    this.node.destroy();
  }

  private fail(error: unknown): void {
    console.error(error);
    clearPreparedFarm(this.art);
    if (this.isValid && this.screen?.isValid) this.screen.showError();
  }

  private resize(): void {
    applyDesignResolution();
  }
  private onHide(): void {
    this.hidden = true;
  }
  private onShow(): void {
    this.hidden = false;
  }

  onDestroy(): void {
    view.off('canvas-resize', this.resize, this);
    game.off(Game.EVENT_HIDE, this.onHide, this);
    game.off(Game.EVENT_SHOW, this.onShow, this);
    director.removePersistRootNode(this.node);
    clearPreparedFarm(this.art);
    if (!this.transferred) this.art.dispose();
  }
}
