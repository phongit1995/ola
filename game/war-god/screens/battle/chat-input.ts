export interface ChatInputController {
  takeValue(): string;
  clear(): void;
  append(text: string): void;
  layout(left: number, top: number, width: number, height: number, fontSize: number): void;
  setVisible(visible: boolean): void;
  dispose(): void;
}

interface ChatInputOptions {
  onSubmit(): void;
  onFocusChange(focused: boolean): void;
}

export function createChatInput(options: ChatInputOptions): ChatInputController {
  const input = document.createElement('input');
  if (window.ReactNativeWebView == null) input.className = 'war-god-web-chat-input';
  input.type = 'text';
  input.maxLength = 120;
  input.placeholder = 'Nhập tin nhắn...';
  Object.assign(input.style, {
    position: 'absolute',
    zIndex: '10',
    background: 'transparent',
    border: 'none',
    outline: 'none',
    color: '#fff',
    fontFamily: "'RobotoCondensed', system-ui, sans-serif",
    fontWeight: '700',
    padding: '0 8px',
    display: 'none',
  });
  const onKeyDown = (event: KeyboardEvent): void => {
    if (event.key === 'Enter') options.onSubmit();
  };
  const onFocus = (): void => options.onFocusChange(true);
  const onBlur = (): void => options.onFocusChange(false);
  input.addEventListener('keydown', onKeyDown);
  input.addEventListener('focus', onFocus);
  input.addEventListener('blur', onBlur);
  document.getElementById('app')!.appendChild(input);

  return {
    takeValue(): string {
      const value = input.value.trim().slice(0, input.maxLength);
      input.value = '';
      return value;
    },
    clear: () => {
      input.value = '';
    },
    append(text: string): void {
      input.value = `${input.value}${text}`.trimStart().slice(0, input.maxLength);
    },
    layout(left, top, width, height, fontSize): void {
      input.style.left = `${left}px`;
      input.style.top = `${top}px`;
      input.style.width = `${width}px`;
      input.style.height = `${height}px`;
      input.style.fontSize = `${fontSize}px`;
    },
    setVisible(visible: boolean): void {
      if (!visible) input.blur();
      input.style.display = visible ? 'block' : 'none';
    },
    dispose(): void {
      input.removeEventListener('keydown', onKeyDown);
      input.removeEventListener('focus', onFocus);
      input.removeEventListener('blur', onBlur);
      input.remove();
    },
  };
}
