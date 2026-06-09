package chat.ola.vn.m;

import android.content.Context;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class q extends p<g> {
    protected chat.ola.vn.entity.e a;

    @Override // chat.ola.vn.m.p
    public ArrayList<chat.ola.vn.mediastore.a> a(Context context) {
        return null;
    }

    public void a(chat.ola.vn.entity.e eVar) {
        this.a = eVar;
        try {
            v();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void c() {
    }

    @Override // chat.ola.vn.m.f
    public void d_() {
    }

    @Override // chat.ola.vn.m.p
    /* JADX INFO: renamed from: e, reason: merged with bridge method [inline-methods] */
    public g g() {
        return g.c() != null ? g.c() : (g) super.g();
    }

    public void j() {
        if (this.a == null || System.currentTimeMillis() - this.a.d() <= 60000) {
            return;
        }
        g().a(this.a);
    }

    protected void v() {
    }
}
