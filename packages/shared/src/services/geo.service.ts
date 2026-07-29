import { env } from '../config/env';
import {
  GEOAPIFY_NEARBY_CATEGORIES,
  GEOAPIFY_PLACES_URL,
  GEOAPIFY_REVERSE_URL,
} from '../constants/geo';
import type { GeoFeature, GeoVenue } from '../types/api/geo.type';

export type { GeoVenue } from '../types/api/geo.type';

export class GeoService {
  static get enabled(): boolean {
    return env.geoapifyKey !== '';
  }

  static async nearby(lat: number, lng: number): Promise<GeoVenue[]> {
    if (!this.enabled) return [];
    const params = new URLSearchParams({
      categories: GEOAPIFY_NEARBY_CATEGORIES,
      filter: `circle:${lng},${lat},1500`,
      bias: `proximity:${lng},${lat}`,
      limit: '24',
      apiKey: env.geoapifyKey,
    });
    const res = await fetch(`${GEOAPIFY_PLACES_URL}?${params.toString()}`);
    if (!res.ok) throw new Error(`geoapify places ${res.status}`);
    const json = (await res.json()) as { features?: GeoFeature[] };
    const seen = new Set<string>();
    const venues: GeoVenue[] = [];
    for (const feature of json.features ?? []) {
      const p = feature.properties;
      const name = p.name ?? p.street ?? p.formatted;
      if (name == null || seen.has(name)) continue;
      seen.add(name);
      venues.push({
        name,
        address: p.formatted ?? p.address_line2 ?? '',
        lat: p.lat,
        lng: p.lon,
      });
    }
    return venues;
  }

  static async reverse(lat: number, lng: number): Promise<GeoVenue | null> {
    if (!this.enabled) return null;
    const params = new URLSearchParams({
      lat: String(lat),
      lon: String(lng),
      apiKey: env.geoapifyKey,
    });
    const res = await fetch(`${GEOAPIFY_REVERSE_URL}?${params.toString()}`);
    if (!res.ok) throw new Error(`geoapify reverse ${res.status}`);
    const json = (await res.json()) as { features?: GeoFeature[] };
    const p = json.features?.[0]?.properties;
    if (p == null) return null;
    const name = p.name ?? p.street ?? p.address_line1 ?? p.formatted ?? '';
    return { name, address: p.formatted ?? '', lat, lng };
  }

  static mapLink(lat: number, lng: number): string {
    return `https://www.google.com/maps/search/?api=1&query=${lat},${lng}`;
  }
}
