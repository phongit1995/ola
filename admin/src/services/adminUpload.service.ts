import http from '@/api/http'
import type { ApiResponse } from '@/types'

export const AdminUploadService = {
  async image(file: File): Promise<string> {
    const form = new FormData()
    form.append('file', file)
    const { data } = await http.post<ApiResponse<{ url: string }>>('/admin/upload', form, {
      headers: { 'Content-Type': 'multipart/form-data' },
    })
    return data.data.url
  },
}
