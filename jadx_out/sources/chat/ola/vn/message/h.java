package chat.ola.vn.message;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class h extends u {
    protected int a;
    protected chat.ola.vn.entity.k b;

    public h(chat.ola.vn.entity.k kVar) {
        super(kVar.g);
        this.a = 0;
        this.b = null;
        this.b = kVar;
    }

    @Override // chat.ola.vn.message.u
    public String Y() {
        return this.b.a;
    }

    @Override // chat.ola.vn.message.u
    public String Z() {
        return this.b.f;
    }

    @Override // chat.ola.vn.message.f
    public void a(f fVar) {
        super.a(fVar);
        this.b = ((h) fVar).b;
    }

    @Override // chat.ola.vn.message.u
    public boolean a(Context context) {
        if (chat.ola.vn.util.m.a(this.b.h)) {
            return false;
        }
        try {
            chat.ola.vn.util.b.n(context, this.b.h);
            OlaApplication.b.l(this.b.g, "wap");
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.message.u
    public String aa() {
        return this.b.j;
    }

    @Override // chat.ola.vn.message.u
    public String ab() {
        return OlaApplication.a(R.string.string_free);
    }

    @Override // chat.ola.vn.message.f
    public void b(f fVar) {
        super.b(fVar);
        this.b = ((h) fVar).b;
    }
}
