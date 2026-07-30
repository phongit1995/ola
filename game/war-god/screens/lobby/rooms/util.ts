const DESIGN_W = 520;

export function makeOverlayInput(opts: {
  numeric?: boolean;
  secure?: boolean;
  maxLength: number;
  placeholder: string;
}): HTMLInputElement {
  const input = document.createElement('input');
  input.type = opts.secure ? 'password' : 'text';
  input.maxLength = opts.maxLength;
  input.placeholder = opts.placeholder;
  input.autocomplete = 'off';
  if (opts.numeric) {
    input.inputMode = 'numeric';
    input.addEventListener('input', () => {
      const digits = input.value.replace(/\D/g, '');
      if (input.value !== digits) input.value = digits;
    });
  }
  Object.assign(input.style, {
    position: 'absolute',
    zIndex: '10',
    boxSizing: 'border-box',
    background: 'transparent',
    border: 'none',
    outline: 'none',
    color: '#fff',
    fontFamily: "'RobotoCondensed', system-ui, sans-serif",
    fontWeight: '700',
    padding: '0 10px',
    display: 'none',
  });
  document.getElementById('app')!.appendChild(input);
  return input;
}

export function placeOverlayInput(
  input: HTMLInputElement,
  x: number,
  y: number,
  w: number,
  h: number,
  fontSize: number,
): void {
  const scale = Math.min(window.innerWidth, DESIGN_W) / DESIGN_W;
  const rootX = Math.round((window.innerWidth - DESIGN_W * scale) / 2);
  input.style.left = `${rootX + x * scale}px`;
  input.style.top = `${y * scale}px`;
  input.style.width = `${w * scale}px`;
  input.style.height = `${h * scale}px`;
  input.style.fontSize = `${fontSize * scale}px`;
}

export function betLabel(bet: number): string {
  return bet > 0 ? `${bet.toLocaleString('vi-VN')} KEN` : 'Miễn phí';
}

export function shortRoomCode(roomId: string): string {
  const clean = roomId.replace(/[^a-zA-Z0-9]/g, '');
  return (clean || roomId).slice(0, 6).toUpperCase();
}
