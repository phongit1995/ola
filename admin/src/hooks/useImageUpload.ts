import { useMutation } from '@tanstack/react-query'
import { AdminUploadService } from '@/services/adminUpload.service'

export function useImageUpload() {
  return useMutation({
    mutationFn: (file: File) => AdminUploadService.image(file),
  })
}
