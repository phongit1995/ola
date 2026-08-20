# 01 — Art direction: Chiếu Bài Ngày Vui

## 1. DNA hình ảnh

Style 02 có năm đặc tính bắt buộc:

1. **Sáng** — phần lớn diện tích nằm trong dải kem hoặc aqua sáng, không có nền tối toàn màn.
2. **Phẳng có chiều sâu vừa đủ** — hình khối chủ yếu từ fill, outline và một shadow ngắn; không mô phỏng vật liệu nặng.
3. **Tròn nhưng không trẻ con** — góc bo rộng, icon thân thiện, typography chắc; tránh bubble quá mềm.
4. **Có nhịp Việt hiện đại** — gợi chiếu đan bằng pattern hình học cực nhẹ và màu ngày hội, không dùng minh họa dân gian rườm rà.
5. **Chính xác như design system** — mọi viền, radius, padding, icon và khoảng cách có số đo cố định; không chấp nhận sai lệch ngẫu nhiên từ ảnh sinh.

Ba từ khóa duyệt nhanh: **tươi — rõ — có nhịp**.

Ba từ khóa loại: **bóng — nặng — giả vật liệu**.

## 2. Tỷ lệ thị giác

Trên một màn điển hình:

- 55–72% diện tích: `mat.aqua`;
- 18–35%: `cream`;
- 5–10%: navy gồm chữ và outline;
- 4–9%: vàng CTA;
- 2–5%: coral nhấn;
- dưới 3%: tím/xanh/coral avatar phụ.

Không để vàng hoặc coral trở thành nền toàn panel lớn. Navy không được phủ thành mảng nền lớn trừ overlay đặc biệt.

## 3. Palette chuẩn

### 3.1 Core tokens

| Token | Hex | Vai trò |
|---|---:|---|
| `cream.50` | `#FFFDF5` | highlight, surface sáng nhất |
| `cream.100` | `#FFF9E8` | nền top bar và page |
| `cream.200` | `#F8EFD7` | surface phụ, disabled nhẹ |
| `cream.300` | `#E8DDBF` | border phụ/track trên kem |
| `aqua.100` | `#BCEFE7` | disabled aqua, selected tint |
| `aqua.300` | `#6EDDD2` | highlight chiếu |
| `aqua.400` | `#4FD1C7` | mặt chiếu chính |
| `aqua.500` | `#2FBEB5` | dot/active teal |
| `teal.600` | `#179E9A` | dữ liệu phụ, link |
| `teal.700` | `#117B7B` | text teal có contrast |
| `navy.700` | `#17496B` | icon phụ/outline nhạt |
| `navy.800` | `#0D3B5C` | outline chính |
| `navy.900` | `#082E4A` | chữ chính |
| `sun.300` | `#FFD867` | highlight CTA |
| `sun.400` | `#FFC83D` | CTA chính |
| `sun.500` | `#F7B725` | pressed/đáy CTA |
| `coral.300` | `#FF8A78` | nhấn nhẹ |
| `coral.400` | `#FF6F61` | đường biên, danger mềm |
| `coral.500` | `#E9574D` | text danger đạt contrast |
| `violet.400` | `#A56AF2` | avatar option |
| `blue.400` | `#6988F5` | avatar option |
| `white` | `#FFFFFF` | lá bài/icon nội dung nhỏ |

### 3.2 Semantic tokens

| Token | Map mặc định | Dùng cho |
|---|---|---|
| `page.bg` | `cream.100` | nền app ngoài chiếu |
| `mat.bg` | `aqua.400` | mặt chiếu/play field |
| `mat.pattern` | `teal.600` @ 4% | texture đan |
| `surface.default` | `cream.50` | row, modal, input |
| `surface.subtle` | `cream.100` | button phụ |
| `surface.selected` | `aqua.100` | row/chip được chọn |
| `border.default` | `navy.800` | viền chính |
| `border.soft` | `navy.700` @ 32% | divider phụ |
| `text.primary` | `navy.900` | chữ chính |
| `text.secondary` | `teal.700` | dữ liệu phụ |
| `text.on-action` | `navy.900` | chữ trên vàng |
| `action.primary` | `sun.400` | CTA |
| `action.primary-pressed` | `sun.500` | CTA pressed |
| `action.secondary` | `cream.50` | nút phụ |
| `status.success` | `teal.600` | sẵn sàng, vào bàn |
| `status.warning` | `sun.500` | chủ bàn, timer thấp |
| `status.danger` | `coral.500` | mất kết nối, rời bàn |
| `focus.ring` | `blue.400` | focus keyboard |

