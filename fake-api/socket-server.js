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

let seeded = false; // chỉ seed tin nhắn 1 lần để tránh trùng khi reconnect

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
      const username = un ? un.toString('utf8') : 'test';
      send(sock, 97, [
        { key: 255, val: vShort(0) },          // status = OK -> ONLINE
        { key: 9,   val: vLong(Date.now()) },   // ciVar.e
        { key: 45,  val: vShort(0) },           // online status
        { key: 4,   val: vStr(username) },
        { key: 22,  val: vStr(username) },
        { key: 61,  val: vStr('vi') },
      ], '(ONLINE! status=0)');

      // Sau khi online -> PUSH danh bạ qua svc 250 (codec ca đã wire) + seed hội thoại
      setTimeout(() => pushFriendListCa(sock), 1000);
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

    // Keepalive / heartbeat (5, 92): ack rỗng để giữ kết nối
    case 5:
    case 92: {
      send(sock, svc, [{ key: 255, val: vShort(0) }], '(keepalive ack)');
      break;
    }

    default:
      console.log('   … (chưa xử lý svc này — chỉ log)');
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
  sock.on('close', () => console.log(`========== ❌ ĐÓNG kết nối ${who} ==========\n`));
});

server.listen(PORT, '0.0.0.0', () => {
  console.log('================================================');
  console.log(` Ola FAKE SOCKET server`);
  console.log(` Lắng nghe TCP 0.0.0.0:${PORT}`);
  console.log(` (app kết nối tới 192.168.2.7:${PORT})`);
  console.log('================================================');
});
