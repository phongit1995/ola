import { EditBox, Label, Node, UITransform } from 'cc';
import { format } from '../../core/Format';
import { ink } from '../../render/constants/Ui.constants';
import { PANEL_ERROR, PANEL_MUTED } from '../shared/PanelPalette.constants';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import { fitLine, goldenIsland, saleLayout, softButton, softFace } from '../inventory/SoftUi';
import { t } from '../../core/i18n/I18n';

/** Digits the player typed, read as whole KEN; anything else is ignored. */
function typedKen(text: string): number {
  const digits = text.replace(/\D/g, '').slice(0, 9);
  return digits ? Number(digits) : 0;
}

/**
 * Diamonds only come from KEN, the Ola currency: a transfer form from the KEN wallet to the diamond wallet.
 * The form is complete but the transfer is not live yet: the server still has to debit KEN, so the button only
 * explains that it opens in a later version.
 */
export const gemsPanel: PanelDefinition = {
  title: () => t('gems.title'),
  render(ctx: PanelContext): void {
    const { app, state, game, ui, art, card, farm: s } = ctx,
      layout = saleLayout(ctx),
      { unit: u, height: h, contentWidth: cw, short } = layout,
      exchange = game.catalog.economy!.kenExchange,
      rate = exchange.kenPerDiamond,
      ken = app.ken,
      maxGems = ken === null ? null : Math.floor(ken / rate);
    // The amount is kept in whole diamonds, so the KEN spent is always a multiple of the rate.
    const gems = Math.max(0, Math.min(99_999, state.gemAmount));
    state.gemAmount = gems;
    const top = h / 2;
    // The same pink gem as the HUD and the factory boost prices, and Ola's own gold "K" coin for KEN.
    const gem = (parent: Node, x: number, y: number, size: number, name: string) =>
        art.plot(parent, 'gem', x * u, y * u, size * u, ((size * 108) / 117) * u, name),
      kenCoin = (parent: Node, x: number, y: number, size: number, name: string) =>
        art.plot(parent, 'ken', x * u, y * u, size * u, size * u, name);

    fitLine(ui.text(card, 'GemRule', t('gems.rule'), 0, (top - 50) * u, cw * u, 18 * u, 12 * u, PANEL_MUTED));

    // From the KEN wallet → to the diamond wallet.
    const walletY = top - (short ? 86 : 94),
      walletH = short ? 50 : 60,
      arrow = 34,
      walletW = (cw - arrow) / 2;
    for (const [side, title, value] of [
      [-1, t('gems.fromKen'), ken === null ? '—' : format(ken)],
      [1, t('gems.toGems'), format(s.diamonds)],
    ] as const) {
      const x = (side * (walletW + arrow)) / 2,
        box = ui.node(card, side < 0 ? 'FromKen' : 'ToGems', x * u, walletY * u, walletW * u, walletH * u);
      softFace(ctx, box, 'material', walletW, walletH, u);
      const textX = 14;
      if (side < 0) kenCoin(box, -walletW / 2 + 22, 0, 28, 'KenCoin');
      else gem(box, -walletW / 2 + 22, 0, 30, 'Gem');
      fitLine(ui.text(box, 'Label', title, textX * u, 10 * u, (walletW - 16 - textX) * u, 16 * u, 11 * u, PANEL_MUTED));
      fitLine(ui.text(box, 'Value', value, textX * u, -9 * u, (walletW - 16 - textX) * u, 22 * u, 18 * u, ink));
    }
    ui.text(card, 'TransferArrow', '→', 0, walletY * u, arrow * u, 30 * u, 24 * u, PANEL_MUTED);

    // The KEN to transfer: typed, or picked from the quick amounts.
    const captionY = walletY - walletH / 2 - (short ? 14 : 20),
      inputY = captionY - (short ? 26 : 30),
      inputH = short ? 38 : 44;
    fitLine(ui.text(card, 'KenCaption', t('gems.amountCaption'), 0, captionY * u, cw * u, 18 * u, 13 * u, PANEL_MUTED));
    const field = ui.node(card, 'ken-amount', 0, inputY * u, cw * u, inputH * u);
    softFace(ctx, field, 'info', cw, inputH, u);
    // Attach EditBox while the node is inactive so it adopts these labels instead of creating its own defaults.
    field.active = false;
    const edit = field.addComponent(EditBox);
    edit.textLabel = ui.text(field, 'InputLabel', '', 0, 0, (cw - 24) * u, (inputH - 8) * u, 20 * u, ink);
    edit.placeholderLabel = ui.text(
      field,
      'Placeholder',
      t('gems.placeholder'),
      0,
      0,
      (cw - 24) * u,
      (inputH - 8) * u,
      16 * u,
      PANEL_MUTED
    );
    // EditBox places its labels by their top-left corner and stretches them over the field; centre the text inside.
    for (const label of [edit.textLabel, edit.placeholderLabel]) {
      label.node.getComponent(UITransform)!.setAnchorPoint(0, 1);
      label.horizontalAlign = Label.HorizontalAlign.CENTER;
      label.verticalAlign = Label.VerticalAlign.CENTER;
    }
    edit.inputMode = EditBox.InputMode.NUMERIC;
    edit.maxLength = 11;
    edit.string = gems ? format(gems * rate) : '';
    kenCoin(field, -cw / 2 + 24, 0, 26, 'KenCoin');
    field.active = true;

    const chipsY = inputY - inputH / 2 - (short ? 22 : 26),
      chips = [
        ...exchange.packs.map(pack => ({ id: 'ken-chip-' + pack, gems: pack })),
        { id: 'ken-chip-all', gems: -1 },
      ],
      chipW = (cw - 6 * (chips.length - 1)) / chips.length;
    chips.forEach((chip, i) => {
      const all = chip.gems < 0,
        value = all ? (maxGems ?? 0) : chip.gems,
        selected = !all && value === gems;
      softButton(
        ctx,
        card,
        chip.id,
        all ? t('common.all') : format(value * rate),
        (i - (chips.length - 1) / 2) * (chipW + 6),
        chipsY,
        chipW,
        short ? 32 : 36,
        () => {
          state.gemAmount = value;
          ctx.render();
        },
        { enabled: !all || !!maxGems, primary: selected, size: 13 }
      );
    });

    // What the transfer gives, and whether the balance covers it.
    const receiveY = chipsY - (short ? 36 : 48),
      receive = ui.text(card, 'GemReceive', '', 0, receiveY * u, (cw - 40) * u, 26 * u, 18 * u, ink),
      receiveGem = gem(card, 0, receiveY, 26, 'ReceiveGem');
    receive.enableWrapText = false;
    receive.overflow = Label.Overflow.NONE;
    const note = ui.text(card, 'GemNote', '', 0, (receiveY - 26) * u, cw * u, 18 * u, 12 * u, PANEL_MUTED);
    fitLine(note);
    const describe = (amount: number): void => {
      const cost = amount * rate,
        missing = ken !== null && cost > ken;
      receive.string = t('gems.receive', { count: format(amount) });
      // The gem sits right before the text; centre the pair by the text's measured width.
      receive.updateRenderData(true);
      const textW = receive.node.getComponent(UITransform)!.width,
        gap = 8 * u,
        iconW = 26 * u,
        start = -(iconW + gap + textW) / 2;
      receiveGem.setPosition(start + iconW / 2, receiveY * u);
      receive.node.setPosition(start + iconW + gap + textW / 2, receiveY * u);
      note.string =
        amount === 0
          ? t('gems.minimum', { rate: format(rate) })
          : missing
            ? t('gems.missingKen', { ken: format(cost - ken!) })
            : ken === null
              ? t('gems.openInOla')
              : t('gems.uses', { ken: format(cost), rate: format(rate) });
      note.color = missing ? PANEL_ERROR : PANEL_MUTED;
    };
    describe(gems);
    // Typing updates the preview live; leaving the field rounds to whole diamonds and redraws the button.
    edit.node.on(EditBox.EventType.TEXT_CHANGED, () => describe(Math.floor(typedKen(edit.string) / rate)));
    edit.node.on(EditBox.EventType.EDITING_DID_ENDED, () => {
      state.gemAmount = Math.min(99_999, Math.floor(typedKen(edit.string) / rate));
      ctx.render();
    });

    const cost = gems * rate,
      ready = gems > 0 && (ken === null || ken >= cost);
    softButton(
      ctx,
      card,
      'gem-transfer',
      gems > 0 ? t('gems.transferAmount', { ken: format(cost) }) : t('gems.transfer'),
      0,
      layout.buttonY,
      layout.buttonWidth,
      layout.buttonHeight,
      () => app.toast(t('gems.comingSoon')),
      { primary: ready, size: 16 }
    );
    goldenIsland(ctx, card);
  },
};
