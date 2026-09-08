export const SITE_URL = 'https://ola-me.pages.dev';
export const APP_NAME = 'Ola Me';
export const SUPPORT_EMAIL = 'support@olachat.net';
export const RESPONSE_TIME_HOURS = 24;

export const PUBLISHER = {
  name: '',
  address: '',
};

export const CHANNELS = [
  { label: 'Facebook Fanpage', href: 'https://www.facebook.com/ola2vn' },
  { label: 'Facebook Group', href: 'https://www.facebook.com/groups/nghienola' },
  { label: 'TikTok', href: 'https://www.tiktok.com/@olachat.net' },
];

export const DOWNLOADS = {
  ios: 'https://testflight.apple.com/join/kjTPXnuv',
  android:
    'https://drive.google.com/drive/folders/1v2rxd3KGoJsN2NLzxLI1DuVB-q-PgtWx',
  androidSize: '56 MB',
};

export const NAV = [
  { slug: 'home', href: '/', key: 'home' },
  { slug: 'support', href: '/support', key: 'support' },
  { slug: 'delete-account', href: '/delete-account', key: 'deleteAccount' },
  { slug: 'privacy', href: '/privacy', key: 'privacy' },
  { slug: 'terms', href: '/terms', key: 'terms' },
  { slug: 'child-safety', href: '/child-safety', key: 'childSafety' },
];

export const UI = {
  vi: {
    home: 'Trang chủ',
    support: 'Hỗ trợ',
    deleteAccount: 'Xoá tài khoản',
    privacy: 'Chính sách bảo mật',
    terms: 'Điều khoản sử dụng',
    childSafety: 'An toàn trẻ em',
    contact: 'Liên hệ',
    tagline:
      'Mạng xã hội giải trí — trò chuyện, phòng cộng đồng, bảng tin và trò chơi.',
    supportDesc: 'Câu hỏi thường gặp, kênh liên hệ và tải ứng dụng.',
    deleteAccountDesc: 'Cách yêu cầu xoá tài khoản và dữ liệu của bạn.',
    privacyDesc: 'Cách chúng tôi thu thập, sử dụng và bảo vệ dữ liệu của bạn.',
    termsDesc: 'Quy định khi sử dụng dịch vụ, tài khoản và vật phẩm ảo.',
    childSafetyDesc:
      'Tiêu chuẩn chống bóc lột, xâm hại tình dục trẻ em và cách báo cáo.',
    contactDesc: 'Mọi câu hỏi, khiếu nại hoặc yêu cầu xoá tài khoản.',
  },
  en: {
    home: 'Home',
    support: 'Support',
    deleteAccount: 'Delete account',
    privacy: 'Privacy Policy',
    terms: 'Terms of Use',
    childSafety: 'Child Safety',
    contact: 'Contact',
    tagline:
      'Entertainment social network — chat, community rooms, feed and games.',
    supportDesc: 'Frequently asked questions, contact channels and downloads.',
    deleteAccountDesc: 'How to request deletion of your account and data.',
    privacyDesc: 'How we collect, use and protect your data.',
    termsDesc: 'Rules for using the service, accounts and virtual items.',
    childSafetyDesc:
      'Our standards against child sexual abuse and exploitation, and how to report.',
    contactDesc: 'Any question, complaint or account deletion request.',
  },
};

