package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class r extends d {
    private chat.ola.vn.entity.u z;

    public r() {
        this.z = null;
    }

    public r(d dVar, byte b) {
        super(dVar, b, (byte) 10);
        this.z = null;
    }

    public chat.ola.vn.entity.u a() {
        return this.z;
    }

    public void a(chat.ola.vn.entity.u uVar) {
        this.z = uVar;
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
