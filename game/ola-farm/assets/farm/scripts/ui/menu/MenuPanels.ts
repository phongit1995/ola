import { MENU_ROW_COLOR, MENU_QUESTION_COLOR, MENU_INPUT_COLOR, GROUP_NAMES, GEM_PACKS } from './MenuPanels.constants';
import { EditBox } from 'cc';
import { countdown, remainingSeconds } from '../../core/Countdown';
import { orderedCrops } from '../../core/FarmGame';
import { formatWallet } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';

function offlineGuide(ctx: PanelContext): string {
  const offline = ctx.app.session.runtime.session;
  return !offline.offlineProgressEnabled
    ? 'Đóng game sẽ dừng công việc.'
    : offline.maxOfflineSeconds === null
      ? 'Công việc đã bắt đầu tiếp tục khi đóng game.'
      : `Công việc tiếp tục tối đa ${countdown(offline.maxOfflineSeconds)} mỗi lần vắng mặt.`;
}

export const welcomePanel: PanelDefinition = {
  title: 'Nông trại của bạn',
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
      `${farm.plots.filter(p => p.group === 'crop' && p.unlocked).length} ruộng đã mở · ${cfg.farm.length} cây · ${cfg.livestock?.length ?? 0} loài\n\n1. Vào Shop xây máy thức ăn và chuồng gà. Gieo lúa mì, ngô để làm cám; cho gà ăn rồi thu trứng.\n\n2. Thu hoạch và bán sản phẩm trong kho để kiếm xu và XP. Các công trình mới mở dần khi lên level.\n\n3. Xem mốc và giá trong Shop. Đạt level chỉ mở quyền mua; bấm xây mới có công trình. Một số loại còn cần thu đủ sản phẩm yêu cầu.\n\n4. Nâng hàng chờ và sức chứa chuồng. Chạm chuồng để cho ăn, thu sản phẩm hoặc quản lý đàn.\n\nHiện có ${farm.coins} xu, ${farm.diamonds} kim cương, ${farm.machines.length} máy và ${animals} vật nuôi. Giữ hạt giống để xem thời gian lớn. ${offlineText}`,
      w / 2 - 40,
      -295,
      w - 130,
      590,
      26,
      ink
    );
    if (legacy) {
      ui.text(
        content,
        'LegacySaveNotice',
        'Đây là lượt chơi mới. Bản lưu nông trại cũ vẫn được giữ riêng; bạn có thể xuất để khôi phục bằng bản game cũ.',
        w / 2 - 40,
        -665,
        w - 130,
        120,
        23,
        ink
      );
      ui.button(
        content,
        'export-legacy',
        'Xuất bản lưu nông trại cũ',
        w / 2 - 40,
        -775,
        w - 140,
        64,
        () => app.exportSave('legacy'),
        { variant: 'blue' }
      );
    }
    ctx.footer('welcome-start', 'Bắt đầu chơi', () => app.act({ type: 'dismissGuide' }, 'Click 1', () => app.close()));
  },
};

