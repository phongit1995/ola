package chat.ola.vn.lock;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.r;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class f extends a implements View.OnClickListener {
    static String w = "";
    d y;

    @Override // chat.ola.vn.lock.a, chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.u.setText(R.string.string_reenter_passcode);
    }

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
        this.y = (e) Fragment.instantiate(getActivity(), e.class.getName());
        y().B();
    }

    @Override // chat.ola.vn.lock.a
    protected boolean e(String str) {
        if (!m.b(str, w)) {
            Bundle bundle = new Bundle();
            bundle.putBoolean("passCodeIndicatorTextView", true);
            this.y = (c) Fragment.instantiate(getActivity(), c.class.getName(), bundle);
            y().B();
            return false;
        }
        if (OlaPasscodeSettingActivity.e == null) {
            OlaPasscodeSettingActivity.e = new r();
        }
        OlaPasscodeSettingActivity.e.a = str;
        chat.ola.vn.e.a().p(OlaPasscodeSettingActivity.e.toString());
        this.y = (e) Fragment.instantiate(getActivity(), e.class.getName());
        y().B();
        return true;
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_set_pass_code);
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public d h() {
        return this.y;
    }
}
