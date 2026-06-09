package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.IntentFilter;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.sms.a;
import chat.ola.vn.sms.b;
import chat.ola.vn.util.f;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;

/* JADX INFO: loaded from: classes.dex */
public class OlaPhoneVerificationActivity extends c implements View.OnClickListener, a.InterfaceC0049a {
    private EditText e;
    private View f;
    private a g;
    private View h;
    private View i;
    private TextView j;
    private CheckBox k;
    private Runnable l;
    private String m;
    private String n;

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        try {
            o.a((Context) this, (View) this.e, false);
        } catch (Throwable unused) {
        }
        try {
            String string = this.e.getText().toString();
            if (m.c(string)) {
                return;
            }
            String strA = o.a(string);
            c(true);
            if (o.b(strA, h.O.f)) {
                C();
            } else {
                OlaApplication.b.a((String) null, strA, (Long) null, (Byte) null);
            }
        } catch (Throwable unused2) {
        }
    }

    private void C() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.2
            @Override // java.lang.Runnable
            @SuppressLint({"NewApi"})
            public void run() {
                OlaPhoneVerificationActivity olaPhoneVerificationActivity;
                StringBuilder sb;
                try {
                    if (!n.b(OlaPhoneVerificationActivity.this) || !c.x()) {
                        OlaPhoneVerificationActivity.this.c(false);
                        i.a(OlaPhoneVerificationActivity.this, OlaPhoneVerificationActivity.this.getString(R.string.dialog_title_inform), OlaPhoneVerificationActivity.this.getString(R.string.message_verify_phone_manually_instruction, new Object[]{h.O.f, "\"MGM XT " + h.a() + "\"", "8055", m.m("8055")}), (String) null, OlaPhoneVerificationActivity.this.getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.2.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                try {
                                    dialogInterface.dismiss();
                                    o.a(OlaPhoneVerificationActivity.this, "MGM XT " + h.a());
                                    OlaPhoneVerificationActivity.this.finish();
                                } catch (Throwable unused) {
                                }
                            }
                        });
                        return;
                    }
                    if (!b.a(OlaPhoneVerificationActivity.this)) {
                        if (h.O.u > 0 || !OlaPhoneVerificationActivity.this.k.isChecked()) {
                            OlaPhoneVerificationActivity.this.m = "8055";
                            olaPhoneVerificationActivity = OlaPhoneVerificationActivity.this;
                            sb = new StringBuilder();
                            sb.append("MGM XT ");
                            sb.append(h.a());
                        } else {
                            OlaPhoneVerificationActivity.this.m = "8655";
                            olaPhoneVerificationActivity = OlaPhoneVerificationActivity.this;
                            sb = new StringBuilder();
                            sb.append("MGM BUYVIP ");
                            sb.append(h.a());
                            sb.append("  xt");
                        }
                        olaPhoneVerificationActivity.n = sb.toString();
                        OlaPhoneVerificationActivity.this.requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS"}, 106);
                        return;
                    }
                    if (h.O.u <= 0 && OlaPhoneVerificationActivity.this.k.isChecked()) {
                        b.a(OlaPhoneVerificationActivity.this, "8655", "MGM BUYVIP " + h.a() + " xt");
                        f.a().a("Buy VIP and Verify", (long) 4000);
                        return;
                    }
                    b.a(OlaPhoneVerificationActivity.this, "8055", "MGM XT " + h.a());
                    f.a().c("Verify phone number");
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void D() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.3
            @Override // java.lang.Runnable
            @SuppressLint({"NewApi"})
            public void run() {
                try {
                    if (!n.b(OlaPhoneVerificationActivity.this) || !c.x()) {
                        OlaPhoneVerificationActivity.this.c(false);
                        i.a(OlaPhoneVerificationActivity.this, OlaPhoneVerificationActivity.this.getString(R.string.dialog_title_inform), OlaPhoneVerificationActivity.this.getString(R.string.message_verify_phone_manually_instruction, new Object[]{h.O.f, "\"MGM MS " + h.a() + "\"", "8055", m.m("8055")}), (String) null, OlaPhoneVerificationActivity.this.getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.3.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                try {
                                    dialogInterface.dismiss();
                                    o.a(OlaPhoneVerificationActivity.this, "MGM MS " + h.a());
                                    OlaPhoneVerificationActivity.this.finish();
                                } catch (Throwable unused) {
                                }
                            }
                        });
                        return;
                    }
                    if (b.a(OlaPhoneVerificationActivity.this)) {
                        b.a(OlaPhoneVerificationActivity.this, "8055", "MGM MS " + h.a());
                        return;
                    }
                    OlaPhoneVerificationActivity.this.m = "8055";
                    OlaPhoneVerificationActivity.this.n = "MGM MS " + h.a();
                    OlaPhoneVerificationActivity.this.requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS"}, 106);
                } catch (Throwable unused) {
                }
            }
        });
    }

    public static void a(Context context) {
        OlaPhoneVerifyByAccountKitActivity.a(context);
    }

    private void f(String str) {
        try {
            if (m.a(str)) {
                this.e.setText((CharSequence) null);
            } else {
                this.e.setText(o.a(str));
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    public void c(boolean z) {
        this.f.setVisibility(z ? 0 : 8);
        if (this.l == null) {
            this.l = new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.4
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (OlaPhoneVerificationActivity.this.f.getVisibility() == 0) {
                            OlaPhoneVerificationActivity.this.f.setVisibility(8);
                        }
                        i.a(OlaPhoneVerificationActivity.this, R.string.dialog_title_inform, R.string.message_send_sms_fail_confirm);
                    } catch (Throwable unused) {
                    }
                }
            };
        }
        OlaApplication.c(this.l);
        if (z) {
            OlaApplication.a(this.l, 60000L);
        }
    }

    @Override // chat.ola.vn.sms.a.InterfaceC0049a
    public void f(final String str, final String str2) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.5
                @Override // java.lang.Runnable
                public void run() {
                    if (b.a(str)) {
                        try {
                            OlaPhoneVerificationActivity.this.c(false);
                            OlaPhoneVerificationActivity.this.finish();
                        } catch (Throwable unused) {
                        }
                    }
                }
            });
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.6
                @Override // java.lang.Runnable
                public void run() {
                    if (b.a(str)) {
                        try {
                            i.b(c.c(), OlaPhoneVerificationActivity.this.getString(R.string.dialog_title_inform), str2);
                        } catch (Throwable unused) {
                        }
                    }
                }
            }, 1000L);
            OlaApplication.b.b(h.a(), (short) 0);
        } catch (Throwable unused) {
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

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void m() {
        C();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                finish();
                return;
            }
            switch (id) {
                case R.id.phoneUnlockedButton /* 2131297223 */:
                    D();
                    break;
                case R.id.phoneVerificationButton /* 2131297224 */:
                    B();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_phone_verification_layout);
        this.f = findViewById(R.id.progressBarViewLayout);
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_verify_phone_number);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_cancel);
        textView.setOnClickListener(this);
        findViewById(R.id.olaActionBarTitleViewLayout).setOnClickListener(this);
        this.j = (TextView) findViewById(R.id.phoneVerificationHintTextView);
        this.k = (CheckBox) findViewById(R.id.buyVipCheckBox);
        try {
            this.k.setText(chat.ola.vn.util.i.a(this.k, getString(R.string.message_register_vip_account_and_price)));
        } catch (Throwable unused) {
        }
        this.h = findViewById(R.id.phoneVerificationButton);
        this.h.setOnClickListener(this);
        this.i = findViewById(R.id.phoneUnlockedButton);
        this.i.setOnClickListener(this);
        this.e = (EditText) findViewById(R.id.phoneNumberEditText);
        try {
            this.h.setVisibility(0);
            if (h.O.u <= 0) {
                this.k.setVisibility(0);
            } else {
                this.k.setVisibility(8);
            }
            this.i.setVisibility(8);
            if (!m.a(h.O.f)) {
                f(h.O.f);
                if (h.O.B) {
                    this.e.setEnabled(false);
                    this.h.setVisibility(8);
                    this.k.setVisibility(8);
                    this.i.setVisibility(0);
                    this.j.setText(R.string.message_unlock_phone_instruction);
                } else {
                    this.e.setEnabled(true);
                    this.h.setVisibility(0);
                    if (h.O.u <= 0) {
                        this.k.setVisibility(0);
                    } else {
                        this.k.setVisibility(8);
                    }
                    this.i.setVisibility(8);
                    this.j.setText(R.string.message_enter_phone_number_on_device);
                }
            } else if (m.a(h.S)) {
                this.e.setText("");
            } else {
                f(h.S);
                this.e.setEnabled(true);
                this.h.setVisibility(0);
                if (h.O.u <= 0) {
                    this.k.setVisibility(0);
                } else {
                    this.k.setVisibility(8);
                }
                this.i.setVisibility(8);
                this.j.setText(R.string.message_enter_phone_number_on_device);
            }
        } catch (Throwable unused2) {
        }
        this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaPhoneVerificationActivity.1
            /* JADX WARN: Removed duplicated region for block: B:5:0x000a  */
            @Override // android.widget.TextView.OnEditorActionListener
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public boolean onEditorAction(android.widget.TextView r1, int r2, android.view.KeyEvent r3) {
                /*
                    r0 = this;
                    if (r3 == 0) goto La
                    int r1 = r3.getKeyCode()     // Catch: java.lang.Throwable -> L12
                    r3 = 66
                    if (r1 == r3) goto Ld
                La:
                    r1 = 6
                    if (r2 != r1) goto L12
                Ld:
                    chat.ola.vn.activity.OlaPhoneVerificationActivity r1 = chat.ola.vn.activity.OlaPhoneVerificationActivity.this     // Catch: java.lang.Throwable -> L12
                    chat.ola.vn.activity.OlaPhoneVerificationActivity.a(r1)     // Catch: java.lang.Throwable -> L12
                L12:
                    r1 = 0
                    return r1
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaPhoneVerificationActivity.AnonymousClass1.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
            }
        });
        try {
            this.g = new a();
            this.g.a(this);
            registerReceiver(this.g, new IntentFilter("android.provider.Telephony.SMS_RECEIVED"));
        } catch (Throwable unused3) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        try {
            unregisterReceiver(this.g);
        } catch (Throwable unused) {
        }
        try {
            OlaApplication.c(this.l);
        } catch (Throwable unused2) {
        }
        super.onDestroy();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 106) {
            for (int i2 : iArr) {
                try {
                    if (i2 != 0) {
                        this.m = null;
                        this.n = null;
                        c(false);
                        i.a(this, R.string.dialog_title_inform, R.string.message_request_app_sms_permission_verification);
                        return;
                    }
                } catch (Throwable unused) {
                    return;
                }
            }
            b.a(this, this.m, this.n);
            if (this.n.startsWith("MGM XT")) {
                f.a().c("Verify phone number");
            } else if (this.n.startsWith("MGM BUYVIP")) {
                f.a().a("Buy VIP and Verify", 4000);
            }
        }
        this.m = null;
        this.n = null;
    }
}
