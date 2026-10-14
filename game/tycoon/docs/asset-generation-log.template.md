# Asset generation log — template

Mỗi asset raster sinh ra (quân cờ, nền lobby, logo, fx) phải có một mục theo mẫu dưới, ghi vào `asset-generation-log.md` cùng thư mục (file log không bắt buộc commit nếu chứa prompt dài; PNG/webp nháp không commit).

```md
## <tên file đích, ví dụ tokens/tk-xe-may.webp>

- Ngày:
- Công cụ sinh:
- Prompt (đầy đủ):
- Negative prompt:
- Ảnh tham chiếu (nếu có):
- Số lần sinh / phương án chọn:
- Hậu kỳ: trim alpha / scale / cwebp -q
- Kích thước cuối: <w × h>, <KB>
- QA: [ ] đúng palette 01 · [ ] không chữ giả · [ ] đọc được ở size thật trên viewport 360 · [ ] alpha thật ngoài hình · [ ] silhouette khác các quân còn lại
- Người duyệt:
```

Quy tắc: không sửa tay pixel để che lỗi sinh; nếu sai thì sinh lại. Prompt base và negative chuẩn ở [04 §6](./04-asset-manifest-and-prompts.md).
