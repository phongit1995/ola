package chat.ola.vn.lock;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.util.m;
import com.facebook.appevents.AppEventsConstants;

/* JADX INFO: loaded from: classes.dex */
public class a extends d implements View.OnClickListener, Animation.AnimationListener {
    protected Animation a;
    protected View b;
    protected Button c;
    protected Button d;
    protected Button e;
    protected Button f;
    protected Button g;
    protected Button h;
    protected Button i;
    protected Button j;
    protected Button k;
    protected Button l;
    protected Button m;
    protected Button n;
    protected Button o;
    protected Button p;
    protected Button q;
    protected TextView r;
    protected TextView u;
    protected TextView v;
    protected String s = "";
    private boolean w = true;
    protected int t = 0;

    private void A() {
        int length = this.s.length();
        if (length > 0) {
            this.s = this.s.substring(0, length - 1);
            B();
        }
    }

    private void B() {
        Button button;
        Button button2;
        int length = this.s.length();
        for (int i = 0; i < 4; i++) {
            switch (i) {
                case 0:
                    if (i < length) {
                        button2 = this.c;
                        button2.setSelected(true);
                    } else {
                        button = this.c;
                        button.setSelected(false);
                    }
                    break;
                case 1:
                    if (i < length) {
                        button2 = this.d;
                        button2.setSelected(true);
                    } else {
                        button = this.d;
                        button.setSelected(false);
                    }
                    break;
                case 2:
                    if (i < length) {
                        button2 = this.e;
                        button2.setSelected(true);
                    } else {
                        button = this.e;
                        button.setSelected(false);
                    }
                    break;
                case 3:
                    if (i < length) {
                        button2 = this.f;
                        button2.setSelected(true);
                    } else {
                        button = this.f;
                        button.setSelected(false);
                    }
                    break;
            }
        }
        if (this.t > 10) {
            return;
        }
        int i2 = this.t;
    }

    private void a(boolean z) {
        this.g.setEnabled(z);
        this.h.setEnabled(z);
        this.i.setEnabled(z);
        this.j.setEnabled(z);
        this.k.setEnabled(z);
        this.l.setEnabled(z);
        this.m.setEnabled(z);
        this.n.setEnabled(z);
        this.o.setEnabled(z);
        this.p.setEnabled(z);
        this.q.setEnabled(z);
    }

