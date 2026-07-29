import type { ReactNode } from 'react';

export const URL_SOURCE = 'https?:\\/\\/[^\\s]+|www\\.[^\\s]+';
export const URL_TOKEN_PATTERN = new RegExp(`^(?:${URL_SOURCE})$`);
export const URL_LINK_CLASS = 'text-ola-primary-darker underline break-all';

const URL_TRAILING_PUNCTUATION = /[.,;:!?)\]}'"]+$/;

export function isUrlToken(part: string): boolean {
  return URL_TOKEN_PATTERN.test(part);
}

export function renderUrlToken(part: string, key: number): ReactNode {
  const trailingMatch = part.match(URL_TRAILING_PUNCTUATION);
  const trailing = trailingMatch == null ? '' : trailingMatch[0];
  const url =
    trailing === '' ? part : part.slice(0, part.length - trailing.length);
  const href = url.startsWith('www.') ? `https://${url}` : url;
  return (
    <span key={key}>
      <a
        href={href}
        target="_blank"
        rel="noopener noreferrer"
        onClick={(event) => event.stopPropagation()}
        className={URL_LINK_CLASS}
      >
        {url}
      </a>
      {trailing}
    </span>
  );
}
