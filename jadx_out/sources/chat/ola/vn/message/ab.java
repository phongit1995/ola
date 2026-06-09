package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class ab extends d {
    private String A;
    private String z;

    public ab() {
    }

    public ab(d dVar, byte b) {
        super(dVar, b, (byte) 7);
    }

    public String C() {
        return this.A;
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

    @Override // chat.ola.vn.message.d
    public boolean w() {
        return true;
    }
}
