package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class i extends d {
    private chat.ola.vn.entity.z z;

    public i() {
        this.z = null;
    }

    public i(d dVar, byte b) {
        super(dVar, b, (byte) 10);
        this.z = null;
    }

    public chat.ola.vn.entity.z a() {
        return this.z;
    }

    public void a(chat.ola.vn.entity.z zVar) {
        this.z = zVar;
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
