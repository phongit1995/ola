export const HTTP_STATUS = {
  unauthorized: 401,
  forbidden: 403,
  notFound: 404,
  conflict: 409,
  locked: 423,
  tooManyRequests: 429,
  serverError: 500,
} as const;
