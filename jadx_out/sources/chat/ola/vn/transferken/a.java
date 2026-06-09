package chat.ola.vn.transferken;

import android.content.Intent;
import chat.ola.vn.m.f;

/* JADX INFO: loaded from: classes.dex */
public abstract class a extends f {
    private a a;

    public void a(a aVar) {
        this.a = aVar;
    }

    public abstract a c();

    public final a d() {
        return this.a;
    }

    public OlaTransferKenActivity e() {
        if (getActivity() == null || !(getActivity() instanceof OlaTransferKenActivity)) {
            return null;
        }
        return (OlaTransferKenActivity) getActivity();
    }

    public Intent h() {
        try {
            return e().getIntent();
        } catch (Throwable unused) {
            return new Intent();
        }
    }

    public void j() {
        try {
            e().finish();
        } catch (Throwable unused) {
        }
    }
}
