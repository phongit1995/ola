import type { ArtLoadProgress } from '../../render/types/Art.types';

export const STATUS: Record<ArtLoadProgress['phase'], string> = {
  data: 'Đang chuẩn bị nông trại…',
  town: 'Đang tải nhà cửa và cây trồng…',
  ported: 'Đang tải tài nguyên…',
  'town-ui': 'Đang chuẩn bị cửa hàng…',
  'plot-ui': 'Đang chuẩn bị ruộng vườn…',
  'island-ui': 'Đang chuẩn bị các bảng điều khiển…',
  ready: 'Đang mở nông trại…',
};
