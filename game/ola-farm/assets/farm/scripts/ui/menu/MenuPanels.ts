import { MENU_ROW_COLOR, MENU_QUESTION_COLOR, MENU_INPUT_COLOR, GROUP_NAMES } from './MenuPanels.constants';
import { EditBox } from 'cc';
import { countdown, remainingSeconds } from '../../core/Countdown';
import { orderedCrops } from '../../core/FarmGame';
import { formatWallet } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { t } from '../../core/i18n/I18n';

function offlineGuide(ctx: PanelContext): string {
  const offline = ctx.app.session.runtime.session;
  return !offline.offlineProgressEnabled
    ? t('offline.disabled')
    : offline.maxOfflineSeconds === null
      ? t('offline.unlimited')
      : t('offline.capped', { time: countdown(offline.maxOfflineSeconds) });
}

export const welcomePanel: PanelDefinition = {
  title: () => t('welcome.title'),
  render(ctx: PanelContext): void {
    const { app, ui, width: w } = ctx,
      content = ctx.list(850),
      legacy = app.session.saver.legacySource();
    const game = app.game,
      farm = game.state,
      cfg = game.catalog;
    const offlineText = offlineGuide(ctx);
    const animals = farm.plots.reduce((n, p) => n + (p.residents?.animals.length ?? 0), 0);
    ui.text(
      content,
      'WelcomeGuide',
      t('welcome.body', {
        fields: farm.plots.filter(p => p.group === 'crop' && p.unlocked).length,
        crops: cfg.farm.length,
        species: cfg.livestock?.length ?? 0,
        coins: farm.coins,
        gems: farm.diamonds,
        machines: farm.machines.length,
        animals,
        offline: offlineText,
      }),
      w / 2 - 40,
      -295,
      w - 130,
      590,
      26,
      ink
    );
    if (legacy) {
      ui.text(content, 'LegacySaveNotice', t('welcome.legacy'), w / 2 - 40, -665, w - 130, 120, 23, ink);
      ui.button(
        content,
        'export-legacy',
        t('save.exportLegacy'),
        w / 2 - 40,
        -775,
        w - 140,
        64,
        () => app.exportSave('legacy'),
        { variant: 'blue' }
      );
    }
    ctx.footer('welcome-start', t('welcome.start'), () =>
      app.act({ type: 'dismissGuide' }, 'Click 1', () => app.close())
    );
  },
};

export const plotsPanel: PanelDefinition = {
  title: () => t('plots.title'),
  render(ctx: PanelContext): void {
    const { app, game, farm: s, ui, width: w } = ctx;
    const nextField = game.nextLockedCrop();
    const plots = s.plots.filter(
        p => game.isActivePlot(p) && (!game.simple || p.group !== 'crop' || p.unlocked || p.id === nextField?.id)
      ),
      content = ctx.list(plots.length * 100);
    const canSelect = !app.session.storageFailed && (!app.session.paused || app.session.pauseBeforeMenu === false);
    plots.forEach((p, i) => {
      const y = -50 - i * 100;
      ui.box(content, 'PlotRow', (w - 80) / 2, y, w - 110, 92, MENU_ROW_COLOR);
      const text = ui.text(content, 'PlotText', '', (w - 80) * 0.34, y, (w - 80) * 0.62, 90, 24, ink);
      ctx.timer(() => {
        if (!text.isValid) return;
        const field = game.simple && p.group === 'crop' && !p.unlocked ? game.fieldUnlockOffer(p.id) : null;
        const status = field
          ? field.unlocked
            ? t('plots.buyLand', { coins: formatWallet(field.price ?? 0) })
            : field.reason
          : !p.unlocked
            ? t('plots.notImproved')
            : p.crop
              ? `${game.farm(p.crop)?.name ?? ''} · ${game.isReady(p) ? t('plots.ripe') : countdown(remainingSeconds(p.ready, s.time, app.session.speed))}`
              : p.residents
                ? (game.catalog.livestock?.find(t => t.key === p.residents?.species)?.name ?? t('plots.pen'))
                : t('plots.empty');
        const number =
          p.group === 'crop' ? orderedCrops(s.plots).findIndex(plot => plot.id === p.id) + 1 : (p.cell ?? p.id) + 1;
        text.string = `${t(GROUP_NAMES[p.group])} #${number}${p.cell === null ? t('plots.extension') : ''}\n${status}`;
      });
      ui.button(
        content,
        `plot-${p.id}`,
        !p.unlocked
          ? game.simple && p.group === 'crop'
            ? t('plots.viewField')
            : t('plots.improve')
          : game.isReady(p)
            ? t('plots.harvest')
            : t('plots.select'),
        (w - 80) * 0.83,
        y,
        150,
        58,
        () => {
          app.close();
          app.tapPlot(p.id);
        },
        { enabled: canSelect }
      );
    });
  },
};

