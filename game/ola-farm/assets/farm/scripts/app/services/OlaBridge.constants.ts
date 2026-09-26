/** Mirrors packages/shared/src/constants/arcadeBridge.ts; the Cocos project cannot import the monorepo package. */
export const OLA_BRIDGE_SOURCE = { Game: 'ola-game', Host: 'ola-host' } as const;

export const OLA_BRIDGE_EVENT = { Ready: 'ready', Exit: 'exit', GetToken: 'get_token', Token: 'token' } as const;

/** Same wait as the arcade SDK (game/src/sdk/bridge.ts) before a silent host counts as no token. */
export const TOKEN_TIMEOUT_MS = 8000;
