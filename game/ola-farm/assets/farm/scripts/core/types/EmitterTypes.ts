export type Listener<A extends unknown[]> = (...args: A) => void;

export type AnyListener = Listener<unknown[]>;
