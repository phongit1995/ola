package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaFacebookActivity;
import chat.ola.vn.b.t;
import chat.ola.vn.c;
import chat.ola.vn.c.x;
import chat.ola.vn.e;
import chat.ola.vn.f.a;
import chat.ola.vn.f.d;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.l.b;
import chat.ola.vn.network.a.a.ai;
import chat.ola.vn.network.a.a.p;
import chat.ola.vn.signup.OlaSignUpActivity;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.f;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import chat.ola.vn.view.OlaGalleryView;
import com.facebook.AccessToken;
import com.facebook.accountkit.AccountKitLoginResult;
import com.facebook.accountkit.ui.AccountKitActivity;
import com.facebook.accountkit.ui.AccountKitConfiguration;
import com.facebook.accountkit.ui.LoginType;
import com.facebook.applinks.AppLinkData;
import com.mg.ola.common.d.g;
import java.util.List;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"ClickableViewAccessibility"})
public class OlaLoginActivity extends c implements View.OnClickListener, a, d, p.a {
    private View A;
    private String B;
    private p.a C;
    private p.a D;
    private ai.a E;
    private Runnable G;
    private EditText e;
    private EditText f;
    private ImageView g;
    private EditText h;
    private TextView i;
    private View j;
    private Animation k;
    private View l;
    private OlaGalleryView o;
    private t p;
    private View s;
    private Button t;
    private View u;
    private List<chat.ola.vn.h.a> v;
    private View w;
    private View x;
    private View y;
    private TextView z;
    private String q = null;
    private int r = 0;
    private chat.ola.vn.network.c F = new chat.ola.vn.network.c() { // from class: chat.ola.vn.activity.OlaLoginActivity.1
        @Override // chat.ola.vn.network.c
        public void a() {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str) {
            try {
                if (m.a(str)) {
                    OlaLoginActivity.this.c(false);
                    i.b(OlaLoginActivity.this, OlaLoginActivity.this.getString(R.string.string_info), OlaLoginActivity.this.getString(R.string.string_login_by_facebook_account_error));
                } else {
                    OlaLoginActivity.this.c(true);
                    OlaLoginActivity.this.B = str;
                    b.a(str, AccessToken.getCurrentAccessToken().getToken(), OlaLoginActivity.this.F);
                }
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, String str2, String str3) {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, boolean z) {
        }

        /* JADX WARN: Removed duplicated region for block: B:13:0x0051 A[Catch: Throwable -> 0x007c, TryCatch #0 {Throwable -> 0x007c, blocks: (B:4:0x0009, B:6:0x000f, B:8:0x0016, B:10:0x0029, B:11:0x0033, B:16:0x006f, B:12:0x003b, B:13:0x0051, B:15:0x0064), top: B:19:0x0009 }] */
        @Override // chat.ola.vn.network.c
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void a(java.util.List<java.lang.String> r6) {
            /*
                r5 = this;
                r0 = 2131690825(0x7f0f0549, float:1.9010705E38)
                r1 = 2131690785(0x7f0f0521, float:1.9010623E38)
                r2 = 0
                if (r6 == 0) goto L51
                int r3 = r6.size()     // Catch: java.lang.Throwable -> L7c
                if (r3 <= 0) goto L51
                int r3 = r6.size()     // Catch: java.lang.Throwable -> L7c
                r4 = 1
                if (r3 <= r4) goto L3b
                chat.ola.vn.activity.OlaLoginActivity r3 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity.a(r3, r2)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r3 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                java.lang.String r3 = chat.ola.vn.activity.OlaLoginActivity.b(r3)     // Catch: java.lang.Throwable -> L7c
                boolean r6 = chat.ola.vn.signup.fb.OlaSignUpByFacebookActivity.a(r2, r3, r6)     // Catch: java.lang.Throwable -> L7c
                if (r6 != 0) goto L6f
                chat.ola.vn.activity.OlaLoginActivity r6 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                java.lang.String r1 = r2.getString(r1)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
            L33:
                java.lang.String r0 = r2.getString(r0)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.i.i.b(r6, r1, r0)     // Catch: java.lang.Throwable -> L7c
                goto L6f
            L3b:
                chat.ola.vn.activity.OlaLoginActivity r0 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                java.lang.String r0 = chat.ola.vn.activity.OlaLoginActivity.b(r0)     // Catch: java.lang.Throwable -> L7c
                java.lang.Object r6 = r6.get(r2)     // Catch: java.lang.Throwable -> L7c
                java.lang.String r6 = (java.lang.String) r6     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r1 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.network.c r1 = chat.ola.vn.activity.OlaLoginActivity.a(r1)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.l.b.d(r0, r6, r1)     // Catch: java.lang.Throwable -> L7c
                goto L6f
            L51:
                chat.ola.vn.activity.OlaLoginActivity r6 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity.a(r6, r2)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r6 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                java.lang.String r2 = chat.ola.vn.activity.OlaLoginActivity.b(r2)     // Catch: java.lang.Throwable -> L7c
                boolean r6 = chat.ola.vn.signup.fb.OlaSignUpByFacebookActivity.a(r6, r2)     // Catch: java.lang.Throwable -> L7c
                if (r6 != 0) goto L6f
                chat.ola.vn.activity.OlaLoginActivity r6 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                java.lang.String r1 = r2.getString(r1)     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.activity.OlaLoginActivity r2 = chat.ola.vn.activity.OlaLoginActivity.this     // Catch: java.lang.Throwable -> L7c
                goto L33
            L6f:
                r6 = 16386(0x4002, float:2.2962E-41)
                chat.ola.vn.c.x.j = r6     // Catch: java.lang.Throwable -> L7c
                chat.ola.vn.e r6 = chat.ola.vn.e.a()     // Catch: java.lang.Throwable -> L7c
                short r0 = chat.ola.vn.c.x.j     // Catch: java.lang.Throwable -> L7c
                r6.d(r0)     // Catch: java.lang.Throwable -> L7c
            L7c:
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaLoginActivity.AnonymousClass1.a(java.util.List):void");
        }

        @Override // chat.ola.vn.network.c
        public void a(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void b() {
        }

        @Override // chat.ola.vn.network.c
        public void b(String str, String str2, String str3) {
            try {
                h.d(str);
                if (!m.a(str2)) {
                    h.b(str2);
                }
                h.c(str3);
                e.a().a(str);
                e.a().b(str3);
                if (!m.a(str2)) {
                    chat.ola.vn.h.b.a(OlaApplication.a(), str, str2, str3, null);
                }
                OlaApplication.b.b(str);
                OlaLoginActivity.this.a(OlaBottomTabActivity.class);
                OlaLoginActivity.this.finish();
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void b(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void b(short s) {
        }

        @Override // chat.ola.vn.network.c
        public void c() {
        }

        @Override // chat.ola.vn.network.c
        public void d() {
        }
    };

    /* JADX INFO: renamed from: chat.ola.vn.activity.OlaLoginActivity$7, reason: invalid class name */
    class AnonymousClass7 implements p.a {
        AnonymousClass7() {
        }

        @Override // chat.ola.vn.network.a.a.p.a
        public void a(final String str, List<String> list) {
            try {
                OlaLoginActivity.this.c(false);
                if (list != null && list.size() > 0) {
                    if (list.size() > 1) {
                        OlaRecoveredAccountListActivity.a(OlaLoginActivity.this, str, list);
                        return;
                    }
                    String str2 = list.get(0);
                    if (!m.a(str2)) {
                        OlaLoginActivity.this.c(true);
                        OlaApplication.b.a(str2, str, OlaLoginActivity.this.J());
                        return;
                    }
                }
                i.a(OlaLoginActivity.this, R.string.dialog_title_fail, R.string.message_fail_no_account_linked_to_phone, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.7.1
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i) {
                        try {
                            dialogInterface.dismiss();
                            if (i != 0) {
                                return;
                            }
                            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaLoginActivity.7.1.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    OlaSignUpActivity.a(OlaLoginActivity.this, str);
                                }
                            });
                            OlaApplication.b.a(str);
                        } catch (Throwable unused) {
                        }
                    }
                });
            } catch (Throwable unused) {
            }
        }
    }

    private void F() {
        chat.ola.vn.h.a aVar;
        try {
            this.j = findViewById(R.id.loadingProgressBar);
            this.t = (Button) findViewById(R.id.btnLogin);
            this.t.setOnClickListener(this);
            this.l = findViewById(R.id.olaLogoImageView);
            this.y = findViewById(R.id.forgotPasswordTextView);
            this.y.setVisibility(0);
            this.y.setOnClickListener(this);
            this.s = findViewById(R.id.btnLoginFacebook);
            this.s.setOnClickListener(this);
            this.s.setVisibility(0);
            this.u = findViewById(R.id.btnRegisterWhite);
            this.u.setOnClickListener(this);
            this.w = findViewById(R.id.btnClearUserName);
            this.x = findViewById(R.id.btnClearPassword);
            this.w.setOnClickListener(this);
            this.x.setOnClickListener(this);
            this.A = findViewById(R.id.validationCodeLayout);
            this.h = (EditText) findViewById(R.id.validationCodeEditText);
            this.g = (ImageView) findViewById(R.id.validationCodeImageView);
            this.i = (TextView) findViewById(R.id.txtCapchaMessage);
            this.o = (OlaGalleryView) findViewById(R.id.accountGallery);
            this.o.setVisibility(8);
            this.p = new t(this);
            this.p.a(this);
            this.o.setAdapter(this.p);
            this.v = chat.ola.vn.h.b.a(this);
            if (this.v == null || this.v.isEmpty()) {
                this.o.setVisibility(8);
                this.l.setVisibility(0);
            } else {
                this.o.setVisibility(0);
                this.l.setVisibility(8);
            }
            this.p.a(this.v);
            this.p.notifyDataSetChanged();
            this.e = (EditText) findViewById(R.id.txtUserName);
            this.f = (EditText) findViewById(R.id.txtPassword);
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.14
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if (i != 2) {
                        return false;
                    }
                    OlaLoginActivity.this.B();
                    return false;
                }
            });
            this.e.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.activity.OlaLoginActivity.15
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        String lowerCase = OlaLoginActivity.this.e.getText().toString().trim().toLowerCase();
                        String string = OlaLoginActivity.this.f.getText().toString();
                        if (m.a(lowerCase) && m.a(string)) {
                            OlaLoginActivity.this.t.setText(R.string.string_register_account);
                        } else {
                            OlaLoginActivity.this.t.setText(R.string.string_login);
                        }
                    } catch (Throwable unused) {
                        OlaLoginActivity.this.t.setText(R.string.string_login);
                    }
                    OlaLoginActivity.this.w.setVisibility(editable.length() == 0 ? 8 : 0);
                }

                @Override // android.text.TextWatcher
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }

                @Override // android.text.TextWatcher
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }
            });
            this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.activity.OlaLoginActivity.16
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        String lowerCase = OlaLoginActivity.this.e.getText().toString().trim().toLowerCase();
                        String string = OlaLoginActivity.this.f.getText().toString();
                        if (m.a(lowerCase) && m.a(string)) {
                            OlaLoginActivity.this.t.setText(R.string.string_register_account);
                        } else {
                            OlaLoginActivity.this.t.setText(R.string.string_login);
                        }
                    } catch (Throwable unused) {
                        OlaLoginActivity.this.t.setText(R.string.string_login);
                    }
                    OlaLoginActivity.this.x.setVisibility(editable.length() == 0 ? 8 : 0);
                }

                @Override // android.text.TextWatcher
                public void beforeTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }

                @Override // android.text.TextWatcher
                public void onTextChanged(CharSequence charSequence, int i, int i2, int i3) {
                }
            });
            try {
                String strI = e.a().i();
                if (m.a(strI)) {
                    if (this.v != null && (aVar = this.v.get(0)) != null) {
                        this.e.setText(aVar.a.name);
                        this.f.setText(aVar.b);
                    }
                } else if (this.v != null) {
                    int size = this.v.size();
                    int i = 0;
                    while (true) {
                        if (i < size) {
                            chat.ola.vn.h.a aVar2 = this.v.get(i);
                            if (aVar2 != null && m.b(strI, aVar2.a.name)) {
                                this.e.setText(aVar2.a.name);
                                this.f.setText(aVar2.b);
                                break;
                            }
                            i++;
                        } else {
                            break;
                        }
                    }
                }
                if (m.a(this.e.getText().toString())) {
                    this.w.setVisibility(8);
                } else {
                    this.w.setVisibility(0);
                }
                if (m.a(this.f.getText().toString())) {
                    this.x.setVisibility(8);
                } else {
                    this.x.setVisibility(0);
                }
                try {
                    String lowerCase = this.e.getText().toString().trim().toLowerCase();
                    String string = this.f.getText().toString();
                    if (m.a(lowerCase) && m.a(string)) {
                        this.t.setText(R.string.string_register_account);
                    } else {
                        this.t.setText(R.string.string_login);
                    }
                } catch (Throwable unused) {
                    this.t.setText(R.string.string_login);
                }
                String str = "" + getPackageManager().getPackageInfo(getPackageName(), 0).versionCode;
                this.z = (TextView) findViewById(R.id.versionCodeTextView);
                this.z.setText(getString(R.string.string_version) + ": " + str);
            } catch (Throwable unused2) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @SuppressLint({"NewApi"})
    private void G() {
        D();
    }

    private p.a H() {
        if (this.C == null) {
            this.C = new AnonymousClass7();
        }
        return this.C;
    }

    private p.a I() {
        if (this.D == null) {
            this.D = new p.a() { // from class: chat.ola.vn.activity.OlaLoginActivity.8
                @Override // chat.ola.vn.network.a.a.p.a
                public void a(String str, List<String> list) {
                    if (list != null) {
                        try {
                            if (list.size() > 0) {
                                if (list.size() > 1) {
                                    OlaRecoveredAccountListActivity.a(OlaLoginActivity.this, str, list, R.string.string_select_account_to_login);
                                    return;
                                }
                                String str2 = list.get(0);
                                if (!m.a(str2)) {
                                    OlaLoginActivity.this.c(true);
                                    OlaApplication.b.a(str2, str, OlaLoginActivity.this.J());
                                    return;
                                }
                            }
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                    OlaSignUpActivity.a(OlaLoginActivity.this, str);
                }
            };
        }
        return this.D;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public ai.a J() {
        if (this.E == null) {
            this.E = new ai.a() { // from class: chat.ola.vn.activity.OlaLoginActivity.9
                @Override // chat.ola.vn.network.a.a.ai.a
                public void a_(String str, String str2) {
                    try {
                        OlaTutorialActivity.e = true;
                        OlaTutorialActivity.f = true;
                        OlaBottomTabActivity.g = false;
                        OlaLoginActivity.this.e.setText(str);
                        OlaLoginActivity.this.f.setText(str2);
                        OlaLoginActivity.this.B();
                    } catch (Throwable unused) {
                    }
                }

                @Override // chat.ola.vn.network.a.a.ai.a
                public void c_() {
                    try {
                        OlaLoginActivity.this.c(false);
                        i.a(OlaLoginActivity.this, R.string.dialog_title_fail, R.string.message_fail_recover_password, R.string.button_support, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.9.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                try {
                                    dialogInterface.dismiss();
                                    if (i != 0) {
                                        OlaLoginActivity.this.finish();
                                    } else {
                                        OlaLoginActivity.this.K();
                                    }
                                } catch (Throwable unused) {
                                }
                            }
                        });
                    } catch (Throwable unused) {
                    }
                }
            };
        }
        return this.E;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void K() {
        if (g.a(this) && n.b(this)) {
            chat.ola.vn.util.b.c(this, "1900588883");
        } else {
            i.b(this, getString(R.string.dialog_title_inform), getString(R.string.message_tip_to_call_cse, new Object[]{"1900588883"}));
        }
    }

    private void L() {
        i.a(this, R.string.dialog_title_forgot_password, R.string.dialog_forgot_password_content, R.string.string_start, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.11
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        OlaLoginActivity.this.E();
                    } catch (Throwable unused) {
                        return;
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    private void a(final chat.ola.vn.h.a aVar) {
        i.d(this, getString(R.string.message_inform), getString(R.string.message_delete_me_account_format, new Object[]{"@" + aVar.a.name}), getString(R.string.string_delete), getString(R.string.string_no), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.19
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        chat.ola.vn.h.b.a(OlaLoginActivity.this, aVar.a.name);
                    } catch (Throwable unused) {
                    }
                    try {
                        if (m.b(aVar.a.name, OlaLoginActivity.this.e.getText().toString())) {
                            OlaLoginActivity.this.e.setText("");
                            OlaLoginActivity.this.f.setText("");
                        }
                        if (m.b(aVar.a.name, e.a().i())) {
                            e.a().a((String) null);
                        }
                    } catch (Throwable unused2) {
                    }
                    try {
                        OlaLoginActivity.this.v.remove(aVar);
                    } catch (Throwable unused3) {
                    }
                    try {
                        if (OlaLoginActivity.this.v.size() > 0) {
                            chat.ola.vn.h.a aVar2 = (chat.ola.vn.h.a) OlaLoginActivity.this.v.get(0);
                            OlaLoginActivity.this.e.setText(aVar2.a.name);
                            OlaLoginActivity.this.f.setText(aVar2.b);
                            OlaLoginActivity.this.o.setVisibility(0);
                            OlaLoginActivity.this.l.setVisibility(8);
                        } else {
                            OlaLoginActivity.this.o.setVisibility(8);
                            OlaLoginActivity.this.l.setVisibility(0);
                        }
                    } catch (Throwable unused4) {
                    }
                    OlaLoginActivity.this.p.notifyDataSetChanged();
                }
                dialogInterface.dismiss();
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(final String str, final String str2, final String str3, final String str4) {
        try {
            if (OlaApplication.b.a(str, str2, str3, str4)) {
                return;
            }
            OlaApplication.b(new Runnable() { // from class: chat.ola.vn.activity.OlaLoginActivity.17
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        OlaLoginActivity.this.a(str, str2, str3, str4);
                    } catch (Throwable unused) {
                    }
                }
            }, 3000L);
        } catch (Throwable unused) {
            OlaApplication.b(new Runnable() { // from class: chat.ola.vn.activity.OlaLoginActivity.18
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        OlaLoginActivity.this.a(str, str2, str3, str4);
                    } catch (Throwable unused2) {
                    }
                }
            }, 3000L);
        }
    }

    @TargetApi(11)
    public static boolean a(Context context) {
        try {
            if (c.c() instanceof OlaLoginActivity) {
                return false;
            }
        } catch (Throwable unused) {
        }
        try {
            Intent intent = new Intent(context, (Class<?>) OlaLoginActivity.class);
            if (g.c()) {
                intent.addFlags(268468224);
            } else {
                intent.addFlags(67108864);
            }
            context.startActivity(intent);
            return true;
        } catch (Throwable unused2) {
            context.startActivity(new Intent(context, (Class<?>) OlaLoginActivity.class));
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        try {
            if (this.G == null) {
                this.G = new Runnable() { // from class: chat.ola.vn.activity.OlaLoginActivity.10
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            if (OlaApplication.b.h()) {
                                return;
                            }
                            i.a(OlaLoginActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout, R.string.button_support, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.10.1
                                @Override // android.content.DialogInterface.OnClickListener
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    if (i == 0) {
                                        try {
                                            OlaLoginActivity.this.K();
                                        } catch (Throwable unused) {
                                            return;
                                        }
                                    }
                                    dialogInterface.dismiss();
                                }
                            });
                            OlaLoginActivity.this.j.setVisibility(8);
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            long j = OlaApplication.b.g() ? 15000L : 60000L;
            OlaApplication.c(this.G);
            if (!z) {
                this.j.setVisibility(8);
            } else {
                this.j.setVisibility(0);
                OlaApplication.a(this.G, j);
            }
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"UnlocalizedSms"})
    private void f(String str) {
        if (m.a(str)) {
            return;
        }
        i.a(this, R.string.dialog_title_forgot_password, R.string.message_recommend_recovery_password, R.string.string_yes, R.string.string_no, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.6
            @Override // android.content.DialogInterface.OnClickListener
            public void onClick(DialogInterface dialogInterface, int i) {
                if (i == 0) {
                    try {
                        i.b(OlaLoginActivity.this, OlaLoginActivity.this.getString(R.string.dialog_title_forgot_password), OlaLoginActivity.this.getString(R.string.message_tip_to_recover_password, new Object[]{"1900588883"}), OlaLoginActivity.this.getString(R.string.string_close), (String) null, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.6.1
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface2, int i2) {
                                dialogInterface2.dismiss();
                            }
                        });
                    } catch (Throwable unused) {
                        return;
                    }
                }
                dialogInterface.dismiss();
            }
        });
    }

    /* JADX WARN: Code restructure failed: missing block: B:36:0x008a, code lost:
    
        r2 = r7.d;
     */
    /* JADX WARN: Removed duplicated region for block: B:57:0x0020 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:71:? A[RETURN, SYNTHETIC] */
    @android.annotation.SuppressLint({"DefaultLocale"})
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void B() {
        /*
            r9 = this;
            r0 = 0
            android.widget.EditText r1 = r9.e     // Catch: java.lang.Throwable -> L1a
            boolean r1 = r1.isFocused()     // Catch: java.lang.Throwable -> L1a
            if (r1 == 0) goto Lf
            android.widget.EditText r1 = r9.e     // Catch: java.lang.Throwable -> L1a
        Lb:
            chat.ola.vn.util.o.a(r9, r1, r0)     // Catch: java.lang.Throwable -> L1a
            goto L1a
        Lf:
            android.widget.EditText r1 = r9.f     // Catch: java.lang.Throwable -> L1a
            boolean r1 = r1.isFocused()     // Catch: java.lang.Throwable -> L1a
            if (r1 == 0) goto L1a
            android.widget.EditText r1 = r9.f     // Catch: java.lang.Throwable -> L1a
            goto Lb
        L1a:
            boolean r1 = r9.C()
            if (r1 == 0) goto La5
            chat.ola.vn.network.OlaNetworkService r1 = chat.ola.vn.OlaApplication.b     // Catch: java.lang.Throwable -> L2c
            boolean r1 = r1.h()     // Catch: java.lang.Throwable -> L2c
            if (r1 == 0) goto L2c
            r9.w()     // Catch: java.lang.Throwable -> L2c
            return
        L2c:
            r1 = 1
            r2 = 0
            android.widget.EditText r3 = r9.e     // Catch: java.lang.Throwable -> L8e
            android.text.Editable r3 = r3.getText()     // Catch: java.lang.Throwable -> L8e
            java.lang.String r3 = r3.toString()     // Catch: java.lang.Throwable -> L8e
            java.lang.String r3 = r3.trim()     // Catch: java.lang.Throwable -> L8e
            java.lang.String r3 = r3.toLowerCase()     // Catch: java.lang.Throwable -> L8e
            android.widget.EditText r4 = r9.f     // Catch: java.lang.Throwable -> L8c
            android.text.Editable r4 = r4.getText()     // Catch: java.lang.Throwable -> L8c
            java.lang.String r4 = r4.toString()     // Catch: java.lang.Throwable -> L8c
            android.view.View r5 = r9.A     // Catch: java.lang.Throwable -> L64
            int r5 = r5.getVisibility()     // Catch: java.lang.Throwable -> L64
            if (r5 != 0) goto L61
            android.widget.EditText r5 = r9.h     // Catch: java.lang.Throwable -> L64
            android.text.Editable r5 = r5.getText()     // Catch: java.lang.Throwable -> L64
            java.lang.String r5 = r5.toString()     // Catch: java.lang.Throwable -> L64
            java.lang.String r6 = chat.ola.vn.util.m.b(r5)     // Catch: java.lang.Throwable -> L65
            goto L62
        L61:
            r6 = r2
        L62:
            r5 = r6
            goto L65
        L64:
            r5 = r2
        L65:
            r9.c(r1)     // Catch: java.lang.Throwable -> L91
            java.util.List<chat.ola.vn.h.a> r6 = r9.v     // Catch: java.lang.Throwable -> L91
            if (r6 == 0) goto L91
            java.util.List<chat.ola.vn.h.a> r6 = r9.v     // Catch: java.lang.Throwable -> L91
            java.util.Iterator r6 = r6.iterator()     // Catch: java.lang.Throwable -> L91
        L72:
            boolean r7 = r6.hasNext()     // Catch: java.lang.Throwable -> L91
            if (r7 == 0) goto L91
            java.lang.Object r7 = r6.next()     // Catch: java.lang.Throwable -> L91
            chat.ola.vn.h.a r7 = (chat.ola.vn.h.a) r7     // Catch: java.lang.Throwable -> L91
            android.accounts.Account r8 = r7.a     // Catch: java.lang.Throwable -> L91
            java.lang.String r8 = r8.name     // Catch: java.lang.Throwable -> L91
            boolean r8 = chat.ola.vn.util.m.b(r8, r3)     // Catch: java.lang.Throwable -> L91
            if (r8 == 0) goto L72
            java.lang.String r6 = r7.d     // Catch: java.lang.Throwable -> L91
            r2 = r6
            goto L91
        L8c:
            r4 = r2
            goto L90
        L8e:
            r3 = r2
            r4 = r3
        L90:
            r5 = r4
        L91:
            java.lang.String r6 = r9.q     // Catch: java.lang.Throwable -> La2
            boolean r6 = chat.ola.vn.util.m.b(r6, r3)     // Catch: java.lang.Throwable -> La2
            if (r6 != 0) goto L9e
            r9.q = r3     // Catch: java.lang.Throwable -> La2
        L9b:
            r9.r = r0     // Catch: java.lang.Throwable -> La2
            goto La2
        L9e:
            int r0 = r9.r     // Catch: java.lang.Throwable -> La2
            int r0 = r0 + r1
            goto L9b
        La2:
            r9.a(r3, r4, r5, r2)
        La5:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.activity.OlaLoginActivity.B():void");
    }

    @SuppressLint({"DefaultLocale"})
    public boolean C() {
        try {
            String lowerCase = this.e.getText().toString().trim().toLowerCase();
            String string = this.f.getText().toString();
            if (m.a(lowerCase)) {
                if (this.k != null) {
                    this.e.startAnimation(this.k);
                }
                return false;
            }
            int iIndexOf = lowerCase.indexOf("@");
            if (iIndexOf > 0) {
                lowerCase = lowerCase.substring(0, iIndexOf);
                this.e.setText(lowerCase);
            }
            if (!m.a(lowerCase, 1)) {
                i.a(this, R.string.dialog_title_warning, R.string.message_invalid_username_format);
                return false;
            }
            if (m.c(string)) {
                if (this.k != null) {
                    this.f.startAnimation(this.k);
                }
                return false;
            }
            if (this.A.getVisibility() != 0 || !m.a(this.h.getText().toString())) {
                return true;
            }
            if (this.k != null) {
                this.h.startAnimation(this.k);
            }
            return false;
        } catch (Throwable th) {
            th.printStackTrace();
            return false;
        }
    }

    public void D() {
        Intent intent = new Intent(this, (Class<?>) AccountKitActivity.class);
        AccountKitConfiguration.AccountKitConfigurationBuilder accountKitConfigurationBuilder = new AccountKitConfiguration.AccountKitConfigurationBuilder(LoginType.PHONE, AccountKitActivity.ResponseType.TOKEN);
        accountKitConfigurationBuilder.setReadPhoneStateEnabled(true);
        accountKitConfigurationBuilder.setReceiveSMS(true);
        accountKitConfigurationBuilder.setFacebookNotificationsEnabled(true);
        intent.putExtra(AccountKitActivity.ACCOUNT_KIT_ACTIVITY_CONFIGURATION, accountKitConfigurationBuilder.build());
        startActivityForResult(intent, 4);
    }

    public void E() {
        Intent intent = new Intent(this, (Class<?>) AccountKitActivity.class);
        AccountKitConfiguration.AccountKitConfigurationBuilder accountKitConfigurationBuilder = new AccountKitConfiguration.AccountKitConfigurationBuilder(LoginType.PHONE, AccountKitActivity.ResponseType.TOKEN);
        accountKitConfigurationBuilder.setReadPhoneStateEnabled(true);
        accountKitConfigurationBuilder.setReceiveSMS(true);
        accountKitConfigurationBuilder.setFacebookNotificationsEnabled(true);
        intent.putExtra(AccountKitActivity.ACCOUNT_KIT_ACTIVITY_CONFIGURATION, accountKitConfigurationBuilder.build());
        startActivityForResult(intent, 6);
    }

    @Override // chat.ola.vn.c
    protected void a() {
        if (h.g()) {
            h.q = e.a().h();
            OlaBottomTabActivity.a(this, h.q, (Bundle) null);
            finish();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr) {
        String strTrim;
        try {
            strTrim = this.e.getText().toString().trim();
        } catch (Throwable unused) {
            strTrim = null;
        }
        try {
            if (i == 0) {
                if (m.a(str)) {
                    str = getString(R.string.message_fail_unknow_reason);
                }
                i.b(this, getString(R.string.dialog_title_fail), str, getString(R.string.button_support), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.5
                    @Override // android.content.DialogInterface.OnClickListener
                    public void onClick(DialogInterface dialogInterface, int i2) {
                        if (i2 == 0) {
                            try {
                                OlaLoginActivity.this.K();
                            } catch (Throwable unused2) {
                                return;
                            }
                        }
                        dialogInterface.dismiss();
                    }
                });
            } else if (i != 2) {
                if (i != 7) {
                    if (i == 10) {
                        if (this.r >= 3) {
                            this.r = 3;
                            if (!m.a(strTrim)) {
                                f(strTrim);
                            }
                        } else {
                            j.c(this, R.string.message_connection_login_fail_password);
                            if (this.k != null) {
                                this.f.startAnimation(this.k);
                            }
                            this.f.requestFocus();
                            this.f.selectAll();
                        }
                    }
                } else if (this.r >= 3) {
                    this.r = 3;
                    f(strTrim);
                } else {
                    if (this.k != null) {
                        this.e.startAnimation(this.k);
                    }
                    this.e.requestFocus();
                    this.e.selectAll();
                    if (this.k != null) {
                        this.f.startAnimation(this.k);
                    }
                    j.c(this, R.string.message_connection_login_fail_usernameorpassword);
                }
            } else if (this.A.getVisibility() == 0) {
                if (m.a(str)) {
                    this.i.setText(R.string.string_require_captcha_dialog_message);
                } else {
                    this.i.setText(str);
                }
                this.h.requestFocus();
                this.h.setText("");
                if (this.k != null) {
                    this.h.startAnimation(this.k);
                }
                j.c(this, R.string.string_wrong_captcha_dialog_message);
            }
            c(false);
            if (bArr == null) {
                this.h.setText("");
                this.g.setImageBitmap(null);
                this.A.setVisibility(8);
            } else {
                Bitmap bitmapDecodeByteArray = BitmapFactory.decodeByteArray(bArr, 0, bArr.length);
                this.h.setText("");
                this.g.setImageBitmap(bitmapDecodeByteArray);
                this.A.setVisibility(0);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        c(false);
        if (s == 59 && i != 7 && i != 10 && i != 23 && i != 41) {
            switch (i) {
                case 0:
                case 2:
                    break;
                case 1:
                    i.a(this, R.string.dialog_title_fail, R.string.message_connection_lost_network_title, R.string.button_support, R.string.string_close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.3
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            if (i2 == 0) {
                                try {
                                    OlaLoginActivity.this.K();
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    break;
                default:
                    i.c(this, getString(R.string.dialog_title_fail), getString(R.string.message_login_fail_with_error_code) + ": " + i, getString(R.string.button_support), getString(R.string.string_close), new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.4
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            if (i2 == 0) {
                                try {
                                    OlaLoginActivity.this.K();
                                } catch (Throwable unused) {
                                    return;
                                }
                            }
                            dialogInterface.dismiss();
                        }
                    });
                    break;
            }
            return;
        }
        super.a(i, str, bArr, dVarArr, s);
    }

    @Override // chat.ola.vn.network.a.a.p.a
    public void a(String str, List<String> list) {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void b(String str, byte[] bArr) {
        if (bArr != null) {
            if (m.a(str)) {
                this.i.setText(R.string.string_require_captcha_dialog_message);
            } else {
                this.i.setText(str);
            }
            this.g.setImageBitmap(BitmapFactory.decodeByteArray(bArr, 0, bArr.length));
            this.A.setVisibility(0);
            this.h.requestFocus();
            this.h.setText("");
            if (this.k != null) {
                this.h.startAnimation(this.k);
            }
            j.c(this, R.string.string_require_captcha_dialog_message);
        } else {
            this.h.setText("");
            this.g.setImageBitmap(null);
            this.A.setVisibility(8);
        }
        c(false);
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void o() {
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        String stringExtra;
        EditText editText;
        try {
            if (i == 4) {
                AccountKitLoginResult accountKitLoginResult = (AccountKitLoginResult) intent.getParcelableExtra(AccountKitLoginResult.RESULT_KEY);
                if (accountKitLoginResult.getError() == null) {
                    if (accountKitLoginResult.wasCancelled()) {
                        return;
                    }
                    if (accountKitLoginResult.getAccessToken() != null) {
                        String token = accountKitLoginResult.getAccessToken().getToken();
                        if (m.a(token)) {
                            return;
                        }
                        try {
                            OlaApplication.b.a(token);
                            OlaApplication.b.a(token, I());
                            return;
                        } catch (Throwable unused) {
                            return;
                        }
                    }
                }
                OlaSignUpActivity.a((c) this);
                return;
            }
            if (i == 6) {
                AccountKitLoginResult accountKitLoginResult2 = (AccountKitLoginResult) intent.getParcelableExtra(AccountKitLoginResult.RESULT_KEY);
                if (accountKitLoginResult2.getError() != null || accountKitLoginResult2.wasCancelled() || accountKitLoginResult2.getAccessToken() == null) {
                    return;
                }
                String token2 = accountKitLoginResult2.getAccessToken().getToken();
                if (m.a(token2)) {
                    return;
                }
                c(true);
                OlaApplication.b.a(token2, H());
                return;
            }
            if (i == 7) {
                if (i2 != -1) {
                    return;
                }
                String stringExtra2 = intent.getStringExtra("_username");
                stringExtra = intent.getStringExtra("_pass");
                this.e.setText(stringExtra2);
                editText = this.f;
            } else {
                if (i2 != -1 || i != 1) {
                    return;
                }
                String stringExtra3 = intent.getStringExtra("_username");
                stringExtra = intent.getStringExtra("_pass");
                this.e.setText(stringExtra3);
                editText = this.f;
            }
            editText.setText(stringExtra);
            B();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        finish();
    }

    @Override // android.view.View.OnClickListener
    @SuppressLint({"NewApi"})
    public void onClick(View view) {
        EditText editText;
        try {
            switch (view.getId()) {
                case R.id.btnClearPassword /* 2131296443 */:
                    this.f.setText("");
                    this.f.requestFocus();
                    editText = this.f;
                    o.a((Context) this, (View) editText, true);
                    break;
                case R.id.btnClearUserName /* 2131296445 */:
                    this.e.setText("");
                    this.e.requestFocus();
                    editText = this.e;
                    o.a((Context) this, (View) editText, true);
                    break;
                case R.id.btnLogin /* 2131296477 */:
                    try {
                        String lowerCase = this.e.getText().toString().trim().toLowerCase();
                        String string = this.f.getText().toString();
                        if (m.a(lowerCase) && m.a(string)) {
                            G();
                        } else {
                            B();
                        }
                    } catch (Throwable unused) {
                        B();
                        return;
                    }
                    break;
                case R.id.btnLoginFacebook /* 2131296478 */:
                    if (AccessToken.getCurrentAccessToken() == null || AccessToken.getCurrentAccessToken().isExpired()) {
                        OlaFacebookActivity.a(this, (Bundle) null, new OlaFacebookActivity.a() { // from class: chat.ola.vn.activity.OlaLoginActivity.2
                            @Override // chat.ola.vn.activity.OlaFacebookActivity.a
                            public void a() {
                                OlaLoginActivity.this.c(true);
                                b.a(AccessToken.getCurrentAccessToken().getToken(), OlaLoginActivity.this.F);
                            }
                        });
                    } else {
                        b.a(AccessToken.getCurrentAccessToken().getToken(), this.F);
                    }
                    break;
                case R.id.btnRegisterWhite /* 2131296530 */:
                    G();
                    break;
                case R.id.forgotPasswordTextView /* 2131296806 */:
                    L();
                    break;
                case R.id.imgAccountRemoveAction /* 2131296858 */:
                    a((chat.ola.vn.h.a) view.getTag());
                    break;
                case R.id.imgIcon /* 2131296892 */:
                case R.id.txtAccountName /* 2131297510 */:
                    chat.ola.vn.h.a aVar = (chat.ola.vn.h.a) view.getTag();
                    this.e.setText(aVar.a.name);
                    this.f.setText(aVar.b);
                    if (!m.a(aVar.a.name) && !m.a(aVar.b)) {
                        B();
                        break;
                    }
                    break;
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            int iB = e.a().b();
            if (iB > 0 && iB <= 88) {
                chat.ola.vn.h.b.g();
            }
        } catch (Throwable unused) {
        }
        try {
            if (!e.a().m()) {
                Locale[] availableLocales = Locale.getAvailableLocales();
                boolean z = true;
                if (availableLocales != null && availableLocales.length > 0) {
                    int length = availableLocales.length - 1;
                    while (true) {
                        if (length < 0) {
                            break;
                        }
                        String language = availableLocales[length].getLanguage();
                        if (language.indexOf(95) > 0) {
                            language = m.e(language, "_")[0];
                        }
                        if (m.b(language, "vi")) {
                            x.b("default");
                            z = false;
                            break;
                        }
                        length--;
                    }
                }
                if (z) {
                    OlaLanguageChooser.a(this);
                    finish();
                    return;
                }
            }
        } catch (Throwable th) {
            x.b("default");
            th.printStackTrace();
        }
        try {
            overridePendingTransition(0, 0);
        } catch (Throwable unused2) {
        }
        try {
            try {
                setContentView(R.layout.login_view_layout);
                try {
                    findViewById(R.id.olaLoginPageFrameLayout).setOnTouchListener(new View.OnTouchListener() { // from class: chat.ola.vn.activity.OlaLoginActivity.12
                        @Override // android.view.View.OnTouchListener
                        public boolean onTouch(View view, MotionEvent motionEvent) {
                            OlaLoginActivity olaLoginActivity;
                            EditText editText;
                            try {
                                if (view.getId() == R.id.olaLoginPageFrameLayout) {
                                    if (OlaLoginActivity.this.e.isFocused()) {
                                        olaLoginActivity = OlaLoginActivity.this;
                                        editText = OlaLoginActivity.this.e;
                                    } else if (OlaLoginActivity.this.f.isFocused()) {
                                        olaLoginActivity = OlaLoginActivity.this;
                                        editText = OlaLoginActivity.this.f;
                                    } else {
                                        olaLoginActivity = OlaLoginActivity.this;
                                        editText = OlaLoginActivity.this.h;
                                    }
                                    o.a((Context) olaLoginActivity, (View) editText, false);
                                    return false;
                                }
                            } catch (Throwable unused3) {
                            }
                            return false;
                        }
                    });
                } catch (Throwable unused3) {
                }
                this.k = AnimationUtils.loadAnimation(this, R.anim.shake);
                F();
                if (bolts.c.a(this, getIntent()) != null) {
                    f.a().c("Launch From AppLink");
                } else {
                    AppLinkData.fetchDeferredAppLinkData(this, new AppLinkData.CompletionHandler() { // from class: chat.ola.vn.activity.OlaLoginActivity.13
                        @Override // com.facebook.applinks.AppLinkData.CompletionHandler
                        public void onDeferredAppLinkDataFetched(AppLinkData appLinkData) {
                            try {
                                f.a().c("Launch From AppLink");
                            } catch (Throwable unused4) {
                            }
                        }
                    });
                }
            } catch (Throwable unused4) {
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
            setContentView(R.layout.login_view_layout);
            F();
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void q() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void s() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void t() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void w() {
        c(false);
        a(OlaBottomTabActivity.class);
        finish();
    }
}