export const INTRO = {
  vi: {
    headline: 'Mạng xã hội chat, kết bạn và giải trí cho người Việt',
    lead: 'Nhắn tin tức thì, tham gia phòng chat theo chủ đề, kết bạn bốn phương, chia sẻ khoảnh khắc và chơi mini game — tất cả trong một ứng dụng nhẹ, miễn phí.',
    aboutTitle: `${APP_NAME} là gì?`,
    about: [
      `${APP_NAME} là mạng xã hội trò chuyện miễn phí dành cho người Việt, kết hợp nhắn tin nhanh, phòng chat theo chủ đề, kết bạn, chia sẻ khoảnh khắc cùng nhiều mini game và quà tặng.`,
      'Dù bạn muốn tìm bạn mới, trò chuyện sau giờ làm, tham gia phòng chat sôi động hay đơn giản là giải trí, ứng dụng mang tới một cộng đồng thân thiện và luôn nhộn nhịp — hoạt động mượt trên web, Android và iOS.',
    ],
    featuresTitle: 'Tính năng chính',
    features: [
      { icon: '💬', name: 'Phòng chat sôi động', desc: 'Hàng nghìn phòng theo chủ đề, sở thích và khu vực để trò chuyện nhóm mỗi ngày.' },
      { icon: '⚡', name: 'Nhắn tin thời gian thực', desc: 'Tin nhắn gửi tức thì kèm hình ảnh, tin nhắn thoại, sticker và biểu cảm.' },
      { icon: '📞', name: 'Gọi thoại & video', desc: 'Gọi trực tiếp cho bạn bè ngay trong ứng dụng, truyền theo thời gian thực.' },
      { icon: '🖼️', name: 'Bảng tin Me', desc: 'Đăng ảnh, ghi âm, check-in và chia sẻ khoảnh khắc với cộng đồng hoặc bạn bè.' },
      { icon: '🎮', name: 'Mini game', desc: 'Vòng Quay May Mắn, Đập Trứng, Sút Penalty, Tiến Lên — chơi ngay trong app.' },
      { icon: '🎁', name: 'Quà tặng & VIP', desc: 'Gửi quà, sưu tầm vật phẩm và trải nghiệm đặc quyền VIP dành cho thành viên.' },
      { icon: '🤝', name: 'Clan & kết bạn', desc: 'Lập clan, tìm bạn ở gần và mở rộng mối quan hệ khắp Việt Nam.' },
      { icon: '🛡️', name: 'An toàn & văn minh', desc: 'Công cụ quản lý phòng, chặn và báo cáo giúp cộng đồng luôn thân thiện.' },
    ],
    stepsTitle: 'Bắt đầu trong 3 bước',
    steps: [
      { name: 'Đăng ký miễn phí', desc: 'Tạo tài khoản chỉ trong vài giây.' },
      { name: 'Chọn phòng hoặc tìm bạn', desc: 'Tham gia phòng chat theo chủ đề hoặc khám phá người dùng gần bạn.' },
      { name: 'Trò chuyện & kết nối', desc: 'Nhắn tin, tặng quà, chơi game và mở rộng cộng đồng bạn bè.' },
    ],
    downloadTitle: 'Tải ứng dụng',
    downloadDesc: `${APP_NAME} có bản cho Android (file APK) và iPhone/iPad (qua TestFlight).`,
    linksTitle: 'Hỗ trợ & pháp lý',
    ageNote: 'Ứng dụng dành cho người dùng từ 18 tuổi trở lên. Miễn phí sử dụng; một số vật phẩm VIP và quà tặng là tuỳ chọn.',
  },
  en: {
    headline: 'A chat, friendship and entertainment social network',
    lead: 'Instant messaging, themed chat rooms, new friends, shared moments and mini games — all in one lightweight, free app.',
    aboutTitle: `What is ${APP_NAME}?`,
    about: [
      `${APP_NAME} is a free social chat network built for Vietnamese users, combining instant messaging, themed chat rooms, making friends, sharing moments, mini games and gifts.`,
      'Whether you want to meet new people, chat after work, join a lively room or simply have fun, the app offers a friendly, always-busy community — running smoothly on web, Android and iOS.',
    ],
    featuresTitle: 'Key features',
    features: [
      { icon: '💬', name: 'Lively chat rooms', desc: 'Thousands of rooms by topic, interest and region for daily group chat.' },
      { icon: '⚡', name: 'Real-time messaging', desc: 'Instant messages with images, voice notes, stickers and emoji.' },
      { icon: '📞', name: 'Voice & video calls', desc: 'Call friends directly inside the app, streamed in real time.' },
      { icon: '🖼️', name: 'Me feed', desc: 'Post photos, voice recordings and check-ins to the community or just your friends.' },
      { icon: '🎮', name: 'Mini games', desc: 'Lucky Wheel, Egg Smash, Penalty Kick, Thirteen — playable right in the app.' },
      { icon: '🎁', name: 'Gifts & VIP', desc: 'Send gifts, collect items and enjoy VIP perks for members.' },
      { icon: '🤝', name: 'Clans & friends', desc: 'Create a clan, find people nearby and grow your circle nationwide.' },
      { icon: '🛡️', name: 'Safe & civil', desc: 'Room moderation, blocking and reporting tools keep the community friendly.' },
    ],
    stepsTitle: 'Start in 3 steps',
    steps: [
      { name: 'Sign up for free', desc: 'Create an account in a few seconds.' },
      { name: 'Pick a room or find friends', desc: 'Join a themed chat room or discover users near you.' },
      { name: 'Chat & connect', desc: 'Message, send gifts, play games and grow your community.' },
    ],
    downloadTitle: 'Download the app',
    downloadDesc: `${APP_NAME} is available for Android (APK file) and iPhone/iPad (via TestFlight).`,
    linksTitle: 'Support & legal',
    ageNote: 'The app is for users aged 18 and over. Free to use; some VIP items and gifts are optional purchases.',
  },
};

