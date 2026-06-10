/**
 * Fake SOCKET server cho app Ola 2.1.11 (giao thức nhị phân kiểu YMSG)
 * -------------------------------------------------------------------
 * App kết nối TCP tới host đã patch (192.168.2.7) cổng 1239.
 *
 * WIRE FORMAT (đã đọc từ w/dr.java, w/ce.java, w/cg.java, util/e.java):
 *  - Client GỬI (dr):  [len(4) BE = body+6][6,5,10,19,4][svc(1)][body]
 *       body = lặp { key(1) , vlen(4 BE) , value(vlen) }
 *  - Client NHẬN (ce): [numKeys(2) BE][bodyLen(4) BE][svc(1)][body]
 *       body = lặp { key(1) , vlen(4 BE) , value(vlen) }
 *
 * Mục tiêu: bắt + log mọi packet, đáp lại handshake (195) và login (206)
 * để app qua được màn đăng nhập. Chạy: node socket-server.js
 */
const net = require('net');
const PORT = process.env.SPORT || 1239;

// ---------- Helpers build value ----------
const vStr  = (s) => Buffer.from(String(s), 'utf8');
const vByte = (n) => Buffer.from([n & 0xff]);
const vShort= (n) => { const b = Buffer.alloc(2); b.writeUInt16BE(n & 0xffff, 0); return b; };
const vInt  = (n) => { const b = Buffer.alloc(4); b.writeUInt32BE(n >>> 0, 0); return b; };
const vLong = (n) => { const b = Buffer.alloc(8); b.writeBigUInt64BE(BigInt(n)); return b; };
const vBytes= (arr) => Buffer.from(arr);

// ---------- Build packet client đọc được (ce format) ----------
function build(svc, kvs) {
  const body = Buffer.concat(kvs.map(({ key, val }) => {
    const h = Buffer.alloc(5);
    h.writeUInt8(key & 0xff, 0);
    h.writeUInt32BE(val.length >>> 0, 1);
    return Buffer.concat([h, val]);
  }));
  const header = Buffer.alloc(7);
  header.writeUInt16BE(kvs.length & 0xffff, 0); // numKeys
  header.writeUInt32BE(body.length >>> 0, 2);   // bodyLen
  header.writeUInt8(svc & 0xff, 6);             // service code
  return Buffer.concat([header, body]);
}

function send(sock, svc, kvs, note = '') {
  const pkt = build(svc, kvs);
  sock.write(pkt);
  console.log(`   ➤ TRẢ svc=${svc}  keys=[${kvs.map((k) => k.key).join(',')}]  (${pkt.length}B) ${note}`);
}

// ---------- Hiển thị value cho dễ đọc ----------
function showVal(buf) {
  const printable = buf.length > 0 && buf.length < 80 &&
    buf.every((b) => b === 9 || b === 10 || b === 13 || (b >= 32 && b < 127));
  if (printable) return `"${buf.toString('utf8')}"`;
  if (buf.length <= 8) return `0x${buf.toString('hex')}`;
  return `<${buf.length}B 0x${buf.slice(0, 12).toString('hex')}…>`;
}

// ---------- Parse 1 packet client gửi ----------
function parseBody(body) {
  const kv = [];
  let pos = 0;
  while (pos + 5 <= body.length) {
    const key = body.readUInt8(pos); pos += 1;
    const vlen = body.readUInt32BE(pos); pos += 4;
    if (pos + vlen > body.length) break;
    kv.push({ key, val: body.slice(pos, pos + vlen) });
    pos += vlen;
  }
  return kv;
}
const getKey = (kv, k) => { const f = kv.find((x) => x.key === k); return f ? f.val : null; };

// ---------- PROXY HTTP-over-socket (svc 204) ----------
// App tunnel request REST qua socket. Ta tự "fetch" nội bộ: route theo path
// và trả body JSON (Buffer) y như REST server. Trả null = chưa fake (bỏ qua).
const shortUrl = (u) => { try { const x = new URL(u); return x.pathname; } catch (e) { return u.slice(0, 48); } };

// Hồ sơ BẢN THÂN (entity.ag). w.a(byte[]) cần tối thiểu field "nick".
// vip=1 + phone.verified=true → tab Phòng chat không cảnh báo "Mua VIP / xác thực".
// Account hệ thống "daptrung" (mở khi bấm section "Đập trứng" trên trang Me) →
// đặt tên/đại diện riêng cho dễ nhận biết.
function buildProfileJSON(nick) {
  const isEgg = nick === 'daptrung';
  return JSON.stringify({
    nick,
    name: isEgg ? 'Đập Trứng 🥚' : 'Fake ' + nick,
    gender: 1, birthday: 788918400000,
    registerMs: Date.now() - 1e10, lastActiveAgo: 60, socialLinkType: 0,
    noFans: 12, noFriends: 34, noMedias: 5,
    statusMessage: isEgg
      ? 'Đập trứng trúng KEN/VIP mỗi ngày! (trang giả — feed do server đẩy)'
      : 'Hồ sơ giả (nạp qua svc204 proxy — KHÔNG cần patch smali)',
    cared: false, isFan: false, blocked: false, vip: 1,
    phone: { number: '0901234567', verified: true, protect: true },
    like: { '1': 0, '3': 0, liked: 0 },
    friends: ['linhchi92', 'tuananh', 'maiphuong', 'quanghuy', 'thuhuong'],
    fans: ['linhchi92', 'tuananh'],
    medias: [],
  });
}