### 3.3 Quy tắc tương phản

- `text.primary` trên cream: tối thiểu 10:1.
- `text.primary` trên vàng: tối thiểu 8:1.
- `text.primary` trên aqua: tối thiểu 6.5:1.
- chữ nhỏ teal chỉ dùng `teal.700`, không dùng `aqua.500`.
- coral làm text phải dùng `coral.500` và font weight ≥700.
- text disabled vẫn phải đạt 3:1; trạng thái còn được biểu thị bằng icon/label.

## 4. Hình học

### 4.1 Border

Scale duy nhất:

- `border.hairline`: 1 px — divider nội bộ, không bao component tương tác;
- `border.control`: 2 px — nút, input, avatar, row, modal;
- `border.emphasis`: 3 px — CTA lớn hoặc turn ring;
- `border.decorative`: 4 px — chỉ hai đường cong biên chiếu ở màn lớn.

Màu border tương tác mặc định `navy.800`. Không có double border trên button. Không dùng outline đen.

### 4.2 Radius

| Token | px | Dùng cho |
|---|---:|---|
| `radius.xs` | 8 | badge nhỏ, input compact |
| `radius.sm` | 12 | icon button, chip |
| `radius.md` | 16 | button chuẩn, room row |
| `radius.lg` | 20 | modal, CTA lớn |
| `radius.xl` | 28 | plaque/logo region |
| `radius.pill` | 999 | avatar, nameplate, pill |

Không tự tạo radius 14, 18, 22 hoặc 24 nếu không có lý do layout rõ ràng.

### 4.3 Stroke cap và icon

- SVG icon dùng `stroke-linecap="round"`, `stroke-linejoin="round"`.
- Stroke 2 px trong viewBox 24; icon hero 2.5 px.
- Icon dùng một màu, không gradient.
- Kích thước hình thấy được chiếm 50–58% vùng chạm.
- Mũi tên back, chat, refresh, lock, close và send phải cùng một bộ nét.

## 5. Chiếu bài và đường biên

“Chiếu” là mảng aqua phẳng có pattern dệt hình thoi rất nhẹ.

Pattern chuẩn:

- tile 24 × 24 CSS px hoặc 48 × 48 source px;
- nét 1 px;
- hai đường chéo tạo hình thoi, có thể thêm một cạnh gấp nhỏ;
- màu `teal.600` ở opacity 3–5%;
- không có noise hạt;
- không làm texture đậm dưới text, bài hoặc nút.

Đường biên ngày vui:

- một đường coral 4 px;
- một khoảng cream 6–8 px;
- một đường teal/navy 2 px;
- đường cong rộng và liên tục;
- không có ornament ở góc;
- trên lobby, đường cong phân tách header kem và thân aqua;
- trên table, đường cong xuất hiện ở trên và dưới để gợi mặt chiếu lớn.

## 6. Typography

### 6.1 Font

Ưu tiên:

- display/CTA: `Baloo 2` 700–800 hoặc `Nunito Sans` 800 nếu cần giảm tính hoạt hình;
- body/UI: `Nunito Sans` 600–800;
- fallback: `Arial Rounded MT Bold`, `Arial`, sans-serif.

Không dùng serif, handwritten, condensed hoặc font có hiệu ứng in nổi.

### 6.2 Type scale tại viewport 390

| Token | Size/line | Weight | Dùng cho |
|---|---:|---:|---|
| `display.xl` | 44/46 | 800 | logo “TIẾN LÊN” lobby |
| `display.md` | 28/32 | 800 | result/title modal lớn |
| `title.lg` | 20/26 | 800 | CTA, title phòng |
| `title.md` | 17/22 | 800 | room name, section |
| `body.lg` | 16/22 | 700 | button chuẩn |
| `body.md` | 14/20 | 700 | nội dung row |
| `body.sm` | 12/17 | 700 | meta/subtitle |
| `label.xs` | 11/14 | 800 | badge |

Letter spacing:

