/**
 * Fake REST API server cho app Ola 2.1.11
 * ----------------------------------------
 * Mục đích: thay thế http://api.ola.vn/ bằng máy local để TEST.
 * App gắn prefix "json/" (JSON) hoặc "html/" (HTML) vào path, kèm nhiều
 * tham số chung (owsc, owsn, cid, apv, sig, ctms, ...). Server này log
 * MỌI request để bạn thấy app có gọi đúng vào đây không, và trả về dữ
 * liệu giả hợp lệ cho các endpoint quan trọng.
 *
 * Chạy:  npm install && npm start
 * Cổng:  PORT (mặc định 8080)
 */
const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

// ----- Middleware: log mọi request -----
let seq = 0;
app.use((req, res, next) => {
  const n = ++seq;
  const q = Object.keys(req.query).length ? '  ' + JSON.stringify(req.query) : '';
  console.log(`\n[#${n}] ${new Date().toLocaleTimeString()}  ${req.method} ${req.path}${q}`);
  next();
});
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ----- Helpers -----
const ok = (payload = {}) => ({ code: 0, payload, meta: 'fake-ok' });
const now = () => Date.now();
const SESSION = 'FAKE_SESSION_0001';

// =====================================================================
//  TÀI KHOẢN / ĐĂNG NHẬP  (json/id/*)
// =====================================================================

// Lấy "public key" (thực ra là seed dùng để XOR mật khẩu). App đọc chuỗi
// dạng "[b1,b2,...]" rồi split. Trả 16 byte bất kỳ là đủ.
app.get('/json/id/pubkey', (req, res) => {
  const bytes = Array.from({ length: 16 }, (_, i) => (i * 7 + 13) % 256);
  res.type('text/plain').send('[' + bytes.join(',') + ']');
});

// Đăng nhập REST (dùng bởi OlaWebLoginActivity). code==1 = thành công.
app.get('/json/id/signin', (req, res) => {
  const un = req.query.un || 'tester';
  res.json({
    code: 1,
    loginName: un,
    sessionCode: SESSION,
    lastLoginTime: now(),
    meta: 'OK',
  });
});

// Kiểm tra nick tồn tại / có thể đăng ký
app.get('/json/id/check', (req, res) => res.json({ nick: req.query.un || '', result: true }));
app.get('/json/id/regable', (req, res) => res.json({ nick: req.query.un || '', result: true }));

// Thông tin hệ thống (capabilities)
app.get('/json/id/pubinfo', (req, res) =>
  res.json({ ip: '192.168.2.7', ms: now(), acckit: false, facebook: true })
);

// Hồ sơ người dùng
app.get('/json/id/profile', (req, res) => {
  const nick = req.query.un || 'tester';
  const isSelf = (nick === req.query.owsn);  // owsn = login nick
  res.json({
    nick,
    name: 'Fake ' + nick,
    gender: 1,
    birthday: 788918400000,       // 1995-01-01 as millis
    registerMs: now() - 1e10,
    lastActiveAgo: 60,
    socialLinkType: 0,
    noFans: 12,
    noFriends: 34,
    noMedias: 5,
    statusMessage: 'Đây là tài khoản giả từ fake-api',
    cared: false,
    isFan: false,
    blocked: false,
    vip: 1,                                   // VIP → tránh warning "Mua VIP" ở phòng chat
    phone: { number: '0901234567', verified: true, protect: true },  // verified → tránh warning "Cần xác thực"
    like: { '1': 0, '3': 0, liked: 0 },
    friends: [],
    fans: [],
    medias: [],
  });
});

app.get('/json/id/authweb', (req, res) => res.json({ url: `http://192.168.2.7:${PORT}/html/login` }));
app.get('/json/id/activehit', (req, res) => res.json(ok()));
app.get('/json/id/signoutall', (req, res) => res.json(ok()));

