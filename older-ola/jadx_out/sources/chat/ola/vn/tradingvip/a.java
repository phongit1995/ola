package chat.ola.vn.tradingvip;

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

    public OlaTraddingVipActivity e() {
        if (getActivity() == null || !(getActivity() instanceof OlaTraddingVipActivity)) {
            return null;
        }
        return (OlaTraddingVipActivity) getActivity();
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
