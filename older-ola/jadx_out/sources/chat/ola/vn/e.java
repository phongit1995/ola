package chat.ola.vn;

import android.accounts.Account;
import android.content.Context;
import chat.ola.vn.e.k;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.p;
import chat.ola.vn.entity.w;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class e implements chat.ola.vn.f.a {
    public static int a = 320;
    public static int b = 480;
    public static int c = 320;
    public static int d = 480;
    public static int e = 38;
    private static e f;
    private com.mg.ola.common.b.d A;
    private com.mg.ola.common.b.d B;
    private com.mg.ola.common.b.d C;
    private com.mg.ola.common.b.d D;
    private com.mg.ola.common.b.d E;
    private com.mg.ola.common.b.d F;
    private com.mg.ola.common.b.b G;
    private com.mg.ola.common.b.b H;
    private com.mg.ola.common.b.b I;
    private com.mg.ola.common.b.b J;
    private com.mg.ola.common.b.b K;
    private com.mg.ola.common.b.b L;
    private com.mg.ola.common.b.b M;
    private com.mg.ola.common.b.b N;
    private com.mg.ola.common.b.c g;
    private com.mg.ola.common.b.c h;
    private com.mg.ola.common.b.c i;
    private com.mg.ola.common.b.d j;
    private com.mg.ola.common.b.d k;
    private com.mg.ola.common.b.d l;
    private com.mg.ola.common.b.d o;
    private com.mg.ola.common.b.d p;
    private com.mg.ola.common.b.d q;
    private com.mg.ola.common.b.d r;
    private com.mg.ola.common.b.d s;
    private com.mg.ola.common.b.d t;
    private com.mg.ola.common.b.d u;
    private com.mg.ola.common.b.d v;
    private com.mg.ola.common.b.d w;
    private com.mg.ola.common.b.d x;
    private com.mg.ola.common.b.d y;
    private com.mg.ola.common.b.d z;

    private e() {
        Context contextA = OlaApplication.a();
        try {
            this.j = new com.mg.ola.common.b.d(contextA, R.string.key_last_online_account_id);
        } catch (Throwable unused) {
        }
        try {
            this.l = new com.mg.ola.common.b.d(contextA, R.string.key_last_chat_working_session);
        } catch (Throwable unused2) {
        }
        try {
            this.k = new com.mg.ola.common.b.d(contextA, R.string.key_ola_me_unread_notification);
        } catch (Throwable unused3) {
        }
        try {
            this.o = new com.mg.ola.common.b.d(contextA, R.string.key_http_chat_url);
        } catch (Throwable unused4) {
        }
        try {
            this.p = new com.mg.ola.common.b.d(contextA, R.string.key_install_package);
        } catch (Throwable unused5) {
        }
        try {
            this.q = new com.mg.ola.common.b.d(contextA, R.string.key_app_language);
        } catch (Throwable unused6) {
        }
        try {
            this.r = new com.mg.ola.common.b.d(contextA, R.string.key_account_list);
        } catch (Throwable unused7) {
        }
        try {
            this.s = new com.mg.ola.common.b.d(contextA, R.string.key_gcm_reg_id);
        } catch (Throwable unused8) {
        }
        try {
            this.t = new com.mg.ola.common.b.d(contextA, R.string.key_purchased_data);
        } catch (Throwable unused9) {
        }
        try {
            this.u = new com.mg.ola.common.b.d(contextA, R.string.key_hot_pictures);
        } catch (Throwable unused10) {
        }
        try {
            this.v = new com.mg.ola.common.b.d(contextA, R.string.key_un_upload_pictures);
        } catch (Throwable unused11) {
        }
        try {
            this.w = new com.mg.ola.common.b.d(contextA, R.string.key_snap_pic_brush_info);
        } catch (Throwable unused12) {
        }
        try {
            this.x = new com.mg.ola.common.b.d(contextA, R.string.key_rss_search_content_type);
        } catch (Throwable unused13) {
        }
        try {
            this.y = new com.mg.ola.common.b.d(contextA, R.string.key_last_quick_check_in_venue);
        } catch (Throwable unused14) {
        }
        try {
            this.I = new com.mg.ola.common.b.b(contextA, R.string.key_app_version_code);
        } catch (Throwable unused15) {
        }
        try {
            this.J = new com.mg.ola.common.b.b(contextA, R.string.key_ola_app_store_revision);
        } catch (Throwable unused16) {
        }
        try {
            this.g = new com.mg.ola.common.b.c(contextA, R.string.key_ola_app_store_show_time);
        } catch (Throwable unused17) {
        }
        try {
            this.K = new com.mg.ola.common.b.b(contextA, R.string.key_snap_pic_time);
        } catch (Throwable unused18) {
        }
        try {
            this.L = new com.mg.ola.common.b.b(contextA, R.string.key_rss_font_size);
        } catch (Throwable unused19) {
        }
        try {
            this.M = new com.mg.ola.common.b.b(contextA, R.string.key_resized_view_height);
        } catch (Throwable unused20) {
        }
        try {
            this.N = new com.mg.ola.common.b.b(contextA, R.string.key_post_me_scope);
        } catch (Throwable unused21) {
        }
        try {
            this.i = new com.mg.ola.common.b.c(contextA, R.string.key_last_vote_time);
        } catch (Throwable unused22) {
        }
        try {
            this.G = new com.mg.ola.common.b.b(contextA, R.string.key_vip_icon_rev);
        } catch (Throwable unused23) {
        }
        try {
            this.H = new com.mg.ola.common.b.b(contextA, R.string.key_last_opening_tab);
        } catch (Throwable unused24) {
        }
        try {
            this.z = new com.mg.ola.common.b.d(contextA, R.string.key_tutorial);
        } catch (Throwable unused25) {
        }
        try {
            this.A = new com.mg.ola.common.b.d(contextA, R.string.key_recent_sticker);
        } catch (Throwable unused26) {
        }
        try {
            this.B = new com.mg.ola.common.b.d(contextA, R.string.key_recent_smiley);
        } catch (Throwable unused27) {
        }
        try {
            this.C = new com.mg.ola.common.b.d(contextA, R.string.key_ignored_venues);
        } catch (Throwable unused28) {
        }
        try {
            this.D = new com.mg.ola.common.b.d(contextA, R.string.key_message_ringtone_sound);
        } catch (Throwable unused29) {
        }
        try {
            this.E = new com.mg.ola.common.b.d(contextA, R.string.key_app_passcode);
        } catch (Throwable unused30) {
        }
        try {
            this.F = new com.mg.ola.common.b.d(contextA, R.string.key_quick_reply_message);
        } catch (Throwable unused31) {
        }
        try {
            this.h = new com.mg.ola.common.b.c(contextA, R.string.key_hide_app_time);
        } catch (Throwable unused32) {
        }
    }

    public static final e a() {
        if (f == null) {
            f = new e();
        }
        return f;
    }

    private void e(List<chat.ola.vn.h.a> list) {
        if (list != null) {
            try {
                if (list.size() != 0) {
                    JSONArray jSONArray = new JSONArray();
                    Iterator<chat.ola.vn.h.a> it2 = list.iterator();
                    while (it2.hasNext()) {
                        jSONArray.put(it2.next().a());
                    }
                    this.r.b(jSONArray.toString());
                    return;
                }
            } catch (Throwable unused) {
                return;
            }
        }
        this.r.b("");
    }

    private List<p> z() {
        ArrayList arrayList = null;
        try {
            String strA = this.t.a("");
            if (!m.a(strA)) {
                JSONArray jSONArray = new JSONArray(strA);
                int length = jSONArray.length();
                for (int i = 0; i < length; i++) {
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    String string = jSONObject.getString("productId");
                    String string2 = jSONObject.getString("signatureData");
                    if (arrayList == null) {
                        arrayList = new ArrayList(length);
                    }
                    p pVar = new p();
                    pVar.f = string;
                    pVar.m = string2;
                    arrayList.add(pVar);
                }
            }
        } catch (Throwable unused) {
        }
        return arrayList;
    }

    public void a(int i) {
        try {
            this.J.b(Integer.valueOf(i));
        } catch (Throwable unused) {
        }
    }

    public void a(long j) {
        try {
            this.g.b(Long.valueOf(j));
        } catch (Throwable unused) {
        }
    }

    public void a(String str) {
        try {
            if (m.a(str)) {
                this.j.b("");
            } else {
                this.j.b(str);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, String str2) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null) {
                listN = new ArrayList<>();
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    aVar.b = str2;
                    e(listN);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, String str2, String str3, String str4) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null) {
                listN = new ArrayList<>();
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    aVar.b = str2;
                    aVar.c = str3;
                    e(listN);
                    return;
                }
            }
            Account account = new Account(str, OlaApplication.a(R.string.account_type));
            chat.ola.vn.h.a aVar2 = new chat.ola.vn.h.a();
            aVar2.a = account;
            aVar2.b = str2;
            aVar2.c = str3;
            aVar2.e = System.currentTimeMillis();
            aVar2.d = str4;
            listN.add(aVar2);
            e(listN);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x002e A[Catch: Throwable -> 0x0033, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0033, blocks: (B:3:0x0002, B:5:0x0008, B:7:0x0014, B:8:0x0024, B:9:0x002a, B:11:0x002e), top: B:14:0x0002 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(java.util.List<chat.ola.vn.entity.w> r5) {
        /*
            r4 = this;
            if (r5 == 0) goto L2e
            int r0 = r5.size()     // Catch: java.lang.Throwable -> L33
            if (r0 <= 0) goto L2e
            org.json.JSONArray r0 = new org.json.JSONArray     // Catch: java.lang.Throwable -> L33
            r0.<init>()     // Catch: java.lang.Throwable -> L33
            r1 = 0
            int r2 = r5.size()     // Catch: java.lang.Throwable -> L33
        L12:
            if (r1 >= r2) goto L24
            java.lang.Object r3 = r5.get(r1)     // Catch: java.lang.Throwable -> L33
            chat.ola.vn.entity.w r3 = (chat.ola.vn.entity.w) r3     // Catch: java.lang.Throwable -> L33
            org.json.JSONObject r3 = r3.b()     // Catch: java.lang.Throwable -> L33
            r0.put(r1, r3)     // Catch: java.lang.Throwable -> L33
            int r1 = r1 + 1
            goto L12
        L24:
            com.mg.ola.common.b.d r5 = r4.A     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = r0.toString()     // Catch: java.lang.Throwable -> L33
        L2a:
            r5.b(r0)     // Catch: java.lang.Throwable -> L33
            return
        L2e:
            com.mg.ola.common.b.d r5 = r4.A     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = ""
            goto L2a
        L33:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.e.a(java.util.List):void");
    }

    public int b() {
        try {
            return this.I.a(0).intValue();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public void b(int i) {
        if (i <= 0) {
            i = 1;
        }
        if (i > 10) {
            i = 10;
        }
        try {
            this.L.b(Integer.valueOf(i));
        } catch (Throwable unused) {
        }
    }

    public void b(long j) {
        try {
            this.i.b(Long.valueOf(j));
        } catch (Throwable unused) {
        }
    }

    public void b(String str) {
        try {
            if (m.a(str)) {
                this.l.b("");
            } else {
                this.l.b(str);
            }
        } catch (Throwable unused) {
        }
    }

    public void b(String str, String str2) {
        try {
            if (m.a(str) || m.a(str2)) {
                return;
            }
            List<p> listZ = z();
            if (listZ == null) {
                listZ = new ArrayList<>();
            }
            Iterator<p> it2 = listZ.iterator();
            while (it2.hasNext()) {
                if (m.b(str, it2.next().f)) {
                    return;
                }
            }
            p pVar = new p();
            pVar.f = str;
            pVar.m = str2;
            listZ.add(pVar);
            JSONArray jSONArray = new JSONArray();
            Iterator<p> it3 = listZ.iterator();
            while (it3.hasNext()) {
                jSONArray.put(it3.next().a());
            }
            this.t.b(jSONArray.toString());
        } catch (Throwable unused) {
        }
    }

    public void b(List<String> list) {
        if (list != null) {
            try {
                if (list.size() != 0) {
                    JSONArray jSONArray = new JSONArray();
                    int size = list.size();
                    for (int i = 0; i < size; i++) {
                        jSONArray.put(i, list.get(i));
                    }
                    this.F.b(jSONArray.toString());
                    return;
                }
            } catch (Throwable unused) {
                return;
            }
        }
        this.F.b("");
    }

    public long c() {
        try {
            return this.g.a(0L).longValue();
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public void c(int i) {
        try {
            this.M.b(Integer.valueOf(i));
        } catch (Throwable unused) {
        }
    }

    public void c(long j) {
        try {
            this.h.b(Long.valueOf(j));
        } catch (Throwable unused) {
        }
    }

    public void c(String str) {
        if (str == null) {
            str = "";
        }
        try {
            this.p.b(str);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x002e A[Catch: Throwable -> 0x0033, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0033, blocks: (B:3:0x0002, B:5:0x0008, B:7:0x0014, B:8:0x0024, B:9:0x002a, B:11:0x002e), top: B:14:0x0002 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void c(java.util.List<chat.ola.vn.entry.h> r5) {
        /*
            r4 = this;
            if (r5 == 0) goto L2e
            int r0 = r5.size()     // Catch: java.lang.Throwable -> L33
            if (r0 <= 0) goto L2e
            org.json.JSONArray r0 = new org.json.JSONArray     // Catch: java.lang.Throwable -> L33
            r0.<init>()     // Catch: java.lang.Throwable -> L33
            r1 = 0
            int r2 = r5.size()     // Catch: java.lang.Throwable -> L33
        L12:
            if (r1 >= r2) goto L24
            java.lang.Object r3 = r5.get(r1)     // Catch: java.lang.Throwable -> L33
            chat.ola.vn.entry.h r3 = (chat.ola.vn.entry.h) r3     // Catch: java.lang.Throwable -> L33
            org.json.JSONObject r3 = r3.c()     // Catch: java.lang.Throwable -> L33
            r0.put(r1, r3)     // Catch: java.lang.Throwable -> L33
            int r1 = r1 + 1
            goto L12
        L24:
            com.mg.ola.common.b.d r5 = r4.B     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = r0.toString()     // Catch: java.lang.Throwable -> L33
        L2a:
            r5.b(r0)     // Catch: java.lang.Throwable -> L33
            return
        L2e:
            com.mg.ola.common.b.d r5 = r4.B     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = ""
            goto L2a
        L33:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.e.c(java.util.List):void");
    }

    public int d() {
        try {
            return (short) this.L.a(5).intValue();
        } catch (Throwable unused) {
            return 5;
        }
    }

    public void d(int i) {
        try {
            this.N.b(Integer.valueOf(i));
        } catch (Throwable unused) {
        }
    }

    public void d(String str) {
        if (str == null) {
            str = "";
        }
        try {
            this.q.b(str);
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x002e A[Catch: Throwable -> 0x0033, TRY_LEAVE, TryCatch #0 {Throwable -> 0x0033, blocks: (B:3:0x0002, B:5:0x0008, B:7:0x0014, B:8:0x0024, B:9:0x002a, B:11:0x002e), top: B:14:0x0002 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void d(java.util.List<chat.ola.vn.entity.OlaVenueEntity> r5) {
        /*
            r4 = this;
            if (r5 == 0) goto L2e
            int r0 = r5.size()     // Catch: java.lang.Throwable -> L33
            if (r0 <= 0) goto L2e
            org.json.JSONArray r0 = new org.json.JSONArray     // Catch: java.lang.Throwable -> L33
            r0.<init>()     // Catch: java.lang.Throwable -> L33
            r1 = 0
            int r2 = r5.size()     // Catch: java.lang.Throwable -> L33
        L12:
            if (r1 >= r2) goto L24
            java.lang.Object r3 = r5.get(r1)     // Catch: java.lang.Throwable -> L33
            chat.ola.vn.entity.OlaVenueEntity r3 = (chat.ola.vn.entity.OlaVenueEntity) r3     // Catch: java.lang.Throwable -> L33
            org.json.JSONObject r3 = r3.a()     // Catch: java.lang.Throwable -> L33
            r0.put(r1, r3)     // Catch: java.lang.Throwable -> L33
            int r1 = r1 + 1
            goto L12
        L24:
            com.mg.ola.common.b.d r5 = r4.C     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = r0.toString()     // Catch: java.lang.Throwable -> L33
        L2a:
            r5.b(r0)     // Catch: java.lang.Throwable -> L33
            return
        L2e:
            com.mg.ola.common.b.d r5 = r4.C     // Catch: java.lang.Throwable -> L33
            java.lang.String r0 = ""
            goto L2a
        L33:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.e.d(java.util.List):void");
    }

    public int e() {
        try {
            return this.M.a(0).intValue();
        } catch (Throwable unused) {
            return 5;
        }
    }

    public void e(int i) {
        try {
            this.H.b(Integer.valueOf(i));
        } catch (Throwable unused) {
        }
    }

    public void e(String str) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null) {
                listN = new ArrayList<>();
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    aVar.b = "";
                    e(listN);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    public short f() {
        try {
            return (short) this.N.a(2).intValue();
        } catch (Throwable unused) {
            return (short) 2;
        }
    }

    public void f(String str) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null) {
                listN = new ArrayList<>();
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    listN.remove(aVar);
                    e(listN);
                    return;
                }
            }
        } catch (Throwable unused) {
        }
    }

    public boolean f(int i) {
        try {
            String[] strArrSplit = this.k.a("").split(":");
            int i2 = Integer.parseInt(strArrSplit[0]);
            long j = Long.parseLong(strArrSplit[1]);
            if (i2 != i) {
                return true;
            }
            if (System.currentTimeMillis() - j > 3600000) {
                return true;
            }
        } catch (Throwable unused) {
        }
        return false;
    }

    public int g() {
        try {
            return this.G.a(18).intValue();
        } catch (Throwable unused) {
            return 18;
        }
    }

    public void g(int i) {
        try {
            if (i <= 0) {
                this.k.b("");
                return;
            }
            this.k.b(i + ":" + System.currentTimeMillis());
        } catch (Throwable unused) {
        }
    }

    public void g(String str) {
        if (str == null) {
            str = "";
        }
        try {
            this.s.b(str);
        } catch (Throwable unused) {
        }
    }

    public int h() {
        try {
            int iIntValue = this.H.a(0).intValue();
            if (iIntValue != 14) {
                switch (iIntValue) {
                    case 0:
                    case 1:
                    case 2:
                        break;
                    default:
                        return 0;
                }
            }
            return iIntValue;
        } catch (Throwable unused) {
            return 0;
        }
    }

    public void h(String str) {
        try {
            if (m.a(str)) {
                return;
            }
            List<String> listQ = q();
            if (listQ == null) {
                listQ = new ArrayList<>();
            }
            Iterator<String> it2 = listQ.iterator();
            while (it2.hasNext()) {
                if (m.b(str, it2.next())) {
                    return;
                }
            }
            while (true) {
                int size = listQ.size();
                if (size <= 10) {
                    break;
                } else {
                    listQ.remove(size - 1);
                }
            }
            listQ.add(0, str);
            int size2 = listQ.size();
            JSONArray jSONArray = new JSONArray();
            for (int i = 0; i < size2; i++) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("path", listQ.get(i));
                jSONArray.put(i, jSONObject);
            }
            this.u.b(jSONArray.toString());
        } catch (Throwable unused) {
        }
    }

    public String i() {
        try {
            return this.j.a("");
        } catch (Throwable unused) {
            return null;
        }
    }

    public void i(String str) {
        List<String> listQ;
        int size;
        try {
            if (m.a(str) || (listQ = q()) == null) {
                return;
            }
            Iterator<String> it2 = listQ.iterator();
            while (true) {
                if (!it2.hasNext()) {
                    break;
                }
                String next = it2.next();
                if (m.b(str, next)) {
                    listQ.remove(next);
                    break;
                }
            }
            while (true) {
                size = listQ.size();
                if (size <= 10) {
                    break;
                } else {
                    listQ.remove(size - 1);
                }
            }
            JSONArray jSONArray = new JSONArray();
            for (int i = 0; i < size; i++) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("path", listQ.get(i));
                jSONArray.put(i, jSONObject);
            }
            this.u.b(jSONArray.toString());
        } catch (Throwable unused) {
        }
    }

    public String j() {
        try {
            return this.l.a("");
        } catch (Throwable unused) {
            return null;
        }
    }

    public void j(String str) {
        int size;
        try {
            if (m.a(str)) {
                return;
            }
            List<String> listS = s();
            if (listS == null) {
                listS = new ArrayList<>();
            }
            Iterator<String> it2 = listS.iterator();
            while (it2.hasNext()) {
                if (m.b(str, it2.next())) {
                    return;
                }
            }
            while (true) {
                size = listS.size();
                if (size < 10) {
                    break;
                } else {
                    listS.remove(size - 1);
                }
            }
            listS.add(0, str);
            JSONArray jSONArray = new JSONArray();
            for (int i = 0; i < size; i++) {
                JSONObject jSONObject = new JSONObject();
                jSONObject.put("path", listS.get(i));
                jSONArray.put(i, jSONObject);
            }
            this.v.b(jSONArray.toString());
        } catch (Throwable unused) {
        }
    }

    public String k() {
        try {
            return this.p.a("");
        } catch (Throwable unused) {
            return null;
        }
    }

    public void k(String str) {
        List<p> listZ;
        try {
            if (m.a(str) || (listZ = z()) == null) {
                return;
            }
            JSONArray jSONArray = new JSONArray();
            for (p pVar : listZ) {
                if (!m.b(pVar.f, str)) {
                    jSONArray.put(pVar.a());
                }
            }
            if (jSONArray.length() == 0) {
                this.t.b("");
            } else {
                this.t.b(jSONArray.toString());
            }
        } catch (Throwable unused) {
        }
    }

    public String l() {
        try {
            return this.q.a("default");
        } catch (Throwable unused) {
            return null;
        }
    }

    public String l(String str) {
        try {
            if (m.a(str)) {
                return null;
            }
            for (p pVar : z()) {
                if (m.b(str, pVar.f)) {
                    return pVar.m;
                }
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public String m(String str) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null || listN.size() <= 0) {
                return null;
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    return aVar.b;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean m() {
        try {
            return this.q.a(null) != null;
        } catch (Throwable unused) {
            return true;
        }
    }

    public String n(String str) {
        try {
            List<chat.ola.vn.h.a> listN = n();
            if (listN == null || listN.size() <= 0) {
                return null;
            }
            for (chat.ola.vn.h.a aVar : listN) {
                if (m.b(aVar.a.name, str)) {
                    return aVar.d;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public List<chat.ola.vn.h.a> n() {
        JSONArray jSONArray;
        try {
            String strA = this.r.a("");
            if (!m.a(strA) && (jSONArray = new JSONArray(strA)) != null && jSONArray.length() > 0) {
                int length = jSONArray.length();
                ArrayList arrayList = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    long jCurrentTimeMillis = System.currentTimeMillis();
                    if (jSONObject.has("username")) {
                        String string = jSONObject.getString("username");
                        String string2 = jSONObject.has("password") ? jSONObject.getString("password") : null;
                        String string3 = jSONObject.has("workingSession") ? jSONObject.getString("workingSession") : null;
                        if (jSONObject.has("lastAccessTime")) {
                            try {
                                jCurrentTimeMillis = Long.parseLong(jSONObject.getString("lastAccessTime"));
                            } catch (Throwable unused) {
                            }
                        }
                        Account account = new Account(string, OlaApplication.a(R.string.account_type));
                        chat.ola.vn.h.a aVar = new chat.ola.vn.h.a();
                        aVar.a = account;
                        aVar.b = string2;
                        aVar.c = string3;
                        aVar.e = jCurrentTimeMillis;
                        arrayList.add(aVar);
                    }
                }
                if (arrayList != null) {
                    try {
                        Collections.sort(arrayList, new chat.ola.vn.e.a());
                    } catch (Throwable unused2) {
                    }
                }
                return arrayList;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    public void o() {
        try {
            this.u.b("");
        } catch (Throwable unused) {
        }
    }

    public void o(String str) {
        try {
            if (m.a(str)) {
                str = "Ola";
            }
            this.D.b(str);
        } catch (Throwable unused) {
        }
    }

    public String p() {
        try {
            return this.s.a("");
        } catch (Throwable unused) {
            return null;
        }
    }

    public void p(String str) {
        try {
            if (m.a(str)) {
                str = "";
            }
            this.E.b(str);
        } catch (Throwable unused) {
        }
    }

    public List<String> q() {
        ArrayList arrayList = null;
        try {
            String strA = this.u.a("");
            if (!m.a(strA)) {
                JSONArray jSONArray = new JSONArray(strA);
                int length = jSONArray.length();
                for (int i = 0; i < length; i++) {
                    String string = jSONArray.getJSONObject(i).getString("path");
                    if (arrayList == null) {
                        arrayList = new ArrayList(length);
                    }
                    if (com.mg.ola.common.d.c.a(string)) {
                        arrayList.add(string);
                    }
                }
            }
        } catch (Throwable unused) {
        }
        return arrayList;
    }

    public String r() {
        return "news";
    }

    public List<String> s() {
        ArrayList arrayList = null;
        try {
            String strA = this.v.a("");
            if (!m.a(strA)) {
                JSONArray jSONArray = new JSONArray(strA);
                int length = jSONArray.length();
                for (int i = 0; i < length; i++) {
                    String string = jSONArray.getJSONObject(i).getString("path");
                    if (arrayList == null) {
                        arrayList = new ArrayList(length);
                    }
                    arrayList.add(string);
                }
            }
        } catch (Throwable unused) {
        }
        return arrayList;
    }

    public List<w> t() {
        try {
            JSONArray jSONArray = new JSONArray(this.A.a(""));
            int length = jSONArray.length();
            if (length <= 0) {
                return null;
            }
            ArrayList arrayList = new ArrayList(length);
            for (int i = 0; i < length; i++) {
                w wVarA = w.a(jSONArray.getJSONObject(i));
                if (!arrayList.contains(wVarA)) {
                    arrayList.add(wVarA);
                }
            }
            Collections.sort(arrayList, new k());
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public String u() {
        try {
            return this.D.a("Ola");
        } catch (Throwable unused) {
            return "Ola";
        }
    }

    public String v() {
        try {
            return this.E.a("");
        } catch (Throwable unused) {
            return "";
        }
    }

    public List<String> w() {
        ArrayList arrayList = null;
        try {
            JSONArray jSONArray = new JSONArray(this.F.a(""));
            int length = jSONArray.length();
            if (length > 0) {
                ArrayList arrayList2 = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    try {
                        arrayList2.add(jSONArray.getString(i));
                    } catch (Throwable unused) {
                        arrayList = arrayList2;
                    }
                }
                return arrayList2;
            }
        } catch (Throwable unused2) {
        }
        try {
            ArrayList arrayList3 = new ArrayList(3);
            try {
                for (String str : OlaApplication.a().getResources().getStringArray(R.array.quick_reply_messages)) {
                    arrayList3.add(str);
                }
                return arrayList3;
            } catch (Throwable unused3) {
                return arrayList3;
            }
        } catch (Throwable unused4) {
            return arrayList;
        }
    }

    public List<chat.ola.vn.entry.h> x() {
        chat.ola.vn.entry.h hVar;
        try {
            JSONArray jSONArray = new JSONArray(this.B.a(""));
            int length = jSONArray.length();
            if (length > 0) {
                ArrayList arrayList = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    short s = (short) jSONObject.getInt("smileyType");
                    if (s == 0) {
                        String string = jSONObject.getString("smileyTextContent");
                        hVar = new chat.ola.vn.entry.h(chat.ola.vn.util.h.a().a(string).intValue(), s, string);
                    } else if (s == 1) {
                        int i2 = jSONObject.getInt("emojiCode");
                        hVar = new chat.ola.vn.entry.h(chat.ola.vn.util.g.a().a(i2).intValue(), s, i2);
                    } else {
                        hVar = null;
                    }
                    if (hVar != null) {
                        hVar.a = jSONObject.getLong("lastHitTime");
                        if (!arrayList.contains(hVar)) {
                            arrayList.add(hVar);
                        }
                    }
                }
                Collections.sort(arrayList, new chat.ola.vn.e.j());
                return arrayList;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public List<OlaVenueEntity> y() {
        try {
            JSONArray jSONArray = new JSONArray(this.C.a(""));
            int length = jSONArray.length();
            if (length > 0) {
                ArrayList arrayList = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
                    olaVenueEntity.a(jSONObject.getString("venueId"));
                    long j = jSONObject.getLong("timeStamp");
                    if (System.currentTimeMillis() - j <= 28800000) {
                        olaVenueEntity.b(j);
                        arrayList.add(olaVenueEntity);
                    }
                }
                return arrayList;
            }
        } catch (Throwable unused) {
        }
        return new ArrayList(20);
    }
}
