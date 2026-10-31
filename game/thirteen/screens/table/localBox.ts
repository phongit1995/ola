export interface LocalBox {
  left: number;
  top: number;
  width: number;
  height: number;
}

export function localBox(element: HTMLElement, root: HTMLElement): LocalBox {
  let left = 0;
  let top = 0;
  let node: HTMLElement | null = element;
  while (node && node !== root) {
    left += node.offsetLeft;
    top += node.offsetTop;
    const parent = node.offsetParent as HTMLElement | null;
    if (parent && parent !== root) {
      left += parent.clientLeft;
      top += parent.clientTop;
    }
    node = parent;
  }
  return { left, top, width: element.offsetWidth, height: element.offsetHeight };
}

export function tableRoot(element: Element | null): HTMLElement | null {
  return element?.closest<HTMLElement>('.tl-table-screen') ?? null;
}
