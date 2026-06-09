package chat.ola.vn.entry;

import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import chat.ola.vn.util.i;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public chat.ola.vn.entity.f a;
    public chat.ola.vn.entity.g b;
    public CharSequence c;
    public CharSequence d;
    public String[] e;
    public String f;
    public long g;
    public String h;
    public List<String> i;
    public List<String> j;
    public List<String> k;
    public byte l;
    public String m;
    public String n;
    public String o;
    public String p;
    public String q;
    public int r;
    private boolean s;
    private int t;
    private byte u;
    private List<String> v;

    public b() {
        this.a = null;
        this.e = null;
        this.f = null;
        this.g = 0L;
        this.h = "";
        this.l = (byte) 0;
        this.m = null;
        this.n = null;
        this.o = null;
        this.p = null;
        this.q = null;
        this.s = false;
        this.r = 0;
        this.u = (byte) 0;
        this.i = new ArrayList();
        this.k = new ArrayList();
        this.j = new ArrayList();
        this.b = new chat.ola.vn.entity.g();
    }

    public b(chat.ola.vn.entity.g gVar) {
        int i;
        List<String> list;
        String str = null;
        this.a = null;
        this.e = null;
        this.f = null;
        this.g = 0L;
        this.h = "";
        this.l = (byte) 0;
        this.m = null;
        this.n = null;
        this.o = null;
        this.p = null;
        this.q = null;
        this.s = false;
        this.r = 0;
        this.u = (byte) 0;
        this.b = gVar;
        if (gVar.p() == 0) {
            this.u = (byte) 0;
        } else if (gVar.p() == 1) {
            this.u = (byte) 1;
        } else if (gVar.p() == 2) {
            this.u = (byte) 2;
        }
        StringBuffer stringBuffer = new StringBuffer();
        this.v = i.a(gVar.b(), "", stringBuffer);
        if (this.v != null) {
            this.b.b(stringBuffer.toString());
        }
        this.c = i.c(this.b.b());
        if (gVar.c() != null) {
            if (this.v == null) {
                this.v = new ArrayList();
            }
            this.v.add(0, gVar.c());
        }
        this.i = new ArrayList();
        this.k = new ArrayList();
        this.j = new ArrayList();
        try {
            if (this.v != null && this.v.size() > 0) {
                int size = this.v.size();
                String str2 = null;
                for (int i2 = 0; i2 < size; i2++) {
                    String str3 = this.v.get(i2);
                    char cCharAt = str3.charAt(1);
                    if (cCharAt != 'P') {
                        if (cCharAt != 'S') {
                            if (cCharAt == 'V') {
                                str2 = str2 == null ? str3 : str2;
                                if (!this.j.contains(str3)) {
                                    list = this.j;
                                    list.add(str3);
                                }
                            }
                        } else if (!this.k.contains(str3)) {
                            list = this.k;
                            list.add(str3);
                        }
                    } else if (!this.i.contains(str3)) {
                        list = this.i;
                        list.add(str3);
                    }
                }
                str = str2;
            }
            if (this.i.size() == 0) {
                String strB = this.b.b();
                if (!m.a(strB) && this.b.k() != 2 && this.b.k() != 11) {
                    this.m = i.g(strB);
                    if (m.a(this.m)) {
                        this.m = i.d(strB);
                        if (!m.a(this.m)) {
                            this.l = (byte) 0;
                        } else if (!m.a(str)) {
                            this.m = str;
                            this.l = (byte) 2;
                            this.j.clear();
                        }
                    } else {
                        this.l = (byte) 1;
                    }
                }
            }
        } catch (Throwable unused) {
        }
        switch (this.b.k()) {
            case 3:
                i = 4;
                break;
            case 4:
                i = 5;
                break;
            case 5:
                i = 6;
                break;
            case 6:
                i = 7;
                break;
            case 7:
            case 8:
            default:
                if (this.i.size() > 0) {
                    this.t = 1;
                    return;
                } else {
                    if (this.m == null) {
                        this.t = 0;
                        return;
                    }
                    i = 3;
                }
                break;
            case 9:
                i = 8;
                break;
            case 10:
                i = 9;
                break;
        }
        this.t = i;
    }

    public static b a() {
        b bVar = new b();
        bVar.a(2);
        return bVar;
    }

    public void a(int i) {
        this.t = i;
    }

    public void a(String str) {
        try {
            if (m.a(str) || m.b(str.trim(), this.b.a())) {
                String strA = this.b.a();
                this.d = new SpannableStringBuilder(strA);
                ((SpannableStringBuilder) this.d).setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, strA.length(), 33);
            } else {
                this.d = new SpannableStringBuilder(this.b.a() + " · " + str);
                ((SpannableStringBuilder) this.d).setSpan(new ForegroundColorSpan(chat.ola.vn.f.y), 0, this.b.a().length(), 33);
                ((SpannableStringBuilder) this.d).setSpan(new ForegroundColorSpan(chat.ola.vn.f.z), this.b.a().length(), this.d.length(), 33);
            }
            this.d = chat.ola.vn.util.g.a().a(this.d);
        } catch (Throwable unused) {
        }
    }

    public void a(boolean z) {
        this.s = z;
    }

    public CharSequence b() {
        if (this.d == null) {
            a(this.b != null ? this.b.w() : null);
        }
        return this.d;
    }

    public String c() {
        if (this.b != null) {
            return this.b.a();
        }
        return null;
    }

    public int d() {
        return this.t;
    }

    public boolean e() {
        return this.s;
    }

    public List<String> f() {
        return this.i;
    }

    public List<String> g() {
        return this.v;
    }

    public byte h() {
        return this.u;
    }
}
