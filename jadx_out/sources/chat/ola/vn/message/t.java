package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class t extends d {
    public short A;
    private String B;
    public short z;

    public t(d dVar, byte b) {
        super(dVar, b, (byte) 9);
        this.z = (short) 0;
        this.A = (short) 0;
    }

    public short C() {
        return this.A;
    }

    public short D() {
        return this.z;
    }

    public String a() {
        return this.B;
    }

    public void a(String str, short s) {
        this.z = s;
        this.A = this.z;
        this.B = str;
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }

    public void d(short s) {
        this.A = s;
    }

    @Override // chat.ola.vn.message.d
    protected boolean h() {
        return false;
    }
}