export const pausePanel: PanelDefinition = {
  title: 'Menu',
  render(ctx: PanelContext): void {
    const { app, ui, art, width: w } = ctx,
      settings = app.session.settings;
    const content = ctx.list(w < 800 ? 790 : 620),
      cols = w < 800 ? 2 : 3,
      cw = (w - 100) / cols;
    const buttons: Array<[string, string, string, () => void]> = [
      ['arrange', t('menu.arrange'), 'pauseMenu', () => app.beginArrangement()],
      [
        'home',
        t('menu.farm'),
        'pausePlay',
        () => {
          app.close();
          app.focusHome();
        },
      ],
      ['plots', t('plots.title'), 'pauseMenu', () => app.open('plots')],
      ['restart', t('menu.restart'), 'pauseRestart', () => app.open('restart-confirm')],
      ['resume', t('menu.resume'), 'pausePlay', () => app.close()],
      [
        'sound',
        t('menu.sound', { state: t(settings.sound ? 'common.on' : 'common.off') }),
        'pauseSound',
        () => app.toggleAudio('sound'),
      ],
      [
        'music',
        t('menu.music', { state: t(settings.music ? 'common.on' : 'common.off') }),
        'pauseMusic',
        () => app.toggleAudio('music'),
      ],
      ['help', t('help.title'), 'pauseHelp', () => app.open('help')],
    ];
    buttons.forEach(([id, title, image, action], i) =>
      ui.button(
        content,
        id,
        title,
        10 + cw * ((i % cols) + 0.5),
        -90 - Math.floor(i / cols) * 170,
        Math.min(cw - 20, 180),
        150,
        action,
        { icon: art.data.panels.widgets[image].texture }
      )
    );
    const y = -Math.ceil(buttons.length / cols) * 170 - 45;
    if (app.session.realTime) ui.text(content, 'RealTime', t('menu.realTime'), (w - 80) / 2, y, w - 100, 60, 22, ink);
    else
      app.session.availableSpeeds.forEach((speed, i) =>
        ui.button(
          content,
          'speed-' + speed,
          `${speed}×${ctx.speed === speed ? ' ✓' : ''}`,
          (w - 80) / 2 + (i - 1) * 150,
          y,
          130,
          55,
          () => app.setSpeed(speed),
          { variant: 'blue' }
        )
      );
  },
};

function confirmPanel(kind: 'improve' | 'restart-confirm'): PanelDefinition {
  return {
    title: ctx =>
      kind === 'improve'
        ? ctx.game.simple
          ? t('land.title', {
              number: orderedCrops(ctx.farm.plots).findIndex(plot => plot.id === ctx.state.improveId) + 1,
            })
          : t('confirm.improveTitle')
        : t('menu.restart'),
    render(ctx: PanelContext): void {
      const { app, state, ui, art, card, width: w } = ctx;
      ui.box(card, 'QuestionBacking', 0, 40, w - 90, 160, MENU_QUESTION_COLOR);
      ui.text(
        card,
        'Question',
        kind === 'improve' ? t('confirm.improve') : t('confirm.restart'),
        0,
        40,
        w - 100,
        160,
        28,
        ink
      );
      if (kind === 'improve') art.plot(card, 'gem', 0, -40, 62, (62 * 108) / 117);
      ui.button(
        card,
        'confirm',
        t('common.ok'),
        -w * 0.22,
        -150,
        w * 0.35,
        60,
        () => {
          if (kind === 'improve') {
            if (state.improveId !== null)
              app.act({ type: 'improve', plot: state.improveId }, 'Click 1', () => app.close());
          } else app.restart();
        },
        { enabled: kind !== 'improve' || ctx.canAct }
      );
      ui.button(
        card,
        'cancel-confirm',
        t('common.cancel'),
        w * 0.22,
        -150,
        w * 0.35,
        60,
        () => (kind === 'improve' ? app.close() : app.open('pause')),
        { variant: 'blue' }
      );
    },
  };
}
export const improvePanel = confirmPanel('improve');
export const restartConfirmPanel = confirmPanel('restart-confirm');

