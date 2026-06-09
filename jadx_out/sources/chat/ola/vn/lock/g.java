package chat.ola.vn.lock;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.View;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;

/* JADX INFO: loaded from: classes.dex */
public class g extends a implements View.OnClickListener {
    e w;

    @Override // chat.ola.vn.lock.a, chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        this.u.setText(R.string.string_enter_pass_code);
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
        this.w = (e) Fragment.instantiate(getActivity(), e.class.getName());
        y().B();
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_turn_passcode_off);
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public d h() {
        return this.w;
    }

    @Override // chat.ola.vn.lock.a, chat.ola.vn.lock.d
    public d j() {
        return this.x;
    }

    @Override // chat.ola.vn.lock.a
    protected void v() {
        try {
            OlaPasscodeSettingActivity.e.a = "";
            chat.ola.vn.e.a().p(OlaPasscodeSettingActivity.e.toString());
            this.w = (e) Fragment.instantiate(getActivity(), e.class.getName());
        } catch (Throwable unused) {
        }
    }
}
