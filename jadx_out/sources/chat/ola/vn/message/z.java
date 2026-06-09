package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class z extends d {
    protected String z;

    public z(d dVar, byte b) {
        super(dVar, b, (byte) 6);
        this.z = null;
    }

    public void a(String str) {
        this.z = str;
    }

    @Override // chat.ola.vn.message.d
    protected boolean h() {
        return false;
    }

    @Override // chat.ola.vn.message.d
    public boolean w() {
        return true;
    }
}
