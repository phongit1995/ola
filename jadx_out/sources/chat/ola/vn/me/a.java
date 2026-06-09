package chat.ola.vn.me;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import chat.ola.vn.entity.ab;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.i;
import chat.ola.vn.entity.o;
import chat.ola.vn.entity.w;
import chat.ola.vn.entity.y;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.entry.c.f;
import chat.ola.vn.h;
import chat.ola.vn.network.OlaNetworkService;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class a {
    protected List<ab> a;
    protected w b;
    private long o;
    protected String c = null;
    protected String d = null;
    protected String e = null;
    protected String f = null;
    protected String g = null;
    protected long h = 0;
    protected long i = 0;
    private int p = 0;
    private int q = 0;
    private int r = 0;
    protected short j = 2;
    protected byte k = 0;
    protected boolean l = false;
    protected boolean m = true;
    protected boolean n = false;

    public a() {
        this.o = 0L;
        this.o = System.currentTimeMillis();
    }

    static /* synthetic */ int a(a aVar) {
        int i = aVar.q + 1;
        aVar.q = i;
        return i;
    }

    public static a a(String str) {
        try {
            return a(new JSONObject(str));
        } catch (Throwable unused) {
            return null;
        }
    }

    public static a a(JSONObject jSONObject) {
        JSONArray jSONArray;
        int length;
        try {
            a aVar = new a();
            aVar.o = jSONObject.getLong("meDraftId");
            aVar.i = jSONObject.getLong("lastModifiedTime");
            aVar.k = (byte) jSONObject.getInt("state");
            aVar.j = (short) jSONObject.getInt("editPrivacy");
            aVar.h = jSONObject.getLong("commentMeId");
            if (jSONObject.has("updateStatus")) {
                aVar.l = jSONObject.getBoolean("updateStatus");
            }
            if (jSONObject.has("commentRss")) {
                aVar.n = jSONObject.getBoolean("commentRss");
            }
            if (jSONObject.has("postStatusToMePage")) {
                aVar.m = jSONObject.getBoolean("postStatusToMePage");
            }
            if (jSONObject.has("text")) {
                aVar.c = jSONObject.getString("text");
            }
            if (jSONObject.has("sticker")) {
                aVar.b = w.a(jSONObject.getJSONObject("sticker"));
            }
            if (jSONObject.has("attachedPhotoList") && (length = (jSONArray = jSONObject.getJSONArray("attachedPhotoList")).length()) > 0) {
                aVar.a = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    try {
                        aVar.a.add(ab.a(jSONArray.getJSONObject(i)));
                    } catch (Throwable unused) {
                    }
                }
            }
            return aVar;
        } catch (Throwable unused2) {
            return null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c() {
        OlaNetworkService olaNetworkService;
        String str;
        short s;
        short s2;
        String str2;
        String str3 = "";
        final String str4 = null;
        final String strA = this.b != null ? this.b.a() : null;
        if (this.a != null) {
            int size = this.a.size();
            for (int i = 0; i < size; i++) {
                ab abVar = this.a.get(i);
                if (strA == null) {
                    strA = abVar.c;
                } else if (m.a(str3)) {
                    str3 = "##" + abVar.c + "#";
                } else {
                    str3 = str3 + " ##" + abVar.c + "#";
                }
            }
        }
        if (!m.a(str3)) {
            if (!m.a(this.c)) {
                str3 = str3 + " " + this.c;
            }
            this.c = str3;
        }
        if (m.a(this.c) && !m.a(strA)) {
            this.c = "##" + strA + "#";
            strA = null;
        }
        if (m.a(this.c) && m.a(strA)) {
            return;
        }
        final e eVar = new e() { // from class: chat.ola.vn.me.a.2
            @Override // chat.ola.vn.entry.c.e
            public short a() {
                return (short) 1;
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(int i2, short s3, String str5, chat.ola.vn.entity.d[] dVarArr) {
                try {
                    chat.ola.vn.util.c.c.a(OlaApplication.a(), str5);
                } catch (Throwable unused) {
                }
            }

            @Override // chat.ola.vn.entry.c.e
            public void a(Object... objArr) {
                try {
                    chat.ola.vn.util.c.c.b(OlaApplication.a());
                    a aVarY = h.u.y();
                    if (aVarY == null || aVarY.equals(a.this)) {
                        h.u.a((a) null);
                    }
                    if (a.this.d != null) {
                        chat.ola.vn.n.c.a().a(a.this.d);
                    }
                } catch (Throwable unused) {
                }
            }
        };
        if (this.l) {
            String str5 = this.c;
            if (!m.a(strA)) {
                str5 = m.a(str5) ? "##" + strA + "#" : str5 + " ##" + strA + "#";
            }
            OlaApplication.b.h(str5);
            if (!this.m) {
                return;
            }
        }
        if (!m.a(chat.ola.vn.n.c.a().b()) && !m.a(chat.ola.vn.n.c.a().c())) {
            str4 = chat.ola.vn.n.c.a().b() + ":" + chat.ola.vn.n.c.a().c();
        }
        if (this.h > 0) {
            if (this.n) {
                OlaApplication.b.b(this.c, this.h, strA, (short) 0, this.j, str4, f.a(eVar));
                return;
            } else {
                OlaApplication.b.a(this.c, this.h, strA, (short) 0, this.j, str4, f.a(eVar));
                return;
            }
        }
        if (!m.a(this.e)) {
            olaNetworkService = OlaApplication.b;
            str = this.c;
            s = 0;
            s2 = this.j;
            str2 = this.e;
        } else {
            if (!m.a(this.d)) {
                OlaApplication.b.a(this.f, this.d, this.g, new chat.ola.vn.p.a() { // from class: chat.ola.vn.me.a.3
                    @Override // chat.ola.vn.p.a
                    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void a(OlaVenueEntity olaVenueEntity) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void a(o oVar) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void a(y yVar) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void a(List<g> list, long j) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void a(short s3, String str6) {
                        OlaApplication.b.a(a.this.c, strA, (short) 0, a.this.j, str4, (String) null, f.a(eVar));
                    }

                    @Override // chat.ola.vn.p.a
                    public void b(OlaVenueEntity olaVenueEntity) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void b(List<OlaVenueEntity> list, int i2) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void c(List<OlaCheckInActionEntity> list) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void c(List<OlaCheckInItemEntity> list, int i2) {
                    }

                    @Override // chat.ola.vn.p.a
                    public void f(String str6) {
                        OlaApplication.b.a(a.this.c, strA, (short) 0, a.this.j, str4, str6, f.a(eVar));
                    }
                });
                return;
            }
            olaNetworkService = OlaApplication.b;
            str = this.c;
            s = 0;
            s2 = this.j;
            str2 = null;
        }
        olaNetworkService.a(str, strA, s, s2, str4, str2, f.a(eVar));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d() {
        chat.ola.vn.util.c.c.a(OlaApplication.a(), OlaApplication.a(R.string.message_fail_post_me_by_uploading));
    }

    static /* synthetic */ int g(a aVar) {
        int i = aVar.p + 1;
        aVar.p = i;
        return i;
    }

    public JSONObject a() {
        JSONObject jSONObjectB;
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("meDraftId", this.o);
            jSONObject.put("lastModifiedTime", this.i);
            jSONObject.put("state", (int) this.k);
            jSONObject.put("editPrivacy", (int) this.j);
            jSONObject.put("commentMeId", this.h);
            jSONObject.put("updateStatus", this.l);
            jSONObject.put("postStatusToMePage", this.m);
            jSONObject.put("commentRss", this.n);
            if (!m.a(this.c)) {
                jSONObject.put("text", this.c);
            }
            if (this.b != null && (jSONObjectB = this.b.b()) != null) {
                jSONObject.put("sticker", jSONObjectB);
            }
            if (this.a != null && this.a.size() > 0) {
                JSONArray jSONArray = new JSONArray();
                int size = this.a.size();
                for (int i = 0; i < size; i++) {
                    JSONObject jSONObjectA = this.a.get(i).a();
                    if (jSONObjectA != null) {
                        jSONArray.put(jSONObjectA);
                    }
                }
                jSONObject.put("attachedPhotoList", jSONArray);
            }
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void b() {
        boolean z = false;
        if (this.a != null) {
            try {
                this.q = 0;
                this.p = 0;
                this.r = this.a.size();
                Iterator<ab> it2 = this.a.iterator();
                while (it2.hasNext()) {
                    if (it2.next().b == 0) {
                        this.q++;
                    } else {
                        z = true;
                    }
                }
            } catch (Throwable unused) {
            }
        }
        if (!z) {
            c();
            return;
        }
        for (final ab abVar : this.a) {
            if (abVar.b == 1) {
                String str = null;
                if (!m.a(chat.ola.vn.n.c.a().b()) && !m.a(chat.ola.vn.n.c.a().c())) {
                    str = chat.ola.vn.n.c.a().b() + ":" + chat.ola.vn.n.c.a().c();
                }
                chat.ola.vn.u.b.a().a(abVar.c, str, new chat.ola.vn.u.o() { // from class: chat.ola.vn.me.a.1
                    private void a() {
                        a.g(a.this);
                        try {
                            j.d(chat.ola.vn.c.c(), R.string.message_upload_fail);
                        } catch (Throwable unused2) {
                        }
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(int i, int i2) {
                        chat.ola.vn.util.c.b.a(OlaApplication.a(), i, i2, a.this.p, a.this.q, a.this.r);
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(i iVar) {
                        a.a(a.this);
                        abVar.b = (byte) 0;
                        abVar.c = iVar.d();
                        if (a.this.p > 0 && a.this.q + a.this.p == a.this.r) {
                            a.this.d();
                        } else if (a.this.q == a.this.r) {
                            a.this.c();
                        }
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str2) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str2, int i) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str2, int i, String str3) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void a(String str2, String str3) {
                        a();
                    }

                    @Override // chat.ola.vn.u.o
                    public void b(String str2, String str3) {
                        a();
                    }
                });
            }
        }
    }

    public boolean equals(Object obj) {
        try {
            if (this.o == ((a) obj).o) {
                return true;
            }
        } catch (Throwable unused) {
        }
        return super.equals(obj);
    }

    public String toString() {
        try {
            return a().toString();
        } catch (Throwable unused) {
            return null;
        }
    }
}
