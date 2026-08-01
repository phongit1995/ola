export function hasMePostBody(
  content: string | null | undefined,
  imageCount: number,
  sticker: string | null | undefined,
  checkIn: unknown
): boolean {
  return (
    (content ?? '').trim() !== '' ||
    imageCount > 0 ||
    (sticker ?? '').trim() !== '' ||
    checkIn != null
  );
}

export function shouldCleanupRejectedPostUpload(status: number): boolean {
  return status === 0 || status >= 400;
}
