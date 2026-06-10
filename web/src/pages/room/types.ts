export interface Room {
  id: string;
  title: string;
  subtitle: string;
  members: number;
  color: string;
}

export interface RoomFilters {
  showAll: boolean;
  media: boolean;
  female: boolean;
  male: boolean;
  flexible: boolean;
}
