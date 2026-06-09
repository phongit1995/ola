package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class l extends d {
    private String A;
    private String B;
    protected String z;

    public l() {
    }

    public l(d dVar, byte b) {
        super(dVar, b, (byte) 8);
    }

    public String C() {
        return this.A;
    }

    public String D() {
        return this.B;
    }

    public String a() {
        return this.z;
    }

    public void a(String str) {
        this.z = str;
    }

    @Override // chat.ola.vn.message.d
    protected boolean h() {
        return false;
    }

    public void n(String str) {
        this.A = str;
    }

    public void o(String str) {
        this.B = str;
    }

    @Override // chat.ola.vn.message.d
    public boolean w() {
        return true;
    }
}
