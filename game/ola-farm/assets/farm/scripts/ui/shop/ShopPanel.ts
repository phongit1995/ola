import { penNames } from '../../core/constants/HusbandryDefaults';
import { penPlotId } from '../../core/FarmCatalog';
import type { ConstructionOffer } from '../../core/types/ConstructionTypes';
import type { PanelContext, PanelDefinition } from '../shared/PanelContext.types';
import type { ShopEntry } from './ShopView.types';
import { ShopView } from './ShopView';
import { t } from '../../core/i18n/I18n';
import { contentName } from '../../core/i18n/LocalizeContent';
import { SHORT_MACHINE_NAMES } from './ShopPanel.constants';

function construction(
  ctx: PanelContext,
  offer: ConstructionOffer,
  detail: string
): Pick<ShopEntry, 'quantity' | 'description' | 'detail' | 'label' | 'coinPrice' | 'locked' | 'enabled'> {
  const full = offer.count >= offer.limit,
    price = offer.price;
  return {
    quantity: `${offer.count}/${offer.limit}`,
    description: !offer.unlocked
      ? offer.reason
      : price !== null && ctx.farm.coins < price
        ? t('shop.needMoreCoins', { coins: price - ctx.farm.coins })
        : detail,
    detail: true,
    label: full
      ? t('build.limitReached', { limit: offer.limit })
      : price === null
        ? t('shop.cannotBuild')
        : String(price),
    coinPrice: !full && price !== null ? price : undefined,
    locked: !full && !offer.unlocked,
    enabled: ctx.canAct && offer.unlocked && !full && price !== null && ctx.farm.coins >= price,
  };
}

function entries(ctx: PanelContext): ShopEntry[] {
  const { app, state, game } = ctx;
  if (state.shopTab === 'buildings')
    return game.machineTypes.map(type => {
      const offer = game.machineConstructionOffer(type.id);
      const name = (SHORT_MACHINE_NAMES[type.id] ? t(SHORT_MACHINE_NAMES[type.id]) : undefined) ?? type.name;
      return {
        id: 'shop-machine-' + type.id,
        name,
        prefab: type.prefab,
        ...construction(
          ctx,
          offer,
          t('shop.buildMachine', {
            number: offer.count + 1,
            count: game.catalog.products.filter(r => r.machine === type.id).length,
          })
        ),
        buy: () => {
          if (!offer.buildingId) return;
          const building = offer.buildingId;
          app.act({ type: 'buyMachine', machineType: type.id, building }, 'Click 1', () => {
            app.close();
            app.focusBuilding(building);
          });
        },
      };
    });
  return (game.catalog.livestock ?? []).flatMap(type => {
    const first = game.catalog.residentPens?.find(site => site.species === type.key);
    if (!first) return [];
    const offer = game.penConstructionOffer(type.key);
    const prefab = (
      { layer: 'yard-coop', 'dairy-cow': 'yard-cowshed', pig: 'yard-pigpen', sheep: 'yard-sheepfold' } as Record<
        string,
        string
      >
    )[type.key];
    return [
      {
        id: 'shop-animal-' + penPlotId(first),
        name: penNames[type.key] ? contentName(penNames[type.key]) : type.name,
        prefab,
        ...construction(
          ctx,
          offer,
          t('shop.buildPen', { number: offer.count + 1, count: game.startingAnimals(type.key) })
        ),
        buy: () => {
          if (offer.plotId === undefined || !offer.buildingId) return;
          const building = offer.buildingId;
          app.act({ type: 'buyPen', plot: offer.plotId }, 'Click 1', () => {
            app.close();
            app.focusBuilding(building);
          });
        },
      },
    ];
  });
}

/** Construction counts houses. Animal slots and purchases belong to the selected pen. */
export const shopPanel: PanelDefinition = {
  title: () => t('shop.title'),
  render(ctx): void {
    ctx.card.getComponent(ShopView)!.render(ctx, entries(ctx));
  },
};
