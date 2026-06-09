package chat.ola.vn.message;

import chat.ola.vn.entity.ah;

/* JADX INFO: loaded from: classes.dex */
public class q extends d {
    protected String A;
    protected String B;
    protected long C;
    protected int D;
    protected byte E;
    protected ah z;

    public q(d dVar, byte b) {
        super(dVar, b, (byte) 17);
        this.A = null;
        this.B = null;
        this.C = 0L;
        this.D = 0;
        this.E = (byte) 1;
        h("received-tradding-vip");
    }

    public long C() {
        return this.C;
    }

    public int D() {
        return this.D;
    }

    public byte E() {
        return this.E;
    }

    public String F() {
        return this.A;
    }

    public String G() {
        return this.B;
    }

    public ah a() {
        return this.z;
    }

    public void a(ah ahVar) {
        this.z = ahVar;
    }

    public void a(String str) {
        this.A = str;
    }

    public void b(int i) {
        this.D = i;
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }

    public void c(byte b) {
        this.E = b;
        if (this.a != null) {
            this.a.a(this, this.u, this.u);
        }
    }

    public void c(long j) {
        this.C = j;
    }

    public void n(String str) {
        this.B = str;
    }
}
