package chat.ola.vn.activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.entity.d;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaChangePasswordActivity extends c implements View.OnClickListener {
    private static String k;
    private Animation e;
    private EditText f;
    private EditText g;
    private EditText h;
    private Runnable i = null;
    private ProgressDialog j;

    private void B() {
        try {
            OlaApplication.b.g(this.f.getText().toString(), this.g.getText().toString(), (short) 38);
            c(true);
        } catch (Throwable unused) {
        }
    }

    private boolean C() {
        boolean z;
        if (m.a(this.f.getText().toString())) {
            this.f.startAnimation(this.e);
            this.f.requestFocus();
            j.a(this, R.string.message_change_password_blank_password);
            z = false;
        } else {
            z = true;
        }
        String string = this.g.getText().toString();
        if (m.a(string) || string.length() < 6) {
            this.g.startAnimation(this.e);
            this.g.requestFocus();
            j.a(this, R.string.message_change_password_blank_password);
            z = false;
        }
        String string2 = this.h.getText().toString();
        if (m.a(string2) || string2.length() < 6) {
            this.h.startAnimation(this.e);
            this.h.requestFocus();
            j.a(this, R.string.message_change_password_blank_password);
            z = false;
        }
        if (m.a(string, string2)) {
            return z;
        }
        i.a(this, R.string.message_inform, R.string.message_change_password_unmatched_new_password);
        this.h.startAnimation(this.e);
        this.h.requestFocus();
        return false;
    }

    public static void a(Context context) {
        a(context, (String) null);
    }

    public static void a(Context context, String str) {
        k = str;
        context.startActivity(new Intent(context, (Class<?>) OlaChangePasswordActivity.class));
    }

    private void c(boolean z) {
        try {
            if (this.i == null) {
                this.i = new Runnable() { // from class: chat.ola.vn.activity.OlaChangePasswordActivity.2
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaChangePasswordActivity.this.j.dismiss();
                            OlaChangePasswordActivity.this.j = null;
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.i);
            if (!z) {
                if (this.j != null) {
                    this.j.dismiss();
                    this.j = null;
                    return;
                }
                return;
            }
            if (this.j != null) {
                if (!this.j.isShowing()) {
                }
                OlaApplication.b(this.i, 30000L);
            }
            this.j = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_change_password_watting));
            this.j.show();
            OlaApplication.b(this.i, 30000L);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, d[] dVarArr, short s) {
        String string;
        super.a(i, str, bArr, dVarArr, s);
        if (s == 38) {
            c(false);
            if (i == 7) {
                i.a(this, R.string.message_inform, R.string.message_change_password_wrong_old_password);
                this.f.startAnimation(this.e);
                this.f.requestFocus();
                return;
            }
            if (i != 10) {
                if (m.a(str)) {
                    string = getString(R.string.message_inform);
                    str = getString(R.string.message_fail_unknow_reason);
                } else {
                    string = getString(R.string.message_inform);
                }
                i.b(this, string, str);
            } else {
                i.a(this, R.string.message_inform, R.string.message_fail_password_invalid);
            }
            this.g.requestFocus();
            this.g.selectAll();
            this.h.setText("");
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void b(short s) {
        c(false);
        i.a(this, R.string.message_inform, R.string.message_change_password_success, R.string.string_close, 0, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaChangePasswordActivity.1
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                dialogInterface.dismiss();
                OlaChangePasswordActivity.this.finish();
            }
        });
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id != R.id.btnChange) {
            if (id != R.id.olaActionBarBackViewLayout) {
                return;
            }
            finish();
        } else if (C()) {
            B();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.change_password_layout);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_change_password);
        this.f = (EditText) findViewById(R.id.txtOldPassword);
        String strB = h.b();
        if (m.a(k)) {
            if (!h.a(strB)) {
                ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.hint_enter_set_your_password);
                this.f.setText(strB);
            }
            this.g = (EditText) findViewById(R.id.txtNewPassword);
            this.h = (EditText) findViewById(R.id.txtPreTypePassword);
            findViewById(R.id.btnChange).setOnClickListener(this);
            findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
            this.e = AnimationUtils.loadAnimation(this, R.anim.shake);
        }
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.hint_enter_set_your_password);
        this.f.setText(k);
        this.f.setVisibility(8);
        this.g = (EditText) findViewById(R.id.txtNewPassword);
        this.h = (EditText) findViewById(R.id.txtPreTypePassword);
        findViewById(R.id.btnChange).setOnClickListener(this);
        findViewById(R.id.olaActionBarBackViewLayout).setOnClickListener(this);
        this.e = AnimationUtils.loadAnimation(this, R.anim.shake);
    }
}