function proxyFetch(url) {
  let path = url, q;
  try { const x = new URL(url); path = x.pathname; q = x.searchParams; } catch (e) {}
  // /json/id/profile?un=<nick>&owsn=<self> → hồ sơ; un=self → set h.O.
  if (path.endsWith('/id/profile')) {
    const nick = (q && (q.get('un') || q.get('owsn'))) || 'tester';
    return vStr(buildProfileJSON(nick));
  }
  // các URL khác (aurora/venue, scrape, …) chưa cần → bỏ qua (app tự chịu null)
  return null;
}

// ---------- Dữ liệu giả ----------
const FAKE_FRIENDS = [
  { nick: 'linhchi92',  name: 'Linh Chi',     phone: '0901111111', status: 'Hôm nay trời đẹp ☀️' },
  { nick: 'tuananh',    name: 'Tuấn Anh',     phone: '0902222222', status: 'Đang bận...' },
  { nick: 'maiphuong',  name: 'Mai Phương',   phone: '0903333333', status: 'Nghe nhạc 🎧' },
  { nick: 'quanghuy',   name: 'Quang Huy',    phone: '0904444444', status: '' },
  { nick: 'thuhuong',   name: 'Thu Hương',    phone: '0905555555', status: 'Yêu đời 💚' },
];
const FAKE_CONVOS = [
  { nick: 'linhchi92', msg: 'Alo, lâu rồi không gặp nha!' },
  { nick: 'tuananh',   msg: 'Tối nay đi cà phê không?' },
  { nick: 'maiphuong', msg: 'Gửi bạn tài liệu nhé 📄' },
];

// Danh sách PHÒNG CHAT công khai (tab "Phòng chat", svc 81 / codec at).
// entity.s: id(long), name, desc(key30), thumb(key104), type(key103), gps(key109).
const FAKE_ROOMS = [
  { id: 1001, name: 'Hà Nội Friends',   desc: 'Giao lưu kết bạn Hà Nội 🏙️',  type: 0 },
  { id: 1002, name: 'Sài Gòn Đêm',      desc: 'Tâm sự đêm khuya 🌙',          type: 0 },
  { id: 1003, name: 'Yêu Âm Nhạc',      desc: 'Chia sẻ nhạc hay mỗi ngày 🎵', type: 0 },
  { id: 1004, name: 'Game Thủ Việt',    desc: 'Hội anh em game thủ 🎮',       type: 0 },
  { id: 1005, name: 'Phòng Tâm Sự',     desc: 'Lắng nghe & sẻ chia 💬',       type: 0 },
  { id: 1006, name: 'Tiếng Anh Mỗi Ngày', desc: 'Luyện nói tiếng Anh 🗣️',    type: 0 },
];

// TRẢ LỜI svc 9 (af): danh bạ theo format s.a(sVar,...) = lặp
// key7(nick)+key22(tên)+key12(type)+key45(online)+key38+key13(status).
// Callback a(List<message.f>,int) -> h.t.d(list) -> đổ vào DANH BẠ.
function replyBuddyList(sock) {
  const kvs = [];
  for (const f of FAKE_FRIENDS) {
    kvs.push({ key: 7,  val: vStr(f.nick) });   // nick
    kvs.push({ key: 22, val: vStr(f.name) });   // tên hiển thị
    kvs.push({ key: 12, val: vShort(0) });      // status type
    kvs.push({ key: 45, val: vShort(1) });      // online
    kvs.push({ key: 38, val: vShort(0) });
    if (f.status) kvs.push({ key: 13, val: vStr(f.status) }); // status msg
  }
  kvs.push({ key: 39, val: vInt(0) });
  send(sock, 9, kvs, `(TRẢ danh bạ svc9: ${FAKE_FRIENDS.length} bạn)`);
}

// PUSH 1 tin đến (svc 14) từ 1 nick -> tạo hội thoại trong "TIN NHẮN"
function pushIncomingMsg(sock, fromNick, text) {
  send(sock, 14, [
    { key: 7,   val: vStr(fromNick) },   // người gửi (peer) -> tin ĐẾN
    { key: 8,   val: vStr(text) },
    { key: 9,   val: vLong(Date.now()) },
    { key: 220, val: vByte(0) },
    { key: 45,  val: vShort(0) },
  ], `(PUSH tin từ "${fromNick}")`);
}

// PUSH danh bạ trùng (svc 193, action 0): key7=nick, key4=SĐT, key22=tên
// -> gVar.c(list) -> h.t.i(list) -> hiện trong tab DANH BẠ.
function pushContactFriends(sock) {
  const kvs = [{ key: 114, val: vByte(0) }];
  for (const f of FAKE_FRIENDS) {
    kvs.push({ key: 7,  val: vStr(f.nick) });
    kvs.push({ key: 4,  val: vStr(f.phone) });
    kvs.push({ key: 22, val: vStr(f.name) });
  }
  kvs.push({ key: 255, val: vShort(0) });
  send(sock, 193, kvs, `(PUSH danh bạ svc193: ${FAKE_FRIENDS.length} bạn)`);
}

// PUSH danh bạ qua svc 250 (0xfa) — đã wire codec `ca` vào ch.smali.
// Format ca: mỗi bạn bắt đầu bằng key138(nick), +key139(type), +key205(unread),
// +key110(flag last-msg) +key7(sender) +key8(nội dung) +key9(time) cho preview.
function pushFriendListCa(sock) {
  const kvs = [];
  for (const f of FAKE_FRIENDS) {
    kvs.push({ key: 138, val: vStr(f.nick) });            // nick (định danh record)
    kvs.push({ key: 139, val: vShort(0) });               // type
    kvs.push({ key: 205, val: vInt(0) });                 // unread
    kvs.push({ key: 7,   val: vStr(f.nick) });            // sender tin cuối
    kvs.push({ key: 8,   val: vStr(f.status || 'Xin chào!') }); // nội dung preview
    kvs.push({ key: 9,   val: vLong(Date.now()) });
    kvs.push({ key: 110, val: vStr('1') });               // flag để vào nhánh last-msg
  }
  kvs.push({ key: 255, val: vShort(0) });
  send(sock, 250, kvs, `(PUSH danh bạ svc250/ca: ${FAKE_FRIENDS.length} bạn)`);
}

