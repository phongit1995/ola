# Word-chain status icons — pack A

Generated with the built-in image generation tool, using row A of the selected style sheet as reference. Each icon was generated separately with transparent alpha; export only trims transparent margins and scales to 144 × 144 (WebP). No color-based background removal.

Files: `web/src/assets/icons/word-chain/status/*.webp` (moved out of `src/assets` together with this note). The WebP export also bakes in the old CSS filter `saturate(0.85) brightness(1.04)`, so the UI no longer applies it.

UI: 28px corner reactions, 24px inline trophy. Mappings: `ok` → correct, `win` → win, `invalid_format` → warning, `mismatch`/`repeated`/`not_in_dict` → error.

## Minimize header icon

`web/src/assets/icons/word-chain/minimize.webp` uses candidate 02 (rounded green square with a gold minus), generated with the built-in image tool using the existing trophy, rules, lookup and correct icons as style references.

Export: preserve generated alpha, trim transparent padding, then fit within a 132px box on a transparent 144 × 144 WebP canvas. Display at 34 × 34 CSS pixels inside a 44 × 44 button, to the right of Rules. Its painted height is about 31px, matching the trophy and rules icons despite their different transparent margins. No CSS color filter is applied.

Variant prompt: A plump rounded-square green button with a wide golden-yellow horizontal minus centered inside. Match the green book cover's rounded bevel and forest-green contour. The golden minus is thick and softly rounded. One restrained highlight on the upper-left corner. No other symbols.

## Buy guesses button icon

`web/src/assets/icons/word-chain/buy-guesses.webp` combines candidate 02 (green ticket) with the plus from candidate 07, generated with the built-in image tool in the same style as the minimize and hint icons. Drafts are not committed.

Export: preserve generated alpha, trim transparent padding (12px margin at the 1024px source), then scale to a 144 × 89 WebP. Display at `h-5 w-auto` (about 32 × 20 CSS pixels) left of the "Mua lượt" label in the composer's primary button, which uses `px-3 gap-1` instead of the send button's `px-4` so the input keeps room at 360px. No CSS color filter is applied.

## Generation prompts

### correct.png

Use case: precise-object-edit. Input image: reference sheet of styles, ONLY use its TOP ROW A. Deliver ONE standalone production UI icon, not a sheet. Match row A's friendly illustrated design, thick smooth forest-green contour, rich leaf green/gold/pink palette, soft two-tone highlights. Recreate clean antialiased artwork, preserving row A identity. Square canvas, icon centered and filling 90-94% of width/height; minimal transparent margins. A genuinely transparent PNG alpha outside the icon, no background card, no dark backdrop, no cast glow, no text or letters, no watermark, no extra icons. Used at 28px in corner of chat bubble, so keep major glyph bold. Recreate TOP ROW A FIRST icon only: green round medallion with bold white check dark-green outline, small leaf lower-left, tiny pink heart lower-right, two tiny amber rays upper-right. Same cheerful style.

### win.png

Use case: precise-object-edit. Input image: reference sheet of styles, ONLY use its TOP ROW A. Deliver ONE standalone production UI icon, not a sheet. Match row A's friendly illustrated design, thick smooth forest-green contour, rich leaf green/gold/pink palette, soft two-tone highlights. Recreate clean antialiased artwork, preserving row A identity. Square canvas, icon centered and filling 90-94% of width/height; minimal transparent margins. A genuinely transparent PNG alpha outside the icon, no background card, no dark backdrop, no cast glow, no text or letters, no watermark, no extra icons. Used at 28px in corner of chat bubble, so keep major glyph bold. Recreate TOP ROW A SECOND icon only: gold cup trophy with two handles, white/gold star centered on cup, pink ribbon tails on both sides at base, dark green outlines, three short amber rays above. Trophy silhouette must remain very clear.

### warning.png

Use case: precise-object-edit. Input image: reference sheet of styles, ONLY use its TOP ROW A. Deliver ONE standalone production UI icon, not a sheet. Match row A's friendly illustrated design, thick smooth forest-green contour, rich leaf green/gold/pink palette, soft two-tone highlights. Recreate clean antialiased artwork, preserving row A identity. Square canvas, icon centered and filling 90-94% of width/height; minimal transparent margins. A genuinely transparent PNG alpha outside the icon, no background card, no dark backdrop, no cast glow, no text or letters, no watermark, no extra icons. Used at 28px in corner of chat bubble, so keep major glyph bold. Recreate TOP ROW A THIRD icon only: rounded amber triangular caution sign with dark green exclamation mark, forest-green outline, small leaf lower-left, two tiny amber rays upper-right, soft light inner rim.

### error.png

Use case: precise-object-edit. Input image: reference sheet of styles, ONLY use its TOP ROW A. Deliver ONE standalone production UI icon, not a sheet. Match row A's friendly illustrated design, thick smooth forest-green contour, rich leaf green/gold/pink palette, soft two-tone highlights. Recreate clean antialiased artwork, preserving row A identity. Square canvas, icon centered and filling 90-94% of width/height; minimal transparent margins. A genuinely transparent PNG alpha outside the icon, no background card, no dark backdrop, no cast glow, no text or letters, no watermark, no extra icons. Used at 28px in corner of chat bubble, so keep major glyph bold. Recreate TOP ROW A FOURTH icon only: pink-red round medallion with bold white X outlined in dark reddish green, thick forest-green contour, small green leaves lower-left and two tiny pink rays upper-right. Same visual size as check medallion.
