import { env } from '@config';

export interface GeoVenue {
  name: string;
  address: string;
  lat: number;
  lng: number;
}

const PLACES_URL = 'https://api.geoapify.com/v2/places';
const STATIC_MAP_URL = 'https://maps.geoapify.com/v1/staticmap';
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

  static staticMap(lat: number, lng: number, width = 600, height = 240): string {
    if (!this.enabled) return '';
    const params = new URLSearchParams({
      style: 'osm-bright',
      width: String(width),
      height: String(height),
      center: `lonlat:${lng},${lat}`,
      zoom: '15',
      marker: `lonlat:${lng},${lat};type:material;color:%23e63946;size:medium`,
      apiKey: env.geoapifyKey,
    });
    return `${STATIC_MAP_URL}?${params.toString()}`;
  }
}

interface GeoFeature {
  properties: {
    name?: string;
    street?: string;
    formatted?: string;
    address_line2?: string;
    lat: number;
    lon: number;
  };
}
