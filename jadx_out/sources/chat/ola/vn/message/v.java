package chat.ola.vn.message;

import chat.ola.vn.entity.ah;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class v extends d {
    public String A;
    public String B;
    public long C;
    public int D;
    public int E;
    public byte F;
    public byte G;
    public byte H;
    public byte I;
    public boolean J;
    public boolean K;
    private List<String> L;
    private CharSequence M;
    public ah z;

    public v() {
        super(null, (byte) 0, (byte) 0);
        this.z = null;
        this.A = null;
        this.B = null;
        this.C = 0L;
        this.D = 0;
        this.E = 0;
        this.F = (byte) -1;
        this.G = (byte) 0;
        this.H = (byte) -1;
        this.I = (byte) 0;
        this.J = false;
        this.K = false;
    }

    public String C() {
        try {
            return this.M.toString();
        } catch (Throwable unused) {
            return null;
        }
    }

    public CharSequence D() {
        return this.M;
    }

    public List<String> a() {
        return this.L;
    }

    @Override // chat.ola.vn.message.d
    public void f(String str) {
        super.f(str);
        if (chat.ola.vn.util.m.a(str)) {
            return;
        }
        this.L = chat.ola.vn.util.i.b((CharSequence) str);
        if (this.L != null) {
            Iterator<String> it2 = this.L.iterator();
            while (it2.hasNext()) {
                if (chat.ola.vn.entity.i.i(it2.next()) != 1) {
                    it2.remove();
                }
            }
        }
        this.M = chat.ola.vn.util.i.d(str, "");
    }
}
