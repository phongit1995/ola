package chat.ola.vn.lock;

import android.support.v4.app.Fragment;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class c extends a implements View.OnClickListener {
    d w;

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public String c() {
        try {
            return OlaApplication.a(R.string.string_cancel);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public String d() {
        return null;
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public void e() {
        this.w = (e) Fragment.instantiate(getActivity(), e.class.getName());
        y().B();
    }

    @Override // chat.ola.vn.lock.a
    protected boolean e(String str) {
        this.w = (f) Fragment.instantiate(getActivity(), f.class.getName());
        f.w = str;
        y().B();
        return true;
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_set_pass_code);
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public d h() {
        return this.w;
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public d j() {
        return (e) Fragment.instantiate(getActivity(), e.class.getName());
    }
}
