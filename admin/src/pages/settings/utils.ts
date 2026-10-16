export function parseServiceAccount(text: string): Record<string, unknown> {
  let parsed: unknown
  try {
    parsed = JSON.parse(text)
  } catch {
    throw new Error('Nội dung không phải JSON hợp lệ')
  }
  if (parsed == null || typeof parsed !== 'object' || Array.isArray(parsed)) {
    throw new Error('Nội dung không phải JSON hợp lệ')
  }
  const value = parsed as Record<string, unknown>
  if (value.type !== 'service_account') {
    throw new Error('File phải là service account JSON (type = service_account)')
  }
  if (!value.project_id || !value.private_key || !value.client_email) {
    throw new Error('Service account JSON thiếu project_id, private_key hoặc client_email')
  }
  return value
}
