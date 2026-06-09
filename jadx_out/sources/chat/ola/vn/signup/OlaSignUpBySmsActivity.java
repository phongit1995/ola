package chat.ola.vn.signup;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.f;
import chat.ola.vn.i.i;
import chat.ola.vn.p.j;
import chat.ola.vn.sms.a;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import com.mg.ola.common.widget.OlaTextView;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaSignUpBySmsActivity extends chat.ola.vn.c implements View.OnClickListener, chat.ola.vn.f.a, a.InterfaceC0049a {
    private static boolean q = false;
    private EditText e;
    private View f;
    private TextView g;
    private Runnable h;
    private Runnable i;
    private List<String> j;
    private ProgressDialog l;
    private Runnable o;
    private chat.ola.vn.sms.a p;
    private int k = 0;
    private long r = 0;

    /* JADX INFO: Access modifiers changed from: private */
    public void B() {
        try {
            String string = this.e.getText().toString();
            try {
                string = string.trim();
            } catch (Throwable unused) {
            }
            if (!m.a(string) && string.length() >= 6) {
                if (Character.isLetter(string.charAt(0))) {
                    OlaApplication.b.a(string, new j() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.5
                        @Override // chat.ola.vn.p.j
                        public void a(String str, boolean z) {
                            TextView textView;
                            String string2;
                            try {
                                if (z) {
                                    OlaSignUpBySmsActivity.this.g.setTextColor(f.H);
                                    OlaSignUpBySmsActivity.this.g.setVisibility(0);
                                    textView = OlaSignUpBySmsActivity.this.g;
                                    string2 = OlaSignUpBySmsActivity.this.getString(R.string.message_username_available);
                                } else {
                                    OlaSignUpBySmsActivity.this.g.setVisibility(0);
                                    OlaSignUpBySmsActivity.this.g.setTextColor(f.k);
                                    textView = OlaSignUpBySmsActivity.this.g;
                                    string2 = OlaSignUpBySmsActivity.this.getString(R.string.message_fail_username_exist);
                                }
                                textView.setText(string2);
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                    return;
                }
                this.g.setVisibility(0);
                this.g.setTextColor(f.k);
                this.g.setText(getString(R.string.message_fail_username_not_start_by_non_letter));
                return;
            }
            this.g.setVisibility(0);
            this.g.setTextColor(f.k);
            this.g.setText(getString(R.string.message_fail_short_username));
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void C() {
        try {
            String string = this.e.getText().toString();
            try {
                string = string.trim();
            } catch (Throwable unused) {
            }
            if (!m.a(string) && string.length() >= 6) {
                if (Character.isLetter(string.charAt(0))) {
                    c(true);
                    OlaApplication.b.a(string, new j() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.6
                        private void a(String str) {
                            if (System.currentTimeMillis() - OlaSignUpBySmsActivity.this.r > 30000) {
                                OlaSignUpBySmsActivity.this.r = System.currentTimeMillis();
                                OlaSignUpBySmsActivity.this.d(true);
                                chat.ola.vn.sms.b.a(OlaSignUpBySmsActivity.this, "8055", "MGM DK " + str);
                            }
                        }

                        @Override // chat.ola.vn.p.j
                        public void a(String str, boolean z) {
                            try {
                                OlaSignUpBySmsActivity.this.c(false);
                                if (!z) {
                                    OlaSignUpBySmsActivity.this.g.setVisibility(0);
                                    OlaSignUpBySmsActivity.this.g.setTextColor(f.k);
                                    OlaSignUpBySmsActivity.this.g.setText(OlaSignUpBySmsActivity.this.getString(R.string.message_fail_username_exist));
                                } else if (!chat.ola.vn.c.x() || !n.b(OlaSignUpBySmsActivity.this)) {
                                    c.a = str;
                                    OlaSignUpBySmsActivity.this.D();
                                } else {
                                    OlaSignUpBySmsActivity.this.g.setTextColor(f.H);
                                    OlaSignUpBySmsActivity.this.g.setVisibility(0);
                                    OlaSignUpBySmsActivity.this.g.setText(OlaSignUpBySmsActivity.this.getString(R.string.message_username_available));
                                    a(str);
                                }
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                    return;
                } else {
                    this.g.setVisibility(0);
                    this.g.setTextColor(f.k);
                    this.g.setText(getString(R.string.message_fail_username_not_start_by_non_letter));
                    return;
                }
            }
            this.g.setVisibility(0);
            this.g.setTextColor(f.k);
            this.g.setText(getString(R.string.message_fail_short_username));
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void D() {
        try {
            if (q) {
                return;
            }
            q = true;
            OlaSignUpActivity.a((chat.ola.vn.c) this);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void d(boolean z) {
        try {
            if (this.o == null) {
                this.o = new Runnable() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.7
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaSignUpBySmsActivity.this.l.dismiss();
                            OlaSignUpBySmsActivity.this.l = null;
                        } catch (Throwable unused) {
                        }
                        try {
                            c.a = OlaSignUpBySmsActivity.this.e.getText().toString();
                            OlaSignUpBySmsActivity.this.D();
                        } catch (Throwable unused2) {
                        }
                    }
                };
            }
            OlaApplication.c(this.o);
            if (!z) {
                if (this.l != null) {
                    this.l.dismiss();
                    this.l = null;
                    return;
                }
                return;
            }
            if (this.l != null) {
                if (!this.l.isShowing()) {
                }
                OlaApplication.b(this.o, 60000L);
            }
            this.l = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_please_wait_sending_sms));
            this.l.show();
            OlaApplication.b(this.o, 60000L);
        } catch (Throwable unused) {
        }
    }

    static /* synthetic */ int f(OlaSignUpBySmsActivity olaSignUpBySmsActivity) {
        int i = olaSignUpBySmsActivity.k + 1;
        olaSignUpBySmsActivity.k = i;
        return i;
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    public void c(boolean z) {
        View view;
        int i;
        try {
            if (this.h == null) {
                this.h = new Runnable() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.4
                    @Override // java.lang.Runnable
                    public void run() {
                        i.a(OlaSignUpBySmsActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                        OlaSignUpBySmsActivity.this.c(false);
                    }
                };
            }
            OlaApplication.c(this.h);
            if (z) {
                OlaApplication.a(this.h, 60000L);
                view = this.f;
                i = 0;
            } else {
                view = this.f;
                i = 8;
            }
            view.setVisibility(i);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.sms.a.InterfaceC0049a
    public void f(String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.8
            @Override // java.lang.Runnable
            public void run() {
                try {
                    OlaSignUpBySmsActivity.this.d(false);
                    ArrayList<String> arrayListA = chat.ola.vn.util.i.a(str2, '<', '>');
                    if (arrayListA == null || arrayListA.size() < 2) {
                        arrayListA = chat.ola.vn.util.i.a(str2);
                    }
                    if (arrayListA == null || arrayListA.size() < 2) {
                        c.a = OlaSignUpBySmsActivity.this.e.getText().toString();
                        OlaSignUpBySmsActivity.this.D();
                        return;
                    }
                    String str3 = arrayListA.get(0);
                    String str4 = arrayListA.get(1);
                    OlaSignUpBySmsActivity.this.c(false);
                    Intent intent = new Intent();
                    intent.putExtra("_username", str3);
                    intent.putExtra("_pass", str4);
                    OlaSignUpBySmsActivity.this.setResult(-1, intent);
                    OlaTutorialActivity.e = true;
                    OlaBottomTabActivity.g = true;
                    try {
                        chat.ola.vn.util.f.a().c("Reg nick by SMS OK");
                        OlaTutorialActivity.f = false;
                    } catch (Throwable unused) {
                    }
                    OlaSignUpBySmsActivity.this.finish();
                } catch (Throwable unused2) {
                }
            }
        });
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        q = true;
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i2 == -1 && i == 1) {
            try {
                String stringExtra = intent.getStringExtra("_username");
                String stringExtra2 = intent.getStringExtra("_pass");
                c(false);
                Intent intent2 = new Intent();
                intent2.putExtra("_username", stringExtra);
                intent2.putExtra("_pass", stringExtra2);
                setResult(-1, intent2);
            } catch (Throwable unused) {
            }
        }
        finish();
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.f.getVisibility() == 0) {
            return;
        }
        super.onBackPressed();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.nextStepButton) {
                C();
            } else {
                if (id != R.id.olaActionBarBackViewLayout) {
                    return;
                }
                onBackPressed();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    @SuppressLint({"NewApi"})
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_sign_up_by_sms_layout);
        q = false;
        this.f = findViewById(R.id.loadingProgressBar);
        this.g = (TextView) findViewById(R.id.txtAccountErrorInfo);
        OlaTextView olaTextView = (OlaTextView) findViewById(R.id.termAndConditionTextView);
        olaTextView.setText(chat.ola.vn.util.i.b(null, getString(R.string.string_term_hint), null, f.a, true));
        olaTextView.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        this.e = (EditText) findViewById(R.id.txtNickOla);
        this.e.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.1
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
                    chat.ola.vn.signup.OlaSignUpBySmsActivity r1 = chat.ola.vn.signup.OlaSignUpBySmsActivity.this     // Catch: java.lang.Throwable -> L12
                    chat.ola.vn.signup.OlaSignUpBySmsActivity.a(r1)     // Catch: java.lang.Throwable -> L12
                L12:
                    r1 = 0
                    return r1
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.signup.OlaSignUpBySmsActivity.AnonymousClass1.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
            }
        });
        this.e.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.2
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                try {
                    OlaSignUpBySmsActivity.this.g.setVisibility(4);
                    if (OlaSignUpBySmsActivity.this.i == null) {
                        OlaSignUpBySmsActivity.this.i = new Runnable() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.2.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    String string = OlaSignUpBySmsActivity.this.e.getText().toString();
                                    try {
                                        string = string.trim();
                                    } catch (Throwable unused) {
                                    }
                                    if (string.length() >= 6) {
                                        OlaSignUpBySmsActivity.this.g.setVisibility(4);
                                        OlaSignUpBySmsActivity.this.B();
                                    } else if (string.length() > 0) {
                                        OlaSignUpBySmsActivity.this.g.setTextColor(f.k);
                                        OlaSignUpBySmsActivity.this.g.setVisibility(0);
                                        OlaSignUpBySmsActivity.this.g.setText(OlaSignUpBySmsActivity.this.getString(R.string.message_fail_short_username));
                                    }
                                } catch (Throwable unused2) {
                                }
                            }
                        };
                    }
                    OlaApplication.c(OlaSignUpBySmsActivity.this.i);
                    OlaApplication.a(OlaSignUpBySmsActivity.this.i, 1000L);
                } catch (Throwable unused) {
                }
            }

            @Override // android.text.TextWatcher
            public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }

            @Override // android.text.TextWatcher
            public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
            }
        });
        try {
            this.j = OlaSignUpActivity.a((Context) this);
            if (this.j != null && this.j.size() > 0) {
                this.k = 0;
                this.e.setText("");
                c(true);
                int size = this.j.size();
                for (int i = 0; i < size; i++) {
                    OlaApplication.b.a(this.j.get(i), new j() { // from class: chat.ola.vn.signup.OlaSignUpBySmsActivity.3
                        @Override // chat.ola.vn.p.j
                        public void a(String str, boolean z) {
                            OlaSignUpBySmsActivity.f(OlaSignUpBySmsActivity.this);
                            if (z && m.a(OlaSignUpBySmsActivity.this.e.getText().toString())) {
                                OlaSignUpBySmsActivity.this.c(false);
                                OlaSignUpBySmsActivity.this.e.setText(str);
                            } else if (OlaSignUpBySmsActivity.this.k >= OlaSignUpBySmsActivity.this.j.size()) {
                                OlaSignUpBySmsActivity.this.c(false);
                            }
                        }
                    });
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        ((TextView) findViewById(R.id.olaActionBarTitleTextView)).setText(R.string.string_register_account);
        findViewById(R.id.nextStepButton).setOnClickListener(this);
        TextView textView = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        textView.setText(R.string.string_back);
        textView.setOnClickListener(this);
        try {
            this.p = new chat.ola.vn.sms.a();
            this.p.a(this);
            registerReceiver(this.p, new IntentFilter("android.provider.Telephony.SMS_RECEIVED"));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        try {
            unregisterReceiver(this.p);
        } catch (Throwable unused) {
        }
        super.onDestroy();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        q = false;
    }
}