// TRẢ LỜI svc 81 (codec at): danh sách PHÒNG CHAT.
// Decode (w/at.java): đếm key100 = số phòng; mỗi phòng:
//   room id  = giá trị LONG tại entry key100
//   room name= giá trị STRING tại entry key101 (đi song song)
//   giữa 2 key100 liên tiếp đọc: key109(gps), key104(thumb), key103(type), key30(desc)
//   key255 = status (short, 0 = OK).
function replyRoomList(sock) {
  const kvs = [];
  for (const r of FAKE_ROOMS) {
    kvs.push({ key: 100, val: vLong(r.id) });     // room id (long)
    kvs.push({ key: 101, val: vStr(r.name) });    // room name
    kvs.push({ key: 30,  val: vStr(r.desc) });    // mô tả/subtitle
    kvs.push({ key: 104, val: vStr('') });        // thumbnail (rỗng -> không tải ảnh)
    kvs.push({ key: 103, val: vShort(r.type) });  // type
    kvs.push({ key: 109, val: vStr('') });         // gps tag (rỗng -> g=false)
  }
  kvs.push({ key: 255, val: vShort(0) });          // status OK
  send(sock, 81, kvs, `(TRẢ danh sách phòng svc81: ${FAKE_ROOMS.length} phòng)`);
}

// TRẢ danh sách SECTION trang Me (svc 138 → codec w/aw, ch.java:138).
// aw.java đọc key 83 = chuỗi "tag|title|tag|title|…", split theo "|", mỗi cặp
// (tag,title) → entity.af(title, tag); bỏ qua tag "#sh".
// Sau đó network/e.java.c(List<af>) TỰ chèn thêm: Nhật ký, Hộp hôn nhân, Likes,
// "Đập trứng" (#daptrung — chỉ khi list CHƯA có), #Android, #Ola, Funny → lưu
// h.b/h.u → đẩy ra drawer TRÁI trang Me. ⇒ dòng "Đập trứng" (icon trứng nứt)
// xuất hiện; bấm vào → OlaUserMePageActivity.a("#daptrung") → OlaClanMePageActivity
// (contactId="daptrung"). KHÔNG gửi #daptrung ở đây để app tự chèn (cờ z=true).
const ME_SECTIONS = [
  { tag: 'me', title: 'Mọi người' },
  { tag: 'rs', title: 'RSS' },
];
function replyMeSections(sock) {
  const spec = ME_SECTIONS.map((s) => `${s.tag}|${s.title}`).join('|');
  send(sock, 138, [
    { key: 83,  val: vStr(spec) },
    { key: 255, val: vShort(0) },
  ], `(section trang Me svc138/aw: "${spec}" → app tự chèn "Đập trứng")`);
}

// ---------- FEED "Đập trứng" (account daptrung) ----------
// Khi mở trang account "daptrung" (bấm section "Đập trứng" trên trang Me),
// app gửi svc 103 (codec ee) request feed: key7="daptrung", key255=entryType(=4),
// và đặt ci.p = 4 (ci.java:587-596). Response feed "đầy đủ" intended là ee.c()
// (2010 lệnh, không decompile được) — NHƯNG codec ed (svc 92, ch.java:59) là bộ
// decode feed TỰ CHỨA, đọc hiểu trọn vẹn. Nên ta trả svc 92 (ed) thay vì 103.
//
// WIRE FORMAT svc 92 (đọc ed.java + parser s.java — entry theo THỨ TỰ, duyệt
// bằng index/range, KEY ĐƯỢC PHÉP LẶP):
//   key255 = byte entryType  → PHẢI == ci.p (=4) nếu không ed.a() return sớm.
//   iC = count(key8) phải > 0.
//   Mỗi POST (entity.g), đúng thứ tự:
//     key67  string  = nick tác giả (mốc bắt đầu post; .toLowerCase())
//     key22  string  = tên hiển thị
//     key45  byte    = favorite flag
//     key72  long    = postId (mốc bắt đầu block nội dung)
//     key221 byte    = (short phụ) → g.b(short)
//     key220 byte    = nếu >0 tạo media w; để 0 = không ảnh
//     key125 int     = số comment
//     key9   long    = timestamp (ms) hiển thị
//     key8   string  = nội dung text  (g.b(String))
//     key24  string  = url ảnh ("" = không ảnh)
//     key38  string  = mô tả ("")
//   key8/9/24/38 phải nằm SAU key72 và TRƯỚC key67 của post kế (range block).
const EGG_ACCOUNT = 'daptrung';
const EGG_AUTHOR = 'Đập Trứng 🥚';
const DIARY_ENTRY_TYPE = 4; // entry.c.c.a() = (short) 4 → ci.p khi mở trang Me

