export interface KenUpdatedEvent {
  ken?: number;
}

export interface KenChestAvailableEvent {
  id: string;
  expiresAt: string;
}

export interface KenChestClosedEvent {
  id: string;
}
