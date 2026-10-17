export {};

declare global {
  interface IdleDeadline {
    readonly didTimeout: boolean;
    timeRemaining(): number;
  }

  function requestIdleCallback(
    callback: (deadline: IdleDeadline) => void,
    options?: { timeout?: number },
  ): number;

  function cancelIdleCallback(handle: number): void;
}
