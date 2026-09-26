import type { ActionResult, FarmAction } from './types/ActionTypes';
import { FarmGame } from './FarmGame';

/** Applies one action to a game. The switch is exhaustive: a new action fails to compile until it is handled here. */
export function applyAction(game: FarmGame, action: FarmAction): ActionResult {
  switch (action.type) {
    case 'moveBuilding':
      return game.moveBuilding(action.building, action.position);
    case 'plant':
      return game.plant(action.plot, action.crop);
    case 'harvest':
      return game.harvest(action.plot);
    case 'cancel':
      return game.cancel(action.plot);
    case 'boost':
      return game.boost(action.plot);
    case 'improve':
      return game.improve(action.plot);
    case 'rescue':
      return game.rescue();
    case 'dismissGuide':
      return game.dismissGuide();
    case 'produce':
      return game.produce(action.recipe, action.machine);
    case 'collect':
      return game.collect(action.machine, action.batch);
    case 'collectAll':
      return game.collectAll(action.machine);
    case 'cancelQueued':
      return game.cancelQueued(action.machine, action.job);
    case 'expandQueue':
      return game.expandQueue(action.machine);
    case 'boostMachine':
      return game.boostMachine(action.machine);
    case 'buyMachine':
      return game.buyMachine(action.machineType, action.building);
    case 'sellItem':
      return game.sellItem(action.item, action.quantity);
    case 'setPenSpecies':
      return game.setPenSpecies(action.plot, action.species);
    case 'buyAnimal':
      return game.buyAnimal(action.plot, action.slot);
    case 'buyPen':
      return game.buyPen(action.plot);
    case 'expandPen':
      return game.expandPen(action.plot, action.slot);
    case 'sellAnimal':
      return game.sellAnimal(action.plot, action.animal);
    case 'feedAnimals':
      return game.feedAnimals(action.plot, action.animal);
    case 'boostAnimal':
      return game.boostAnimal(action.plot, action.animal);
    case 'collectAnimals':
      return game.collectAnimals(action.plot, action.animal);
    case 'buyCoins':
      return game.buyCoins(action.pack);
    default: {
      const unknown: never = action;
      throw Error('Thao tác không được hỗ trợ: ' + JSON.stringify(unknown));
    }
  }
}
