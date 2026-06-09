package chat.ola.vn.signup;

import chat.ola.vn.m.f;

/* JADX INFO: loaded from: classes.dex */
public abstract class a extends f {
    private a a;

    void a(a aVar) {
        this.a = aVar;
    }

    public abstract a c();

    public final a d() {
        return this.a;
    }

    public abstract String e();

    public abstract String h();

    public OlaSignUpActivity j() {
        if (getActivity() == null || !(getActivity() instanceof OlaSignUpActivity)) {
            return null;
        }
        return (OlaSignUpActivity) getActivity();
    }

    public void v() {
        try {
            j().finish();
        } catch (Throwable unused) {
        }
    }

    public void x() {
    }
}
