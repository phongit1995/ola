package chat.ola.vn.signup;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.f;
import chat.ola.vn.i.i;
import chat.ola.vn.p.j;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c extends a implements View.OnClickListener {
    public static String a;
    private EditText b;
    private EditText c;
    private TextView d;
    private Animation e;
    private View f;
    private List<String> h;
    private Runnable g = null;
    private int i = 0;

    static /* synthetic */ int e(c cVar) {
        int i = cVar.i + 1;
        cVar.i = i;
        return i;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y() {
        try {
            String string = this.b.getText().toString();
            try {
                string = string.trim();
            } catch (Throwable unused) {
            }
            if (!m.a(string) && string.length() >= 6) {
                if (!Character.isLetter(string.charAt(0))) {
                    this.d.setVisibility(0);
                    this.d.setTextColor(f.k);
                    this.d.setText(getString(R.string.message_fail_username_not_start_by_non_letter));
                    return;
                } else {
                    if (m.a((CharSequence) string)) {
                        OlaApplication.b.a(string, new j() { // from class: chat.ola.vn.signup.c.4
                            @Override // chat.ola.vn.p.j
                            public void a(String str, boolean z) {
                                TextView textView;
                                String string2;
                                try {
                                    if (z) {
                                        c.this.d.setTextColor(f.H);
                                        c.this.d.setVisibility(0);
                                        textView = c.this.d;
                                        string2 = c.this.getString(R.string.message_username_available);
                                    } else {
                                        c.this.d.setVisibility(0);
                                        c.this.d.setTextColor(f.k);
                                        textView = c.this.d;
                                        string2 = c.this.getString(R.string.message_fail_username_exist);
                                    }
                                    textView.setText(string2);
                                } catch (Throwable unused2) {
                                }
                            }
                        });
                        return;
                    }
                    this.d.setVisibility(0);
                    this.d.setTextColor(f.k);
                    this.d.setText(getString(R.string.message_fail_username_invalid));
                    return;
                }
            }
            this.d.setVisibility(0);
            this.d.setTextColor(f.k);
            this.d.setText(getString(R.string.message_fail_short_username));
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        TextView textView;
        String string;
        try {
            if (i == 3) {
                this.b.requestFocus();
                this.b.startAnimation(this.e);
                this.d.setVisibility(0);
                this.d.setTextColor(f.k);
                textView = this.d;
                string = getString(R.string.message_fail_username_exist);
            } else {
                if (i != 7) {
                    if (i != 10) {
                        return;
                    }
                    this.c.requestFocus();
                    this.c.startAnimation(this.e);
                    chat.ola.vn.util.j.d(getActivity(), R.string.message_fail_password_invalid);
                    return;
                }
                this.b.requestFocus();
                this.b.startAnimation(this.e);
                this.d.setVisibility(0);
                this.d.setTextColor(f.k);
                textView = this.d;
                string = getString(R.string.message_fail_username_invalid);
            }
            textView.setText(string);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.signup.a
    public a c() {
        try {
            return (d) Fragment.instantiate(getActivity(), d.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.signup.a
    public String e() {
        return OlaApplication.a(R.string.string_cancel);
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_register_account);
    }

    @Override // chat.ola.vn.signup.a
    public String h() {
        return OlaApplication.a(R.string.string_next);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            if (view.getId() != R.id.nextStepButton) {
                return;
            }
            x();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    @SuppressLint({"NewApi"})
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.ola_sign_up_step1, (ViewGroup) null);
        this.d = (TextView) viewInflate.findViewById(R.id.txtAccountErrorInfo);
        this.b = (EditText) viewInflate.findViewById(R.id.txtNickOla);
        this.c = (EditText) viewInflate.findViewById(R.id.txtPassword);
        this.b.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.signup.c.1
            @Override // android.text.TextWatcher
            public void afterTextChanged(Editable editable) {
                try {
                    c.this.d.setVisibility(4);
                    if (c.this.g == null) {
                        c.this.g = new Runnable() { // from class: chat.ola.vn.signup.c.1.1
                            @Override // java.lang.Runnable
                            public void run() {
                                try {
                                    String string = c.this.b.getText().toString();
                                    try {
                                        string = string.trim();
                                    } catch (Throwable unused) {
                                    }
                                    if (string.length() >= 6) {
                                        c.this.d.setVisibility(4);
                                        c.this.y();
                                    } else if (string.length() > 0) {
                                        c.this.d.setTextColor(f.k);
                                        c.this.d.setVisibility(0);
                                        c.this.d.setText(c.this.getString(R.string.message_fail_short_username));
                                    }
                                } catch (Throwable unused2) {
                                }
                            }
                        };
                    }
                    OlaApplication.c(c.this.g);
                    OlaApplication.a(c.this.g, 1000L);
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
            if (m.a(a)) {
                this.h = OlaSignUpActivity.a((Context) j());
                if (this.h != null && this.h.size() > 0) {
                    this.i = 0;
                    this.b.setText("");
                    j().c(true);
                    int size = this.h.size();
                    for (int i = 0; i < size; i++) {
                        OlaApplication.b.a(this.h.get(i), new j() { // from class: chat.ola.vn.signup.c.2
                            @Override // chat.ola.vn.p.j
                            public void a(String str, boolean z) {
                                c.e(c.this);
                                if (z && m.a(c.this.b.getText().toString())) {
                                    c.this.j().c(false);
                                    c.this.b.setText(str);
                                    c.this.c.requestFocus();
                                } else if (c.this.i >= c.this.h.size()) {
                                    c.this.j().c(false);
                                }
                            }
                        });
                    }
                }
            } else {
                j().c(false);
                this.b.setText(a);
                this.c.requestFocus();
                a = null;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        this.c.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.c.3
            /* JADX WARN: Removed duplicated region for block: B:17:? A[RETURN, SYNTHETIC] */
            @Override // android.widget.TextView.OnEditorActionListener
            /*
                Code decompiled incorrectly, please refer to instructions dump.
                To view partially-correct add '--show-bad-code' argument
            */
            public boolean onEditorAction(android.widget.TextView r1, int r2, android.view.KeyEvent r3) {
                /*
                    r0 = this;
                    if (r3 == 0) goto Ld
                    int r1 = r3.getKeyCode()     // Catch: java.lang.Throwable -> Lb
                    r3 = 66
                    if (r1 == r3) goto L10
                    goto Ld
                Lb:
                    r1 = move-exception
                    goto L16
                Ld:
                    r1 = 6
                    if (r2 != r1) goto L19
                L10:
                    chat.ola.vn.signup.c r1 = chat.ola.vn.signup.c.this     // Catch: java.lang.Throwable -> Lb
                    r1.x()     // Catch: java.lang.Throwable -> Lb
                    goto L19
                L16:
                    r1.printStackTrace()
                L19:
                    r1 = 0
                    return r1
                */
                throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.signup.c.AnonymousClass3.onEditorAction(android.widget.TextView, int, android.view.KeyEvent):boolean");
            }
        });
        this.e = AnimationUtils.loadAnimation(j(), R.anim.shake);
        this.f = viewInflate.findViewById(R.id.nextStepButton);
        this.f.setOnClickListener(this);
        return viewInflate;
    }

    @Override // chat.ola.vn.signup.a
    public void x() {
        try {
            String string = this.b.getText().toString();
            final String string2 = this.c.getText().toString();
            try {
                string = string.trim();
            } catch (Throwable unused) {
            }
            if (!m.a(string) && string.length() >= 6) {
                if (!Character.isLetter(string.charAt(0))) {
                    this.d.setVisibility(0);
                    this.d.setTextColor(f.k);
                    this.d.setText(getString(R.string.message_fail_username_not_start_by_non_letter));
                    return;
                }
                if (!m.a(string2) && string2.length() >= 6) {
                    if (!m.a((CharSequence) string)) {
                        this.d.setVisibility(0);
                        this.d.setTextColor(f.k);
                        this.d.setText(getString(R.string.message_fail_username_invalid));
                        i.b(getActivity(), getString(R.string.dialog_title_inform), this.d.getText().toString());
                        return;
                    }
                    j().c(true);
                    if (OlaSignUpActivity.k == null && OlaSignUpActivity.m == null) {
                        OlaApplication.b.i((short) 0);
                    }
                    OlaApplication.b.a(string, new j() { // from class: chat.ola.vn.signup.c.5
                        @Override // chat.ola.vn.p.j
                        public void a(String str, boolean z) {
                            try {
                                c.this.j().c(false);
                                if (!z) {
                                    c.this.b.startAnimation(c.this.e);
                                    c.this.d.setVisibility(0);
                                    c.this.d.setTextColor(f.k);
                                    c.this.d.setText(c.this.getString(R.string.message_fail_username_exist));
                                    return;
                                }
                                c.this.d.setTextColor(f.H);
                                c.this.d.setVisibility(0);
                                c.this.d.setText(c.this.getString(R.string.message_username_available));
                                OlaSignUpActivity.e = str;
                                OlaSignUpActivity.f = string2;
                                c.this.j().B();
                            } catch (Throwable unused2) {
                            }
                        }
                    });
                    return;
                }
                this.c.requestFocus();
                this.c.startAnimation(this.e);
                chat.ola.vn.util.j.d(getActivity(), R.string.message_fail_short_password);
                return;
            }
            this.d.setVisibility(0);
            this.d.setTextColor(f.k);
            this.d.setText(getString(R.string.message_fail_short_username));
        } catch (Throwable unused2) {
        }
    }
}