export const plotsPanel: PanelDefinition = {
  title: 'Danh sách ô',
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
            ? `Mua đất · ${formatWallet(field.price ?? 0)} xu`
            : field.reason
          : !p.unlocked
            ? 'Chưa cải tạo'
            : p.crop
              ? `${game.farm(p.crop)?.name ?? ''} · ${game.isReady(p) ? 'Đã lớn' : countdown(remainingSeconds(p.ready, s.time, app.session.speed))}`
              : p.residents
                ? (game.catalog.livestock?.find(t => t.key === p.residents?.species)?.name ?? 'Chuồng')
                : 'Ô trống';
        const number =
          p.group === 'crop' ? orderedCrops(s.plots).findIndex(plot => plot.id === p.id) + 1 : (p.cell ?? p.id) + 1;
        text.string = `${GROUP_NAMES[p.group]} #${number}${p.cell === null ? ' · Ruộng mở rộng' : ''}\n${status}`;
      });
      ui.button(
        content,
        `plot-${p.id}`,
        !p.unlocked
          ? game.simple && p.group === 'crop'
            ? 'Xem ô đất'
            : 'Cải tạo'
          : game.isReady(p)
            ? 'Thu hoạch'
            : 'Chọn ô',
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
  title: 'Tạm dừng',
  render(ctx: PanelContext): void {
    const { app, ui, art, width: w } = ctx,
      settings = app.session.settings;
    const content = ctx.list(w < 800 ? 790 : 620),
      cols = w < 800 ? 2 : 3,
      cw = (w - 100) / cols;
    const buttons: Array<[string, string, string, () => void]> = [
      ['arrange', 'Sắp xếp', 'pauseMenu', () => app.beginArrangement()],
      [
        'home',
        'Nông trại',
        'pausePlay',
        () => {
          app.close();
          app.focusHome();
        },
      ],
      ['plots', 'Danh sách ô', 'pauseMenu', () => app.open('plots')],
      ['restart', 'Chơi lại', 'pauseRestart', () => app.open('restart-confirm')],
      ['resume', 'Tiếp tục', 'pausePlay', () => app.close()],
      ['sound', `Âm thanh: ${settings.sound ? 'Bật' : 'Tắt'}`, 'pauseSound', () => app.toggleAudio('sound')],
      ['music', `Nhạc: ${settings.music ? 'Bật' : 'Tắt'}`, 'pauseMusic', () => app.toggleAudio('music')],
      ['help', 'Cách chơi & bản lưu', 'pauseHelp', () => app.open('help')],
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
    if (app.session.realTime)
      ui.text(
        content,
        'RealTime',
        'Thời gian thực · Menu đang tạm dừng công việc',
        (w - 80) / 2,
        y,
        w - 100,
        60,
        22,
        ink
      );
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
          ? `Mua ô đất #${orderedCrops(ctx.farm.plots).findIndex(plot => plot.id === ctx.state.improveId) + 1}`
          : 'Cải tạo ô đất'
        : 'Chơi lại',
    render(ctx: PanelContext): void {
      const { app, state, ui, art, card, width: w } = ctx;
      ui.box(card, 'QuestionBacking', 0, 40, w - 90, 160, MENU_QUESTION_COLOR);
      ui.text(
        card,
        'Question',
        kind === 'improve'
          ? 'Cải tạo ô này với 1 kim cương?'
          : 'Chơi lại sẽ đặt lại xu, XP, kho và toàn bộ công trình.\nBạn sẽ xây lại từ đầu. Tiếp tục?',
        0,
        40,
        w - 100,
        160,
        28,
        ink
      );
      if (kind === 'improve') art.image(card, art.data.ui.widgets.hudDiamond.texture, 0, -40, 62, 62);
      ui.button(
        card,
        'confirm',
        'Đồng ý',
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
        'Hủy bỏ',
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
  title: 'Cách chơi & bản lưu',
  render(ctx: PanelContext): void {
    const { app, game, ui, width: w } = ctx,
      content = ctx.list(2100),
      cx = (w - 80) / 2;
    ui.text(
      content,
      'Help',
      'Chào mừng đến với Ola Farm. Chạm ô trống để gieo, cây chín để thu hoạch. Chạm cây đang lớn để hủy hoặc làm chín bằng kim cương; giá tăng theo thời gian còn lại.\n\nNhà máy chế biến nguyên liệu; Kho bán sản phẩm lấy xu. Khởi đầu có 500 xu và 10 kim cương.\n\nKéo/chụm/cuộn để di chuyển và thu phóng. Shop xây chuồng và máy. Mở ô kèm con trong bảng chuồng. Menu → Nông trại đưa về khu ruộng và chuồng. Space tạm dừng, Esc đóng bảng.\n\nĐồng hồ dùng thời gian thực. OFFLINE_GUIDE Tạm dừng hoặc mở Menu sẽ dừng công việc cho đến khi tiếp tục.\n\nTiến độ tự lưu. Xuất JSON để sao lưu; nhập bản lưu Ola Farm để tiếp tục trên máy khác.'
        .replace('OFFLINE_GUIDE', offlineGuide(ctx))
        .replace(
          '500 xu và 10 kim cương',
          `${game.catalog.economy?.startingWallet.coins ?? 500} xu và ${game.catalog.economy?.startingWallet.diamonds ?? 10} kim cương`
        ),
      cx,
      -260,
      w - 135,
      500,
      24,
      ink
    );
    ui.button(content, 'export', 'Xuất bản lưu JSON', cx, -570, w - 180, 62, () => app.exportSave(), {
      variant: 'blue',
    });
    ui.button(content, 'import', 'Nhập bản lưu JSON', cx, -650, w - 180, 62, () => app.importSave(), {
      variant: 'blue',
    });
    ui.button(content, 'save-text', 'Nhập/xem JSON dạng văn bản', cx, -730, w - 180, 62, () => {
      ctx.state.saveText = '';
      app.open('save-text');
    });
    ui.text(
      content,
      'NewFarmHelp',
      '8 cây: lúa mì, ngô, bắp cải, dâu, nho, khoai tây, bí ngô, củ cải đường.\n\nLượt mới chưa có máy hay chuồng. Bắt đầu bằng máy thức ăn, chuồng gà và cám gà. Các nhóm công trình sau mở cách nhau nhiều level; xem mốc và giá trong Shop. Lên level không tự cấp nhà.\n\nMỗi máy có hàng đợi và khay nhận riêng; xem số ô trong cửa sổ máy. Trả nguyên liệu khi xếp; hủy việc đang chờ hoàn đúng nguyên liệu. Nhận hàng trong khay để máy chạy tiếp.\n\nGà, bò, heo, cừu nuôi theo từng ô. Làm thức ăn rồi cho ăn và nhận sản phẩm. Xem sức chứa tối đa trong cửa sổ chuồng; mua ô mới đã kèm một con.\n\nKho có 35 loại vật phẩm. Tìm nguyên liệu trong thẻ công thức chỉ nơi trồng, nuôi hoặc máy cần mua. Bản này dùng lượt lưu riêng; bản lưu cũ vẫn giữ để xuất.',
      cx,
      -1090,
      w - 135,
      620,
      23,
      ink
    );
    ui.button(
      content,
      'rescue',
      'Hết vốn: nhận hạt lúa hỗ trợ',
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
      ['retry-save', 'Thử lưu lại', () => app.retrySave()],
      ['export-source', 'Xuất dữ liệu gốc trong máy', () => app.exportSave('source')],
      ['export-backup', 'Xuất bản dự phòng', () => app.exportSave('backup')],
      ['export-pending', 'Xuất thao tác đang chờ lưu', () => app.exportSave('pending')],
      ['export-legacy', 'Xuất bản lưu nông trại cũ', () => app.exportSave('legacy')],
      ['export-legacy-backup', 'Xuất dự phòng nông trại cũ', () => app.exportSave('legacy-backup')],
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
  title: 'Thêm xu',
  render(ctx: PanelContext): void {
    const { app, farm: s, ui, art, width: w } = ctx,
      packs = ctx.game.coinPacks,
      content = ctx.list(packs.length * 110 + 120);
    ui.text(
      content,
      'CoinsHelp',
      `Đổi kim cương lấy xu. Bạn đang có ${formatWallet(s.diamonds)} kim cương.`,
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
      ui.text(content, 'PackText', `${formatWallet(pack.coins)} xu`, (w - 80) * 0.4, y, (w - 80) * 0.5, 90, 28, ink);
      art.image(content, art.data.ui.widgets.hudDiamond.texture, (w - 80) * 0.72 - 8, y, 40, 40, 'PackGem');
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
    ctx.footer('coins-close', 'Đóng', () => app.close());
  },
};
export const gemsPanel: PanelDefinition = {
  title: 'Thêm kim cương',
  render(ctx: PanelContext): void {
    const { app, farm: s, ui, art, width: w } = ctx,
      packs = ctx.game.catalog.economy?.gemPacks ?? GEM_PACKS,
      content = ctx.list(packs.length * 110 + 140);
    ui.text(
      content,
      'GemsHelp',
      `Bạn đang có ${formatWallet(s.diamonds)} kim cương. Cửa hàng kim cương chưa mở bán; các gói dưới đây chỉ là bản xem trước.`,
      (w - 80) / 2,
      -50,
      w - 140,
      80,
      23,
      ink
    );
    packs.forEach((pack, i) => {
      const y = -150 - i * 110;
      ui.box(content, 'PackRow', (w - 80) / 2, y, w - 110, 100, MENU_ROW_COLOR);
      art.image(content, art.data.ui.widgets.hudDiamond.texture, 70, y, 52, 52, 'PackGem');
      ui.text(content, 'PackText', `${pack.gems} kim cương`, (w - 80) * 0.4, y, (w - 80) * 0.5, 90, 28, ink);
      // Tappable on purpose: a disabled button would never reach the handler, and the toast explains why nothing happens.
      ui.button(
        content,
        `gem-pack-${i}`,
        pack.price,
        (w - 80) * 0.83,
        y,
        130,
        58,
        () => app.toast('Cửa hàng kim cương sẽ mở ở bản sau.'),
        { variant: 'blue' }
      );
    });
    ctx.footer('gems-close', 'Đóng', () => app.close());
  },
};

export const saveTextPanel: PanelDefinition = {
  title: 'Bản lưu JSON',
  render(ctx: PanelContext): void {
    const { app, state, ui, card, width: w, height: h } = ctx;
    const node = ui.box(card, 'JsonInput', 0, -10, w - 90, h - 220, MENU_INPUT_COLOR);
    const edit = node.addComponent(EditBox);
    edit.textLabel = ui.text(node, 'InputLabel', '', 0, 0, w - 120, h - 240, 18, ink);
    edit.placeholderLabel = ui.text(node, 'Placeholder', 'Dán JSON bản lưu ở đây', 0, 0, w - 120, h - 240, 22, ink);
    edit.inputMode = EditBox.InputMode.ANY;
    edit.maxLength = 2_000_000;
    edit.string = state.saveText;
    edit.node.on(EditBox.EventType.TEXT_CHANGED, () => {
      state.saveText = edit.string;
    });
    ctx.footer('apply-import', 'Nhập JSON', () => app.importText(edit.string), true);
    ctx.footer(
      'show-json',
      'Hiện JSON hiện tại',
      () => {
        edit.string = app.session.exportText();
        state.saveText = edit.string;
      },
      false
    );
  },
};
