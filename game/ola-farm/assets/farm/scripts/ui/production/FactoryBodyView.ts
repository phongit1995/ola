import { _decorator, instantiate, Mask, Node, Prefab, ScrollView, UITransform } from 'cc';
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
  private queueScroll: ScrollView | null = null;
  private boostRow: Node | null = null;
  private slotTemplate: Node | null = null;
  private queueViewportWidth = -1;
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

  /**
   * Places the authored queue row inside a horizontal scroll view, created once at runtime so larger slots can
   * overflow a narrow screen. The player's scroll position survives refreshes until the row changes width.
   */
  resizeQueue(x: number, y: number, w: number, h: number, contentWidth: number, u: number): void {
    if (!this.queueScroll) {
      const root = new Node('QueueScroll'),
        viewport = new Node('QueueViewport');
      root.layer = viewport.layer = this.queue.layer;
      this.node.insertChild(root, this.queue.getSiblingIndex());
      root.addComponent(UITransform);
      root.addChild(viewport);
      viewport.addComponent(UITransform);
      viewport.addComponent(Mask);
      viewport.addChild(this.queue);
      this.queue.getComponent(UITransform)!.setAnchorPoint(0, 0.5);
      const scroll = root.addComponent(ScrollView);
      scroll.content = this.queue;
      scroll.horizontal = true;
      scroll.vertical = false;
      scroll.inertia = true;
      scroll.cancelInnerEvents = true;
      this.queueScroll = scroll;
    }
    const root = this.queueScroll.node;
    root.setPosition(x * u, y * u);
    root.getComponent(UITransform)!.setContentSize(w * u, h * u);
    this.queue.parent!.getComponent(UITransform)!.setContentSize(w * u, h * u);
    this.queue.getComponent(UITransform)!.setContentSize(Math.max(w, contentWidth) * u, h * u);
    if (this.queueViewportWidth !== w * u) {
      this.queueViewportWidth = w * u;
      this.queue.setPosition((-w / 2) * u, 0);
    } else this.queue.setPosition(this.queue.position.x, 0);
  }

  /** Queue slot views, excluding the runtime boost row that shares their scrolling content. */
  get queueSlots(): Node[] {
    return this.queue.children.filter(node => node !== this.boostRow);
  }

  /**
   * Active queue slots for this render. The prefab authors five; ready batches can need one more, cloned from a
   * copy of the untouched first slot so the clone starts from the authored pose.
   */
  queueSlotNodes(count: number): Node[] {
    const slots = this.queueSlots;
    this.slotTemplate ??= instantiate(slots[0]);
    while (slots.length < count) {
      const clone = instantiate(this.slotTemplate);
      this.queue.insertChild(clone, slots.length);
      slots.push(clone);
    }
    slots.forEach((node, i) => {
      node.active = i < count;
    });
    return slots.slice(0, count);
  }

  /** An empty row inside the scrolling queue for this render's per-job boost buttons. */
  resetBoostRow(): Node {
    if (!this.boostRow?.isValid) {
      this.boostRow = new Node('QueueBoosts');
      this.boostRow.layer = this.queue.layer;
      this.boostRow.addComponent(UITransform).setAnchorPoint(0, 0.5);
      this.queue.addChild(this.boostRow);
    }
    for (const child of [...this.boostRow.children]) {
      child.removeFromParent();
      child.destroy();
    }
    return this.boostRow;
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
