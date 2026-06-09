package chat.ola.vn.message;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class p extends d {
    protected List<chat.ola.vn.entity.ab> z;

    public p(d dVar, byte b) {
        super(dVar, b, (byte) 2);
        this.z = null;
    }

    public List<chat.ola.vn.entity.ab> a() {
        if (this.z == null || this.z.size() == 0) {
            return null;
        }
        return new ArrayList(this.z);
    }

    @Override // chat.ola.vn.message.d
    void a(d dVar) {
        super.a(dVar);
        try {
            p pVar = (p) dVar;
            if (pVar.z != null) {
                this.z = new ArrayList(pVar.z);
            }
        } catch (Throwable unused) {
        }
    }

    public void b(List<chat.ola.vn.entity.ab> list) {
        this.z = new ArrayList(list);
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
