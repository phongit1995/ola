# Chỉ số game Ola Farm

Bộ tài liệu này ghi **toàn bộ chỉ số đang chạy** của Ola Farm để chốt số liệu: cây trồng, ruộng, vật nuôi và chuồng, nhà máy, công thức, vật phẩm, EXP và level, kim cương, thời gian, tổng chi phí.

> Mọi con số lấy từ 5 file cấu hình trong [`assets/farm/bundles/farm-town/`](../../assets/farm/bundles/farm-town/) qua đúng bộ nạp mà game dùng ([`tools/load-farm-catalog.ts`](../../tools/load-farm-catalog.ts)), đối chiếu với luật trong [`assets/farm/scripts/core/`](../../assets/farm/scripts/core/) ngày 25/09/2026. Nếu tài liệu và JSON lệch nhau thì **JSON là chuẩn**; khi đổi JSON phải cập nhật lại tài liệu này.

Đây là **bộ số đã cân bằng lại ngày 25/09/2026**: đường level, giá đất, EXP vật nuôi theo loài, thưởng kim cương khi lên level, giá làm xong ngay 1 kim cương mỗi phút còn lại (thêm cho nhà máy) và gói đổi xu. Những gì đã đổi và những điểm còn mở xem [12](12-diem-can-chot.md).

## Mục lục

| # | Tài liệu | Nội dung |
| ---: | --- | --- |
| 01 | [Tổng quan và khởi đầu](01-tong-quan-va-khoi-dau.md) | Vòng chơi, xu/kim cương/EXP, trạng thái khởi đầu, giới hạn, các thao tác |
| 02 | [EXP, level và mở khóa](02-exp-level-mo-khoa.md) | Nguồn EXP, thưởng lên level, công thức level, nhịp chơi ước tính, bảng 99 level, lịch mở khóa theo level, điều kiện mở heo/cừu |
| 03 | [Cây trồng](03-cay-trong.md) | 8 cây: level, thời gian, giá hạt, sản lượng, giá bán, EXP, lãi mỗi giờ và mỗi ngày theo lịch chơi |
| 04 | [Ruộng](04-ruong.md) | 40 ô ruộng: level và giá mở, cách đặt giá |
| 05 | [Vật nuôi và chuồng](05-vat-nuoi-va-chuong.md) | 4 loài, 8 chuồng, giá ô chuồng, thức ăn, sản phẩm, EXP theo loài, số mỗi ngày theo lịch chơi |
| 06 | [Nhà máy](06-nha-may.md) | 8 loại, 16 nhà, giá và level, hàng chờ, khay nhận |
| 07 | [Công thức chế biến](07-cong-thuc.md) | 23 công thức: nguyên liệu, thành phẩm, thời gian, EXP, chênh lệch giá, một máy mỗi ngày |
| 08 | [Vật phẩm và giá bán](08-vat-pham-gia-ban.md) | 35 vật phẩm: giá bán, nguồn, nơi dùng, giá vốn hạt giống |
| 09 | [Kim cương, xu, tăng tốc, hoàn tiền](09-kim-cuong-xu.md) | Ví khởi đầu, nguồn kim cương, gói đổi xu, cách tính giá làm xong ngay (cây, vật nuôi, nhà máy), hoàn tiền, lúa cứu trợ |
| 10 | [Thời gian, offline và lưu game](10-thoi-gian-offline-luu.md) | Thời gian thực (Menu không dừng đồng hồ), offline, lưu tự động, các thông số runtime |
| 11 | [Tổng chi phí](11-tong-chi-phi.md) | Chi phí xây hết, chi phí lũy kế theo level |
| 12 | [Điểm cần chốt](12-diem-can-chot.md) | Những gì đã chốt đợt 25/09/2026 và những điểm còn mở |

## Quy ước đọc bảng