    private void f(String str) {
        if (this.w) {
            try {
                if (this.a != null) {
                    this.a.cancel();
                    this.a.reset();
                }
            } catch (Throwable unused) {
            }
            this.s += str;
            B();
            if (this.s.length() >= 4) {
                e(this.s);
            }
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    private void z() {
        TextView textView;
        int i;
        Object[] objArr;
        this.v.setVisibility(0);
        if (this.t == 1) {
            textView = this.v;
            i = R.string.string_passcode_fail;
            objArr = new Object[]{Integer.valueOf(this.t)};
        } else {
            textView = this.v;
            i = R.string.string_passcode_fails;
            objArr = new Object[]{Integer.valueOf(this.t)};
        }
        textView.setText(getString(i, objArr));
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.lock.d
    public String c() {
        try {
            return OlaApplication.a(R.string.string_cancel);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.lock.d
    public String d() {
        return null;
    }

    @Override // chat.ola.vn.lock.d
    public void e() {
        y().finish();
    }

    protected boolean e(String str) {
        try {
            if (m.b(str, OlaPasscodeSettingActivity.e.a)) {
                v();
                y().B();
                return true;
            }
            this.t++;
            z();
            x();
            chat.ola.vn.util.c.b.a((Context) y(), 1000L);
            this.s = "";
            B();
            if (this.a == null) {
                return false;
            }
            this.b.startAnimation(this.a);
            this.a.setAnimationListener(this);
            return false;
        } catch (Throwable unused) {
            y().B();
            return true;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_enter_pass_code);
    }

    @Override // chat.ola.vn.lock.d
    public d h() {
        return (e) Fragment.instantiate(getActivity(), e.class.getName());
    }

    @Override // chat.ola.vn.lock.d
    public d j() {
        return null;
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationEnd(Animation animation) {
        this.w = true;
        a(this.w);
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationRepeat(Animation animation) {
    }

    @Override // android.view.animation.Animation.AnimationListener
    public void onAnimationStart(Animation animation) {
        this.w = false;
        a(this.w);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        String str;
        try {
            int id = view.getId();
            if (id == R.id.deleteButton) {
                A();
                return;
            }
            switch (id) {
                case R.id.number0Button /* 2131297159 */:
                    str = AppEventsConstants.EVENT_PARAM_VALUE_NO;
                    break;
                case R.id.number1Button /* 2131297160 */:
                    str = "1";
                    break;
                case R.id.number2Button /* 2131297161 */:
                    str = "2";
                    break;
                case R.id.number3Button /* 2131297162 */:
                    str = "3";
                    break;
                case R.id.number4Button /* 2131297163 */:
                    str = "4";
                    break;
                case R.id.number5Button /* 2131297164 */:
                    str = "5";
                    break;
                case R.id.number6Button /* 2131297165 */:
                    str = "6";
                    break;
                case R.id.number7Button /* 2131297166 */:
                    str = "7";
                    break;
                case R.id.number8Button /* 2131297167 */:
                    str = "8";
                    break;
                case R.id.number9Button /* 2131297168 */:
                    str = "9";
                    break;
                default:
                    return;
            }
            f(str);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_check_passcode_fragment_layout, (ViewGroup) null);
        try {
            this.a = AnimationUtils.loadAnimation(getActivity(), R.anim.shake);
            this.a.setDuration(1000L);
        } catch (Throwable unused) {
            this.a = null;
        }
        this.b = viewInflate.findViewById(R.id.passCodeCheckViewLayout);
        this.u = (TextView) viewInflate.findViewById(R.id.passCodeIndicatorTextView);
        this.u.setTextColor(chat.ola.vn.f.y);
        this.c = (Button) viewInflate.findViewById(R.id.passCodeCheck1);
        this.d = (Button) viewInflate.findViewById(R.id.passCodeCheck2);
        this.e = (Button) viewInflate.findViewById(R.id.passCodeCheck3);
        this.f = (Button) viewInflate.findViewById(R.id.passCodeCheck4);
        this.g = (Button) viewInflate.findViewById(R.id.number0Button);
        this.g.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.g.setTextColor(chat.ola.vn.f.y);
        this.g.setOnClickListener(this);
        this.h = (Button) viewInflate.findViewById(R.id.number1Button);
        this.h.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.h.setTextColor(chat.ola.vn.f.y);
        this.h.setOnClickListener(this);
        this.i = (Button) viewInflate.findViewById(R.id.number2Button);
        this.i.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.i.setTextColor(chat.ola.vn.f.y);
        this.i.setOnClickListener(this);
        this.j = (Button) viewInflate.findViewById(R.id.number3Button);
        this.j.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.j.setTextColor(chat.ola.vn.f.y);
        this.j.setOnClickListener(this);
        this.k = (Button) viewInflate.findViewById(R.id.number4Button);
        this.k.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.k.setTextColor(chat.ola.vn.f.y);
        this.k.setOnClickListener(this);
        this.l = (Button) viewInflate.findViewById(R.id.number5Button);
        this.l.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.l.setTextColor(chat.ola.vn.f.y);
        this.l.setOnClickListener(this);
        this.m = (Button) viewInflate.findViewById(R.id.number6Button);
        this.m.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.m.setTextColor(chat.ola.vn.f.y);
        this.m.setOnClickListener(this);
        this.n = (Button) viewInflate.findViewById(R.id.number7Button);
        this.n.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.n.setTextColor(chat.ola.vn.f.y);
        this.n.setOnClickListener(this);
        this.o = (Button) viewInflate.findViewById(R.id.number8Button);
        this.o.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.o.setTextColor(chat.ola.vn.f.y);
        this.o.setOnClickListener(this);
        this.p = (Button) viewInflate.findViewById(R.id.number9Button);
        this.p.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.p.setTextColor(chat.ola.vn.f.y);
        this.p.setOnClickListener(this);
        this.q = (Button) viewInflate.findViewById(R.id.deleteButton);
        this.q.setBackgroundResource(R.drawable.btn_passcode_classical_selector);
        this.q.setTextColor(chat.ola.vn.f.y);
        this.q.setOnClickListener(this);
        this.r = (TextView) viewInflate.findViewById(R.id.passCodeHintTextView);
        this.v = (TextView) viewInflate.findViewById(R.id.passCodeFailTextView);
        try {
            Bundle arguments = getArguments();
            if (arguments != null && arguments.getBoolean("passCodeIndicatorTextView", false)) {
                this.r.setVisibility(0);
            }
        } catch (Throwable unused2) {
        }
        return viewInflate;
    }

    protected void v() {
    }

    protected void x() {
    }
}
