package chat.ola.vn.message;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class m extends u {
    protected int a;
    protected chat.ola.vn.o.d b;

    public m() {
        super("osimi.chat.ola.vn");
        this.a = 0;
        this.b = null;
        this.b = new chat.ola.vn.o.d();
    }

    @Override // chat.ola.vn.message.u
    public String Y() {
        return OlaApplication.a(R.string.general_tab_osimi);
    }

    @Override // chat.ola.vn.message.u
    public String Z() {
        return OlaApplication.a(R.string.string_chat_to_osimi);
    }

    @Override // chat.ola.vn.message.f
    public void a(f fVar) {
        super.a(fVar);
        this.b = ((m) fVar).b;
    }

    @Override // chat.ola.vn.message.u
    public boolean a(Context context) {
        this.b.b(context);
        return false;
    }

    @Override // chat.ola.vn.message.u
    public String aa() {
        return null;
    }

    @Override // chat.ola.vn.message.u
    public String ab() {
        return null;
    }

    @Override // chat.ola.vn.message.u
    public int ac() {
        return R.drawable.ic_tab_osimi;
    }

    @Override // chat.ola.vn.message.f
    public void b(f fVar) {
        super.b(fVar);
        this.b = ((m) fVar).b;
    }
}
