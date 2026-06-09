package chat.ola.vn.signup.fb;

import android.annotation.SuppressLint;
import android.database.Cursor;
import android.os.Bundle;
import android.provider.ContactsContract;
import android.support.v4.internal.view.SupportMenu;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.activity.OlaLoginActivity;
import chat.ola.vn.e;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.f;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import com.facebook.AccessToken;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.mg.ola.common.d.g;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class d extends b implements View.OnClickListener {
    static String a = null;
    static String b = null;
    static String c = null;
    static long d = 0;
    static byte e = 2;
    private EditText f;
    private List<String> g;
    private TextView h;
    private View i;
    private Animation j;
    private View k;
    private View l;
    private Runnable m = null;
    private short n = -1;

    @SuppressLint({"InlinedApi", "NewApi"})
    private chat.ola.vn.network.c o = new chat.ola.vn.network.c() { // from class: chat.ola.vn.signup.fb.d.3
        @Override // chat.ola.vn.network.c
        public void a() {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str) {
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, String str2, String str3) {
            try {
                f.a().c("Reg nick by FB OK");
                OlaTutorialActivity.f = true;
            } catch (Throwable unused) {
            }
            try {
                if (OlaApplication.b != null) {
                    h.d(str);
                    h.b(str2);
                    h.c(str3);
                    e.a().a(str);
                    e.a().b(str3);
                    chat.ola.vn.h.b.a(OlaApplication.a(), str, str2, str3, null);
                    OlaApplication.b.b(str);
                }
                OlaTutorialActivity.e = false;
                OlaBottomTabActivity.g = true;
                d.this.v();
            } catch (Throwable unused2) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, boolean z) {
            try {
                if (z) {
                    d.this.h.setVisibility(0);
                    d.this.h.setTextColor(chat.ola.vn.f.k);
                    d.this.h.setText(d.this.getString(R.string.message_fail_username_exist));
                    d.this.k.setVisibility(4);
                    d.this.l.setVisibility(4);
                    return;
                }
                d.this.h.setTextColor(chat.ola.vn.f.H);
                d.this.h.setVisibility(0);
                d.this.h.setText(d.this.getString(R.string.message_username_available));
                d.this.k.setVisibility(4);
                d.this.l.setVisibility(0);
            } catch (Throwable unused) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void a(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void a(short s) {
            d.this.e().c(false);
            try {
                if (s == 0) {
                    j.c(d.this.e(), d.this.getString(R.string.message_fail_unknow_reason));
                    OlaLoginActivity.a(d.this.e());
                } else {
                    if (s == 3) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_DUPLICATED_USERNAME");
                        } catch (Throwable unused) {
                        }
                        d.this.h.setVisibility(0);
                        d.this.h.setTextColor(chat.ola.vn.f.k);
                        d.this.h.setText(d.this.getString(R.string.message_fail_username_exist));
                        d.this.k.setVisibility(4);
                        d.this.l.setVisibility(4);
                        return;
                    }
                    if (s == 7) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INVALID_USERNAME_PASSWORD");
                        } catch (Throwable unused2) {
                        }
                        j.c(d.this.e(), d.this.getString(R.string.message_fail_username_or_password));
                        OlaLoginActivity.a(d.this.e());
                    } else if (s == 10) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INVALID_PASSWORD");
                        } catch (Throwable unused3) {
                        }
                        j.c(d.this.e(), d.this.getString(R.string.message_fail_password_invalid));
                        OlaLoginActivity.a(d.this.e());
                    } else if (s == 22) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INACTIVATED_ACCOUNT");
                        } catch (Throwable unused4) {
                        }
                        j.c(d.this.e(), d.this.getString(R.string.string_facebook_account_invalid));
                        OlaLoginActivity.a(d.this.e());
                    } else {
                        if (s != 32) {
                            return;
                        }
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_LOGIN_SERVER_BUSY");
                        } catch (Throwable unused5) {
                        }
                        j.c(d.this.e(), d.this.getString(R.string.message_server_busy));
                        OlaLoginActivity.a(d.this.e());
                    }
                }
                d.this.v();
            } catch (Throwable unused6) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void b() {
            d.this.e().c(false);
        }

        @Override // chat.ola.vn.network.c
        public void b(String str, String str2, String str3) {
        }

        @Override // chat.ola.vn.network.c
        public void b(List<String> list) {
            if (list == null) {
                list = new ArrayList<>();
            }
            try {
                if (list.size() == 0 && g.f()) {
                    Cursor cursorQuery = d.this.e().getApplication().getContentResolver().query(ContactsContract.Profile.CONTENT_URI, null, null, null, null);
                    cursorQuery.moveToFirst();
                    String string = cursorQuery.getString(cursorQuery.getColumnIndex("display_name"));
                    if (!m.a(string)) {
                        String strR = m.r(string);
                        if (!m.a(strR)) {
                            list.add(strR);
                        }
                    }
                    cursorQuery.close();
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            try {
                if (d.this.g == null) {
                    d.this.g = new ArrayList(list);
                }
                if (d.this.g.size() > 0) {
                    String strTrim = null;
                    try {
                        String string2 = d.this.f.getText().toString();
                        try {
                            strTrim = string2.trim();
                        } catch (Throwable unused) {
                            strTrim = string2;
                        }
                    } catch (Throwable unused2) {
                    }
                    if (m.a(strTrim)) {
                        d.this.f.setText((CharSequence) d.this.g.get(0));
                        d.this.f.setSelection(d.this.f.getText().length());
                    }
                }
            } catch (Throwable th2) {
                th2.printStackTrace();
            }
            d.this.y();
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

    /* JADX INFO: Access modifiers changed from: private */
    public void A() {
        if (this.f.getText().length() <= 6) {
            this.f.requestFocus();
            this.f.startAnimation(this.j);
            this.h.setTextColor(chat.ola.vn.f.k);
            this.h.setVisibility(0);
            this.h.setText(getString(R.string.message_fail_short_username));
            return;
        }
        b = this.f.getText().toString().toLowerCase(Locale.US);
        if (!m.a((CharSequence) b)) {
            this.h.setTextColor(chat.ola.vn.f.k);
            this.h.setVisibility(0);
            this.h.setText(getString(R.string.message_fail_username_invalid));
            i.b(getActivity(), getString(R.string.dialog_title_inform), this.h.getText().toString());
            return;
        }
        e().c(true);
        StringBuilder sb = new StringBuilder();
        sb.append("fb:");
        sb.append(chat.ola.vn.j.a.a("" + System.currentTimeMillis()));
        chat.ola.vn.l.b.a(a, b, sb.toString(), c, this.o);
    }

    private GraphRequest B() {
        return GraphRequest.newMeRequest(AccessToken.getCurrentAccessToken(), new GraphRequest.GraphJSONObjectCallback() { // from class: chat.ola.vn.signup.fb.d.6
            @Override // com.facebook.GraphRequest.GraphJSONObjectCallback
            public void onCompleted(JSONObject jSONObject, GraphResponse graphResponse) {
                if (jSONObject != null) {
                    try {
                        String string = jSONObject.getString("gender");
                        d.e = m.b(string, "male") ? (byte) 1 : m.b(string, "female") ? (byte) 0 : (byte) 2;
                    } catch (Throwable unused) {
                    }
                    try {
                        d.d = new SimpleDateFormat("MM/dd/yyyy", Locale.US).parse(jSONObject.getString("birthday").toString()).getTime();
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                }
            }
        });
    }

    private void C() {
        GraphRequest.executeBatchAsync(B());
    }

    private void a(View view) {
        try {
            this.f = (EditText) view.findViewById(R.id.txtAccountId);
            this.f.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.signup.fb.d.1
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        if (d.this.m == null) {
                            d.this.m = new Runnable() { // from class: chat.ola.vn.signup.fb.d.1.1
                                @Override // java.lang.Runnable
                                public void run() {
                                    try {
                                        String string = d.this.f.getText().toString();
                                        try {
                                            string = string.trim();
                                        } catch (Throwable unused) {
                                        }
                                        if (string.length() >= 6) {
                                            d.this.h.setVisibility(4);
                                            d.this.x();
                                        } else if (string.length() > 0) {
                                            d.this.h.setTextColor(chat.ola.vn.f.k);
                                            d.this.h.setVisibility(0);
                                            d.this.h.setText(d.this.getString(R.string.message_fail_short_username));
                                        }
                                    } catch (Throwable unused2) {
                                    }
                                }
                            };
                        }
                        OlaApplication.c(d.this.m);
                        if (editable.toString().length() >= 6) {
                            d.this.k.setVisibility(4);
                            d.this.l.setVisibility(0);
                            OlaApplication.a(d.this.m, 1000L);
                        } else {
                            d.this.h.setVisibility(4);
                            d.this.k.setVisibility(0);
                            d.this.l.setVisibility(4);
                        }
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
            this.f.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.fb.d.2
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 6) {
                        return false;
                    }
                    try {
                        d.this.A();
                        return false;
                    } catch (Throwable unused) {
                        return false;
                    }
                }
            });
            this.h = (TextView) view.findViewById(R.id.txtAccountErrorInfo);
            this.k = view.findViewById(R.id.txtAccountTipTextView);
            this.l = view.findViewById(R.id.nextStepButton);
            this.l.setOnClickListener(this);
            this.i = view.findViewById(R.id.btnAccountIdMenu);
            this.i.setOnClickListener(this);
            view.findViewById(R.id.alreadyHaveAccountTextView).setOnClickListener(this);
            C();
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void x() {
        try {
            String string = this.f.getText().toString();
            try {
                string = string.trim();
            } catch (Throwable unused) {
            }
            if (!m.a(string) && string.length() >= 6) {
                chat.ola.vn.l.b.c(a, string, this.o);
                return;
            }
            this.h.setVisibility(0);
            this.h.setTextColor(SupportMenu.CATEGORY_MASK);
            this.h.setText(getString(R.string.message_fail_short_username));
        } catch (Throwable unused2) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y() {
        View view;
        int i;
        if (this.g == null || this.g.size() <= 1) {
            view = this.i;
            i = 8;
        } else {
            view = this.i;
            i = 0;
        }
        view.setVisibility(i);
    }

    private void z() {
        if (AccessToken.getCurrentAccessToken() == null || AccessToken.getCurrentAccessToken().isExpired() || a == null) {
            return;
        }
        chat.ola.vn.l.b.c(a, this.o);
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        try {
            if (this.f != null && !m.a(b)) {
                this.f.setText(b);
            }
            if (this.n != 3) {
                return;
            }
            this.h.setVisibility(0);
            this.h.setTextColor(chat.ola.vn.f.k);
            this.h.setText(getString(R.string.message_fail_username_exist));
            this.k.setVisibility(4);
            this.l.setVisibility(4);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.signup.fb.b
    public b c() {
        return null;
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_register_account);
    }

    @Override // chat.ola.vn.signup.fb.b
    public String h() {
        try {
            return getString(R.string.string_finish);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.signup.fb.b
    public void j() {
        try {
            A();
        } catch (Throwable unused) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:13:0x0037 A[Catch: Throwable -> 0x006d, TryCatch #0 {Throwable -> 0x006d, blocks: (B:2:0x0000, B:17:0x0063, B:11:0x0019, B:12:0x001d, B:13:0x0037, B:15:0x0047, B:16:0x0060), top: B:20:0x0000 }] */
    @Override // android.view.View.OnClickListener
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void onClick(android.view.View r7) {
        /*
            r6 = this;
            int r7 = r7.getId()     // Catch: java.lang.Throwable -> L6d
            r0 = 2131296358(0x7f090066, float:1.821063E38)
            if (r7 == r0) goto L37
            r0 = 2131296411(0x7f09009b, float:1.8210738E38)
            if (r7 == r0) goto L1d
            r0 = 2131296446(0x7f0900be, float:1.8210809E38)
            if (r7 == r0) goto L37
            r0 = 2131297139(0x7f090373, float:1.8212214E38)
            if (r7 == r0) goto L19
            goto L63
        L19:
            r6.A()     // Catch: java.lang.Throwable -> L6d
            goto L63
        L1d:
            chat.ola.vn.i.m r7 = new chat.ola.vn.i.m     // Catch: java.lang.Throwable -> L6d
            chat.ola.vn.signup.fb.OlaSignUpByFacebookActivity r0 = r6.e()     // Catch: java.lang.Throwable -> L6d
            r7.<init>(r0)     // Catch: java.lang.Throwable -> L6d
            java.util.List<java.lang.String> r0 = r6.g     // Catch: java.lang.Throwable -> L6d
            r7.a(r0)     // Catch: java.lang.Throwable -> L6d
            chat.ola.vn.signup.fb.d$5 r0 = new chat.ola.vn.signup.fb.d$5     // Catch: java.lang.Throwable -> L6d
            r0.<init>()     // Catch: java.lang.Throwable -> L6d
            r7.a(r0)     // Catch: java.lang.Throwable -> L6d
            r7.show()     // Catch: java.lang.Throwable -> L6d
            goto L63
        L37:
            android.widget.EditText r7 = r6.f     // Catch: java.lang.Throwable -> L6d
            android.text.Editable r7 = r7.getText()     // Catch: java.lang.Throwable -> L6d
            java.lang.String r7 = r7.toString()     // Catch: java.lang.Throwable -> L6d
            boolean r7 = chat.ola.vn.util.m.a(r7)     // Catch: java.lang.Throwable -> L6d
            if (r7 != 0) goto L60
            android.support.v4.app.FragmentActivity r0 = r6.getActivity()     // Catch: java.lang.Throwable -> L6d
            r1 = 2131690527(0x7f0f041f, float:1.90101E38)
            r2 = 2131690528(0x7f0f0420, float:1.9010102E38)
            r3 = 2131690639(0x7f0f048f, float:1.9010327E38)
            r4 = 2131690824(0x7f0f0548, float:1.9010703E38)
            chat.ola.vn.signup.fb.d$4 r5 = new chat.ola.vn.signup.fb.d$4     // Catch: java.lang.Throwable -> L6d
            r5.<init>()     // Catch: java.lang.Throwable -> L6d
            chat.ola.vn.i.i.a(r0, r1, r2, r3, r4, r5)     // Catch: java.lang.Throwable -> L6d
            goto L63
        L60:
            r6.v()     // Catch: java.lang.Throwable -> L6d
        L63:
            chat.ola.vn.signup.fb.OlaSignUpByFacebookActivity r7 = r6.e()     // Catch: java.lang.Throwable -> L6d
            android.widget.EditText r0 = r6.f     // Catch: java.lang.Throwable -> L6d
            r1 = 0
            chat.ola.vn.util.o.a(r7, r0, r1)     // Catch: java.lang.Throwable -> L6d
        L6d:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.signup.fb.d.onClick(android.view.View):void");
    }

    @Override // chat.ola.vn.m.f, android.support.v4.app.Fragment
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            this.n = getArguments().getShort("_result", (short) -1);
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.register_ola_nick_by_fb_username, (ViewGroup) null);
        try {
            this.n = getArguments().getShort("_result", (short) -1);
        } catch (Throwable unused) {
        }
        a(viewInflate);
        z();
        this.j = AnimationUtils.loadAnimation(e(), R.anim.shake);
        return viewInflate;
    }
}