// Khi vừa biết target = daptrung mà trước đó đã có svc103 feed-request đang chờ
// (pendingType4 = entryType, ci.p vẫn = entryType đó) → trả feed luôn. Nếu chưa
// có svc103 nào (ci.p chưa chắc = type) thì KHÔNG gửi (tránh ed.a() drop do lệch
// ci.p); đợi svc103 tới sẽ trả ở case 103.
function maybeSendEggFeedOnTarget(sock) {
  if (currentMeTarget === EGG_ACCOUNT && pendingType4 >= 0) {
    const type = pendingType4;
    pendingType4 = -1;
    console.log(`   🥚 Target=daptrung + có svc103 chờ (type=${type}) → trả FEED (svc 92)`);
    replyEggFeed(sock, type);
  }
}
const EGG_POSTS = [
  { text: '🥚 Chào mừng tới Đập Trứng! Mỗi ngày đập 3 quả, săn KEN và VIP miễn phí.', comments: 0 },
  { text: '🎉 Bạn vừa ĐẬP TRÚNG 5.000 KEN từ quả trứng vàng may mắn! ✨', comments: 12 },
  { text: '🎁 Trứng bạc: +1 ngày VIP đã được cộng vào tài khoản của bạn 👑', comments: 5 },
  { text: '🥚 Hôm nay bạn đã đập 2/3 quả. Quay lại sau để đập tiếp nhé!', comments: 3 },
  { text: '🏆 Bảng vàng hôm nay: linhchi92 đập trúng JACKPOT 1.000.000 KEN!', comments: 47 },
];
// svc=92 (codec ed) → callback 3-arg a(g,List,short) [dùng cho in-place me].
// svc=103 (codec ee.c) → callback 4-arg a(String,short,List,short) [trang clan
// OlaClanMePageActivity render "ME Đã Đăng" khi s2==80]. ee.c đọc CÙNG bộ key
// như ed (67/22/45/72/221/220/125/9/8/24/38) nên dùng chung layout.
function replyEggFeed(sock, entryType, svc = 92) {
  const now = Date.now();
  const kvs = [{ key: 255, val: vByte(entryType) }];
  EGG_POSTS.forEach((p, i) => {
    kvs.push({ key: 67,  val: vStr(EGG_ACCOUNT) });
    kvs.push({ key: 22,  val: vStr(EGG_AUTHOR) });
    kvs.push({ key: 45,  val: vByte(0) });
    kvs.push({ key: 72,  val: vLong(900000 + i) });
    kvs.push({ key: 221, val: vByte(0) });
    kvs.push({ key: 220, val: vByte(0) });
    kvs.push({ key: 125, val: vInt(p.comments) });
    kvs.push({ key: 9,   val: vLong(now - i * 3600000) });
    kvs.push({ key: 8,   val: vStr(p.text) });
    kvs.push({ key: 24,  val: vStr('') });
    kvs.push({ key: 38,  val: vStr('') });
  });
  send(sock, svc, kvs, `(FEED Đập trứng svc${svc}: ${EGG_POSTS.length} post, type=${entryType})`);
}

let currentMeTarget = null; // account đang mở trên trang Me (đặt qua svc 50/80)
let pendingType4 = -1; // entryType của svc103 feed-request đang chờ biết target (ci.p)
let seeded = false; // chỉ seed tin nhắn 1 lần để tránh trùng khi reconnect
let isOnline = false; // track xem đã login xong chưa (svc 97 đã trả)
let pendingRoomRequest = null; // lưu socket nếu svc 81 đến trước khi online
let onlineSince = 0; // mốc thời gian online (svc 97) → bỏ qua auto-rejoin phòng cũ
const AUTO_REJOIN_MS = 3000; // svc 85 trong 3s đầu sau online = auto-rejoin (bỏ qua)

