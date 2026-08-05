import { xhrChatBotTransport } from '@ola/shared/services/chatBotXhrTransport';
import type { ChatBotRequest } from '@ola/shared/services';

const HEADERS_RECEIVED = 2;
const LOADING = 3;
const DONE = 4;

class FakeXhr {
  static instances: FakeXhr[] = [];
  static LOADING = LOADING;

  readyState = 0;
  status = 0;
  statusText = '';
  responseType = '';
  responseText = '';
  sentBody: string | null = null;
  aborted = false;
  requestHeaders: Record<string, string> = {};
  method = '';
  url = '';

  onreadystatechange: (() => void) | null = null;
  onprogress: (() => void) | null = null;
  onload: (() => void) | null = null;
  onerror: (() => void) | null = null;
  onabort: (() => void) | null = null;

  constructor() {
    FakeXhr.instances.push(this);
  }

  open(method: string, url: string) {
    this.method = method;
    this.url = url;
    this.readyState = 1;
  }

  setRequestHeader(name: string, value: string) {
    this.requestHeaders[name] = value;
  }

  send(body: string | null) {
    this.sentBody = body;
  }

  abort() {
    this.aborted = true;
    this.onabort?.();
  }

  respondHeaders(status: number, statusText = '') {
    this.status = status;
    this.statusText = statusText;
    this.readyState = HEADERS_RECEIVED;
    this.onreadystatechange?.();
  }

  pushText(text: string) {
    this.responseText += text;
    this.readyState = LOADING;
    this.onreadystatechange?.();
    this.onprogress?.();
  }

  finish() {
    this.readyState = DONE;
    this.onreadystatechange?.();
    this.onload?.();
  }

  failNetwork() {
    this.readyState = DONE;
    this.onerror?.();
  }
}

const request: ChatBotRequest = {
  url: 'https://api.test/api/v1/chat-bot',
  init: {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Authorization: 'Bearer t' },
    body: '{"messages":[],"stream":true}',
  },
};

function installFakeXhr() {
  FakeXhr.instances = [];
  (globalThis as { XMLHttpRequest?: unknown }).XMLHttpRequest = FakeXhr;
}

function latestXhr(): FakeXhr {
  const xhr = FakeXhr.instances.at(-1);
  if (xhr == null) throw new Error('no xhr created');
  return xhr;
}

const flush = () => new Promise<void>((resolve) => setImmediate(() => resolve()));

describe('xhrChatBotTransport', () => {
  beforeEach(installFakeXhr);

  it('gửi đúng method, url, header và body', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    expect(xhr.method).toBe('POST');
    expect(xhr.url).toBe(request.url);
    expect(xhr.responseType).toBe('text');
    expect(xhr.requestHeaders.Authorization).toBe('Bearer t');
    expect(xhr.sentBody).toBe(request.init.body);

    xhr.respondHeaders(200);
    await expect(pending).resolves.toMatchObject({ status: 200 });
  });

  it('phát text tăng dần theo từng lần progress, không lặp lại phần cũ', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(200);
    const response = await pending;
    if (response == null) throw new Error('response is null');

    const chunks: string[] = [];
    const streamed = response.readStream((text) => {
      chunks.push(text);
      return true;
    });

    xhr.pushText('data: {"delta":"Chào "}\n\n');
    xhr.pushText('data: {"delta":"bạn"}\n\n');
    xhr.finish();
    await streamed;

    expect(chunks).toEqual([
      'data: {"delta":"Chào "}\n\n',
      'data: {"delta":"bạn"}\n\n',
    ]);
  });

  it('flush phần text đã về trước khi readStream kịp gắn', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(200);
    const response = await pending;
    if (response == null) throw new Error('response is null');

    xhr.pushText('data: {"delta":"sớm"}\n\n');

    const chunks: string[] = [];
    const streamed = response.readStream((text) => {
      chunks.push(text);
      return true;
    });
    xhr.finish();
    await streamed;

    expect(chunks).toEqual(['data: {"delta":"sớm"}\n\n']);
  });

  it('dừng đọc và huỷ request khi consumer trả false', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(200);
    const response = await pending;
    if (response == null) throw new Error('response is null');

    const chunks: string[] = [];
    const streamed = response.readStream((text) => {
      chunks.push(text);
      return false;
    });

    xhr.pushText('data: [DONE]\n\n');
    await streamed;

    expect(chunks).toHaveLength(1);
    expect(xhr.aborted).toBe(true);
  });

  it('readErrorMessage đợi body xong rồi lấy field error', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(502, 'Bad Gateway');
    const response = await pending;
    if (response == null) throw new Error('response is null');
    expect(response.status).toBe(502);

    const message = response.readErrorMessage();
    xhr.pushText('{"error":"chat bot upstream rejected request"}');
    xhr.finish();

    await expect(message).resolves.toBe('chat bot upstream rejected request');
  });

  it('trả null khi signal đã abort từ trước', async () => {
    const controller = new AbortController();
    controller.abort();
    await expect(
      xhrChatBotTransport(request, controller.signal)
    ).resolves.toBeNull();
    expect(FakeXhr.instances).toHaveLength(0);
  });

  it('abort giữa chừng thì kết thúc stream mà không ném lỗi', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(200);
    const response = await pending;
    if (response == null) throw new Error('response is null');

    const streamed = response.readStream(() => true);
    xhr.pushText('data: {"delta":"đang gõ"}\n\n');
    controller.abort();

    await expect(streamed).resolves.toBeUndefined();
    expect(xhr.aborted).toBe(true);
  });

  it('lỗi mạng khi đang stream thì ném ChatBotStreamError network', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    const xhr = latestXhr();
    xhr.respondHeaders(200);
    const response = await pending;
    if (response == null) throw new Error('response is null');

    const streamed = response.readStream(() => true);
    xhr.failNetwork();

    await expect(streamed).rejects.toMatchObject({ code: 'network' });
  });

  it('lỗi mạng trước khi có header thì reject ngay', async () => {
    const controller = new AbortController();
    const pending = xhrChatBotTransport(request, controller.signal);
    await flush();

    latestXhr().failNetwork();
    await expect(pending).rejects.toMatchObject({ code: 'network' });
  });
});
