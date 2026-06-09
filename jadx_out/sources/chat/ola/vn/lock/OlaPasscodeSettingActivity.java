package chat.ola.vn.lock;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.entity.r;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaPasscodeSettingActivity extends chat.ola.vn.c implements View.OnClickListener {
    static r e;
    private d f;
    private TextView g;
    private TextView h;
    private TextView i;

    public static void a(Context context) {
        context.startActivity(new Intent(context, (Class<?>) OlaPasscodeSettingActivity.class));
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public void B() {
        d dVarH;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null && (dVarH = this.f.h()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.olaPasscodeFragment, dVarH, dVarH.getClass().getName());
                dVarH.a(this.f);
                a(dVarH.e_(), dVarH.d(), dVarH.c());
                this.f = dVarH;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public d C() {
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null) {
                d dVarJ = this.f.j();
                if (dVarJ != null) {
                    fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                    fragmentTransactionBeginTransaction.replace(R.id.olaPasscodeFragment, dVarJ, dVarJ.getClass().getName());
                    a(dVarJ.e_(), dVarJ.d(), dVarJ.c());
                    fragmentTransactionBeginTransaction.commit();
                }
                this.f = dVarJ;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return this.f;
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void a(String str, String str2, String str3) {
        this.g.setText(str);
        if (m.a(str3)) {
            this.i.setVisibility(4);
        } else {
            this.i.setText(str3);
            this.i.setVisibility(0);
        }
        if (m.a(str2)) {
            this.h.setVisibility(4);
        } else {
            this.h.setText(str2);
            this.h.setVisibility(0);
        }
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (C() == null) {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.olaActionBarBackViewLayout) {
            onBackPressed();
        } else {
            if (id != R.id.olaActionBarButtonTextView) {
                return;
            }
            this.f.e();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        d dVar;
        String name;
        super.onCreate(bundle);
        setContentView(R.layout.ola_passcode_setting_layout);
        this.g = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.h = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        this.h.setOnClickListener(this);
        this.i = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.i.setText(R.string.string_cancel);
        this.i.setOnClickListener(this);
        this.i.setVisibility(4);
        this.h.setVisibility(4);
        try {
            e = r.a(chat.ola.vn.e.a().v());
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (e == null || m.a(e.a)) {
                this.f = (d) Fragment.instantiate(this, e.class.getName());
                dVar = this.f;
                name = e.class.getName();
            } else {
                this.f = (d) Fragment.instantiate(this, a.class.getName());
                dVar = this.f;
                name = a.class.getName();
            }
            fragmentTransactionBeginTransaction.add(R.id.olaPasscodeFragment, dVar, name);
            a(this.f.e_(), this.f.d(), this.f.c());
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
