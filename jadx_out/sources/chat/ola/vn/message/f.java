package chat.ola.vn.message;

import android.annotation.SuppressLint;
import android.net.Uri;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class f {
    g A;
    public boolean B;
    public long M;
    String U;
    protected List<d> W;
    private long a;
    protected List<f> c;
    protected String d;
    protected String e;
    protected String f;
    protected String g;
    protected String h;
    protected String i;
    protected String j;
    protected String k;
    protected String l;
    protected String m;
    protected short w;
    protected short x;
    public String n = null;
    protected long o = 0;
    public long p = 0;
    public Long q = null;
    public long r = 0;
    public long s = 0;
    public long t = 0;
    private int b = 0;
    protected short u = 0;
    protected short v = -1;
    protected byte y = -1;
    protected byte z = 0;
    private Boolean Z = null;
    private Boolean aa = null;
    private Long ab = null;
    private boolean ac = false;
    private CharSequence ad = null;
    private CharSequence ae = null;
    public List<String> C = null;
    public int D = -1;
    public int E = 0;
    public Boolean F = null;
    private byte af = 5;
    public boolean G = false;
    private boolean ag = false;
    public long H = System.currentTimeMillis();
    private chat.ola.vn.game.caro.b ah = null;
    private boolean ai = false;
    protected boolean I = false;
    public Long J = null;
    public Long K = null;
    public long L = 0;
    public long N = 0;
    private Map<String, d> aj = null;
    public String O = null;
    protected String P = null;
    public boolean Q = true;
    public String R = null;
    public d S = null;
    public d T = null;
    public byte V = 0;
    int X = -1;
    int Y = -1;

    public f(String str, short s) {
        this.x = (short) 0;
        this.B = true;
        this.M = 0L;
        this.U = null;
        this.d = chat.ola.vn.util.m.a(str, s);
        this.x = s;
        this.U = b(this.d, s);
        this.M = 0L;
        if (this.x == 1) {
            this.B = false;
        }
    }

    private void Y() {
        if (this.b == 0) {
            chat.ola.vn.util.c.b.a(OlaApplication.a(), U());
        }
    }

    private CharSequence Z() {
        return p("");
    }

    private void a(d dVar, d dVar2) {
        try {
            if (H() && this.G && dVar.d() == 1) {
                if (dVar2 == null || dVar2.d() != 1 || System.currentTimeMillis() - dVar2.m() >= 43200000) {
                    a((Boolean) true);
                    if (OlaApplication.c != null) {
                        OlaApplication.c.a(this, dVar, OlaApplication.e());
                    }
                }
            }
        } catch (Throwable unused) {
        }
    }

    private CharSequence aa() {
        String strE = e();
        if (chat.ola.vn.util.m.c(strE)) {
            return null;
        }
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(strE);
        if (spannableStringBuilder.length() > 0) {
            spannableStringBuilder.setSpan(new ForegroundColorSpan(chat.ola.vn.f.D), 0, spannableStringBuilder.length(), 18);
        }
        return spannableStringBuilder;
    }

    public static String b(String str, short s) {
        StringBuilder sb;
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        if (s != 1) {
            if (s == 2) {
                sb = new StringBuilder();
            }
            sb.append(str);
            sb.append("#");
            sb.append((int) s);
            return sb.toString();
        }
        s = 0;
        sb = new StringBuilder();
        str = str.toLowerCase(Locale.US);
        sb.append(str);
        sb.append("#");
        sb.append((int) s);
        return sb.toString();
    }

    public static int c(String str, short s) {
        try {
            return b(str, s).hashCode();
        } catch (Throwable unused) {
            return 100;
        }
    }

    private boolean d(long j) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(j);
        int i = calendar.get(5);
        int i2 = calendar.get(2);
        calendar.setTimeInMillis(System.currentTimeMillis());
        int i3 = calendar.get(5);
        int i4 = calendar.get(2);
        if (i2 == i4) {
            return i3 > i;
        }
        if (i2 < i4) {
            return (i2 == 0 && i4 == 11) ? false : true;
        }
        return false;
    }

    private CharSequence p(String str) {
        String strE;
        if (chat.ola.vn.util.m.c(e())) {
            strE = str;
        } else if (chat.ola.vn.util.m.a(str)) {
            str = "";
            strE = e();
        } else {
            strE = str + " · " + e();
        }
        if (chat.ola.vn.util.m.c(strE)) {
            return null;
        }
        SpannableStringBuilder spannableStringBuilder = new SpannableStringBuilder(strE);
        if (spannableStringBuilder.length() > 0) {
            if (!chat.ola.vn.util.m.c(str)) {
                SpannableStringBuilder spannableStringBuilder2 = spannableStringBuilder;
                spannableStringBuilder2.setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, str.length(), 18);
                spannableStringBuilder2.setSpan(new ForegroundColorSpan(chat.ola.vn.f.z), str.length(), spannableStringBuilder.length(), 18);
                return spannableStringBuilder;
            }
            spannableStringBuilder.setSpan(new ForegroundColorSpan(chat.ola.vn.f.z), 0, spannableStringBuilder.length(), 18);
        }
        return spannableStringBuilder;
    }

    public void A() {
        this.af = (byte) 5;
    }

    public void B() {
        if (this.c != null) {
            this.c.clear();
            this.c = null;
        }
        this.a = 0L;
    }

    public void C() {
        B();
        if (this.W != null) {
            this.W.clear();
            this.W = null;
        }
        if (this.aj != null) {
            this.aj.clear();
            this.aj = null;
        }
        this.S = null;
        this.F = null;
        this.T = null;
        this.b = 0;
        Y();
        this.V = (byte) 0;
        this.n = null;
        this.s = 0L;
        if (this.A != null) {
            this.A.a(this, this.W);
        }
    }

    public void D() {
        if (this.W != null) {
            this.W.clear();
            this.W = null;
        }
        if (this.aj != null) {
            this.aj.clear();
            this.aj = null;
        }
        this.S = null;
        this.F = null;
        this.b = 0;
        Y();
        this.T = null;
        this.V = (byte) 0;
        this.n = null;
        this.s = 0L;
        this.P = null;
        this.O = null;
        if (this.A != null) {
            this.A.a(this, this.W);
        }
    }

    public void E() {
        try {
            this.A.u();
        } catch (Throwable unused) {
        }
    }

    public List<f> F() {
        return a(false);
    }

    public List<String> G() {
        ArrayList arrayList = null;
        if (this.W != null) {
            for (d dVar : this.W) {
                if (dVar.x()) {
                    try {
                        List<chat.ola.vn.entity.ab> listA = ((p) dVar).a();
                        if (listA != null && listA.size() > 0) {
                            for (chat.ola.vn.entity.ab abVar : listA) {
                                if (abVar.b == 0 && chat.ola.vn.entity.i.i(abVar.c) == 1) {
                                    if (arrayList == null) {
                                        arrayList = new ArrayList();
                                    }
                                    arrayList.add(abVar.c);
                                }
                            }
                        }
                    } catch (Throwable unused) {
                    }
                }
            }
        }
        return arrayList;
    }

    public boolean H() {
        if (W()) {
            return this.Z == null ? chat.ola.vn.c.x.k == 0 : this.Z.booleanValue();
        }
        return false;
    }

    public boolean I() {
        return this.ac;
    }

    public void J() {
        CharSequence charSequenceP;
        try {
            if (chat.ola.vn.util.m.a(this.g)) {
                this.C = null;
            } else {
                this.C = chat.ola.vn.util.i.b((CharSequence) this.g);
            }
            if (this.C == null || this.C.size() <= 0) {
                this.R = null;
            } else {
                this.R = this.C.get(0);
            }
            short s = this.x;
            if (s == 4) {
                this.ae = aa();
                this.ad = new SpannableStringBuilder(b());
                ((SpannableStringBuilder) this.ad).setSpan(new ForegroundColorSpan(chat.ola.vn.f.C), 0, this.ad.length(), 33);
                return;
            }
            switch (s) {
                case 0:
                    String str = "";
                    if (f() != 0) {
                        Calendar calendar = Calendar.getInstance();
                        calendar.setTimeInMillis(f());
                        str = "(" + calendar.get(5) + "/" + (calendar.get(2) + 1) + ") ";
                    }
                    if (!chat.ola.vn.util.m.a(q())) {
                        str = str + q();
                    }
                    charSequenceP = p(str);
                    String strJ = j() + " · " + b();
                    try {
                        if (chat.ola.vn.util.m.b(j(), b().trim())) {
                            strJ = j();
                        }
                    } catch (Throwable unused) {
                    }
                    this.ad = new SpannableStringBuilder(strJ);
                    ((SpannableStringBuilder) this.ad).setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, j().length(), 33);
                    if (strJ.length() > j().length()) {
                        ((SpannableStringBuilder) this.ad).setSpan(new ForegroundColorSpan(chat.ola.vn.f.z), j().length(), strJ.length(), 33);
                    }
                    break;
                case 1:
                    charSequenceP = p("");
                    this.ad = new SpannableStringBuilder(b());
                    ((SpannableStringBuilder) this.ad).setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, j().length(), 33);
                    break;
                case 2:
                    charSequenceP = Z();
                    this.ad = new SpannableStringBuilder(b());
                    ((SpannableStringBuilder) this.ad).setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, this.ad.length(), 33);
                    break;
                default:
                    return;
            }
            this.ae = charSequenceP;
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public int K() {
        try {
            return this.W.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public CharSequence L() {
        if (this.ad == null) {
            J();
        }
        return this.ad;
    }

    public CharSequence M() {
        if (this.ae == null) {
            J();
        }
        return this.ae;
    }

    public boolean N() {
        if (chat.ola.vn.c.x.e()) {
            return this.J == null || System.currentTimeMillis() >= this.J.longValue();
        }
        return false;
    }

    public Uri O() {
        return chat.ola.vn.c.x.d();
    }

    public boolean P() {
        if (!chat.ola.vn.c.x.f()) {
            return false;
        }
        if (this.aa == null) {
            return true;
        }
        return this.aa.booleanValue();
    }

    public chat.ola.vn.game.caro.b Q() {
        return this.ah;
    }

    public void R() {
        if (this.ah != null) {
            this.ah.h();
        }
        this.ah = null;
    }

    public boolean S() {
        return this.ai;
    }

    public String T() {
        return this.P;
    }

    public int U() {
        try {
            return y().hashCode();
        } catch (Throwable unused) {
            return 100;
        }
    }

    public boolean V() {
        return this.ag;
    }

    public boolean W() {
        return true;
    }

    public boolean X() {
        try {
            return this.d.startsWith(".chatgroup.");
        } catch (Throwable unused) {
            return false;
        }
    }

    public long a() {
        try {
            return this.S.m();
        } catch (Throwable unused) {
            return this.M;
        }
    }

    public List<f> a(boolean z) {
        if (!z || System.currentTimeMillis() - this.a < 900000) {
            return this.c;
        }
        return null;
    }

    public void a(byte b) {
        this.ae = null;
        this.y = b;
    }

    public void a(int i) {
        if (this.b != i) {
            this.b = i;
            if (this.b < 0) {
                this.b = 0;
            }
            if (this.b > 0) {
                this.B = false;
            }
            if (this.A != null) {
                this.A.i(this);
            }
            try {
                OlaApplication.c.a(this.d, this.x, i);
            } catch (Throwable unused) {
            }
            Y();
        }
    }

    public void a(long j) {
        this.o = j;
    }

    public void a(d dVar) {
        a(dVar, false);
    }

    void a(d dVar, byte b, byte b2) {
        if (this.b > 0 && b2 == 3) {
            this.b--;
            if (this.b < 0) {
                this.b = 0;
            }
            Y();
        }
        if (this.A != null) {
            this.A.a(dVar, b, b2);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:40:0x00a8 A[Catch: Throwable -> 0x010a, TryCatch #0 {Throwable -> 0x010a, blocks: (B:4:0x0003, B:6:0x0007, B:7:0x000e, B:9:0x0012, B:10:0x0019, B:12:0x0032, B:13:0x0034, B:15:0x0038, B:16:0x003a, B:18:0x0042, B:20:0x0048, B:22:0x004c, B:24:0x0050, B:25:0x0063, B:33:0x0085, B:35:0x008d, B:37:0x0099, B:39:0x00a2, B:47:0x00c9, B:48:0x00cd, B:50:0x00d3, B:51:0x00d8, B:53:0x00e1, B:55:0x00e8, B:57:0x00f2, B:58:0x00f4, B:60:0x0101, B:62:0x0105, B:59:0x00fe, B:42:0x00b0, B:44:0x00b7, B:46:0x00c2, B:45:0x00bd, B:40:0x00a8), top: B:66:0x0003 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(chat.ola.vn.message.d r4, int r5, boolean r6) {
        /*
            Method dump skipped, instruction units count: 267
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.message.f.a(chat.ola.vn.message.d, int, boolean):void");
    }

    public void a(d dVar, boolean z) {
        a(dVar, -1, z);
    }

    public void a(f fVar) {
        if (fVar == null) {
            return;
        }
        this.d = chat.ola.vn.util.m.a(fVar.j(), fVar.k());
        this.e = fVar.b();
        this.f = fVar.n();
        this.g = fVar.d();
        this.h = fVar.e();
        this.i = fVar.o();
        this.j = fVar.p();
        this.k = fVar.q();
        this.l = fVar.s();
        this.m = fVar.t();
        if (fVar.f() != 0) {
            this.o = fVar.f();
        }
        this.v = fVar.h();
        this.w = fVar.i();
        this.x = fVar.k();
        if (this.x > 4) {
            this.x = (short) 0;
        }
        this.y = fVar.r();
        this.z = fVar.u();
        this.U = b(this.d, this.x);
        if (this.x == 1) {
            this.V = (byte) 2;
        }
        a(fVar.g());
        this.Z = fVar.Z;
        this.ab = fVar.ab;
        this.ac = fVar.ac;
        this.K = fVar.K;
        this.L = fVar.L;
        if (fVar.S != null) {
            this.S = fVar.S;
        }
        if (fVar.I) {
            this.I = fVar.I;
        }
        if (this.B) {
            this.B = fVar.B;
        }
        if (!this.ag) {
            this.ag = fVar.ag;
        }
        if (this.N == 0) {
            this.N = fVar.N;
        }
        if (this.M == 0) {
            this.M = fVar.M;
        }
        if (this.J == null) {
            this.J = fVar.J;
        }
        J();
    }

    public void a(Boolean bool) {
        this.Z = bool;
    }

    public void a(Long l) {
        this.ab = l;
    }

    public void a(String str) {
        this.d = chat.ola.vn.util.m.a(str, this.x);
    }

    public void a(String str, d dVar) {
        int iIndexOf;
        try {
            d dVar2 = this.aj.get(str);
            if (dVar2 == null || (iIndexOf = this.W.indexOf(dVar2)) < 0) {
                return;
            }
            l(str);
            a(dVar, iIndexOf, false);
        } catch (Throwable unused) {
        }
    }

    public void a(List<f> list) {
        if (list != null) {
            this.c = list;
            this.a = System.currentTimeMillis();
            if (this.A == null) {
                return;
            }
        } else {
            if (this.c != null) {
                this.c.clear();
            }
            this.c = null;
            this.a = 0L;
            if (this.A == null) {
                return;
            }
        }
        this.A.j(this);
    }

    public void a(List<d> list, String str) {
        try {
            this.P = str;
            int i = 0;
            if (list != null && list.size() > 0) {
                int size = list.size();
                if (this.W == null) {
                    this.W = new ArrayList(list.size() * 2);
                }
                if (this.aj == null) {
                    this.aj = new HashMap();
                }
                ArrayList arrayList = new ArrayList(list.size() + this.W.size());
                boolean z = false;
                for (d dVar : list) {
                    if (dVar.e() == 0) {
                        try {
                            if (this.T != null) {
                                this.W.remove(this.T);
                                this.T.a(dVar);
                            } else {
                                this.T = dVar;
                            }
                        } catch (Throwable unused) {
                        }
                    } else {
                        if (dVar.d() != 0) {
                            Calendar calendar = Calendar.getInstance();
                            calendar.setTimeInMillis(dVar.m());
                            int i2 = calendar.get(5);
                            int i3 = calendar.get(2);
                            if (this.X < 0) {
                                this.X = i2;
                            }
                            if (this.Y < 0) {
                                this.Y = i3;
                            }
                            if (this.W.size() > 0 && dVar.e() != 0 && (i2 != this.X || i3 != this.Y)) {
                                this.X = i2;
                                this.Y = i3;
                                y yVarA = e.a(dVar.m());
                                yVarA.a = this;
                                arrayList.add(yVarA);
                            }
                        }
                        if (!chat.ola.vn.util.m.a(dVar.l)) {
                            d dVar2 = this.aj.get(dVar.l);
                            if (dVar2 == null) {
                                this.aj.put(dVar.l, dVar);
                                arrayList.add(dVar);
                                z = true;
                            } else {
                                dVar2.a(dVar.u);
                            }
                        }
                    }
                    dVar.a = this;
                }
                if (!z) {
                    arrayList.clear();
                }
                if (this.W.size() > 0) {
                    try {
                        if (arrayList.size() > 0) {
                            d dVar3 = this.W.get(0);
                            if (dVar3.e() == 4) {
                                Calendar calendar2 = Calendar.getInstance();
                                calendar2.setTimeInMillis(dVar3.m());
                                int i4 = calendar2.get(5);
                                int i5 = calendar2.get(2);
                                calendar2.setTimeInMillis(((d) arrayList.get(arrayList.size() - 1)).m());
                                int i6 = calendar2.get(5);
                                int i7 = calendar2.get(2);
                                if (i6 == i4 && i7 == i5 && dVar3.e() == 4) {
                                    this.W.remove(dVar3);
                                }
                            }
                        }
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                    arrayList.addAll(this.W);
                }
                this.W = arrayList;
                i = size;
            }
            try {
                this.S = this.W.get(this.W.size() - 1);
                try {
                    for (int size2 = this.W.size() - 1; size2 >= 0; size2--) {
                        d dVar4 = this.W.get(size2);
                        if (dVar4.d() != 1 && dVar4.d() != 2) {
                        }
                        this.S = dVar4;
                        break;
                    }
                } catch (Throwable unused2) {
                }
            } catch (Throwable unused3) {
                this.S = null;
            }
            if (this.A != null) {
                this.A.t();
                this.A.a(this, i, str, list);
            }
        } catch (Throwable unused4) {
        }
    }

    public void a(short s) {
        if (this.u != s) {
            b(s);
            J();
            if (this.A != null) {
                this.A.j(this);
            }
        }
    }

    public void a(boolean z, boolean z2) {
        if (this.ag != z) {
            this.ag = z;
            if (z2) {
                try {
                    chat.ola.vn.h.b.b(chat.ola.vn.h.a(), chat.ola.vn.h.t.p());
                } catch (Throwable unused) {
                }
            }
        }
    }

    public boolean a(String str, short s) {
        try {
            if (this.x == s) {
                return s == 0 ? chat.ola.vn.util.m.b(this.d, str) : chat.ola.vn.util.m.a(this.d, str);
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public d b(int i) {
        try {
            return this.W.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public String b() {
        return chat.ola.vn.util.m.a(this.e) ? this.d : this.e;
    }

    public void b(byte b) {
        if (this.z != b) {
            this.z = b;
            this.ad = null;
            this.ae = null;
        }
    }

    public void b(long j) {
        if (j <= 0 || d(j)) {
            return;
        }
        this.o = j;
        this.ae = null;
        J();
        if (this.A != null) {
            this.A.j(this);
        }
    }

    public void b(f fVar) {
        if (fVar == null) {
            return;
        }
        this.d = chat.ola.vn.util.m.a(fVar.j(), fVar.k());
        this.e = fVar.b();
        this.f = fVar.n();
        this.g = fVar.d();
        this.h = fVar.e();
        this.i = fVar.o();
        this.j = fVar.p();
        this.k = fVar.q();
        this.l = fVar.s();
        this.m = fVar.t();
        if (fVar.f() != 0) {
            this.o = fVar.f();
        }
        this.v = fVar.h();
        this.w = fVar.i();
        this.x = fVar.k();
        if (this.x > 4) {
            this.x = (short) 0;
        }
        this.y = fVar.r();
        this.z = fVar.u();
        this.U = b(this.d, this.x);
        if (this.x == 1) {
            this.V = (byte) 2;
        }
        short s = this.u;
        fVar.g();
        this.u = fVar.g();
        if (fVar.S != null) {
            this.S = fVar.S;
        }
        if (fVar.I) {
            this.I = fVar.I;
        }
        if (this.B) {
            this.B = fVar.B;
        }
        if (!this.ag) {
            this.ag = fVar.ag;
        }
        if (this.N == 0) {
            this.N = fVar.N;
        }
        if (this.M == 0) {
            this.M = fVar.M;
        }
        if (this.J == null) {
            this.J = fVar.J;
        }
        this.ad = null;
        this.ae = null;
    }

    public void b(String str) {
        if (chat.ola.vn.util.m.a(this.e, str)) {
            return;
        }
        this.e = str;
        this.ad = null;
        J();
        if (this.A != null) {
            this.A.j(this);
        }
    }

    void b(String str, d dVar) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                return;
            }
            this.aj.remove(str);
            this.aj.put(dVar.p(), dVar);
        } catch (Throwable unused) {
        }
    }

    public void b(short s) {
        if (this.u != s) {
            this.u = s;
            if (s == 2) {
                this.N = 0L;
            }
            this.ad = null;
            this.ae = null;
        }
    }

    public void b(boolean z) {
        this.ai = z;
    }

    public String c() {
        if (this.e != null) {
            return this.e;
        }
        return "@" + this.d;
    }

    public void c(long j) {
        if (j <= 0 || d(j)) {
            return;
        }
        this.o = j;
        this.ad = null;
        this.ae = null;
    }

    public void c(String str) {
        if (chat.ola.vn.util.m.a(str) || chat.ola.vn.util.m.a(this.e, str)) {
            return;
        }
        this.e = str;
        this.ad = null;
        this.ae = null;
    }

    public void c(short s) {
        this.v = s;
    }

    public void c(boolean z) {
        this.I = z;
    }

    public String d() {
        return this.g;
    }

    public void d(String str) {
        this.g = str;
        this.h = null;
        this.ad = null;
        this.ae = null;
        J();
    }

    public void d(short s) {
        this.w = s;
        J();
    }

    public void d(boolean z) {
        a(z, true);
    }

    public String e() {
        try {
            if (this.h == null) {
                this.h = chat.ola.vn.util.i.d(this.g, "");
            }
        } catch (Throwable unused) {
            this.h = "";
        }
        return this.h;
    }

    public void e(String str) {
        this.g = str;
        this.h = null;
        this.ad = null;
        this.ae = null;
    }

    public void e(short s) {
        this.w = s;
        this.ad = null;
        this.ae = null;
    }

    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        try {
            f fVar = (f) obj;
            if (fVar.k() == this.x) {
                if (this.x != 0 && this.x != 1) {
                    return chat.ola.vn.util.m.a(this.d, fVar.j());
                }
                return chat.ola.vn.util.m.b(this.d, fVar.j());
            }
        } catch (Throwable unused) {
        }
        return false;
    }

    public long f() {
        return this.o;
    }

    public void f(String str) {
        this.f = str;
    }

    public void f(short s) {
        this.x = s;
        if (this.x > 4) {
            this.x = (short) 0;
        }
        this.U = b(this.d, this.x);
    }

    public short g() {
        return this.u;
    }

    public void g(String str) {
        this.i = str;
    }

    public short h() {
        return this.v;
    }

    public void h(String str) {
        this.j = str;
        if (this.A != null) {
            this.A.j(this);
        }
    }

    public short i() {
        return this.w;
    }

    public void i(String str) {
        this.k = str;
        this.ad = null;
        this.ae = null;
    }

    public String j() {
        return this.d;
    }

    public void j(String str) {
        this.l = str;
    }

    public short k() {
        return this.x;
    }

    public void k(String str) {
        this.m = str;
    }

    public void l(String str) {
        try {
            d dVar = this.aj.get(str);
            if (dVar != null) {
                this.W.remove(dVar);
                if (this.A != null) {
                    this.A.b(this, dVar);
                }
            }
        } catch (Throwable unused) {
        }
    }

    public boolean l() {
        short s = this.x;
        return (s == 5 || s == 7) ? false : true;
    }

    public void m(String str) {
        StringBuilder sb;
        try {
            this.s = System.currentTimeMillis();
            if (this.x == 2) {
                sb = new StringBuilder();
                sb.append("@");
                sb.append(str);
            } else {
                sb = new StringBuilder();
                sb.append("@");
                sb.append(this.d);
            }
            this.n = sb.toString();
        } catch (Throwable unused) {
            this.n = "@" + str;
        }
        if (this.A != null) {
            this.A.g(this);
        }
    }

    public boolean m() {
        short s = this.x;
        if (s == 1 || s == 7) {
            return false;
        }
        switch (s) {
            case 4:
            case 5:
                return false;
            default:
                return true;
        }
    }

    public String n() {
        return this.f;
    }

    public void n(String str) {
        this.s = 0L;
        this.n = null;
        if (this.A != null) {
            this.A.h(this);
        }
    }

    public d o(String str) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                return null;
            }
            return this.aj.get(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    public String o() {
        return this.i;
    }

    public String p() {
        return this.j;
    }

    public String q() {
        return this.k;
    }

    public byte r() {
        return this.y;
    }

    public String s() {
        return this.l;
    }

    public String t() {
        return this.m;
    }

    public String toString() {
        return this.d + "#" + ((int) this.x);
    }

    public byte u() {
        return this.z;
    }

    public long v() {
        try {
            return this.S.m();
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public String w() {
        try {
            return this.S.k();
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean x() {
        if (System.currentTimeMillis() - this.r >= 900000) {
            A();
        }
        return this.af == 0;
    }

    public String y() {
        if (this.U == null && this.d != null) {
            this.U = b(this.d, this.x);
        }
        return this.U;
    }

    public int z() {
        return this.b;
    }
}
