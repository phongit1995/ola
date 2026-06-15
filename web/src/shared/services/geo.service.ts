import { env } from '@config';

export interface GeoVenue {
  name: string;
  address: string;
  lat: number;
  lng: number;
}

const PLACES_URL = 'https://api.geoapify.com/v2/places';
const REVERSE_URL = 'https://api.geoapify.com/v1/geocode/reverse';
const NEARBY_CATEGORIES = 'catering,commercial,leisure,tourism,accommodation,education,office';

export class GeoService {
  static get enabled(): boolean {
    return env.geoapifyKey !== '';
  }

  static async nearby(lat: number, lng: number): Promise<GeoVenue[]> {
    if (!this.enabled) return [];
    const params = new URLSearchParams({
      categories: NEARBY_CATEGORIES,
      filter: `circle:${lng},${lat},1500`,
      bias: `proximity:${lng},${lat}`,
      limit: '24',
      apiKey: env.geoapifyKey,
    });
    const res = await fetch(`${PLACES_URL}?${params.toString()}`);
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
    const res = await fetch(`${REVERSE_URL}?${params.toString()}`);
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

interface GeoFeature {
  properties: {
    name?: string;
    street?: string;
    formatted?: string;
    address_line1?: string;
    address_line2?: string;
    lat: number;
    lon: number;
  };
}
