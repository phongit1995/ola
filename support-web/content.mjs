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
];

export const UI = {
  vi: {
    home: 'Trang chủ',
    support: 'Hỗ trợ',
    deleteAccount: 'Xoá tài khoản',
    privacy: 'Chính sách bảo mật',
    terms: 'Điều khoản sử dụng',
    contact: 'Liên hệ',
    tagline:
      'Mạng xã hội giải trí — trò chuyện, phòng cộng đồng, bảng tin và trò chơi.',
    supportDesc: 'Câu hỏi thường gặp, kênh liên hệ và tải ứng dụng.',
    deleteAccountDesc: 'Cách yêu cầu xoá tài khoản và dữ liệu của bạn.',
    privacyDesc: 'Cách chúng tôi thu thập, sử dụng và bảo vệ dữ liệu của bạn.',
    termsDesc: 'Quy định khi sử dụng dịch vụ, tài khoản và vật phẩm ảo.',
    contactDesc: 'Mọi câu hỏi, khiếu nại hoặc yêu cầu xoá tài khoản.',
  },
  en: {
    home: 'Home',
    support: 'Support',
    deleteAccount: 'Delete account',
    privacy: 'Privacy Policy',
    terms: 'Terms of Use',
    contact: 'Contact',
    tagline:
      'Entertainment social network — chat, community rooms, feed and games.',
    supportDesc: 'Frequently asked questions, contact channels and downloads.',
    deleteAccountDesc: 'How to request deletion of your account and data.',
    privacyDesc: 'How we collect, use and protect your data.',
    termsDesc: 'Rules for using the service, accounts and virtual items.',
    contactDesc: 'Any question, complaint or account deletion request.',
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

  'delete-account': {
    vi: {
      title: 'XOÁ TÀI KHOẢN',
      subtitle: `Mạng xã hội ${APP_NAME}`,
      updated: 'Cập nhật ngày 07/09/2026',
      footer: '© 2026 Ola — Mạng xã hội giải trí',
      sections: [
        {
          title: '1. Cách yêu cầu xoá tài khoản',
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
          title: '2. Dữ liệu sẽ bị xoá',
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
          title: '3. Dữ liệu được giữ lại',
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
          title: '4. Thời gian xử lý',
          blocks: [
            {
              type: 'p',
              text: 'Sau khi xác minh, tài khoản được vô hiệu hoá ngay và bạn sẽ bị đăng xuất khỏi mọi thiết bị. Dữ liệu cá nhân được xoá hoặc ẩn danh hoá trong vòng 30 ngày, trừ phần dữ liệu nêu ở mục 3.',
            },
          ],
        },
        {
          title: '5. Không thể hoàn tác',
          blocks: [
            {
              type: 'p',
              text: 'Việc xoá tài khoản là vĩnh viễn. Tên đăng nhập, nội dung, bạn bè, KEN và vật phẩm VIP không thể khôi phục sau khi đã xoá. Nếu chỉ muốn tạm ngừng sử dụng, bạn có thể đăng xuất và quay lại bất cứ lúc nào thay vì xoá tài khoản.',
            },
          ],
        },
        {
          title: '6. Liên hệ',
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
          title: '1. How to request account deletion',
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
          title: '2. Data that will be deleted',
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
          title: '3. Data we keep',
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
          title: '4. How long it takes',
          blocks: [
            {
              type: 'p',
              text: 'Once verified, the account is disabled immediately and you are signed out of every device. Personal data is deleted or anonymised within 30 days, except for the data listed in section 3.',
            },
          ],
        },
        {
          title: '5. This cannot be undone',
          blocks: [
            {
              type: 'p',
              text: 'Account deletion is permanent. Your username, content, friends, KEN and VIP items cannot be restored afterwards. If you only want a break, you can sign out and come back any time instead of deleting the account.',
            },
          ],
        },
        {
          title: '6. Contact',
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
