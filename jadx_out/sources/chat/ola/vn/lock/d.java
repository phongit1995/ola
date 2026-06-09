package chat.ola.vn.lock;

/* JADX INFO: loaded from: classes.dex */
public abstract class d extends chat.ola.vn.m.f {
    protected d x;

    public void a(d dVar) {
        this.x = dVar;
    }

    public String c() {
        return null;
    }

    public String d() {
        return null;
    }

    public void e() {
    }

    public abstract d h();

    public d j() {
        return this.x;
    }

    public OlaPasscodeSettingActivity y() {
        if (getActivity() == null || !(getActivity() instanceof OlaPasscodeSettingActivity)) {
            return null;
        }
        return (OlaPasscodeSettingActivity) getActivity();
    }
}
