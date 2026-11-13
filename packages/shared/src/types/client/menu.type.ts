export interface MenuOption {
  key: string;
  label: string;
  danger?: boolean;
  onSelect: () => void;
}
