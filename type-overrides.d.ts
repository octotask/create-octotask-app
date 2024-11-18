// type-overrides.d.ts
import "lru-cache";

declare module "lru-cache" {
  interface LRUCache<K, V, FC> {
    entries: () => Map<K, V>;
    keys: () => IterableIterator<K>;
    values: () => IterableIterator<V>;
    [Symbol.iterator]: () => IterableIterator<[K, V]>;
  }
}
