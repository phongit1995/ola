package chat.ola.vn.lock;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.r;
import chat.ola.vn.util.m;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class e extends d implements View.OnClickListener {
    protected TextView a;
    protected TextView b;
    protected TextView c;
    protected TextView d;
    protected View e;
    private d f;

    /* JADX INFO: Access modifiers changed from: private */
    public void x() {
        int i;
        TextView textView;
        Object[] objArr;
        r rVar = OlaPasscodeSettingActivity.e;
        if (rVar == null || m.a(rVar.a)) {
            this.a.setText(R.string.string_turn_passcode_on);
            this.b.setTextColor(chat.ola.vn.f.A);
            this.c.setTextColor(chat.ola.vn.f.A);
            this.d.setTextColor(chat.ola.vn.f.A);
            this.b.setEnabled(false);
            this.e.setEnabled(false);
        } else {
            this.a.setText(R.string.string_turn_passcode_off);
            this.b.setTextColor(chat.ola.vn.f.y);
            this.c.setTextColor(chat.ola.vn.f.y);
            this.d.setTextColor(chat.ola.vn.f.y);
            this.b.setEnabled(true);
            this.e.setEnabled(true);
        }
        if (OlaLockScreenActivity.r == 0) {
            this.d.setText(R.string.string_immediately);
            return;
        }
        if (OlaLockScreenActivity.r == 60000) {
            textView = this.d;
            i = R.string.string_after_min;
            objArr = new Object[]{"1"};
        } else {
            long j = OlaLockScreenActivity.r;
            i = R.string.string_after_mins;
            if (j == 300000) {
                textView = this.d;
                objArr = new Object[]{"5"};
            } else if (OlaLockScreenActivity.r == 900000) {
                textView = this.d;
                objArr = new Object[]{"15"};
            } else if (OlaLockScreenActivity.r == 3600000) {
                textView = this.d;
                i = R.string.string_after_hour;
                objArr = new Object[]{"1"};
            } else {
                if (OlaLockScreenActivity.r != 14400000) {
                    return;
                }
                textView = this.d;
                i = R.string.string_after_hours;
                objArr = new Object[]{"4"};
            }
        }
        textView.setText(getString(i, objArr));
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.lock.d
    public String c() {
        return null;
    }

    @Override // chat.ola.vn.lock.d
    public String d() {
        try {
            return OlaApplication.a(R.string.string_back);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_passcode_lock);
    }

    @Override // chat.ola.vn.lock.d
    public d h() {
        try {
            return this.f;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.lock.d
    public d j() {
        return null;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.changePasscodeTextView) {
                r rVar = OlaPasscodeSettingActivity.e;
                if (rVar == null || m.a(rVar.a)) {
                    return;
                } else {
                    this.f = (b) Fragment.instantiate(getActivity(), b.class.getName());
                }
            } else if (id == R.id.requirePasscodeViewLayout) {
                v();
                return;
            } else {
                if (id != R.id.turnOnPasscodeTextView) {
                    return;
                }
                r rVar2 = OlaPasscodeSettingActivity.e;
                this.f = (rVar2 == null || m.a(rVar2.a)) ? (c) Fragment.instantiate(getActivity(), c.class.getName()) : (g) Fragment.instantiate(getActivity(), g.class.getName());
            }
            y().B();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_passcode_menu_fragment_layout, (ViewGroup) null);
        this.a = (TextView) viewInflate.findViewById(R.id.turnOnPasscodeTextView);
        this.b = (TextView) viewInflate.findViewById(R.id.changePasscodeTextView);
        this.c = (TextView) viewInflate.findViewById(R.id.requirePasscodeTextView);
        this.d = (TextView) viewInflate.findViewById(R.id.requirePasscodeModeTextView);
        this.a.setOnClickListener(this);
        this.b.setOnClickListener(this);
        this.e = viewInflate.findViewById(R.id.requirePasscodeViewLayout);
        this.e.setOnClickListener(this);
        x();
        return viewInflate;
    }

    public void v() {
        TextView textView;
        String string;
        Object[] objArr;
        ArrayList arrayList = new ArrayList();
        if (OlaLockScreenActivity.r == 0) {
            this.d.setText(R.string.string_immediately);
        } else {
            if (OlaLockScreenActivity.r == 60000) {
                textView = this.d;
                string = getString(R.string.string_after_min, "1");
            } else {
                if (OlaLockScreenActivity.r == 300000) {
                    textView = this.d;
                    objArr = new Object[]{"5"};
                } else if (OlaLockScreenActivity.r == 900000) {
                    textView = this.d;
                    objArr = new Object[]{"15"};
                } else if (OlaLockScreenActivity.r == 3600000) {
                    textView = this.d;
                    string = getString(R.string.string_after_hour, "1");
                } else if (OlaLockScreenActivity.r == 14400000) {
                    textView = this.d;
                    string = getString(R.string.string_after_hours, "4");
                }
                string = getString(R.string.string_after_mins, objArr);
            }
            textView.setText(string);
        }
        arrayList.add(getString(R.string.string_immediately));
        arrayList.add(getString(R.string.string_after_min, "1"));
        arrayList.add(getString(R.string.string_after_mins, "5"));
        arrayList.add(getString(R.string.string_after_mins, "15"));
        arrayList.add(getString(R.string.string_after_hour, "1"));
        arrayList.add(getString(R.string.string_after_hours, "4"));
        chat.ola.vn.i.m mVar = new chat.ola.vn.i.m(getActivity());
        mVar.a(arrayList);
        mVar.a(new AdapterView.OnItemClickListener() { // from class: chat.ola.vn.lock.e.1
            @Override // android.widget.AdapterView.OnItemClickListener
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
                try {
                    switch (i) {
                        case 0:
                        default:
                            OlaLockScreenActivity.r = 0L;
                            break;
                        case 1:
                            OlaLockScreenActivity.r = 60000L;
                            break;
                        case 2:
                            OlaLockScreenActivity.r = 300000L;
                            break;
                        case 3:
                            OlaLockScreenActivity.r = 900000L;
                            break;
                        case 4:
                            OlaLockScreenActivity.r = 3600000L;
                            break;
                        case 5:
                            OlaLockScreenActivity.r = 14400000L;
                            break;
                    }
                    if (OlaPasscodeSettingActivity.e == null) {
                        OlaPasscodeSettingActivity.e = new r();
                    }
                    OlaPasscodeSettingActivity.e.c = OlaLockScreenActivity.r;
                    chat.ola.vn.e.a().p(OlaPasscodeSettingActivity.e.toString());
                    e.this.x();
                } catch (Throwable unused) {
                }
            }
        });
        mVar.show();
    }
}
