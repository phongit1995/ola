package chat.ola.vn.signup.fb;

import chat.ola.vn.m.f;

/* JADX INFO: loaded from: classes.dex */
public abstract class b extends f {
    private b a;

    public void a(b bVar) {
        this.a = bVar;
    }

    public void a(Class<?> cls) {
        try {
            e().a(cls);
        } catch (Throwable unused) {
        }
    }

    public abstract b c();

    public final b d() {
        return this.a;
    }

    public OlaSignUpByFacebookActivity e() {
        if (getActivity() == null || !(getActivity() instanceof OlaSignUpByFacebookActivity)) {
            return null;
        }
        return (OlaSignUpByFacebookActivity) getActivity();
    }

    public String h() {
        return null;
    }

    public void j() {
    }

    public void v() {
        try {
            e().finish();
        } catch (Throwable unused) {
        }
    }
}
