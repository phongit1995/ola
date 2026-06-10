import { useNavigate } from 'react-router-dom';

/** Một mục điều khoản (tiêu đề + nội dung). */
interface Section {
  title: string;
  body: React.ReactNode;
}

const UPDATED = 'Cập nhật ngày 10/06/2026 — Phiên bản 1.0';

const SECTIONS: Section[] = [
  {
    title: '1. Chấp nhận điều khoản',
    body: (
      <>
        <p>
          Khi tạo tài khoản và sử dụng ứng dụng/mạng xã hội Ola ("Ola", "chúng
          tôi", "dịch vụ"), bạn xác nhận đã đọc, hiểu rõ và đồng ý tuân thủ toàn
          bộ nội dung trong Điều khoản sử dụng này cũng như các quy định, hướng
          dẫn được công bố kèm theo. Nếu không đồng ý với bất kỳ điều khoản nào,
          vui lòng không đăng ký hoặc ngừng sử dụng dịch vụ.
        </p>
        <p>
          Chúng tôi có thể cập nhật, sửa đổi điều khoản này theo thời gian. Việc
          bạn tiếp tục sử dụng dịch vụ sau khi điều khoản được cập nhật đồng
          nghĩa với việc bạn chấp nhận các thay đổi đó.
        </p>
      </>
    ),
  },
  {
    title: '2. Điều kiện sử dụng & tài khoản',
    body: (
      <ul>
        <li>
          Bạn phải từ 13 tuổi trở lên để tạo tài khoản. Nếu dưới 18 tuổi, bạn
          cần có sự đồng ý/giám sát của cha mẹ hoặc người giám hộ hợp pháp.
        </li>
        <li>
          Thông tin đăng ký (tên đăng nhập, mật khẩu…) phải chính xác, không vi
          phạm thuần phong mỹ tục, không mạo danh cá nhân/tổ chức khác.
        </li>
        <li>
          Mỗi người chỉ nên sở hữu một tài khoản và chịu trách nhiệm bảo mật
          thông tin đăng nhập cũng như mọi hoạt động phát sinh từ tài khoản.
        </li>
        <li>
          Nếu phát hiện tài khoản bị truy cập trái phép, vui lòng đổi mật khẩu và
          liên hệ chúng tôi ngay.
        </li>
        <li>
          Chúng tôi có quyền từ chối, tạm khóa hoặc chấm dứt tài khoản vi phạm
          điều khoản mà không cần báo trước.
        </li>
      </ul>
    ),
  },
  {
    title: '3. Quy tắc ứng xử & nội dung bị cấm',
    body: (
      <>
        <p>
          Khi sử dụng Ola (đăng bài, bình luận, trò chuyện, đặt tên/trạng thái,
          phòng cộng đồng…), bạn không được:
        </p>
        <ul>
          <li>
            Đăng tải nội dung khiêu dâm, bạo lực, phân biệt chủng tộc/tôn
            giáo/giới tính, kích động thù hận hoặc vi phạm pháp luật Việt Nam;
          </li>
          <li>
            Quấy rối, đe dọa, bắt nạt, xúc phạm danh dự, nhân phẩm người khác;
          </li>
          <li>
            Phát tán thông tin sai sự thật, lừa đảo, spam, quảng cáo trái phép,
            liên kết độc hại;
          </li>
          <li>Mạo danh người khác, tổ chức, cơ quan nhà nước;</li>
          <li>
            Sử dụng phần mềm/công cụ tự động (bot), khai thác lỗi hệ thống để
            trục lợi hoặc gây ảnh hưởng đến trải nghiệm chung;
          </li>
          <li>
            Mua bán, trao đổi tài khoản, vật phẩm ảo (KEN, VIP…) bằng tiền thật
            ngoài các kênh chính thức do Ola cung cấp.
          </li>
        </ul>
        <p>
          Nội dung vi phạm có thể bị gỡ bỏ; tài khoản liên quan có thể bị cảnh
          cáo, tạm khóa hoặc chấm dứt vĩnh viễn tùy mức độ.
        </p>
      </>
    ),
  },
  {
    title: '4. Nội dung do người dùng tạo',
    body: (
      <>
        <p>
          Bạn giữ quyền sở hữu đối với nội dung (bài viết, hình ảnh, tin nhắn,
          trạng thái…) mà bạn đăng tải. Tuy nhiên, bằng việc đăng tải lên Ola,
          bạn cấp cho chúng tôi quyền lưu trữ, hiển thị, sao lưu nội dung đó
          trong phạm vi cần thiết để vận hành và cải thiện dịch vụ.
        </p>
        <p>
          Bạn cam kết nội dung đăng tải không vi phạm quyền sở hữu trí tuệ, quyền
          riêng tư của bên thứ ba và tự chịu trách nhiệm pháp lý đối với nội dung
          mình tạo ra.
        </p>
      </>
    ),
  },
  {
    title: '5. Vật phẩm ảo, tiền tệ trong ứng dụng (KEN, VIP…)',
    body: (
      <ul>
        <li>
          KEN, VIP và các vật phẩm/tiền tệ ảo khác trong Ola không phải tiền
          thật, không có giá trị quy đổi ra tiền mặt và chỉ có giá trị sử dụng
          trong phạm vi ứng dụng.
        </li>
        <li>
          Việc nạp/mua KEN hoặc vật phẩm ảo (nếu có) là giao dịch tự nguyện;
          chúng tôi không chịu trách nhiệm với các giao dịch mua bán bằng tiền
          thật giữa người dùng với nhau ngoài hệ thống chính thức.
        </li>
        <li>
          Chúng tôi có quyền điều chỉnh, tạm ngưng hoặc chấm dứt các vật
          phẩm/tính năng ảo bất kỳ lúc nào nhằm đảm bảo vận hành ổn định, công
          bằng.
        </li>
        <li>
          Tài khoản vi phạm (gian lận, khai thác lỗi, mua bán trái phép…) có thể
          bị thu hồi vật phẩm ảo và/hoặc khóa tài khoản mà không được hoàn lại.
        </li>
      </ul>
    ),
  },
  {
    title: '6. Quyền riêng tư & dữ liệu cá nhân',
    body: (
      <>
        <p>
          Chúng tôi thu thập một số thông tin cần thiết (tên đăng nhập, email
          khôi phục nếu bạn cung cấp, dữ liệu sử dụng…) nhằm vận hành, bảo mật và
          cải thiện dịch vụ. Chúng tôi không bán thông tin cá nhân của bạn cho
          bên thứ ba.
        </p>
        <p>
          Tin nhắn, nội dung trò chuyện riêng tư được lưu trữ phục vụ tính năng
          của ứng dụng và chỉ được truy cập trong các trường hợp cần thiết để vận
          hành, xử lý sự cố hoặc theo yêu cầu của cơ quan nhà nước có thẩm quyền
          theo quy định pháp luật.
        </p>
      </>
    ),
  },
  {
    title: '7. Giới hạn trách nhiệm',
    body: (
      <>
        <p>
          Ola được cung cấp "nguyên trạng", có thể gặp gián đoạn, lỗi kỹ thuật
          hoặc bảo trì định kỳ. Chúng tôi nỗ lực đảm bảo dịch vụ ổn định nhưng
          không cam kết tuyệt đối về tính liên tục, không có lỗi.
        </p>
        <p>
          Chúng tôi không chịu trách nhiệm với thiệt hại phát sinh từ: hành vi
          của người dùng khác, nội dung do người dùng đăng tải, mất mát dữ liệu
          do lỗi thiết bị/đường truyền của bạn, hoặc các sự kiện bất khả kháng.
        </p>
      </>
    ),
  },
  {
    title: '8. Chấm dứt sử dụng',
    body: (
      <p>
        Bạn có thể ngừng sử dụng dịch vụ bất kỳ lúc nào. Chúng tôi có quyền tạm
        khóa hoặc chấm dứt tài khoản nếu phát hiện vi phạm điều khoản, hành vi
        gây hại đến hệ thống hoặc cộng đồng người dùng, kể cả khi chưa có thông
        báo trước, nhằm bảo vệ quyền lợi chung.
      </p>
    ),
  },
  {
    title: '9. Liên hệ',
    body: (
      <p>
        Mọi góp ý, phản ánh, khiếu nại liên quan đến tài khoản, nội dung hoặc
        điều khoản sử dụng, vui lòng liên hệ qua email hỗ trợ của Ola.
      </p>
    ),
  },
];

/**
 * Trang Điều khoản sử dụng Ola — dựng tương tự olaken.me/dieu-khoan.html
 * (header xanh gradient + các card trắng).
 */
export function TermsPage() {
  const navigate = useNavigate();

  return (
    <div className="min-h-full bg-[#f0f7f0] font-sans text-gray-800">
      {/* Header xanh gradient */}
      <header className="relative bg-gradient-to-br from-ola-primary-dark to-ola-primary px-5 pt-7 pb-6 text-center">
        <button
          type="button"
          onClick={() => navigate(-1)}
          className="absolute top-4 left-4 text-sm text-white/90"
        >
          ‹ Quay lại
        </button>
        <img
          src="/favicon.png"
          alt="Ola"
          className="mx-auto mb-3 h-16 w-16 rounded-2xl shadow-lg"
        />
        <h1 className="text-xl font-bold tracking-wide text-white">
          ĐIỀU KHOẢN SỬ DỤNG
        </h1>
        <p className="mt-1.5 text-[13px] text-white/85">Mạng xã hội Ola</p>
      </header>

      <main className="mx-auto max-w-2xl px-4 pt-6 pb-14">
        <p className="mb-4 text-center text-xs text-[#5a7a5d]">{UPDATED}</p>

        <div className="mb-4 rounded-xl border border-[#ffd54f] bg-[#fff8e1] px-4 py-3.5 text-[13px] text-[#6d4c00]">
          <strong>Lưu ý:</strong> Đây là bản điều khoản mẫu phục vụ mục đích học
          tập / nghiên cứu, không phải văn bản pháp lý chính thức.
        </div>

        {SECTIONS.map((s) => (
          <section
            key={s.title}
            className="mb-4 rounded-xl bg-white px-4 py-5 shadow-[0_2px_10px_rgba(0,0,0,.06)] [&_li]:mb-2 [&_li]:text-sm [&_p]:mb-2 [&_p]:text-sm [&_ul]:list-disc [&_ul]:pl-5"
          >
            <h2 className="mb-2.5 text-base font-extrabold tracking-wide text-ola-primary-dark">
              {s.title}
            </h2>
            {s.body}
          </section>
        ))}
      </main>

      <footer className="px-4 pb-5 text-center text-xs text-[#7a9a7d]">
        © 2026 Ola — Mạng xã hội giải trí (bản mô phỏng)
      </footer>
    </div>
  );
}
