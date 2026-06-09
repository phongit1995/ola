package chat.ola.vn.room;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.h;
import chat.ola.vn.r.a.f;

/* JADX INFO: loaded from: classes.dex */
public class OlaPublicRoomFilterSettingActivity extends c implements View.OnClickListener, CompoundButton.OnCheckedChangeListener {
    private CheckBox e;
    private CheckBox f;
    private CheckBox g;
    private CheckBox h;
    private CheckBox i;

    private void B() {
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_select_filter_mode);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_back);
        textView.setOnClickListener(this);
        this.e = (CheckBox) findViewById(R.id.filterShowAllCheckBox);
        this.e.setOnCheckedChangeListener(this);
        this.f = (CheckBox) findViewById(R.id.filterMediaCheckBox);
        this.f.setOnCheckedChangeListener(this);
        this.g = (CheckBox) findViewById(R.id.filterFemaleCheckBox);
        this.g.setOnCheckedChangeListener(this);
        this.h = (CheckBox) findViewById(R.id.filterMaleCheckBox);
        this.h.setOnCheckedChangeListener(this);
        this.i = (CheckBox) findViewById(R.id.filterFlexibleCheckBox);
        this.i.setOnCheckedChangeListener(this);
    }

    private void C() {
        CheckBox checkBox;
        try {
            short sQ = h.x.q();
            if (h.x.r()) {
                if ((f.d & sQ) == f.d) {
                    this.f.setChecked(true);
                }
                if ((f.a & sQ) == f.a) {
                    this.g.setChecked(true);
                }
                if ((f.b & sQ) == f.b) {
                    this.h.setChecked(true);
                }
                if ((sQ & f.c) != f.c) {
                    return;
                } else {
                    checkBox = this.i;
                }
            } else {
                checkBox = this.e;
            }
            checkBox.setChecked(true);
        } catch (Throwable unused) {
        }
    }

    private void D() {
        CheckBox checkBox;
        boolean z;
        if (this.f.isChecked() && this.g.isChecked() && this.h.isChecked() && this.i.isChecked()) {
            if (this.e.isChecked()) {
                return;
            }
            checkBox = this.e;
            z = true;
        } else {
            if (!this.e.isChecked()) {
                return;
            }
            checkBox = this.e;
            z = false;
        }
        checkBox.setChecked(z);
    }

    private void E() {
        short s;
        try {
            h.x.q();
            if (this.e.isChecked()) {
                s = f.e;
            } else {
                s = this.f.isChecked() ? (short) (0 | f.d) : (short) 0;
                if (this.g.isChecked()) {
                    s = (short) (s | f.a);
                }
                if (this.h.isChecked()) {
                    s = (short) (s | f.b);
                }
                if (this.i.isChecked()) {
                    s = (short) (s | f.c);
                }
            }
            h.x.a(s);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaPublicRoomFilterSettingActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
        C();
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        E();
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.CompoundButton.OnCheckedChangeListener
    public void onCheckedChanged(CompoundButton compoundButton, boolean z) {
        CheckBox checkBox;
        boolean z2;
        try {
            switch (compoundButton.getId()) {
                case R.id.filterFemaleCheckBox /* 2131296789 */:
                case R.id.filterFlexibleCheckBox /* 2131296790 */:
                case R.id.filterMaleCheckBox /* 2131296791 */:
                case R.id.filterMediaCheckBox /* 2131296792 */:
                    if (z) {
                        D();
                        return;
                    } else {
                        checkBox = this.e;
                        z2 = false;
                    }
                    break;
                case R.id.filterShowAllCheckBox /* 2131296793 */:
                    if (!z) {
                        return;
                    }
                    z2 = true;
                    if (!this.f.isChecked()) {
                        this.f.setChecked(true);
                    }
                    if (!this.g.isChecked()) {
                        this.g.setChecked(true);
                    }
                    if (!this.h.isChecked()) {
                        this.h.setChecked(true);
                    }
                    if (this.i.isChecked()) {
                        return;
                    } else {
                        checkBox = this.i;
                    }
                    break;
                default:
                    return;
            }
            checkBox.setChecked(z2);
        } catch (Throwable unused) {
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.actionBarView || id != R.id.olaActionBarBackViewLayout) {
                return;
            }
            finish();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_public_room_filter_setting_layout);
        B();
    }
}
