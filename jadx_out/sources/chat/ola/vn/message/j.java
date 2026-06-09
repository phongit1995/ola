package chat.ola.vn.message;

/* JADX INFO: loaded from: classes.dex */
public class j extends d {
    protected long z;

    public j(d dVar, byte b) {
        super(dVar, b, (byte) 15);
        this.z = 0L;
    }

    public long a() {
        return this.z;
    }

    @Override // chat.ola.vn.message.d
    void a(d dVar) {
        super.a(dVar);
        try {
            j jVar = (j) dVar;
            if (0 != jVar.z) {
                this.z = jVar.z;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }

    public void c(long j) {
        this.z = j;
    }
}