// ---------- Xử lý từng packet ----------
let pktNo = 0;
function handle(sock, svc, kv) {
  pktNo++;
  console.log(`\n[pkt #${pktNo}] ⇦ NHẬN svc=${svc}  (${kv.length} keys)`);
  kv.forEach(({ key, val }) => console.log(`        key ${key} = ${showVal(val)}`));

  switch (svc) {
    // svc 96 = HELLO/connect đầu tiên (gửi info thiết bị). Client đọc key 11
    // (short) rồi gọi gVar.f() -> coi như đã kết nối. Trả key 11 để app đi tiếp.
    case 96: {
      send(sock, 96, [{ key: 11, val: vShort(1) }], '(hello/connected ack)');
      break;
    }

    // Handshake (svc 195): client gửi key 5. Trả seed (key 8) + key 1 (short).
    case 195: {
      send(sock, 195, [
        { key: 8, val: vBytes([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]) }, // seed
        { key: 1, val: vShort(0) },
      ], '(handshake response)');
      break;
    }

    // LOGIN (svc 206): trả về thành công.
    // f.java response đọc: key2(loginName), key135(working session),
    // key112, key9(long time), key255(status short).
    case 206: {
      const un = getKey(kv, 2);
      const username = un ? un.toString('utf8') : 'tester';
      send(sock, 206, [
        { key: 2,   val: vStr(username) },          // loginName
        { key: 135, val: vStr('WS_FAKE_0001') },    // working session
        { key: 112, val: vStr('') },
        { key: 9,   val: vLong(Date.now()) },        // last login time
        { key: 255, val: vShort(0) },                // status 0 = OK ?
      ], '(LOGIN success)');
      break;
    }

    // svc 97 (ba) = QUAN TRỌNG NHẤT: response gọi gVar.a(ciVar, status)
    // -> chuyển STATE_AUTHENTICATING => STATE_ONLINE, join phòng, vào app.
    // Decode đọc: key255(status), key4, key22, key13, key110, key61, key9(long), key45(short).
    case 97: {
      const un = getKey(kv, 2);
      const username = un ? un.toString('utf8') : 'tester';
      send(sock, 97, [
        { key: 255, val: vShort(0) },          // status = OK -> ONLINE
        { key: 9,   val: vLong(Date.now()) },   // ciVar.e
        { key: 45,  val: vShort(0) },           // online status
        { key: 4,   val: vStr(username) },      // ciVar.j
        { key: 22,  val: vStr(username) },      // ciVar.h
        { key: 13,  val: vStr(username) },      // ciVar.i = NICK MÌNH -> h.d() set self nick
        { key: 61,  val: vStr('vi') },
      ], '(ONLINE! status=0)');

      // Đánh dấu đã online — svc 81 có thể trả lời ngay
      isOnline = true;
      onlineSince = Date.now();

      // Nếu svc 81 đến TRƯỚC khi online (race condition), trả lời sau 2s
      // để REST profile kịp set h.O
      if (pendingRoomRequest) {
        console.log('   📋 svc 81 TREO → delay 2s rồi trả...');
        const pendingSock = pendingRoomRequest;
        pendingRoomRequest = null;
        setTimeout(() => replyRoomList(pendingSock), 2000);
      }

      // Sau khi online -> PUSH danh bạ qua svc 250 (codec ca đã wire) + seed hội thoại
      setTimeout(() => pushFriendListCa(sock), 1000);
      // PUSH section trang Me (svc 138) → drawer Me có dòng "Đập trứng" sẵn sàng
      setTimeout(() => replyMeSections(sock), 1200);
      if (!seeded) {
        seeded = true;
        FAKE_CONVOS.forEach((c, idx) =>
          setTimeout(() => pushIncomingMsg(sock, c.nick, c.msg), 1400 + idx * 400));
      }
      break;
    }

    // svc 14 (Cdo) = GỬI/NHẬN tin nhắn 1-1. App gửi key7=peer, key8=nội dung.
    // Response decode build message.d rồi gVar.a(message.d) -> hiện bubble.
    // => Ta PUSH lại svc 14 với key7=peer (người gửi != mình) = tin ĐẾN.
    case 14: {
      const peer = getKey(kv, 7);
      const content = getKey(kv, 8);
      const peerNick = peer ? peer.toString('utf8') : 'hi';
      const text = content ? content.toString('utf8') : '';
      console.log(`   💬 App gửi tới "${peerNick}": "${text}"`);
      // Ngay lập tức ACK svc 106 → app chuyển tin sang "đã gửi ✓"
      // Dùng key8=text → gVar.j(strB, sA) match by message text
      send(sock, 106, [
        { key: 8,   val: content || vStr(text) },  // message text for matching
        { key: 255, val: vShort(0) },               // status OK
      ], '(ACK gửi tin → ✓)');
      // Auto-reply (chatbot giả) sau 0.6s
      setTimeout(() => {
        const reply = `🤖 Fake server nhận: "${text}" — Xin chào từ máy 192.168.2.7!`;
        send(sock, 14, [
          { key: 7,   val: vStr(peerNick) },   // người gửi = peer -> tin ĐẾN
          { key: 8,   val: vStr(reply) },       // nội dung trả lời
          { key: 9,   val: vLong(Date.now()) },  // thời gian
          { key: 220, val: vByte(0) },
          { key: 45,  val: vShort(0) },
        ], '(PUSH tin trả lời)');
      }, 600);
      break;
    }

    // svc 81 (at) = app XIN danh sách PHÒNG CHAT (gửi 0 keys khi mở tab "Phòng chat").
    // Trả về danh sách phòng → network.e lưu vào h.x → fragment l hiện list.
    // ⚠️ TIMING QUAN TRỌNG: f/a/f.b() (dựng list) đọc h.O (hồ sơ bản thân)
    // KHÔNG null-check → h.O==null thì NPE → list rỗng. h.O được set qua
    // PROXY svc 204 (app tự gửi URL /json/id/profile sau login — xem case 204).
    // → Delay 2s sau online để response svc 204 (id/profile) kịp set h.O xong.
    // (Nhờ vậy KHÔNG cần patch smali h.O=new ag() như bản trước.)
    case 81: {
      if (!isOnline) {
        console.log('   ⏳ svc 81 đến TRƯỚC khi online — TREO, đợi svc 97...');
        pendingRoomRequest = sock;
      } else {
        console.log('   ⏳ svc 81: delay 2s để REST profile (/json/id/pubinfo) kịp set h.O...');
        setTimeout(() => replyRoomList(sock), 2000);
      }
      break;
    }

    // svc 85 (bf) = JOIN phòng (app gửi key100=room nick/id).
    // Trả: key255=status, key100=room id, key101=tên, key104=thumb,
    // + danh sách THÀNH VIÊN (key7=nick lặp; mỗi người key22=tên, key45=online, key13=status).
    // → network.e: x.a(room, members) + x.a(1) (mode=1, VÀO PHÒNG) → hiện danh sách + nội dung.
    // ⚠️ Sau login app TỰ auto-rejoin phòng cũ (lastRoomId) bằng 1 svc 85 ngay.
    // (Lưu ý: join "ola"/"#hai" đi qua svc 104, KHÔNG phải 85.) Nếu honor cái
    // auto-rejoin này, app sẽ nhảy thẳng VÀO phòng ngay sau login thay vì ở list.
    // → Dùng TIME-GATE: svc 85 trong AUTO_REJOIN_MS đầu sau online = auto-rejoin
    //   → bỏ qua (trả lỗi nhẹ) để giữ màn DANH SÁCH; sau đó honor mọi click thật.
    case 85: {
      const ridBuf = getKey(kv, 100);
      let roomId = 0;
      try { roomId = Number(ridBuf.readBigUInt64BE(0)); } catch (e) {}
      const room = FAKE_ROOMS.find((r) => r.id === roomId);
      const isAutoRejoin = onlineSince && (Date.now() - onlineSince) < AUTO_REJOIN_MS;

      if (!room || isAutoRejoin) {
        const reason = !room ? 'phòng không tồn tại' : 'auto-rejoin sau login (bỏ qua, giữ list)';
        console.log(`   ⛔ JOIN ${reason} (parsed id: ${roomId})`);
        send(sock, 85, [
          { key: 255, val: vShort(1) },          // status = ERROR → app giữ màn list
          { key: 100, val: vLong(roomId || 0) },
        ], `(JOIN bỏ qua — ${reason})`);
        break;
      }

      const kvs = [
        { key: 255, val: vShort(0) },        // status OK
        { key: 100, val: vLong(room.id) },   // room id
        { key: 101, val: vStr(room.name) },  // tên phòng
        { key: 104, val: vStr('') },         // thumbnail
      ];
      for (const m of FAKE_FRIENDS) {        // thành viên trong phòng
        kvs.push({ key: 7,  val: vStr(m.nick) });   // nick (mốc 1 record)
        kvs.push({ key: 22, val: vStr(m.name) });   // tên hiển thị
        kvs.push({ key: 45, val: vShort(1) });      // online
        if (m.status) kvs.push({ key: 13, val: vStr(m.status) }); // status
      }
      send(sock, 85, kvs, `(JOIN phòng "${room.name}": ${FAKE_FRIENDS.length} thành viên)`);
      break;
    }

    // svc 209 (cc) = sync hội thoại. Route theo key140 (sub-action):
    //   au=1 -> codec ca = LOAD-MORE danh sách hội thoại (footer "tải thêm" trong TIN NHẮN).
    // Footer kẹt quay vì app gửi svc209/au=1 mà server không trả. Trả lời -> entry callback
    // (network.e.b -> entry.c.f.b(status)) ẩn footer. Gửi hội thoại KHÔNG kèm key110
    // -> cursor (str) = null -> g.s rỗng -> a_() return sớm -> footer không hiện lại.
    case 209: {
      const sub = getKey(kv, 140);
      const au = sub ? sub[0] : -1;
      if (au === 1) {
        const st = getKey(kv, 255);
        const status = st ? st[0] : 0;          // echo entry status (thường 0)
        const kvs = [{ key: 140, val: vByte(1) }];
        for (const f of FAKE_FRIENDS) {
          kvs.push({ key: 138, val: vStr(f.nick) });  // nick (mốc record hội thoại)
          kvs.push({ key: 139, val: vShort(0) });     // type
          kvs.push({ key: 205, val: vInt(0) });       // unread
          // KHÔNG gửi key110/7/8/9 -> str=null -> hết phân trang, footer tắt
        }
        kvs.push({ key: 255, val: vShort(status) });
        send(sock, 209, kvs, `(LOAD-MORE hội thoại au=1: ${FAKE_FRIENDS.length}, ẩn footer)`);
      } else {
        // Các sub-action khác (au=0 init, au=2 search, etc.): trả OK rỗng
        send(sock, 209, [
          { key: 140, val: vByte(au >= 0 ? au : 0) },
          { key: 255, val: vShort(0) },
        ], `(svc209 au=${au} → OK rỗng)`);
      }
      break;
    }

    // svc 9 (af) = app XIN danh bạ -> trả về danh sách bạn (format s.a)
    case 9: {
      replyBuddyList(sock);
      break;
    }

    // svc 193 (ac) = app UPLOAD danh bạ điện thoại (key114=0). Trả về danh
    // sách bạn "trùng" (key7=nick, key4=SĐT, key22=tên) -> gVar.c(list) ->
    // h.t.i(list) -> hiện trong tab DANH BẠ.
    case 193: {
      const action = getKey(kv, 114);
      const act = action ? action[0] : -1;
      if (act === 0) {
        const kvs = [{ key: 114, val: vByte(0) }];
        for (const f of FAKE_FRIENDS) {
          kvs.push({ key: 7,  val: vStr(f.nick) });
          kvs.push({ key: 4,  val: vStr(f.phone) });
          kvs.push({ key: 22, val: vStr(f.name) });
        }
        kvs.push({ key: 255, val: vShort(0) });
        send(sock, 193, kvs, `(TRẢ danh bạ trùng svc193: ${FAKE_FRIENDS.length} bạn)`);
      }
      break;
    }

    // svc 106 (co) = ACK gửi tin thành công. App gửi key72=timestamp hoặc key8=msgText.
    // Server trả key72 + key255=0 → gVar.b(long, short) → message chuyển sang "đã gửi ✓".
    // Nếu không có key72, trả key8 echo → gVar.j(string, short).
    case 106: {
      const ts = getKey(kv, 72);
      const msg = getKey(kv, 8);
      if (ts && ts.length >= 8) {
        // Echo lại timestamp → app mark message as sent
        send(sock, 106, [
          { key: 72,  val: ts },           // confirmed timestamp
          { key: 255, val: vShort(0) },    // status OK
        ], '(ACK gửi tin → ✓)');
      } else if (msg) {
        send(sock, 106, [
          { key: 8,   val: msg },          // echo msg text
          { key: 255, val: vShort(0) },
        ], '(ACK gửi tin by text → ✓)');
      } else {
        // Fallback: trả OK rỗng
        send(sock, 106, [
          { key: 255, val: vShort(0) },
        ], '(ACK gửi tin fallback)');
      }
      break;
    }

    // svc 103 (ee) = Ack đã đọc / Sync engine.
    // Route theo key115: 0=sync full (phức tạp), 1=refresh.
    // Khi mở chat, app gửi key7=peerNick, key72=lastReadTs, key115=0.
    // Trả key255=0 → callback ẩn spinner. Nếu key115=1 → refresh → trả key72+key124.
    case 103: {
      const action = getKey(kv, 115);
      const act = action ? action[0] : 0;
      const peer = getKey(kv, 7);
      const peerNick = peer ? peer.toString('utf8') : '';
      // Khi mở trang Me 1 account, app gửi svc 50 (key7=account) ĐẶT target rồi
      // svc 103 CHỈ có key255=entryType (không key7). Nếu target = "daptrung" và
      // đây là request feed (có key255, không key7 peer) → trả posts qua svc 92 (ed).
      const et = getKey(kv, 255);
      const entryType = et && et.length ? et[0] : -1;
      // Feed request trang Me (chỉ key255=entryType, không key7). ci.p vừa được
      // client set = entryType → trả svc92 NGAY nếu đã biết target=daptrung; nếu
      // chưa biết, nhớ entryType (cờ pending) để khi svc50/80 báo target sẽ trả.
      // POSTS feed của trang clan: svc103 key7="#daptrung", key255="P"(=80).
      // OlaClanMePageActivity nhận posts qua callback a(str,short,List<g>,80).
      // Trả svc92 (ed) echo type 80 → ci.p=80 khớp → render "ME Đã Đăng".
      if (peerNick === '#' + EGG_ACCOUNT) {
        const pt = entryType >= 0 ? entryType : 80;
        console.log(`   🥚 POSTS request "#daptrung" (svc103 type=${pt}) → trả svc103 (ee.c → 4-arg)`);
        replyEggFeed(sock, pt, 103);
        break;
      }
      if (entryType >= 0 && !peer) {
        if (currentMeTarget === EGG_ACCOUNT) {
          console.log(`   🥚 Feed request "daptrung" (svc103 type=${entryType}) → trả svc92 (ed)`);
          replyEggFeed(sock, entryType);
          break;
        }
        pendingType4 = entryType;
      }
      if (act === 1) {
        // Refresh: trả key72=ack time, key124=unread=0
        send(sock, 103, [
          { key: 115, val: vByte(1) },       // echo action=refresh
          { key: 72,  val: vLong(Date.now()) }, // server ack time
          { key: 124, val: vInt(0) },        // unread = 0
          { key: 255, val: vShort(0) },      // status OK
        ], `(ACK read refresh "${peerNick}")`);
      } else {
        // Sync full (action=0): trả rỗng OK để ẩn spinner, không sync entries
        send(sock, 103, [
          { key: 115, val: vByte(0) },       // echo action=sync
          { key: 255, val: vShort(0) },      // status OK
        ], `(ACK read sync "${peerNick}" → OK rỗng)`);
      }
      break;
    }

    // svc 204 (bp) = HAI VAI TRÒ:
    //  (A) Typing indicator: key109=peerNick (chuỗi ngắn), key130=timestamp.
    //  (B) ⭐ HTTP-over-socket PROXY: app tunnel request "REST" qua socket.
    //      key109 = URL đầy đủ (vd ".../json/id/profile?...un=<nick>..."),
    //      key130 = task id (long, = entity.m.a). Server THẬT fetch URL rồi
    //      trả body về. Đây là cách app nạp HỒ SƠ BẢN THÂN → set h.O
    //      (KHÔNG cần patch smali). Xem ci.java:600 (gửi 204), bp.java:20
    //      (decode response: key130=id, key23=body, không key0 → bA<0),
    //      network/e.java:428 → k.a.a(id).a(body) → w.a(bytes) → a(ag) → h.O.
    //  Cách trả: svc 204 với key130=ECHO id, key23=body JSON (raw), KHÔNG key0.
    case 204: {
      const urlBuf = getKey(kv, 109);
      const idBuf  = getKey(kv, 130);          // task id (long 8B) — echo nguyên bytes
      const url    = urlBuf ? urlBuf.toString('utf8') : '';

      // (B) PROXY: chỉ xử lý URL http(s); chuỗi ngắn không phải URL = typing.
      if (/^https?:\/\//i.test(url)) {
        const body = proxyFetch(url);           // -> Buffer|null body để app parse
        if (body && idBuf) {
          send(sock, 204, [
            { key: 130, val: idBuf },           // ECHO task id để client match task
            { key: 23,  val: body },            // body (bytes) -> w.a(byte[]) parse
          ], `(PROXY 204 → ${body.length}B cho ${shortUrl(url)})`);
        } else {
          console.log(`   🌐 PROXY 204 bỏ qua (chưa fake): ${shortUrl(url)}`);
        }
      } else {
        console.log(`   ⌨️  Typing indicator → "${url}"`);
      }
      break;
    }
    // svc 140 (av) = Sync danh sách hội thoại. App gửi 0 keys.
    // Trả danh sách hội thoại (format s.a → message.f[]) → hiện ở tab TIN NHẮN.
    // Trả rỗng → spinner tắt, danh sách giữ nguyên từ svc 209.
    case 140: {
      send(sock, 140, [
        { key: 255, val: vShort(0) },
      ], '(Sync hội thoại svc140 → OK rỗng)');
      break;
    }

    // svc 80 = bookmark/history. Khi mở trang Me 1 account, app gửi key110="mehistory"
    // + key23 (binary) chứa "#daptrung" → cũng là tín hiệu target = daptrung.
    case 80: {
      const k23 = getKey(kv, 23);
      const k110 = getKey(kv, 110);
      const ctx = k110 ? k110.toString('utf8') : '';
      if (k23 && k23.includes(Buffer.from(EGG_ACCOUNT))) {
        currentMeTarget = EGG_ACCOUNT;
        console.log(`   📌 (svc80 ${ctx}) Me target = "daptrung"`);
        maybeSendEggFeedOnTarget(sock);
      }
      send(sock, 80, [{ key: 255, val: vShort(0) }], `(svc80 ${ctx} OK)`);
      break;
    }

    // svc 50 = chọn account mở trên trang Me (key7=account). Ghi nhớ target để
    // svc 103 tiếp theo biết đang xem feed của ai (vd "daptrung").
    case 50: {
      const t = getKey(kv, 7);
      const etReq = getKey(kv, 255);
      const profType = etReq && etReq.length ? etReq[0] : 68; // "D"=0x44=68
      if (t) {
        const nick = t.toString('utf8');
        currentMeTarget = nick;
        const isEgg = nick === EGG_ACCOUNT;
        // codec ai (svc50) decode: key255=byte type(68) → gVar.a(entity.b, 68);
        // key7=account(bVar.a, phải != rỗng), key109=tên(b), 110=mô tả(c), 111(d),
        // key66=short(j), 124/125/126=int(f/g/h), 130=long(i). OlaClanMePageActivity
        // .a(entity.b,68) → this.e=profile → K() → hết kẹt → nạp posts.
        send(sock, 50, [
          { key: 255, val: vByte(profType) },
          { key: 7,   val: vStr(nick) },
          { key: 109, val: vStr(isEgg ? EGG_AUTHOR : nick) },
          { key: 110, val: vStr(isEgg ? 'Đập trứng mỗi ngày — trúng KEN & VIP miễn phí!' : '') },
          { key: 111, val: vStr('') },
          { key: 66,  val: vShort(0) },
          { key: 124, val: vInt(999) },
          { key: 125, val: vInt(EGG_POSTS.length) },
          { key: 126, val: vInt(0) },
          { key: 130, val: vLong(Date.now()) },
        ], `(svc50 PROFILE "${nick}" type=${profType})`);
        console.log(`   📌 Me target="${nick}" → trả profile (entity.b, type ${profType})`);
        maybeSendEggFeedOnTarget(sock);
      } else {
        send(sock, 50, [{ key: 255, val: vShort(0) }], '(svc50 OK rỗng)');
      }
      break;
    }

    // svc 116 (codec cj) = cũng là feed-request trang Me (entry type khác, vd 5).
    // ci.p = entryType vừa gửi. Trả svc92 (ed) echo CHÍNH entryType đó → ed chấp
    // nhận (key255==ci.p) và route a(g,list,type) tới handler màn đang mở qua
    // entry.c.f.b(type). Xử lý y hệt svc103.
    case 116: {
      const et116 = getKey(kv, 255);
      const type116 = et116 && et116.length ? et116[0] : -1;
      if (type116 >= 0 && !getKey(kv, 7)) {
        if (currentMeTarget === EGG_ACCOUNT) {
          console.log(`   🥚 Feed request "daptrung" (svc116 type=${type116}) → trả svc92 (ed)`);
          replyEggFeed(sock, type116);
          break;
        }
        pendingType4 = type116;
      }
      send(sock, 116, [{ key: 255, val: vShort(0) }], `(svc116 type=${type116} OK)`);
      break;
    }

    // svc 42 (z) = Nickname query. Gửi key7=nick. Codec decode rỗng → chỉ cần ack.
    case 42: {
      send(sock, 42, [
        { key: 255, val: vShort(0) },
      ], '(nickname query svc42 → OK)');
      break;
    }

    // Keepalive / heartbeat (5, 92): ack rỗng để giữ kết nối
    case 5:
    case 92: {
      send(sock, svc, [{ key: 255, val: vShort(0) }], '(keepalive ack)');
      break;
    }

    // svc 138 (codec w/aw, ch.java:138) = danh sách SECTION trang Me
    // (KHÔNG phải "notification sync" như README cũ ghi). Trả key83 → drawer Me
    // có dòng "Đập trứng". Xem replyMeSections().
    case 138: {
      replyMeSections(sock);
      break;
    }

    // svc 8 (ae) = Settings/config query. Trả OK rỗng.
    case 8:
    // svc 164 (ax) = RSS/feed config. Trả OK rỗng.
    case 164:
    // svc 168 (az) = Extension config. Trả OK rỗng.
    case 168: {
      send(sock, svc, [
        { key: 255, val: vShort(0) },
      ], `(svc ${svc} → OK rỗng)`);
      break;
    }

    default:
      console.log(`   … (chưa xử lý svc ${svc} — trả OK mặc định)`);
      send(sock, svc, [{ key: 255, val: vShort(0) }], `(svc ${svc} fallback OK)`);
  }
}

