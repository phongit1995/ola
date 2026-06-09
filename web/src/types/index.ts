// Kiểu dữ liệu dùng chung toàn app khai báo ở đây.

export interface Room {
  id: number;
  name: string;
  description?: string;
  memberCount?: number;
}
