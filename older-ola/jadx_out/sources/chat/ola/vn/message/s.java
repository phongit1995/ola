package chat.ola.vn.message;

import chat.ola.vn.entity.ah;

/* JADX INFO: loaded from: classes.dex */
public class s extends d {
    protected String A;
    protected long B;
    protected int C;
    protected byte D;
    protected ah z;

    public s(d dVar, byte b) {
        super(dVar, b, (byte) 16);
        this.A = null;
        this.B = 0L;
        this.C = 0;
        this.D = (byte) 1;
        h("sent-tradding-vip");
    }

    public long C() {
        return this.B;
    }

    public int D() {
        return this.C;
    }

    public byte E() {
        return this.D;
    }

    public String F() {
        return this.A;
    }

    public ah a() {
        return this.z;
    }

    public void a(ah ahVar) {
        this.z = ahVar;
    }

    public void b(int i) {
        this.C = i;
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }

    public void c(byte b) {
        this.D = b;
        if (this.a != null) {
            this.a.a(this, this.u, this.u);
        }
    }

    public void c(long j) {
        this.B = j;
    }
}