// ---------- TCP server ----------
const server = net.createServer((sock) => {
  const who = `${sock.remoteAddress}:${sock.remotePort}`;
  console.log(`\n========== 🔌 KẾT NỐI MỚI từ ${who} ==========`);
  let buf = Buffer.alloc(0);

  sock.on('data', (data) => {
    buf = Buffer.concat([buf, data]);
    // Cố gắng tách nhiều packet trong buffer
    while (buf.length >= 4) {
      const L = buf.readUInt32BE(0);          // = body + 6
      if (buf.length < 4 + L) break;          // chưa đủ packet
      const packet = buf.slice(4, 4 + L);
      buf = buf.slice(4 + L);
      const magic = packet.slice(0, 5);        // [6,5,10,19,4]
      const svc = packet.readUInt8(5);
      const body = packet.slice(6);
      if (!magic.equals(Buffer.from([6, 5, 10, 19, 4]))) {
        console.log(`   ⚠️ magic lạ: 0x${magic.toString('hex')} (svc=${svc}) — vẫn thử parse`);
      }
      try { handle(sock, svc, parseBody(body)); }
      catch (e) { console.log('   ❌ lỗi xử lý:', e.message); }
    }
  });

  sock.on('error', (e) => console.log(`   ⚠️ socket error ${who}: ${e.message}`));
  sock.on('close', () => {
    console.log(`========== ❌ ĐÓNG kết nối ${who} ==========\n`);
    isOnline = false;
    pendingRoomRequest = null;
    onlineSince = 0;
    currentMeTarget = null;
    pendingType4 = -1;
  });
});

server.listen(PORT, '0.0.0.0', () => {
  console.log('================================================');
  console.log(` Ola FAKE SOCKET server`);
  console.log(` Lắng nghe TCP 0.0.0.0:${PORT}`);
  console.log(` (app kết nối tới 192.168.2.7:${PORT})`);
  console.log('================================================');
});
