package chat.ola.vn.tutorial;

import chat.ola.vn.m.f;

/* JADX INFO: loaded from: classes.dex */
public abstract class c extends f {
    private c a;

    public void a(c cVar) {
        this.a = cVar;
    }

    public abstract c c();

    public String d() {
        return null;
    }

    public void e() {
    }

    public final c h() {
        return this.a;
    }

    public OlaTutorialActivity j() {
        if (getActivity() == null || !(getActivity() instanceof OlaTutorialActivity)) {
            return null;
        }
        return (OlaTutorialActivity) getActivity();
    }
}