export const FORM = {
  vi: {
    usernameLabel: 'Tên đăng nhập',
    usernamePlaceholder: 'Tên đăng nhập trong ứng dụng',
    emailLabel: 'Email liên hệ',
    emailPlaceholder: 'email@example.com',
    noteLabel: 'Ghi chú (không bắt buộc)',
    notePlaceholder: 'Lý do xoá, hoặc thông tin giúp chúng tôi xác minh bạn là chủ tài khoản',
    confirm:
      'Tôi hiểu tài khoản, nội dung, số dư KEN và vật phẩm VIP sẽ bị xoá vĩnh viễn và không được hoàn tiền.',
    submit: 'Gửi yêu cầu xoá',
    successTitle: 'Đã gửi thành công',
    successText:
      'Yêu cầu của bạn đang chờ xử lý. Chúng tôi sẽ xác minh và phản hồi qua email trong vòng 7 ngày làm việc.',
    errUsername: 'Vui lòng nhập tên đăng nhập hợp lệ.',
    errEmail: 'Vui lòng nhập email hợp lệ.',
    errConfirm: 'Vui lòng xác nhận bạn hiểu việc xoá là vĩnh viễn.',
  },
  en: {
    usernameLabel: 'Username',
    usernamePlaceholder: 'Your username in the app',
    emailLabel: 'Contact email',
    emailPlaceholder: 'email@example.com',
    noteLabel: 'Note (optional)',
    notePlaceholder:
      'Reason for deleting, or anything that helps us verify you own the account',
    confirm:
      'I understand that my account, content, KEN balance and VIP items will be permanently deleted and are not refundable.',
    submit: 'Submit deletion request',
    successTitle: 'Request submitted',
    successText:
      'Your request is pending. We will verify it and reply by email within 7 business days.',
    errUsername: 'Please enter a valid username.',
    errEmail: 'Please enter a valid email address.',
    errConfirm: 'Please confirm that you understand deletion is permanent.',
  },
};

