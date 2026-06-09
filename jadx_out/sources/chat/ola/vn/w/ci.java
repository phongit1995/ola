package chat.ola.vn.w;

import android.annotation.SuppressLint;
import android.util.Log;
import chat.ola.vn.OlaApplication;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.LinkedList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class ci implements chat.ola.vn.f.d {
    public long e;
    String f;
    String h;
    String i;
    String j;
    String k;
    String l;
    int n;
    private dr t;
    private dq u;
    private chat.ola.vn.p.g v;
    private byte[] w;
    private long x;
    private chat.ola.vn.entity.c y;
    String g = null;
    short o = 0;
    short p = 0;
    long q = 0;
    long r = 0;
    int s = 3;
    private long A = 0;
    private long B = 0;
    private long C = 0;
    private long D = 0;
    private long E = 0;
    private long F = 0;
    private boolean z = false;
    private List<bk> G = new LinkedList();
    String m = "" + System.currentTimeMillis();

    private void a(final byte b) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.55
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 146);
                bkVar.as = b;
                ci.this.a(bkVar, true, true);
            }
        });
    }

    private void a(final byte b, final byte b2, final String str, final String[] strArr, final String str2, final String str3, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.50
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 203);
                bkVar.as = b;
                bkVar.ae = b2;
                bkVar.t = strArr;
                bkVar.s = str;
                bkVar.z = str2;
                bkVar.A = str3;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    private void a(byte b, String str) {
        bk bkVar = new bk((short) 190);
        bkVar.as = b;
        bkVar.z = str;
        a(bkVar);
    }

    private void a(final byte b, final String str, final long j, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.17
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 91);
                bkVar.as = b;
                bkVar.z = str;
                bkVar.S = j;
                bkVar.ac = s;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(byte b, String str, String str2, String str3, short s) {
        bk bkVar = new bk((short) 172);
        bkVar.as = b;
        bkVar.A = str;
        bkVar.L = str2;
        bkVar.m = str3;
        bkVar.aj = s;
        a(bkVar);
    }

    private void a(final byte b, final String str, final String str2, final short s, final short s2) {
        f(new Runnable() { // from class: chat.ola.vn.w.ci.43
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 188);
                bkVar.as = b;
                bkVar.m = str;
                bkVar.s = str2;
                bkVar.ai = s;
                bkVar.aj = s2;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(final byte b, final String str, final short s, final String str2, final short s2) {
        e(new Runnable() { // from class: chat.ola.vn.w.ci.52
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 57);
                bkVar.as = b;
                bkVar.al = s;
                bkVar.A = str;
                bkVar.C = str2;
                bkVar.aj = s2;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(final byte b, final String str, final chat.ola.vn.entity.aa[] aaVarArr, final short s) {
        d(new Runnable() { // from class: chat.ola.vn.w.ci.53
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 80);
                bkVar.as = b;
                bkVar.z = str;
                bkVar.a = aaVarArr;
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(final byte b, final String str, final String[] strArr, final String[] strArr2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.28
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 193);
                bkVar.as = b;
                bkVar.G = strArr;
                bkVar.F = strArr2;
                bkVar.z = str;
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(final int i, final byte b) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.58
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 66);
                bkVar.aa = i;
                bkVar.as = b;
                ci.this.a(bkVar, true, true);
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(bk bkVar) {
        a(bkVar, true, false);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final bk bkVar, boolean z, final boolean z2) {
        if (!z || this.z) {
            chat.ola.vn.h.Q.execute(new Runnable() { // from class: chat.ola.vn.w.ci.14
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        cg cgVar = new cg(bkVar.ab);
                        cgVar.a = z2;
                        bb bbVarA = ch.a().a(cgVar.b());
                        if (bbVarA != null && ci.this.v != null) {
                            bbVarA.a(bkVar, cgVar, ci.this.v);
                            ci.this.t.a(cgVar, ci.this.z);
                        } else {
                            synchronized (ci.this.G) {
                                ci.this.G.add(bkVar);
                            }
                        }
                    } catch (Throwable unused) {
                        synchronized (ci.this.G) {
                            ci.this.G.add(bkVar);
                        }
                    }
                }
            });
            return;
        }
        synchronized (this.G) {
            this.G.add(bkVar);
        }
    }

    private void a(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.A;
            if (j < 5000) {
                long j2 = 5000 - j;
                this.A = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.A = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    private void a(String str, byte b, short s) {
        bk bkVar = new bk((short) 167);
        bkVar.p = str;
        bkVar.aq = b;
        bkVar.aj = s;
        a(bkVar);
    }

    private void a(final String str, final String str2, final boolean z) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.27
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 79);
                bkVar.p = str;
                bkVar.z = str2;
                bkVar.as = z ? (byte) 1 : (byte) 0;
                ci.this.a(bkVar);
            }
        });
    }

    private void a(String str, short s, short s2) {
        bk bkVar = new bk((short) 160);
        bkVar.w = str;
        bkVar.ac = s;
        bkVar.aj = s2;
        a(bkVar);
    }

    private void a(String str, boolean z) {
        bk bkVar = new bk((short) 73);
        bkVar.aw = z;
        bkVar.p = str;
        a(bkVar);
    }

    private void a(String[] strArr, short s) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        StringBuffer stringBuffer = new StringBuffer(strArr[0]);
        for (int i = 1; i < strArr.length; i++) {
            stringBuffer.append(";" + strArr[i]);
        }
        bk bkVar = new bk((short) 149);
        bkVar.p = stringBuffer.toString();
        bkVar.af = s;
        a(bkVar);
    }

    private void b(byte b, String str, long j, short s) {
        bk bkVar = new bk((short) 189);
        bkVar.as = b;
        bkVar.p = str;
        bkVar.W = j;
        bkVar.aj = s;
        a(bkVar);
    }

    private void b(final byte b, final String str, final String[] strArr, final String[] strArr2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.49
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 198);
                bkVar.as = b;
                bkVar.A = str;
                bkVar.F = strArr;
                bkVar.t = strArr2;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    private void b(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.B;
            if (j < 500) {
                long j2 = 500 - j;
                this.B = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.B = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    private void c(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.F;
            if (j < 3000) {
                long j2 = 3000 - j;
                this.F = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.F = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    private void c(final String str, final short s, final String str2, final short s2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.29
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 104);
                bkVar.p = str;
                bkVar.ag = s;
                bkVar.m = str2;
                bkVar.aj = s2;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    private void d(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.C;
            if (j < 5000) {
                long j2 = 5000 - j;
                this.C = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.C = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    private void e(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.D;
            if (j < 500) {
                long j2 = 500 - j;
                this.D = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.D = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    private void f(Runnable runnable) {
        try {
            long jCurrentTimeMillis = System.currentTimeMillis();
            long j = jCurrentTimeMillis - this.E;
            if (j < 10000) {
                long j2 = 10000 - j;
                this.E = jCurrentTimeMillis + j2;
                if (OlaApplication.b(runnable, j2) != null) {
                    return;
                }
            }
            this.E = jCurrentTimeMillis;
            runnable.run();
        } catch (Throwable unused) {
        }
    }

    void a() {
        bk bkVar = new bk((short) 96);
        bkVar.g = this.y.c();
        bkVar.x = this.y.f();
        bkVar.h = this.y.d();
        bkVar.y = this.y.g();
        bkVar.X = this.y.a();
        bkVar.Y = this.y.b();
        bkVar.z = this.y.e();
        a(bkVar, false, false);
    }

    public void a(final int i) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.2
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 9);
                bkVar.aa = i;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final long j) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.16
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 111);
                bkVar.S = j;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final long j, final long j2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.6
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 92);
                bkVar.S = j2;
                bkVar.V = j;
                bkVar.aj = s;
                ci.this.p = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(final long j, final String str, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.22
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 87);
                if (s > 0) {
                    bkVar.ai = s;
                }
                bkVar.R = j;
                bkVar.m = str;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final long j, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.5
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 103);
                bkVar.S = j;
                bkVar.at = (byte) 1;
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final long j, final boolean z, final String str, final String str2, final short s) {
        a(new Runnable() { // from class: chat.ola.vn.w.ci.19
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 85);
                bkVar.aj = s;
                bkVar.R = j;
                if (!chat.ola.vn.util.m.c(str) && !chat.ola.vn.util.m.c(str2)) {
                    bkVar.c = str + " " + str2;
                }
                bkVar.as = z ? (byte) 1 : (byte) 0;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final long j, final boolean z, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.33
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 169);
                bkVar.Q = j;
                bkVar.as = (byte) (!z ? 1 : 0);
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(chat.ola.vn.entity.c cVar) {
        this.y = cVar;
    }

    public void a(chat.ola.vn.p.g gVar) {
        this.v = gVar;
        if (this.u != null) {
            this.u.a(this.v);
            this.u.a(this);
        }
        if (this.t != null) {
            this.t.a(this.v);
        }
    }

    public void a(InputStream inputStream) {
        this.u = new dq(inputStream);
        this.u.a(this.v);
        this.u.a(this);
    }

    public void a(OutputStream outputStream) {
        this.t = new dr(outputStream);
        this.t.a(this.v);
        this.t.a(this);
    }

    public void a(final String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        b(new Runnable() { // from class: chat.ola.vn.w.ci.51
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 143);
                bkVar.z = str;
                bkVar.ac = (short) 1;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(String str, byte b, String str2, short s) {
        a((String) null, str, b, str2, s);
    }

    public void a(String str, int i, short s, short s2) {
        bk bkVar = new bk((short) 125);
        bkVar.p = str;
        bkVar.Z = i;
        bkVar.ad = s;
        bkVar.aj = s2;
        a(bkVar);
    }

    public void a(String str, long j, String str2, short s, String str3, byte b, short s2) {
        a(str, j, str2, (short) 2, s, str3, (String) null, b, s2);
    }

    public void a(final String str, final long j, final String str2, final short s, final short s2, final String str3, final String str4, final byte b, final short s3) {
        f(new Runnable() { // from class: chat.ola.vn.w.ci.15
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 106);
                bkVar.m = str;
                bkVar.S = j;
                bkVar.s = str2;
                bkVar.ak = s;
                bkVar.ai = s2;
                bkVar.c = str3;
                bkVar.as = b;
                if (str4 != null) {
                    bkVar.D = "{\"checkInId\":\"" + str4 + "\"}";
                }
                bkVar.aj = s3;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final String str, final long j, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.4
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 103);
                bkVar.p = str;
                bkVar.S = j;
                bkVar.aj = s;
                ci.this.p = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(final String str, final long j, final boolean z) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.59
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 204);
                bkVar.z = str;
                bkVar.W = j;
                ci.this.a(bkVar, false, z);
            }
        });
    }

    public void a(String str, chat.ola.vn.entity.c cVar, short s) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        try {
            if (!chat.ola.vn.util.m.a(this.g) && !chat.ola.vn.util.m.b(this.g, str)) {
                synchronized (this.G) {
                    this.G.clear();
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        this.g = str;
        this.l = this.m + ":" + str;
        this.y = cVar;
        this.f = str;
        bk bkVar = new bk((short) 97);
        bkVar.ac = (short) 2;
        bkVar.e = this.f;
        bkVar.g = cVar.c();
        bkVar.x = cVar.f();
        bkVar.h = cVar.d();
        bkVar.y = cVar.g();
        bkVar.X = cVar.a();
        bkVar.Y = cVar.b();
        bkVar.M = this.l;
        bkVar.B = cVar.e();
        bkVar.aj = s;
        a(bkVar, false, true);
    }

    public void a(String str, String str2) {
        a(str, new String[]{str2}, new String[]{null});
    }

    public void a(final String str, final String str2, final byte b, final String str3, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.31
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 23);
                bkVar.p = str;
                bkVar.z = str2;
                bkVar.l = str3;
                bkVar.as = b;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(String str, String str2, int i, long j, short s) {
        if (chat.ola.vn.util.m.a(str2)) {
            return;
        }
        bk bkVar = new bk((short) 166);
        bkVar.p = str;
        bkVar.A = str2;
        bkVar.Q = ((long) i) * 24 * 60 * 60 * 1000;
        if (j < 0) {
            j *= -1;
        }
        bkVar.U = j;
        bkVar.aj = s;
        a(bkVar);
    }

    public void a(String str, String str2, long j, short s) {
        byte[] bArrB = chat.ola.vn.j.a.b(this.w, str2);
        bk bkVar = new bk((short) 123);
        bkVar.p = str;
        bkVar.U = j;
        bkVar.am = bArrB;
        bkVar.aj = s;
        a(bkVar);
    }

    public void a(String str, String str2, Long l, Byte b, byte[] bArr) {
        bk bkVar = new bk((short) 12);
        if (!chat.ola.vn.util.m.a(str)) {
            bkVar.i = str;
        }
        if (!chat.ola.vn.util.m.a(str2)) {
            bkVar.j = str2;
        }
        if (l != null) {
            bkVar.O = l;
        }
        if (b != null) {
            bkVar.P = b;
        }
        if (bArr != null) {
            bkVar.ao = bArr;
        }
        a(bkVar);
    }

    public void a(final String str, final String str2, final String str3) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.10
            @Override // java.lang.Runnable
            public void run() {
                if (chat.ola.vn.util.m.a(str2)) {
                    return;
                }
                bk bkVar = new bk((short) 163);
                bkVar.w = str;
                bkVar.s = str2;
                bkVar.A = str3;
                if (str3 != null) {
                    bkVar.z = "id=" + str3 + ";chatgroupId=" + str;
                }
                ci.this.a(bkVar);
            }
        });
    }

    public void a(String str, String str2, String str3, String str4, String str5, Long l, byte b, short s) {
        this.f = chat.ola.vn.util.m.a(str, (short) 0);
        bk bkVar = new bk((short) 2);
        bkVar.e = str;
        bkVar.am = chat.ola.vn.j.a.b(this.w, str2);
        bkVar.f = str2;
        bkVar.z = str3;
        bkVar.i = str4;
        bkVar.d = str5;
        bkVar.O = l;
        bkVar.ar = b;
        bkVar.aj = s;
        a(bkVar, false, false);
    }

    public void a(String str, String str2, String str3, String str4, String str5, Long l, String str6, byte b, short s) {
        this.f = chat.ola.vn.util.m.a(str, (short) 0);
        bk bkVar = new bk((short) 2);
        bkVar.e = str;
        bkVar.am = chat.ola.vn.j.a.b(this.w, str2);
        bkVar.f = str2;
        bkVar.i = str3;
        bkVar.j = str4;
        bkVar.d = str5;
        bkVar.O = l;
        bkVar.k = str6;
        bkVar.ar = b;
        bkVar.aj = s;
        a(bkVar, false, false);
    }

    public void a(String str, String str2, String str3, String str4, short s) {
        bk bkVar = new bk((short) 75);
        bkVar.H = str;
        bkVar.I = str2;
        bkVar.J = str3;
        bkVar.k = str4;
        bkVar.aj = s;
        a(bkVar);
    }

    public void a(final String str, final String str2, final String str3, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.9
            @Override // java.lang.Runnable
            public void run() {
                if (chat.ola.vn.util.m.a(str2) && s == 0) {
                    return;
                }
                bk bkVar = new bk((short) 162);
                bkVar.w = str;
                bkVar.m = str2;
                bkVar.ai = s;
                if (str3 != null) {
                    bkVar.A = str3;
                    bkVar.z = "id=" + str3 + ";chatgroupId=" + str;
                }
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final String str, final String str2, final String str3, final short s, short s2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.64
            @Override // java.lang.Runnable
            public void run() {
                String str4 = str2;
                if (chat.ola.vn.util.m.b(str2, chat.ola.vn.f.c.b)) {
                    str4 = chat.ola.vn.f.c.a;
                }
                bk bkVar = new bk((short) 14);
                bkVar.n = str;
                bkVar.m = str4;
                bkVar.ai = s;
                if (str3 != null) {
                    bkVar.A = str3;
                    bkVar.z = "id=" + str3;
                }
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final String str, final String str2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.30
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 67);
                bkVar.p = str;
                bkVar.l = str2;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(String str, String str2, short s, String str3, String str4, byte b, short s2) {
        a(str, 0L, str2, (short) 0, s, str3, str4, b, s2);
    }

    public void a(final String str, final String str2, final short s, final String str3, final short s2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.56
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 142);
                bkVar.p = str;
                bkVar.ac = (short) 0;
                bkVar.m = str2;
                bkVar.ai = s;
                bkVar.s = str3;
                bkVar.aj = s2;
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void a(String str, String str2, short s, short s2) {
        a((byte) 0, str, str2, s, s2);
    }

    public void a(String str, String str2, String[] strArr, short s) {
        if (chat.ola.vn.util.m.a(str2)) {
            return;
        }
        String string = null;
        if (strArr != null && strArr.length > 0) {
            StringBuffer stringBuffer = new StringBuffer(strArr[0]);
            for (int i = 1; i < strArr.length; i++) {
                stringBuffer.append(";" + strArr[i]);
            }
            string = stringBuffer.toString();
        }
        bk bkVar = new bk((short) 158);
        bkVar.p = string;
        bkVar.i = str2;
        bkVar.A = str;
        bkVar.aj = s;
        a(bkVar);
    }

    public void a(String str, short s) {
        a(str, (short) 0, s);
    }

    public void a(String str, short s, String str2) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 13;
        bkVar.N = str;
        bkVar.av = (byte) s;
        bkVar.A = str2;
        a(bkVar, true, true);
    }

    public void a(final String str, final short s, final String str2, final short s2) {
        if (s == 2 || s == 0) {
            b(new Runnable() { // from class: chat.ola.vn.w.ci.65
                @Override // java.lang.Runnable
                public void run() {
                    bk bkVar = new bk((short) 207);
                    bkVar.N = str;
                    bkVar.av = (byte) s;
                    bkVar.A = str2;
                    bkVar.ac = s2;
                    ci.this.a(bkVar);
                }
            });
        }
    }

    public void a(final String str, final short s, final boolean z) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.60
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 209);
                bkVar.au = (byte) 2;
                bkVar.N = str;
                bkVar.av = (byte) s;
                if (z) {
                    bkVar.as = (byte) 1;
                }
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void a(String str, short s, int[] iArr, int[] iArr2) {
        bk bkVar = new bk((short) 109);
        bkVar.p = str;
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byteArrayOutputStream.write(s);
        if (iArr != null) {
            byteArrayOutputStream.write(8);
            byte[] bArrA = chat.ola.vn.util.e.a((short) iArr[0]);
            byteArrayOutputStream.write(bArrA, 0, bArrA.length);
            byte[] bArrA2 = chat.ola.vn.util.e.a((short) iArr[1]);
            byteArrayOutputStream.write(bArrA2, 0, bArrA2.length);
        } else {
            byteArrayOutputStream.write(9);
        }
        byte[] bArrA3 = chat.ola.vn.util.e.a((short) iArr2[0]);
        byteArrayOutputStream.write(bArrA3, 0, bArrA3.length);
        byte[] bArrA4 = chat.ola.vn.util.e.a((short) iArr2[1]);
        byteArrayOutputStream.write(bArrA4, 0, bArrA4.length);
        bkVar.ap = byteArrayOutputStream.toByteArray();
        a(bkVar, true, true);
    }

    public void a(final String str, final byte[] bArr, final short s) {
        try {
            if (chat.ola.vn.util.m.c(str) || bArr == null || bArr.length == 0) {
                return;
            }
            b(new Runnable() { // from class: chat.ola.vn.w.ci.38
                @Override // java.lang.Runnable
                public void run() {
                    bk bkVar = new bk((short) 109);
                    byte[] bArr2 = new byte[bArr.length + 4];
                    bArr2[0] = 7;
                    bArr2[1] = 0;
                    byte[] bArrA = chat.ola.vn.util.e.a(s);
                    bArr2[2] = bArrA[0];
                    bArr2[3] = bArrA[1];
                    System.arraycopy(bArr, 0, bArr2, 4, bArr.length);
                    bkVar.p = str;
                    bkVar.ap = bArr2;
                    ci.this.a(bkVar, false, true);
                }
            });
        } catch (Throwable unused) {
        }
    }

    public void a(String str, chat.ola.vn.entity.aa[] aaVarArr, short s) {
        a((byte) 1, str, aaVarArr, s);
    }

    public void a(String str, String[] strArr) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        StringBuffer stringBuffer = new StringBuffer(strArr[0]);
        for (int i = 1; i < strArr.length; i++) {
            stringBuffer.append(";" + strArr[i]);
        }
        bk bkVar = new bk((short) 159);
        bkVar.p = stringBuffer.toString();
        bkVar.w = str;
        a(bkVar);
    }

    public void a(String str, String[] strArr, short s) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        a((byte) 0, (byte) 0, (String) null, strArr, str, (String) null, s);
    }

    public void a(final String str, final String[] strArr, final String[] strArr2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.12
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 15);
                bkVar.E = strArr;
                bkVar.F = strArr2;
                bkVar.o = str;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(String str, String[] strArr, String[] strArr2, short s) {
        b((byte) 2, str, strArr, strArr2, s);
    }

    public void a(final List<chat.ola.vn.message.f> list, final boolean z) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.63
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 209);
                bkVar.b = list;
                bkVar.au = (byte) 7;
                if (z) {
                    bkVar.as = (byte) 1;
                }
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void a(final short s) {
        a(new Runnable() { // from class: chat.ola.vn.w.ci.18
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 81);
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    public void a(final short s, final String str, final String str2, final short s2) {
        c(new Runnable() { // from class: chat.ola.vn.w.ci.34
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 194);
                bkVar.as = (byte) s;
                bkVar.z = str;
                bkVar.A = str2;
                bkVar.aj = s2;
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void a(short s, short s2) {
        bk bkVar = new bk((short) 148);
        bkVar.ac = s;
        bkVar.aj = s2;
        a(bkVar);
    }

    public void a(boolean z) {
        if (this.y == null) {
            throw new RuntimeException("No device for connection");
        }
        if (this.u == null || this.t == null || this.v == null) {
            throw new RuntimeException("No Input Stream, Output Stream or Listener");
        }
        this.q = 0L;
        this.s = 3;
        this.z = false;
        a();
    }

    void a(byte[] bArr) {
        this.w = bArr;
        try {
            this.v.e();
        } catch (Throwable unused) {
        }
    }

    public void a(final String[] strArr) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        b(new Runnable() { // from class: chat.ola.vn.w.ci.40
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 170);
                String str = strArr[0];
                for (int i = 1; i < strArr.length; i++) {
                    str = str + ";" + strArr[i];
                }
                bkVar.z = str;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void a(String[] strArr, String[] strArr2) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        if (strArr2 != null && strArr.length != strArr2.length) {
            throw new RuntimeException("Buddy Id array is not the same length with alias array");
        }
        bk bkVar = new bk((short) 54);
        bkVar.E = strArr;
        bkVar.F = strArr2;
        a(bkVar);
    }

    public void a(String[] strArr, String[] strArr2, short s) {
        a((byte) 0, (String) null, strArr, strArr2, s);
    }

    public boolean a(String str, String str2, String str3, String str4, chat.ola.vn.entity.c cVar, short s) {
        if (this.t == null || this.u == null || this.w == null || chat.ola.vn.util.m.a(str) || chat.ola.vn.util.m.c(str2)) {
            return false;
        }
        this.f = str;
        bk bkVar = new bk((short) 206);
        bkVar.e = str;
        bkVar.am = chat.ola.vn.j.a.b(this.w, str2);
        bkVar.k = str3;
        bkVar.B = cVar.e();
        bkVar.C = str4;
        bkVar.g = cVar.c();
        bkVar.x = cVar.f();
        bkVar.h = cVar.d();
        bkVar.y = cVar.g();
        bkVar.aj = s;
        bkVar.z = str2;
        a(bkVar, false, false);
        return true;
    }

    void b() {
        chat.ola.vn.h.a(new Runnable() { // from class: chat.ola.vn.w.ci.1
            @Override // java.lang.Runnable
            public void run() {
                synchronized (ci.this.G) {
                    while (!ci.this.G.isEmpty()) {
                        ci.this.a((bk) ci.this.G.remove(0));
                    }
                }
            }
        });
    }

    public void b(final int i) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.11
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 164);
                bkVar.aa = i;
                ci.this.a(bkVar);
            }
        });
    }

    public void b(long j) {
        bk bkVar = new bk((short) 86);
        bkVar.R = j;
        a(bkVar);
    }

    public void b(long j, String str, short s) {
        a((short) 0, j + "", str, s);
    }

    public void b(long j, short s) {
        b((byte) 0, (String) null, j, s);
    }

    public void b(final String str) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        b(new Runnable() { // from class: chat.ola.vn.w.ci.61
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 143);
                bkVar.z = str;
                bkVar.ac = (short) 0;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void b(String str, long j, String str2, short s, String str3, byte b, short s2) {
        a(str, j, str2, (short) 1, s, str3, (String) null, b, s2);
    }

    public void b(String str, String str2) {
        bk bkVar = new bk((short) 65);
        bkVar.p = str2;
        bkVar.u = str;
        a(bkVar);
    }

    public void b(final String str, final String str2, final String str3) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.13
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 39);
                bkVar.n = str;
                bkVar.s = str2;
                bkVar.A = str3;
                if (str3 != null) {
                    bkVar.z = "id=" + str3;
                }
                ci.this.a(bkVar);
            }
        });
    }

    public void b(String str, String str2, String str3, String str4, short s) {
        bk bkVar = new bk((short) 196);
        bkVar.as = (byte) 1;
        bkVar.z = str;
        bkVar.A = str2;
        bkVar.B = str3;
        bkVar.C = str4;
        bkVar.aj = s;
        a(bkVar);
    }

    public void b(final String str, final String str2, final String str3, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.48
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 201);
                bkVar.w = str;
                bkVar.r = str2;
                bkVar.s = str3;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void b(String str, String str2, short s) {
        a((short) 1, str, str2, s);
    }

    public void b(String str, String str2, short s, short s2) {
        a((byte) 1, str, str2, s, s2);
    }

    public void b(String str, short s) {
        a(str, (short) 1, s);
    }

    public void b(String str, short s, String str2) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 12;
        bkVar.N = str;
        bkVar.av = (byte) s;
        bkVar.A = str2;
        a(bkVar, true, true);
    }

    public void b(String str, short s, String str2, short s2) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        a((byte) 2, str, s, str2, s2);
    }

    public void b(final String str, final byte[] bArr, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.39
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 110);
                byte[] bArr2 = new byte[bArr.length + 4];
                bArr2[0] = 7;
                bArr2[1] = 0;
                byte[] bArrA = chat.ola.vn.util.e.a(s);
                bArr2[2] = bArrA[0];
                bArr2[3] = bArrA[1];
                System.arraycopy(bArr, 0, bArr2, 4, bArr.length);
                bkVar.w = str;
                bkVar.ap = bArr2;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void b(String str, chat.ola.vn.entity.aa[] aaVarArr, short s) {
        a((byte) 0, str, aaVarArr, s);
    }

    public void b(final String str, final String[] strArr, final short s) {
        d(new Runnable() { // from class: chat.ola.vn.w.ci.54
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 82);
                bkVar.z = str;
                bkVar.E = strArr;
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    public void b(short s) {
        a(0L, true, (String) null, (String) null, s);
    }

    public void b(boolean z) {
        try {
            synchronized (this.G) {
                Log.e("tabConversation", " clear ");
                this.G.clear();
            }
        } catch (Throwable unused) {
        }
        bk bkVar = new bk((short) 5);
        if (z) {
            bkVar.as = (byte) 0;
        } else {
            bkVar.as = (byte) 1;
        }
        a(bkVar, true, true);
    }

    public void b(String[] strArr) {
        a(strArr, (short) 0);
    }

    public void b(String[] strArr, String[] strArr2, short s) {
        b((byte) 0, (String) null, strArr, strArr2, s);
    }

    public void c() {
        long jCurrentTimeMillis = System.currentTimeMillis();
        if (jCurrentTimeMillis - this.q >= 45000) {
            if (this.s == 0) {
                this.z = false;
                this.v.a();
                return;
            } else {
                this.s--;
                if (this.s < 0) {
                    this.s = 0;
                }
                a(new bk((short) 42), false, false);
                this.q = jCurrentTimeMillis;
            }
        }
        if (jCurrentTimeMillis - this.r >= 300000) {
            d();
        }
    }

    public void c(final long j) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.20
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 61);
                bkVar.R = j;
                ci.this.a(bkVar);
            }
        });
    }

    public void c(long j, short s) {
        b((byte) 1, (String) null, j, s);
    }

    public void c(final String str) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.8
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 44);
                bkVar.p = str;
                ci.this.a(bkVar);
            }
        });
    }

    public void c(String str, String str2) {
        a(new String[]{str}, new String[]{str2});
    }

    public void c(final String str, final String str2, final String str3) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.36
            @Override // java.lang.Runnable
            public void run() {
                try {
                    bk bkVar = new bk((short) 109);
                    byte[] bArrD = chat.ola.vn.util.m.d(str2 + "x" + str3);
                    byte[] bArr = new byte[bArrD.length + 1];
                    bArr[0] = 4;
                    System.arraycopy(bArrD, 0, bArr, 1, bArrD.length);
                    bkVar.p = str;
                    bkVar.ap = bArr;
                    ci.this.a(bkVar, false, true);
                } catch (Throwable unused) {
                }
            }
        });
    }

    public void c(String str, String str2, short s) {
        a((short) 2, str, str2, s);
    }

    public void c(String str, short s) {
        bk bkVar = new bk((short) 165);
        bkVar.w = str;
        bkVar.aj = s;
        a(bkVar);
    }

    public void c(String str, short s, String str2) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 15;
        bkVar.N = str;
        bkVar.av = (byte) s;
        bkVar.A = str2;
        a(bkVar, true, true);
    }

    public void c(short s) {
        c(null, (short) 3, null, s);
    }

    public void c(boolean z) {
        this.z = z;
    }

    public void c(String[] strArr) {
        a(strArr, (short) 1);
    }

    public void d() {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.23
            @Override // java.lang.Runnable
            public void run() {
                ci.this.r = System.currentTimeMillis();
                ci.this.a(new bk((short) 168), false, true);
            }
        });
    }

    public void d(final long j) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.21
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 62);
                bkVar.R = j;
                ci.this.a(bkVar);
            }
        });
    }

    public void d(String str) {
        bk bkVar = new bk((short) 161);
        bkVar.w = str;
        a(bkVar);
    }

    public void d(final String str, final String str2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.35
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 16);
                bkVar.p = chat.ola.vn.util.m.j(str);
                bkVar.o = str2;
                ci.this.a(bkVar);
            }
        });
    }

    public void d(final String str, final String str2, final String str3) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.37
            @Override // java.lang.Runnable
            public void run() {
                try {
                    bk bkVar = new bk((short) 110);
                    byte[] bArrD = chat.ola.vn.util.m.d(str2 + "x" + str3);
                    byte[] bArr = new byte[bArrD.length + 1];
                    bArr[0] = 4;
                    System.arraycopy(bArrD, 0, bArr, 1, bArrD.length);
                    bkVar.w = str;
                    bkVar.ap = bArr;
                    ci.this.a(bkVar, false, true);
                } catch (Throwable unused) {
                }
            }
        });
    }

    public void d(String str, String str2, short s) {
        a((short) 3, str, str2, s);
    }

    public void d(final String str, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.26
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 50);
                bkVar.p = str;
                bkVar.aj = s;
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void d(String str, short s, String str2) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 16;
        bkVar.N = str;
        bkVar.av = (byte) s;
        bkVar.A = str2;
        a(bkVar, true, true);
    }

    public void d(short s) {
        c(null, (short) 2, null, s);
    }

    public void d(final boolean z) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.62
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 209);
                bkVar.au = (byte) 6;
                if (z) {
                    bkVar.as = (byte) 1;
                }
                ci.this.a(bkVar, true, true);
            }
        });
    }

    public void d(String[] strArr) {
        a(strArr, (short) 2);
    }

    void e() {
        this.s = 3;
    }

    public void e(String str) {
        a((byte) 1, str, 0L, (short) 1);
    }

    void e(String str, String str2) {
        a(str, (short) 0, str2, (short) 2);
    }

    public void e(String str, String str2, short s) {
        a((short) 12, str, str2, s);
    }

    public void e(String str, short s) {
        a((byte) 1, str, (String[]) null, (String[]) null, s);
    }

    public void e(short s) {
        c(null, (short) 4, null, s);
    }

    public void f() {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.3
            @Override // java.lang.Runnable
            public void run() {
                ci.this.a(new bk((short) 140));
            }
        });
    }

    public void f(String str) {
        a((byte) 1, str, 0L, (short) 0);
    }

    void f(String str, String str2) {
        a(str, (short) 2, str2, (short) 2);
    }

    public void f(final String str, final String str2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.41
            @Override // java.lang.Runnable
            public void run() {
                String str3;
                if (chat.ola.vn.util.m.a(str) || chat.ola.vn.util.m.a(str2)) {
                    str3 = null;
                } else {
                    str3 = str + " " + str2;
                }
                if (ci.this.y != null) {
                    ci.this.y.h = str;
                    ci.this.y.i = str2;
                }
                bk bkVar = new bk((short) 196);
                bkVar.as = (byte) 0;
                bkVar.c = str3;
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    public void f(String str, short s) {
        c(str, (short) 5, null, s);
    }

    public void f(short s) {
        bk bkVar = new bk((short) 124);
        bkVar.aj = s;
        a(bkVar);
    }

    public void g() {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.7
            @Override // java.lang.Runnable
            public void run() {
                ci.this.a(new bk((short) 138));
            }
        });
    }

    public void g(final String str) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.24
            @Override // java.lang.Runnable
            public void run() {
                ci.this.i = str;
                bk bkVar = new bk((short) 21);
                bkVar.ac = (short) 2;
                bkVar.r = str;
                ci.this.a(bkVar);
            }
        });
    }

    public void g(final String str, final String str2) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.42
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 197);
                bkVar.K = str2;
                bkVar.A = str;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void g(final String str, final String str2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.47
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 25);
                bkVar.am = chat.ola.vn.j.a.b(ci.this.w, str);
                bkVar.an = chat.ola.vn.j.a.b(ci.this.w, str2);
                bkVar.aj = s;
                bkVar.z = str2;
                ci.this.a(bkVar);
            }
        });
    }

    public void g(String str, short s) {
        c(str, (short) 6, null, s);
    }

    public void g(final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.32
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 8);
                bkVar.aj = s;
                ci.this.a(bkVar);
            }
        });
    }

    public void h() {
        try {
            c(false);
            this.q = 0L;
            this.w = null;
            this.x = 0L;
            this.e = 0L;
            this.h = null;
            this.i = null;
            this.j = null;
            this.k = null;
            this.n = 0;
            this.o = (short) 0;
            this.y = null;
            this.q = 0L;
            this.r = 0L;
            this.s = 3;
            this.A = 0L;
            this.B = 0L;
            this.C = 0L;
            this.D = 0L;
            this.E = 0L;
            this.F = 0L;
        } catch (Throwable unused) {
        }
        if (this.u != null) {
            this.u.a();
            this.u = null;
        }
        if (this.t != null) {
            this.t.a();
            this.t = null;
        }
    }

    public void h(String str) {
        b(str, (String) null);
    }

    public void h(String str, String str2) {
        bk bkVar = new bk((short) 122);
        bkVar.ah = (short) 4;
        bkVar.z = str;
        bkVar.A = str2;
        a(bkVar);
    }

    public void h(String str, String str2, short s) {
        bk bkVar = new bk((short) 200);
        bkVar.w = str;
        bkVar.i = str2;
        bkVar.aj = s;
        a(bkVar);
    }

    public void h(String str, short s) {
        c(str, (short) 1, null, s);
    }

    public void h(short s) {
        a((short) 11, (String) null, (String) null, s);
    }

    public String i() {
        return this.f;
    }

    public void i(String str) {
        a(str, (String) null, true);
    }

    public void i(String str, String str2, short s) {
        a((byte) 0, (String) null, str, str2, s);
    }

    public void i(String str, short s) {
        c(str, (short) 0, null, s);
        if (this.v != null) {
            this.v.a(str, (short) 0, s);
        }
    }

    public void i(short s) {
        a((short) 13, (String) null, (String) null, s);
    }

    public void j(String str) {
        a((String) null, str, true);
    }

    public void j(final String str, final String str2, final short s) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.57
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 116);
                bkVar.u = chat.ola.vn.util.m.l(str);
                bkVar.D = str2;
                bkVar.aj = s;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void j(String str, short s) {
        bk bkVar = new bk((short) 147);
        bkVar.p = str;
        bkVar.aj = s;
        a(bkVar);
    }

    public void j(short s) {
        bk bkVar = new bk((short) 1);
        bkVar.aj = s;
        a(bkVar, false, false);
    }

    public boolean j() {
        return (!this.z || this.u == null || this.t == null) ? false : true;
    }

    public String k() {
        return this.i;
    }

    public void k(String str) {
        bk bkVar = new bk((short) 150);
        bkVar.A = str;
        a(bkVar);
    }

    public void k(String str, short s) {
        a(str, (byte) 1, s);
    }

    public void l() {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.25
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 139);
                bkVar.x = ci.this.y.f();
                bkVar.h = ci.this.y.d();
                bkVar.y = ci.this.y.g();
                bkVar.X = ci.this.y.a();
                bkVar.Y = ci.this.y.b();
                bkVar.z = ci.this.y.e();
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void l(String str) {
        bk bkVar = new bk((short) 195);
        bkVar.k = str;
        a(bkVar, false, false);
    }

    public void l(String str, short s) {
        a(str, (byte) 0, s);
    }

    public short m() {
        if (this.o < 0) {
            return (short) 0;
        }
        return this.o;
    }

    public void m(String str) {
        a((byte) 0, str);
    }

    public void m(String str, short s) {
        a((String) null, str, s);
    }

    public String n() {
        return this.h;
    }

    public void n(String str) {
        a((byte) 1, str);
    }

    public void n(String str, short s) {
        a((short) 5, (String) null, str, s);
    }

    public void o() {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.46
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 55);
                bkVar.p = null;
                bkVar.ae = (short) -1;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void o(final String str) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.44
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 55);
                bkVar.p = chat.ola.vn.util.m.j(str);
                bkVar.ae = (short) 15;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void o(String str, short s) {
        a((short) 8, str, (String) null, s);
    }

    public dq p() {
        return this.u;
    }

    public void p(final String str) {
        b(new Runnable() { // from class: chat.ola.vn.w.ci.45
            @Override // java.lang.Runnable
            public void run() {
                bk bkVar = new bk((short) 55);
                bkVar.p = chat.ola.vn.util.m.j(str);
                bkVar.ae = (short) 0;
                ci.this.a(bkVar, false, true);
            }
        });
    }

    public void p(String str, short s) {
        bk bkVar = new bk((short) 202);
        bkVar.s = str;
        bkVar.aj = s;
        a(bkVar);
    }

    public void q() {
        a((byte) 1);
    }

    public void q(String str) {
        a(str, true);
    }

    public void q(String str, short s) {
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        a((byte) 1, (byte) 0, (String) null, (String[]) null, str, (String) null, s);
    }

    public void r() {
        a(0, (byte) 1);
    }

    public void r(String str) {
        a(str, false);
    }

    public void r(String str, short s) {
        bk bkVar = new bk((short) 107);
        bkVar.p = str;
        bkVar.aj = s;
        a(bkVar);
    }

    public void s(String str) {
        bk bkVar = new bk((short) 122);
        bkVar.ah = (short) 0;
        bkVar.p = str;
        a(bkVar);
    }

    public void s(String str, short s) {
        bk bkVar = new bk((short) 109);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bkVar.p = str;
        byteArrayOutputStream.write(s);
        byteArrayOutputStream.write(4);
        bkVar.ap = byteArrayOutputStream.toByteArray();
        a(bkVar, true, true);
    }

    public void t(String str) {
        bk bkVar = new bk((short) 122);
        bkVar.ah = (short) 1;
        bkVar.s = str;
        a(bkVar);
    }

    public void t(String str, short s) {
        bk bkVar = new bk((short) 109);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bkVar.p = str;
        byteArrayOutputStream.write(s);
        byteArrayOutputStream.write(5);
        bkVar.ap = byteArrayOutputStream.toByteArray();
        a(bkVar, true, true);
    }

    public void u(String str) {
        bk bkVar = new bk((short) 122);
        bkVar.ah = (short) 5;
        bkVar.z = str;
        a(bkVar);
    }

    public void u(String str, short s) {
        bk bkVar = new bk((short) 109);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bkVar.p = str;
        byteArrayOutputStream.write(s);
        byteArrayOutputStream.write(6);
        bkVar.ap = byteArrayOutputStream.toByteArray();
        a(bkVar, true, true);
    }

    public void v(String str, short s) {
        bk bkVar = new bk((short) 109);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        bkVar.p = str;
        byteArrayOutputStream.write(s);
        byteArrayOutputStream.write(7);
        bkVar.ap = byteArrayOutputStream.toByteArray();
        a(bkVar, true, true);
    }

    public void w(String str, short s) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 1;
        bkVar.A = str;
        bkVar.aj = s;
        a(bkVar, true, true);
    }

    public void x(String str, short s) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 4;
        bkVar.N = str;
        bkVar.av = (byte) s;
        a(bkVar, true, true);
    }

    public void y(String str, short s) {
        bk bkVar = new bk((short) 209);
        bkVar.au = (byte) 3;
        bkVar.N = str;
        bkVar.av = (byte) s;
        a(bkVar, true, true);
    }
}
