import { _decorator, instantiate, Node, Prefab, ScrollView, UITransform } from 'cc';
import { AuthoredUiView } from '../shared/AuthoredUiView';
import { RecipeChoiceView } from './RecipeChoiceView';
import { IngredientItemView } from './IngredientItemView';

const { ccclass, property } = _decorator;

/** The authored production workspace. Its fixed controls and both recipe modes exist in the prefab. */
@ccclass('FactoryBodyView')
export class FactoryBodyView extends AuthoredUiView {
  @property(ScrollView) scroll: ScrollView = null!;
  @property(Node) queue: Node = null!;
  @property(Node) recipe: Node = null!;
  @property(Node) picker: Node = null!;
  @property(Prefab) recipeChoicePrefab: Prefab = null!;
  @property(Prefab) ingredientItemPrefab: Prefab = null!;
  @property({ type: [Node], tooltip: 'Linked recipe samples for the Editor; hidden during gameplay.' })
  choicePreviews: Node[] = [];
  @property({ type: [Node], tooltip: 'Linked ingredient samples for the Editor; hidden during gameplay.' })
  ingredientPreviews: Node[] = [];
  @property(Node) collect: Node = null!;
  @property(Node) produce: Node = null!;
  @property(Node) pin: Node = null!;
  private choiceViews: RecipeChoiceView[] = [];
  private ingredientViews: IngredientItemView[] = [];

  syncCards(choiceCount: number, ingredientCount: number) {
    for (const node of [...this.choicePreviews, ...this.ingredientPreviews]) node.active = false;
    return {
      choices: this.populate(this.choiceViews, this.recipeChoicePrefab, this.picker, RecipeChoiceView, choiceCount),
      ingredients: this.populate(
        this.ingredientViews,
        this.ingredientItemPrefab,
        this.recipe,
        IngredientItemView,
        ingredientCount
      ),
    };
  }

  /** Reuse live cards on refresh/resize; grow only when the current data needs more. */
  private populate<T extends AuthoredUiView>(
    pool: T[],
    prefab: Prefab,
    parent: Node,
    type: new () => T,
    count: number
  ): T[] {
    while (pool.length < count) {
      const node = instantiate(prefab);
      parent.addChild(node);
      const card = node.getComponent(type);
      if (!card) throw Error(`${prefab.name} thiếu component View.`);
      pool.push(card);
    }
    pool.forEach((card, i) => {
      card.node.active = i < count;
    });
    return pool.slice(0, count);
  }

  resizeScroll(x: number, y: number, w: number, h: number, contentHeight: number, u: number): void {
    this.place(this.scroll.node, x, y, w, h, u);
    const content = this.scroll.content!,
      viewport = content.parent!;
    this.place(viewport, 0, 0, w, h, u);
    this.place(content, -w / 2, h / 2, w, Math.max(h, contentHeight), u);
    for (const branch of [this.recipe, this.picker])
      branch.getComponent(UITransform)!.setContentSize(w * u, Math.max(h, contentHeight) * u);
  }
}