export const PAGES = {
  support: {
    vi: {
      title: 'HỖ TRỢ KHÁCH HÀNG',
      subtitle: `Mạng xã hội ${APP_NAME}`,
      updated: 'Cập nhật ngày 07/09/2026',
      footer: '© 2026 Ola — Mạng xã hội giải trí',
      sections: [
        {
          title: '1. Liên hệ với chúng tôi',
          blocks: [
            {
              type: 'p',
              text: `Gửi email tới ${SUPPORT_EMAIL} — chúng tôi cố gắng phản hồi trong vòng ${RESPONSE_TIME_HOURS} giờ. Để được hỗ trợ nhanh, vui lòng ghi rõ tên đăng nhập, mô tả vấn đề và ảnh chụp màn hình (nếu có).`,
            },
            { type: 'channels' },
          ],
        },
        {
          title: '2. Câu hỏi thường gặp',
          blocks: [
            {
              type: 'faq',
              items: [
                {
                  q: 'Tôi quên mật khẩu, phải làm sao?',
                  a: 'Ở màn hình đăng nhập, chọn "Quên mật khẩu" và nhập tên đăng nhập. Nếu tài khoản có email đã xác thực, mã đặt lại gồm 6 số sẽ được gửi tới email đó và có hiệu lực trong 5 phút. Nếu tài khoản chưa xác thực email, hãy gửi email cho chúng tôi kèm tên đăng nhập để được hỗ trợ xác minh.',
                },
                {
                  q: 'Tôi không đăng nhập được hoặc tài khoản bị khoá?',
                  a: 'Tài khoản có thể bị tạm khoá khi vi phạm Điều khoản sử dụng hoặc có dấu hiệu bị chiếm quyền. Gửi email kèm tên đăng nhập và mô tả tình huống, chúng tôi sẽ kiểm tra và phản hồi.',
                },
                {
                  q: 'Tôi đã nạp KEN nhưng chưa nhận được?',
                  a: 'Kiểm tra mục KEN → Lịch sử giao dịch trong ứng dụng trước. Giao dịch chuyển khoản đúng nội dung thường được cộng tự động trong vài phút. Nếu chuyển thiếu, sai nội dung hoặc quá lâu chưa nhận, gửi email kèm tên đăng nhập, số tiền, thời điểm chuyển và ảnh biên lai để chúng tôi đối soát và cộng tay.',
                },
                {
                  q: 'Làm sao báo cáo người dùng hoặc nội dung vi phạm?',
                  a: 'Bạn có thể chặn người dùng ngay trong phòng chat hoặc trên trang hồ sơ của họ để không nhìn thấy nội dung từ người đó nữa. Với các vi phạm nghiêm trọng (quấy rối, lừa đảo, nội dung người lớn, nội dung liên quan tới trẻ em), gửi email kèm tên đăng nhập của người vi phạm và ảnh chụp màn hình; chúng tôi xử lý theo Điều khoản sử dụng, thường trong vòng 24 giờ.',
                },
                {
                  q: 'Tôi muốn đổi tên hiển thị / thông tin cá nhân?',
                  a: 'Vào Cá nhân → chỉnh sửa hồ sơ để đổi tên hiển thị, ảnh đại diện, ảnh bìa, giới thiệu và các thông tin khác. Việc đổi tên đăng nhập có thể tính phí bằng KEN theo bảng giá hiển thị ngay trong ứng dụng.',
                },
                {
                  q: 'Tôi muốn xoá tài khoản và dữ liệu?',
                  a: 'Xem hướng dẫn chi tiết ở trang Xoá tài khoản.',
                },
                {
                  q: 'Ứng dụng dành cho độ tuổi nào?',
                  a: `${APP_NAME} dành cho người dùng từ 18 tuổi trở lên. Tài khoản của người dưới 18 tuổi sẽ bị khoá hoặc xoá cùng dữ liệu liên quan khi bị phát hiện.`,
                },
              ],
            },
          ],
        },
        {
          title: '3. Tải ứng dụng',
          blocks: [{ type: 'downloads' }],
        },
      ],
    },
    en: {
      title: 'CUSTOMER SUPPORT',
      subtitle: `${APP_NAME} social network`,
      updated: 'Updated 07/09/2026',
      footer: '© 2026 Ola — Entertainment social network',
      sections: [
        {
          title: '1. Contact us',
          blocks: [
            {
              type: 'p',
              text: `Email us at ${SUPPORT_EMAIL} — we aim to reply within ${RESPONSE_TIME_HOURS} hours. To get help faster, include your username, a description of the issue and screenshots if you have them.`,
            },
            { type: 'channels' },
          ],
        },
        {
          title: '2. Frequently asked questions',
          blocks: [
            {
              type: 'faq',
              items: [
                {
                  q: 'I forgot my password. What should I do?',
                  a: 'On the login screen, tap "Forgot password" and enter your username. If the account has a verified email, a 6-digit reset code is sent to that address and stays valid for 5 minutes. If your account has no verified email, email us with your username so we can verify ownership.',
                },
                {
                  q: 'I cannot sign in, or my account is locked?',
                  a: 'Accounts may be suspended for breaching the Terms of Use or when we detect signs of compromise. Email us your username and what happened, and we will review it.',
                },
                {
                  q: 'I topped up KEN but did not receive it?',
                  a: 'First check KEN → Transaction history in the app. Bank transfers with the correct reference are usually credited automatically within minutes. If you transferred a wrong amount or reference, or nothing arrives, email us your username, the amount, the transfer time and a receipt screenshot so we can reconcile and credit it manually.',
                },
                {
                  q: 'How do I report a user or abusive content?',
                  a: 'You can block a user directly in a chat room or from their profile to stop seeing their content. For serious violations (harassment, fraud, adult content, anything involving minors), email us the offending username and screenshots; we act under the Terms of Use, usually within 24 hours.',
                },
                {
                  q: 'How do I change my display name or profile details?',
                  a: 'Go to Personal → edit profile to change your display name, avatar, cover photo, bio and other details. Changing your username may cost KEN at the price shown in the app.',
                },
                {
                  q: 'I want to delete my account and data?',
                  a: 'See the step-by-step guide on the Delete account page.',
                },
                {
                  q: 'What is the minimum age?',
                  a: `${APP_NAME} is for users aged 18 and over. Accounts belonging to anyone under 18 are locked or deleted together with related data once discovered.`,
                },
              ],
            },
          ],
        },
        {
          title: '3. Download the app',
          blocks: [{ type: 'downloads' }],
        },
      ],
    },
  },

  'child-safety': {
    vi: {
      title: 'TIÊU CHUẨN AN TOÀN CHO TRẺ EM',
      subtitle: `Mạng xã hội ${APP_NAME}`,
      updated: 'Cập nhật ngày 08/09/2026',
      footer: '© 2026 Ola — Mạng xã hội giải trí',
      sections: [
        {
          title: '1. Cam kết của chúng tôi',
          blocks: [
            {
              type: 'p',
              text: `${APP_NAME} không khoan nhượng với mọi hành vi bóc lột và xâm hại tình dục trẻ em (CSAE). Nội dung xâm hại tình dục trẻ em (CSAM) bị cấm tuyệt đối trên toàn bộ dịch vụ: tin nhắn riêng, phòng chat cộng đồng, bảng tin Me, bình luận, ảnh đại diện, ảnh bìa, tên hiển thị và mọi nội dung khác do người dùng tạo ra.`,
            },
            {
              type: 'p',
              text: 'Trang này công bố tiêu chuẩn an toàn trẻ em của chúng tôi và đầu mối liên hệ, theo yêu cầu của chính sách Tiêu chuẩn an toàn cho trẻ em của Google Play.',
            },
          ],
        },
        {
          title: '2. Độ tuổi sử dụng',
          blocks: [
            {
              type: 'p',
              text: `${APP_NAME} chỉ dành cho người dùng từ 18 tuổi trở lên. Người dưới 18 tuổi không được phép tạo hoặc sử dụng tài khoản. Khi phát hiện hoặc nhận được báo cáo về tài khoản của người chưa đủ tuổi, chúng tôi khoá tài khoản đó và xoá dữ liệu liên quan.`,
            },
          ],
        },
        {
          title: '3. Hành vi bị nghiêm cấm',
          blocks: [
            {
              type: 'ul',
              items: [
                'Đăng tải, chia sẻ, lưu trữ, quảng bá hoặc yêu cầu nội dung xâm hại tình dục trẻ em dưới mọi hình thức — ảnh, video, âm thanh, văn bản, hoạt hình, hình vẽ hoặc nội dung do AI tạo ra;',
                'Dụ dỗ, gạ gẫm, làm quen với trẻ em nhằm mục đích tình dục (grooming), hoặc mọi hành vi tiếp cận trẻ em với ý đồ tình dục;',
                'Đe doạ phát tán hình ảnh riêng tư của trẻ em để tống tiền hoặc tống tình (sextortion);',
                'Mua bán người, mại dâm trẻ em, du lịch tình dục trẻ em, hoặc quảng cáo, môi giới các hoạt động này;',
                'Mô tả, bình luận hoặc tình dục hoá trẻ em, kể cả khi không kèm hình ảnh;',
                'Chia sẻ đường liên kết, mã mời, tên nhóm hoặc bất kỳ chỉ dẫn nào dẫn tới nội dung xâm hại trẻ em ở nền tảng khác.',
              ],
            },
          ],
        },
        {
          title: '4. Cách báo cáo',
          blocks: [
            {
              type: 'p',
              text: 'Bất kỳ ai cũng có thể báo cáo cho chúng tôi, kể cả khi không có tài khoản:',
            },
            {
              type: 'ol',
              items: [
                'Ngay trong ứng dụng: chạm giữ vào tin nhắn, bài viết hoặc mở hồ sơ người dùng, chọn Báo cáo và chọn lý do phù hợp. Báo cáo được gửi thẳng tới đội ngũ kiểm duyệt.',
                'Chặn người dùng: trong phòng chat hoặc trên trang hồ sơ, chọn Chặn để ngừng nhận nội dung từ người đó ngay lập tức.',
                `Qua email: gửi tới ${SUPPORT_EMAIL} với tiêu đề "Báo cáo an toàn trẻ em", kèm tên đăng nhập của người vi phạm, ảnh chụp màn hình và mô tả sự việc.`,
              ],
            },
            {
              type: 'note',
              text: 'Báo cáo liên quan tới an toàn trẻ em được ưu tiên xử lý trước mọi loại báo cáo khác. Nếu bạn tin rằng một trẻ em đang gặp nguy hiểm tức thời, hãy liên hệ ngay công an địa phương hoặc Tổng đài quốc gia bảo vệ trẻ em 111 trước khi báo cho chúng tôi.',
            },
          ],
        },
        {
          title: '5. Cách chúng tôi xử lý',
          blocks: [
            {
              type: 'ol',
              items: [
                'Tiếp nhận và xem xét báo cáo trong vòng 24 giờ;',
                'Gỡ bỏ ngay nội dung vi phạm khỏi dịch vụ;',
                'Khoá vĩnh viễn tài khoản vi phạm và chặn việc tạo lại tài khoản;',
                'Lưu giữ bằng chứng phục vụ điều tra theo quy định của pháp luật;',
                'Chuyển vụ việc tới cơ quan chức năng có thẩm quyền.',
              ],
            },
          ],
        },
        {
          title: '6. Báo cáo cho cơ quan chức năng',
          blocks: [
            {
              type: 'p',
              text: 'Chúng tôi tuân thủ pháp luật Việt Nam về bảo vệ trẻ em và về an toàn thông tin mạng. Khi phát hiện hoặc xác nhận nội dung xâm hại tình dục trẻ em, chúng tôi báo cáo cho cơ quan chức năng có thẩm quyền tại Việt Nam và hợp tác đầy đủ với cơ quan điều tra, bao gồm việc cung cấp dữ liệu theo yêu cầu hợp pháp.',
            },
            {
              type: 'p',
              text: 'Chúng tôi cũng phối hợp với các tổ chức bảo vệ trẻ em và các nền tảng phân phối ứng dụng trong phạm vi pháp luật cho phép.',
            },
          ],
        },
        {
          title: '7. Phòng ngừa và kiểm duyệt',
          blocks: [
            {
              type: 'ul',
              items: [
                'Công cụ báo cáo và chặn có mặt ở mọi nơi hiển thị nội dung do người dùng tạo;',
                'Phòng chat cộng đồng có quản trị viên và công cụ quản lý thành viên;',
                'Đội ngũ kiểm duyệt xem xét báo cáo hằng ngày và xử lý theo Điều khoản sử dụng;',
                'Tài khoản bị xác định là của người dưới 18 tuổi sẽ bị khoá và xoá dữ liệu;',
                'Chúng tôi rà soát định kỳ các biện pháp an toàn và cập nhật khi cần thiết.',
              ],
            },
          ],
        },
        {
          title: '8. Đầu mối liên hệ',
          blocks: [
            {
              type: 'p',
              text: `Đầu mối liên hệ chuyên trách về an toàn trẻ em: ${SUPPORT_EMAIL}. Chúng tôi cam kết phản hồi các yêu cầu từ người dùng, cơ quan chức năng, tổ chức bảo vệ trẻ em và nền tảng phân phối ứng dụng liên quan tới nội dung xâm hại trẻ em.`,
            },
          ],
        },
        {
          title: '9. Cập nhật',
          blocks: [
            {
              type: 'p',
              text: 'Tiêu chuẩn này có thể được cập nhật khi pháp luật, chính sách nền tảng hoặc tính năng ứng dụng thay đổi. Ngày cập nhật gần nhất được ghi ở đầu trang.',
            },
          ],
        },
      ],
    },
    en: {
      title: 'CHILD SAFETY STANDARDS',
      subtitle: `${APP_NAME} social network`,
      updated: 'Updated 08/09/2026',
      footer: '© 2026 Ola — Entertainment social network',
      sections: [
        {
          title: '1. Our commitment',
          blocks: [
            {
              type: 'p',
              text: `${APP_NAME} has zero tolerance for child sexual abuse and exploitation (CSAE). Child sexual abuse material (CSAM) is strictly prohibited everywhere in the service: private messages, community chat rooms, the Me feed, comments, avatars, cover photos, display names and any other user-generated content.`,
            },
            {
              type: 'p',
              text: 'This page publishes our child safety standards and our point of contact, as required by the Google Play Child Safety Standards policy.',
            },
          ],
        },
        {
          title: '2. Minimum age',
          blocks: [
            {
              type: 'p',
              text: `${APP_NAME} is for users aged 18 and over. Anyone under 18 is not permitted to create or use an account. When we discover or are told about an underage account, we lock it and delete the related data.`,
            },
          ],
        },
        {
          title: '3. Prohibited conduct',
          blocks: [
            {
              type: 'ul',
              items: [
                'Uploading, sharing, storing, promoting or soliciting child sexual abuse material in any form — images, video, audio, text, animation, drawings or AI-generated content;',
                'Grooming, soliciting or befriending a child for sexual purposes, or any approach to a child with sexual intent;',
                'Threatening to publish a child’s private images for extortion or sexual coercion (sextortion);',
                'Human trafficking, child prostitution, child sex tourism, or advertising or brokering such activity;',
                'Describing, commenting on or sexualising children, even without imagery;',
                'Sharing links, invite codes, group names or any directions to child abuse content on other platforms.',
              ],
            },
          ],
        },
        {
          title: '4. How to report',
          blocks: [
            {
              type: 'p',
              text: 'Anyone can report to us, including people without an account:',
            },
            {
              type: 'ol',
              items: [
                'In the app: long-press a message or post, or open a user profile, choose Report and pick the matching reason. Reports go straight to our moderation team.',
                'Block a user: in a chat room or on their profile, choose Block to stop receiving their content immediately.',
                `By email: write to ${SUPPORT_EMAIL} with the subject "Child safety report", including the offending username, screenshots and a description.`,
              ],
            },
            {
              type: 'note',
              text: 'Child safety reports are prioritised ahead of every other report type. If you believe a child is in immediate danger, contact your local police first, or in Vietnam the National Child Protection Hotline on 111, before reporting to us.',
            },
          ],
        },
        {
          title: '5. How we respond',
          blocks: [
            {
              type: 'ol',
              items: [
                'We receive and review the report within 24 hours;',
                'We remove the violating content from the service immediately;',
                'We permanently ban the offending account and block re-registration;',
                'We preserve evidence for investigation as required by law;',
                'We escalate the case to the competent authorities.',
              ],
            },
          ],
        },
        {
          title: '6. Reporting to authorities',
          blocks: [
            {
              type: 'p',
              text: 'We comply with Vietnamese law on child protection and network information security. When child sexual abuse material is found or confirmed, we report it to the competent authorities in Vietnam and cooperate fully with investigators, including providing data under lawful request.',
            },
            {
              type: 'p',
              text: 'We also cooperate with child protection organisations and app distribution platforms to the extent permitted by law.',
            },
          ],
        },
        {
          title: '7. Prevention and moderation',
          blocks: [
            {
              type: 'ul',
              items: [
                'Reporting and blocking tools are available everywhere user-generated content appears;',
                'Community chat rooms have moderators and member management tools;',
                'Our moderation team reviews reports daily and acts under the Terms of Use;',
                'Accounts identified as belonging to someone under 18 are locked and their data deleted;',
                'We review our safety measures periodically and update them when needed.',
              ],
            },
          ],
        },
        {
          title: '8. Point of contact',
          blocks: [
            {
              type: 'p',
              text: `Our designated child safety point of contact is ${SUPPORT_EMAIL}. We commit to responding to enquiries from users, authorities, child protection organisations and app distribution platforms regarding child abuse content.`,
            },
          ],
        },
        {
          title: '9. Updates',
          blocks: [
            {
              type: 'p',
              text: 'These standards may be updated as laws, platform policies or app features change. The date of the most recent update is shown at the top of this page.',
            },
          ],
        },
      ],
    },
  },

  'delete-account': {
    vi: {
      title: 'XOÁ TÀI KHOẢN',
      subtitle: `Mạng xã hội ${APP_NAME}`,
      updated: 'Cập nhật ngày 07/09/2026',
      footer: '© 2026 Ola — Mạng xã hội giải trí',
      sections: [
        {
          title: '1. Gửi yêu cầu xoá tài khoản',
          blocks: [
            {
              type: 'p',
              text: 'Điền tên đăng nhập và email liên hệ của bạn. Chúng tôi sẽ xác minh bạn là chủ tài khoản trước khi xoá, nên hãy dùng email đã xác thực trong tài khoản nếu có.',
            },
            { type: 'form' },
          ],
        },
        {
          title: '2. Cách khác: gửi email',
          blocks: [
            {
              type: 'ol',
              items: [
                `Gửi email tới ${SUPPORT_EMAIL} với tiêu đề "Yêu cầu xoá tài khoản".`,
                'Ghi rõ tên đăng nhập của tài khoản cần xoá.',
                'Gửi từ chính địa chỉ email đã xác thực trong tài khoản. Nếu tài khoản chưa liên kết email, hãy đính kèm ảnh chụp màn hình trang cá nhân khi đang đăng nhập để chúng tôi xác minh bạn là chủ tài khoản.',
                'Chúng tôi xác minh và phản hồi trong vòng 7 ngày làm việc.',
              ],
            },
            {
              type: 'note',
              text: 'Lưu ý: mục "Xoá tài khoản" trong ứng dụng chỉ gỡ tài khoản đã lưu khỏi thiết bị này để đăng nhập nhanh — nó KHÔNG xoá tài khoản và dữ liệu trên máy chủ. Muốn xoá thật sự, hãy gửi yêu cầu theo các bước trên.',
            },
          ],
        },
        {
          title: '3. Dữ liệu sẽ bị xoá',
          blocks: [
            {
              type: 'ul',
              items: [
                'Hồ sơ cá nhân: tên hiển thị, ảnh đại diện, ảnh bìa, giới thiệu, số điện thoại, giới tính, ngày sinh và email;',
                'Nội dung bạn đã đăng: bài viết Me, ảnh, bình luận, trạng thái;',
                'Tin nhắn, ảnh và tin nhắn thoại bạn đã gửi;',
                'Danh sách bạn bè, quan hệ, clan và các cài đặt cá nhân;',
                'Số dư KEN và vật phẩm VIP còn lại — sẽ mất hiệu lực và không được hoàn tiền;',
                'Token thiết bị dùng để nhận thông báo đẩy.',
              ],
            },
          ],
        },
        {
          title: '4. Dữ liệu được giữ lại',
          blocks: [
            {
              type: 'ul',
              items: [
                'Nhật ký giao dịch nạp tiền, phục vụ đối soát và nghĩa vụ kế toán/thuế, lưu theo thời hạn pháp luật yêu cầu;',
                'Bản ghi liên quan tới báo cáo vi phạm, gian lận hoặc tranh chấp, ở dạng đã ẩn danh;',
                'Bản sao lưu hệ thống, được ghi đè theo chu kỳ trong tối đa 90 ngày.',
              ],
            },
          ],
        },
        {
          title: '5. Thời gian xử lý',
          blocks: [
            {
              type: 'p',
              text: 'Sau khi xác minh, tài khoản được vô hiệu hoá ngay và bạn sẽ bị đăng xuất khỏi mọi thiết bị. Dữ liệu cá nhân được xoá hoặc ẩn danh hoá trong vòng 30 ngày, trừ phần dữ liệu nêu ở mục 3.',
            },
          ],
        },
        {
          title: '6. Không thể hoàn tác',
          blocks: [
            {
              type: 'p',
              text: 'Việc xoá tài khoản là vĩnh viễn. Tên đăng nhập, nội dung, bạn bè, KEN và vật phẩm VIP không thể khôi phục sau khi đã xoá. Nếu chỉ muốn tạm ngừng sử dụng, bạn có thể đăng xuất và quay lại bất cứ lúc nào thay vì xoá tài khoản.',
            },
          ],
        },
        {
          title: '7. Liên hệ',
          blocks: [
            {
              type: 'p',
              text: `Mọi thắc mắc về yêu cầu xoá tài khoản, vui lòng liên hệ ${SUPPORT_EMAIL}.`,
            },
          ],
        },
      ],
    },
    en: {
      title: 'DELETE YOUR ACCOUNT',
      subtitle: `${APP_NAME} social network`,
      updated: 'Updated 07/09/2026',
      footer: '© 2026 Ola — Entertainment social network',
      sections: [
        {
          title: '1. Submit a deletion request',
          blocks: [
            {
              type: 'p',
              text: 'Enter your username and a contact email. We verify that you own the account before deleting it, so use the email verified on the account when you have one.',
            },
            { type: 'form' },
          ],
        },
        {
          title: '2. Alternative: send an email',
          blocks: [
            {
              type: 'ol',
              items: [
                `Send an email to ${SUPPORT_EMAIL} with the subject "Account deletion request".`,
                'State the username of the account to be deleted.',
                'Send it from the email address verified on the account. If the account has no linked email, attach a screenshot of your profile while signed in so we can verify you own the account.',
                'We verify and reply within 7 business days.',
              ],
            },
            {
              type: 'note',
              text: 'Note: the "Delete account" item inside the app only removes the saved account from this device for quick sign-in — it does NOT delete your account or data from our servers. To delete for real, send the request described above.',
            },
          ],
        },
        {
          title: '3. Data that will be deleted',
          blocks: [
            {
              type: 'ul',
              items: [
                'Profile data: display name, avatar, cover photo, bio, phone number, gender, date of birth and email;',
                'Content you posted: Me posts, images, comments and statuses;',
                'Messages, images and voice messages you sent;',
                'Friends, relationships, clan membership and personal settings;',
                'Remaining KEN balance and VIP items — they are forfeited and are not refundable;',
                'Device tokens used for push notifications.',
              ],
            },
          ],
        },
        {
          title: '4. Data we keep',
          blocks: [
            {
              type: 'ul',
              items: [
                'Top-up transaction records, kept for reconciliation and accounting/tax obligations for as long as the law requires;',
                'Records related to abuse reports, fraud or disputes, in anonymised form;',
                'System backups, which are rotated and overwritten within 90 days.',
              ],
            },
          ],
        },
        {
          title: '5. How long it takes',
          blocks: [
            {
              type: 'p',
              text: 'Once verified, the account is disabled immediately and you are signed out of every device. Personal data is deleted or anonymised within 30 days, except for the data listed in section 3.',
            },
          ],
        },
        {
          title: '6. This cannot be undone',
          blocks: [
            {
              type: 'p',
              text: 'Account deletion is permanent. Your username, content, friends, KEN and VIP items cannot be restored afterwards. If you only want a break, you can sign out and come back any time instead of deleting the account.',
            },
          ],
        },
        {
          title: '7. Contact',
          blocks: [
            {
              type: 'p',
              text: `For any question about a deletion request, please contact ${SUPPORT_EMAIL}.`,
            },
          ],
        },
      ],
    },
  },
};
