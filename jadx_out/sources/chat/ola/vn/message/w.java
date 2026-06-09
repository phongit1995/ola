package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class w extends d {
    protected chat.ola.vn.entity.w z;

    public w(d dVar, byte b) {
        super(dVar, b, (byte) 14);
        this.z = null;
    }

    public chat.ola.vn.entity.w a() {
        return this.z;
    }

    public void a(chat.ola.vn.entity.w wVar) {
        this.z = wVar;
    }

    @Override // chat.ola.vn.message.d
    void a(d dVar) {
        super.a(dVar);
        try {
            w wVar = (w) dVar;
            if (wVar.z != null) {
                this.z = wVar.z;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.message.d
    public boolean w() {
        return true;
    }
}
