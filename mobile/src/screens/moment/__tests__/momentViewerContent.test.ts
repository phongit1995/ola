import { momentViewerContent } from '../utils';

describe('momentViewerContent', () => {
  it('fills the width when the crop stays within the limit', () => {
    const content = momentViewerContent(393, 640);
    expect(content.width).toBe(393);
    expect(content.height).toBe(640);
  });

  it('keeps the whole 9:16 canvas on a tall screen', () => {
    const content = momentViewerContent(393, 852);
    expect(content.width).toBe(393);
    expect(content.height).toBeCloseTo((393 * 16) / 9);
  });

  it('falls back to an uncropped 9:16 fit when filling the width would crop too much', () => {
    const content = momentViewerContent(393, 600);
    expect(content.width).toBeCloseTo(337.5);
    expect(content.height).toBeCloseTo(600);
  });

  it('fits a wide screen without cropping', () => {
    const content = momentViewerContent(768, 1000);
    expect(content.width).toBeCloseTo(562.5);
    expect(content.height).toBeCloseTo(1000);
  });
});