export const helpPanel: PanelDefinition = {
  title: () => t('help.title'),
  render(ctx: PanelContext): void {
    const { app, game, ui, width: w } = ctx,
      content = ctx.list(2100),
      cx = (w - 80) / 2;
    ui.text(
      content,
      'Help',
      t('help.body', {
        coins: game.catalog.economy?.startingWallet.coins ?? 500,
        gems: game.catalog.economy?.startingWallet.diamonds ?? 10,
        offline: offlineGuide(ctx),
      }),
      cx,
      -260,
      w - 135,
      500,
      24,
      ink
    );
    ui.button(content, 'export', t('save.exportJson'), cx, -570, w - 180, 62, () => app.exportSave(), {
      variant: 'blue',
    });
    ui.button(content, 'import', t('save.importJson'), cx, -650, w - 180, 62, () => app.importSave(), {
      variant: 'blue',
    });
    ui.button(content, 'save-text', t('save.textJson'), cx, -730, w - 180, 62, () => {
      ctx.state.saveText = '';
      app.open('save-text');
    });
    ui.text(content, 'NewFarmHelp', t('help.newFarm'), cx, -1090, w - 135, 620, 23, ink);
    ui.button(
      content,
      'rescue',
      t('help.rescue'),
      cx,
      -1450,
      w - 160,
      60,
      () => {
        app.close();
        app.act({ type: 'rescue' });
      },
      { enabled: game.canRescue() && !app.session.storageFailed }
    );
    const recovery: Array<[string, string, () => void]> = [
      ['retry-save', t('save.retry'), () => app.retrySave()],
      ['export-source', t('save.exportSource'), () => app.exportSave('source')],
      ['export-backup', t('save.exportBackup'), () => app.exportSave('backup')],
      ['export-pending', t('save.exportPending'), () => app.exportSave('pending')],
      ['export-legacy', t('save.exportLegacy'), () => app.exportSave('legacy')],
      ['export-legacy-backup', t('save.exportLegacyBackup'), () => app.exportSave('legacy-backup')],
    ];
    recovery.forEach(([id, title, action], i) =>
      ui.button(content, id, title, cx, -1540 - i * 80, w - 160, 60, action, {
        variant: id.startsWith('export') ? 'blue' : 'green',
      })
    );
  },
};

/** Opened by the "+" on the coin wallet: trade diamonds for coin packs, the only coin top-up the farm has. */
export const coinsPanel: PanelDefinition = {
  title: () => t('coins.title'),
  render(ctx: PanelContext): void {
    const { app, farm: s, ui, art, width: w } = ctx,
      packs = ctx.game.coinPacks,
      content = ctx.list(packs.length * 110 + 120);
    ui.text(
      content,
      'CoinsHelp',
      t('coins.help', { count: formatWallet(s.diamonds) }),
      (w - 80) / 2,
      -40,
      w - 140,
      60,
      23,
      ink
    );
    packs.forEach((pack, i) => {
      const y = -130 - i * 110,
        affordable = s.diamonds >= pack.diamonds;
      ui.box(content, 'PackRow', (w - 80) / 2, y, w - 110, 100, MENU_ROW_COLOR);
      art.image(content, art.data.ui.widgets.dollar.texture, 70, y, 56, 56, 'PackCoin');
      ui.text(
        content,
        'PackText',
        t('common.coins', { coins: formatWallet(pack.coins) }),
        (w - 80) * 0.4,
        y,
        (w - 80) * 0.5,
        90,
        28,
        ink
      );
      art.plot(content, 'gem', (w - 80) * 0.72 - 8, y, 40, (40 * 108) / 117, 'PackGem');
      ui.button(
        content,
        `coin-pack-${i}`,
        `${pack.diamonds}`,
        (w - 80) * 0.83,
        y,
        130,
        58,
        () => app.act({ type: 'buyCoins', pack: i }, 'Click 1', () => ctx.render()),
        { enabled: affordable, variant: 'blue' }
      );
    });
    ctx.footer('coins-close', t('common.close'), () => app.close());
  },
};
export const saveTextPanel: PanelDefinition = {
  title: () => t('save.jsonTitle'),
  render(ctx: PanelContext): void {
    const { app, state, ui, card, width: w, height: h } = ctx;
    const node = ui.box(card, 'JsonInput', 0, -10, w - 90, h - 220, MENU_INPUT_COLOR);
    const edit = node.addComponent(EditBox);
    edit.textLabel = ui.text(node, 'InputLabel', '', 0, 0, w - 120, h - 240, 18, ink);
    edit.placeholderLabel = ui.text(node, 'Placeholder', t('save.pastePlaceholder'), 0, 0, w - 120, h - 240, 22, ink);
    edit.inputMode = EditBox.InputMode.ANY;
    edit.maxLength = 2_000_000;
    edit.string = state.saveText;
    edit.node.on(EditBox.EventType.TEXT_CHANGED, () => {
      state.saveText = edit.string;
    });
    ctx.footer('apply-import', t('save.importText'), () => app.importText(edit.string), true);
    ctx.footer(
      'show-json',
      t('save.showCurrent'),
      () => {
        edit.string = app.session.exportText();
        state.saveText = edit.string;
      },
      false
    );
  },
};
