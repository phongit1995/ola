package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class c extends d {
    private String z;

    public c(d dVar, byte b) {
        super(dVar, b, (byte) 18);
        this.z = null;
    }

    public String a() {
        return this.z;
    }

    public void a(String str) {
        this.z = str;
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }
}
