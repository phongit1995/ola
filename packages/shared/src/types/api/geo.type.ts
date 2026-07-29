export interface GeoVenue {
  name: string;
  address: string;
  lat: number;
  lng: number;
}

export interface GeoFeature {
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