- logo chính: `0.01em`;
- “MIỀN NAM”: `0.28em` sau khi đã cân khoảng trắng cuối;
- button và body: `0`;
- all-caps nhỏ: `0.04em` tối đa.

Không dùng text shadow. Nếu cần tách chữ khỏi nền, sửa fill hoặc đặt surface bên dưới.

## 7. Shadow và độ sâu

Style 02 chỉ dùng ba shadow:

```css
--shadow-control: 0 3px 0 rgba(8, 46, 74, 0.18);
--shadow-panel: 0 5px 12px rgba(8, 46, 74, 0.12);
--shadow-overlay: 0 12px 30px rgba(8, 46, 74, 0.18);
```

Quy tắc:

- shadow không blur lớn hơn 30 px;
- button dùng shadow ngắn có hướng xuống, không inner bevel;
- pressed dịch xuống 2 px và bỏ `--shadow-control`;
- room row chỉ dùng `--shadow-control` hoặc panel shadow rất nhẹ;
- không shadow chữ;
- không glow màu;
- không ambient occlusion quanh mọi cạnh.

## 8. Gradient

Gradient chỉ được dùng ở ba nơi:

- CTA vàng: `linear-gradient(180deg, #FFD867 0%, #FFC83D 68%, #F7B725 100%)`;
- avatar: gradient hai sắc cùng nhóm màu, chênh lightness dưới 18%;
- turn ring: conic-gradient cho tiến trình thời gian.

Surface cream và aqua mặc định là màu phẳng. Không đặt radial highlight giữa panel.

## 9. Avatar

- hình tròn;
- fill từ bảng avatar cố định theo hash user ID;
- chữ cái đầu trắng, weight 800;
- vòng cream 3 px;
- outline navy 2 px ngoài cùng;
- shadow `--shadow-control`;
- không dùng chân dung AI;
- không thêm texture, huy hiệu hoặc viền kim loại.

Bảng fill tuần hoàn:

1. coral `#FF6F61 → #FF8878`;
2. violet `#8D5DE7 → #B47AF5`;
3. sun `#F5B923 → #FFD45C`;
4. blue `#5C7BE8 → #7E9BFF`;
5. teal `#20AAA5 → #52D1C7`.

## 10. Motion

| Chuyển động | Duration | Easing | Biên độ |
|---|---:|---|---|
| button press | 90 ms | ease-out | translateY 2 px |
| modal in | 180 ms | cubic-bezier(.2,.8,.2,1) | y 12→0, opacity |
| toast in | 160 ms | ease-out | y -8→0 |
| card deal | 220–320 ms | ease-out | theo vị trí bài |
| selected card | 120 ms | ease-out | y -14 px |
| turn pulse | 900 ms | ease-in-out | opacity 0.75→1 |
| result rows | 240 ms + 45 ms stagger | ease-out | y 8→0 |

Với `prefers-reduced-motion: reduce`:

- bỏ stagger, bounce, pulse vô hạn;
- duration tối đa 80 ms;
- giữ thay đổi màu/outline tức thời để state vẫn rõ.

## 11. Dấu vết AI cần loại bỏ

Checklist trực quan bắt buộc:

- mọi chữ là HTML, không phải chữ nằm trong ảnh;
- outline có cùng độ dày trên bốn cạnh;
- góc trái/phải có cùng radius;
- icon đối xứng khi bản chất icon cần đối xứng;
- không có texture tự phát, hạt sáng, vệt cọ hoặc ornament vô nghĩa;
- không có fill “gần màu” giữa các instance cùng component;
- room row thứ tư giống hình học room row thứ nhất;
- avatar không biến dạng và chữ cái nằm đúng tâm quang học;
- shadow có cùng hướng và cùng token;
- đường cong biên chiếu được dựng vector/CSS, không raster méo.

## 12. Anti-style

Không được xuất hiện:

- dark mode toàn màn;
- neon/cyberpunk;
- casino, chip, roulette, kim loại vàng;
- fantasy, cung điện, rồng phượng;
- skeuomorphism gỗ/nỉ/đồng;
- glassmorphism mờ trong suốt;
- clay 3D hoặc nút phồng;
- gradient rainbow;
- sticker/emoji lạm dụng;
- pattern dân gian đậm hơn nội dung gameplay;
- UI generic chỉ gồm card trắng trên nền gradient mà không có nhịp coral/chiếu.