// =====================================================================
//  ME-FEED / LIKE / RSS
// =====================================================================
app.get('/json/me/view/:id', (req, res) =>
  res.json({
    id: req.params.id, content: 'Nội dung me giả #' + req.params.id, creator: 'tester',
    createdDate: now(), deltaTime: 60, likes: [], kulId: 0, mediaCode: '',
    liked: false, likeCount: 0, replyCount: 0,
  })
);
app.get('/json/me/attachs/:id', (req, res) =>
  res.json({ url: '', title: 'attach', intro: '', media: '', noLikes: 0, liked: false, likes: [], noComments: 0, type: 0 })
);
app.get('/json/me/visit/more', (req, res) => res.json({ visits: [], more: false }));
app.get('/json/like/act/*', (req, res) => res.json({ 1: 0, 2: 0, liked: true, likers: [] }));
app.get('/json/like/gets/*', (req, res) => res.json({}));
app.get(['/json/rss/get', '/json/rss/get/:id'], (req, res) =>
  res.json({ type: 0, title: 'RSS giả', content: '<p>fake</p>', thumbCode: '', meId: 0, noLikes: 0, liked: false, noComments: 0 })
);

// =====================================================================
//  MALL / GALLERY / STICKER
// =====================================================================
app.get(['/json/mall', '/json/mall/'], (req, res) => res.json({ code: 0, payload: [] }));
app.get('/json/mall/getTow', (req, res) => res.json({ code: 0, payload: { towId: req.query.towId } }));
app.get('/json/mall/hittow', (req, res) => res.json(ok()));
app.get('/json/mall/yt', (req, res) => res.json({ payload: { title: 'YT giả', duration: 100, hqThumbnailUrl: '' } }));
app.get(['/json/mall/like', '/json/mall/unlike'], (req, res) => res.json(ok()));
app.get('/json/mall/watch', (req, res) => res.json(ok()));
app.get('/json/mall/search', (req, res) => res.json({ code: 0, payload: [] }));
app.get('/json/mall/tags', (req, res) => res.json({ code: 0, payload: [] }));
app.get(['/json/gallery', '/json/gallery/*'], (req, res) =>
  res.json({ type: 'files', morePath: '', cats: [], folders: [], files: [] })
);
app.get('/json/scrape/http/get', (req, res) =>
  res.json({ site: '', title: '', desc: '', image: '', redirect: '' })
);

// =====================================================================
//  THANH TOÁN / GAME / CHECK-IN  (trả rỗng an toàn)
// =====================================================================
app.get('/json/pay/ginapp/*', (req, res) => res.json({ errorCode: 0, payload: [], message: 'ok' }));
app.get('/json/player/*', (req, res) => res.json({ token: 'FAKE_TOKEN', nicks: [], owsc: SESSION }));
app.get('/json/aurora/*', (req, res) => res.json({ code: 0, payload: {} }));

// Danh sách "apps" (shortcut) — gọi lúc khởi động
app.get(['/json/api/apps', '/api/apps'], (req, res) => res.json({ version: 1, apps: [] }));

// =====================================================================
//  HTML (WebView): adme, rss, login...
// =====================================================================
app.get('/html/*', (req, res) =>
  res.type('html').send(`<!doctype html><meta charset="utf-8">
    <body style="font-family:sans-serif;padding:24px;background:#f1f8e9">
    <h2 style="color:#558b2f">Fake Ola server</h2>
    <p>Trang HTML giả cho: <code>${req.path}</code></p></body>`)
);

// =====================================================================
//  CATCH-ALL: bất kỳ json/* nào chưa khai báo -> trả về OK rỗng
// =====================================================================
app.all('/json/*', (req, res) => {
  console.log('   ↳ (catch-all json) chưa có handler riêng -> trả OK rỗng');
  res.json(ok());
});

// Trang gốc để kiểm tra server sống
app.get('/', (req, res) =>
  res.type('html').send(`<!doctype html><meta charset="utf-8">
   <body style="font-family:sans-serif;padding:24px">
   <h1 style="color:#7cb342">🟢 Ola fake-api đang chạy</h1>
   <p>Cổng ${PORT}. Mọi request từ app sẽ được log ở terminal.</p></body>`)
);

// Bất kỳ request nào khác -> log + trả OK (để app không treo)
app.use((req, res) => {
  console.log('   ↳ (fallback) -> trả {code:0}');
  res.json({ code: 0, meta: 'fallback' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`\n================================================`);
  console.log(` Ola FAKE API server`);
  console.log(` Lắng nghe: http://0.0.0.0:${PORT}`);
  console.log(` LAN:       http://192.168.2.7:${PORT}`);
  console.log(` Emulator:  http://10.0.2.2:${PORT}`);
  console.log(`================================================`);
});