- **Đơn vị:** xu, kim cương, EXP. Số viết theo kiểu Việt Nam: `1.250` là một nghìn hai trăm năm mươi, `2,5` là hai phẩy năm. Đây là cách viết của tài liệu; game hiển thị số khác, xem [Hiển thị giá tiền](../cocos/hien-thi-gia-tien.md).
- **Số cấu hình** là số ghi thẳng trong JSON. **Số tính ra** là số suy từ cấu hình để dễ so sánh (lãi mỗi giờ, EXP mỗi giờ, tổng lũy kế…); công thức tính ghi ngay dưới bảng. Số tính ra được làm tròn tối đa 2 chữ số thập phân.
- **Level** là level tối thiểu để mua/gieo/làm. Một số thứ còn cần điều kiện nội dung (mốc Chăn nuôi, mốc Thủ công), xem [02](02-exp-level-mo-khoa.md#điều-kiện-nội-dung-mốc-chăn-nuôi-và-mốc-thủ-công).
- **Giá trị theo giá bán** là tổng giá bán ở kho của một nhóm vật phẩm. **Giá vốn hạt giống** chỉ tính tiền hạt đã bỏ ra để làm ra vật phẩm (qua mọi bước chế biến và chăn nuôi), không tính tiền xây nhà, mua con hay thời gian.

## File cấu hình

| File | Chứa |
| --- | --- |
| [economy.json](../../assets/farm/bundles/farm-town/economy.json) | Ví khởi đầu, EXP và đường level, thưởng kim cương khi lên level, hoàn tiền, gói đổi xu, gói kim cương (chỉ hiển thị), giá hạt/level/EXP/sản lượng cây, giá bán mọi vật phẩm, level và EXP công thức, giá con, EXP theo loài và ô chuồng, giá và level nhà máy, giá ô hàng chờ, giá và level chuồng, 40 ruộng |
| [timing.json](../../assets/farm/bundles/farm-town/timing.json) | Thời gian lớn của cây, thời gian ra sản phẩm của vật nuôi, thời gian làm của công thức, số giây ứng với 1 kim cương khi làm xong ngay |
| [gameplay.json](../../assets/farm/bundles/farm-town/gameplay.json) | Kho khởi đầu, bảng chào mừng, lúa cứu trợ, mốc hình cây lớn, yêu cầu có Máy thức ăn, số chuồng/số con/thức ăn mỗi con, số nhà máy/hàng chờ/khay, điều kiện mốc Chăn nuôi và Thủ công |
| [catalog.json](../../assets/farm/bundles/farm-town/catalog.json) | Mã và tên vật phẩm, nguyên liệu và thành phẩm của công thức, thức ăn và sản phẩm của vật nuôi, công thức thuộc máy nào, công thức/chuồng/máy cần mốc nào |
| [runtime.json](../../assets/farm/bundles/farm-town/runtime.json) | Lưu tự động, tiến trình offline, âm thanh, giao diện, thao tác, camera |

## Khi đổi số

1. Sửa JSON. Chỉ sửa giá trị, không đổi mã (`raw:1`, `pen:12`…) vì bản lưu của người chơi dùng các mã này.
2. Từ `game/ola-farm/` chạy `npm run config:check` (bộ kiểm tra cấu hình dùng chung với game), rồi `npm test`.
3. Build lại bản chạy trong app: `pnpm -C game build:farm` (cần Cocos Creator trên máy), rồi commit `game/public/ola-farm/`.
4. Cập nhật lại tài liệu này, gồm cả các bảng số tính ra. Bảng nhịp chơi ở [02](02-exp-level-mo-khoa.md#nhịp-chơi-ước-tính) và các số "trong mô phỏng" là kết quả mô phỏng ngày 25/09/2026, phải chạy lại mô phỏng mới cập nhật được.

- **Việc đang chạy giữ số cũ.** Cây đang lớn giữ giá hạt, sản lượng, EXP, tiền hoàn và thời gian lúc gieo; món đang làm/đang chờ giữ nguyên liệu, thành phẩm, EXP và thời gian lúc xếp; con đang ăn giữ sản phẩm, EXP và thời gian lúc cho ăn. Chỉ việc mới dùng số mới.
- **Áp dụng ngay:** giá bán, level yêu cầu, giá mua/mở mọi thứ, thưởng lên level và số giây mỗi kim cương khi làm xong ngay (giá tính lại theo thời gian còn lại lúc bấm).
- **Test đang ghi cứng nhiều con số.** `real-time-economy.test.ts` (bảng cây), `land-purchase.test.ts` (bảng giá đất), `boost-rewards.test.ts` (giá làm xong ngay, EXP vật nuôi, EXP xây dựng, thưởng lên level), `animal-boost.test.ts` (giá làm xong ngay của gà), `economy-config.test.ts`, `farm-timing.test.ts`, `construction-reset.test.ts`, `starter-slot-levels.test.ts`, `pen-slots.test.ts`, `two-buildings.test.ts`, `building-placement.test.ts`, `town-husbandry.test.ts`, `simple-farm.test.ts` trong [`tests/`](../../tests/). Đổi số sẽ phải sửa các test này.
