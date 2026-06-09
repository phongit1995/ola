package chat.ola.vn.signup.fb;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.telephony.TelephonyManager;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Patterns;
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
import chat.ola.vn.countrypicker.OlaCountryPickerActivity;
import chat.ola.vn.e;
import chat.ola.vn.h;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.f;
import chat.ola.vn.util.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import com.facebook.appevents.AppEventsConstants;
import com.mg.ola.common.widget.OlaTextView;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;

/* JADX INFO: loaded from: classes.dex */
public class c extends b implements View.OnClickListener, chat.ola.vn.countrypicker.c {
    private EditText a;
    private TextView b;
    private TextView c;
    private Map<String, chat.ola.vn.countrypicker.a> d;
    private TextView e;
    private Animation f;
    private View g;

    @SuppressLint({"InlinedApi", "NewApi"})
    private chat.ola.vn.network.c h = new chat.ola.vn.network.c() { // from class: chat.ola.vn.signup.fb.c.1
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
                c.this.v();
                c.this.e().c(false);
            } catch (Throwable unused2) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void a(String str, boolean z) {
        }

        @Override // chat.ola.vn.network.c
        public void a(List<String> list) {
        }

        @Override // chat.ola.vn.network.c
        public void a(short s) {
            try {
                if (s == 0) {
                    j.c(c.this.e(), c.this.getString(R.string.message_fail_unknow_reason));
                    OlaLoginActivity.a(c.this.e());
                } else {
                    if (s == 3) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_DUPLICATED_USERNAME");
                        } catch (Throwable unused) {
                        }
                        c.this.e().c(false);
                        b bVarC = c.this.e().C();
                        Bundle bundle = new Bundle();
                        bundle.putShort("_result", s);
                        bVarC.setArguments(bundle);
                        return;
                    }
                    if (s == 7) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INVALID_USERNAME_PASSWORD");
                        } catch (Throwable unused2) {
                        }
                        j.c(c.this.e(), c.this.getString(R.string.message_fail_username_or_password));
                        OlaLoginActivity.a(c.this.e());
                    } else if (s == 10) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INVALID_PASSWORD");
                        } catch (Throwable unused3) {
                        }
                        j.c(c.this.e(), c.this.getString(R.string.message_fail_password_invalid));
                        OlaLoginActivity.a(c.this.e());
                    } else if (s == 22) {
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_INACTIVATED_ACCOUNT");
                        } catch (Throwable unused4) {
                        }
                        j.c(c.this.e(), c.this.getString(R.string.string_facebook_account_invalid));
                        OlaLoginActivity.a(c.this.e());
                    } else {
                        if (s != 32) {
                            return;
                        }
                        try {
                            f.a().c("Reg nick by FB FAIL: FAIL_LOGIN_SERVER_BUSY");
                        } catch (Throwable unused5) {
                        }
                        j.c(c.this.e(), c.this.getString(R.string.message_server_busy));
                        OlaLoginActivity.a(c.this.e());
                    }
                }
                c.this.v();
            } catch (Throwable unused6) {
            }
        }

        @Override // chat.ola.vn.network.c
        public void b() {
        }

        @Override // chat.ola.vn.network.c
        public void b(String str, String str2, String str3) {
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

    private void a(Context context) {
        String networkCountryIso;
        try {
            if (m.b(chat.ola.vn.c.y(), "VN")) {
                this.c.setText("VN");
                this.b.setText("+84");
            } else if (m.a(chat.ola.vn.c.y())) {
                this.d = OlaCountryPickerActivity.a(getActivity());
                if (this.d != null) {
                    this.c.setText(chat.ola.vn.c.y());
                    String strC = this.d.get(chat.ola.vn.c.y()).c();
                    if (!m.a(strC)) {
                        this.b.setText("+" + strC);
                        return;
                    }
                }
            } else {
                TelephonyManager telephonyManager = (TelephonyManager) context.getSystemService("phone");
                String simCountryIso = telephonyManager.getSimCountryIso();
                String upperCase = null;
                if (simCountryIso != null && simCountryIso.length() == 2) {
                    upperCase = simCountryIso.toUpperCase(Locale.US);
                } else if (telephonyManager.getPhoneType() != 2 && (networkCountryIso = telephonyManager.getNetworkCountryIso()) != null && networkCountryIso.length() == 2) {
                    upperCase = networkCountryIso.toUpperCase(Locale.US);
                }
                if (m.a(upperCase)) {
                    upperCase = context.getResources().getConfiguration().locale.getCountry();
                }
                this.d = OlaCountryPickerActivity.a(getActivity());
                if (this.d != null) {
                    this.c.setText(upperCase);
                    String strC2 = this.d.get(upperCase).c();
                    if (!m.a(strC2)) {
                        this.b.setText("+" + strC2);
                        return;
                    }
                }
            }
            this.c.setText("VN");
            this.b.setText("+84");
        } catch (Throwable unused) {
            this.c.setText("VN");
            this.b.setText("+84");
        }
    }

    private void a(View view) {
        try {
            this.a = (EditText) view.findViewById(R.id.phoneNumberEditText);
            this.a.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.signup.fb.c.2
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        d.c = c.this.b.getText().toString() + c.this.a.getText().toString();
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
            this.a.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.fb.c.3
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 6) {
                        return false;
                    }
                    try {
                        c.this.y();
                        return false;
                    } catch (Throwable unused) {
                        return false;
                    }
                }
            });
            this.c = (TextView) view.findViewById(R.id.countryNameTextView);
            this.e = (TextView) view.findViewById(R.id.phoneTipTextView);
            if (n.b(e())) {
                this.e.setText(R.string.string_phone_number_protect_hint_2);
            } else {
                this.e.setText(R.string.string_phone_number_protect_hint_1);
            }
            this.b = (TextView) view.findViewById(R.id.countryCodeTextView);
            this.g = view.findViewById(R.id.nextStepButton);
            this.c.setText("VN");
            this.c.setOnClickListener(this);
            this.b.setText("+84");
            this.g.setOnClickListener(this);
            this.b.setOnClickListener(this);
            view.findViewById(R.id.alreadyHaveAccountTextView).setOnClickListener(this);
            OlaTextView olaTextView = (OlaTextView) view.findViewById(R.id.termAndConditionTextView);
            olaTextView.setText(i.b(null, getString(R.string.string_term_hint), null, chat.ola.vn.f.a, true));
            olaTextView.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        } catch (Throwable unused) {
        }
    }

    private boolean e(String str) {
        try {
            Matcher matcher = Patterns.PHONE.matcher(str);
            if (matcher.find() && matcher.start() == 0) {
                return matcher.end() == str.length();
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    private void x() {
        if (this.d == null) {
            this.d = OlaCountryPickerActivity.a(getActivity());
        }
        this.a.setText("");
        if (this.d != null) {
            String str = d.c;
            for (chat.ola.vn.countrypicker.a aVar : this.d.values()) {
                String str2 = "+" + aVar.c();
                if (str.startsWith(str2)) {
                    this.c.setText(aVar.a());
                    this.b.setText("+" + aVar.c());
                    this.a.setText(str.substring(str2.length()));
                    return;
                }
            }
        }
        this.c.setText("VN");
        this.b.setText("+84");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y() {
        try {
            String string = this.a.getText().toString();
            while (!m.a(string) && string.startsWith(AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
                try {
                    string = string.substring(1);
                } catch (Throwable unused) {
                }
            }
            if (chat.ola.vn.c.x() && m.a(string)) {
                this.a.requestFocus();
                this.a.startAnimation(this.f);
                this.e.setTextColor(chat.ola.vn.f.k);
                this.e.setText(getString(R.string.message_fail_phone_invalid));
                return;
            }
            if (!m.a(string)) {
                if (!string.startsWith("+")) {
                    string = this.b.getText().toString() + string;
                }
                if (!e(string)) {
                    this.a.requestFocus();
                    this.a.startAnimation(this.f);
                    this.e.setTextColor(chat.ola.vn.f.k);
                    this.e.setText(getString(R.string.message_fail_phone_number_invalid));
                    return;
                }
            }
            e().c(false);
            d.c = string;
            e().B();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.countrypicker.c
    public void a(chat.ola.vn.countrypicker.a aVar) {
        try {
            this.c.setText(aVar.a());
            this.b.setText("+" + aVar.c());
            d.c = this.b.getText().toString() + this.a.getText().toString();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        if (m.a(d.c)) {
            d.c = h.S;
        }
        if (m.a(d.c)) {
            a(getActivity());
        } else {
            x();
        }
    }

    @Override // chat.ola.vn.signup.fb.b
    public b c() {
        try {
            return (b) Fragment.instantiate(getActivity(), d.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_register_account);
    }

    @Override // chat.ola.vn.signup.fb.b
    public String h() {
        try {
            return getString(R.string.string_continue);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.signup.fb.b
    public void j() {
        y();
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.alreadyHaveAccountTextView /* 2131296358 */:
                    if (!m.a(this.a.getText().toString())) {
                        chat.ola.vn.i.i.a(getActivity(), R.string.string_already_have_account, R.string.string_already_have_account_confirm, R.string.string_continue, R.string.string_login, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.signup.fb.c.4
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                if (i == 1) {
                                    try {
                                        c.this.v();
                                    } catch (Throwable unused) {
                                        return;
                                    }
                                }
                                dialogInterface.dismiss();
                            }
                        });
                    } else {
                        v();
                    }
                    break;
                case R.id.countryCodeTextView /* 2131296719 */:
                case R.id.countryNameTextView /* 2131296720 */:
                    if (this.d == null) {
                        this.d = OlaCountryPickerActivity.a(getActivity());
                    }
                    if (this.d != null) {
                        OlaCountryPickerActivity.e = this;
                        OlaCountryPickerActivity.b(getActivity());
                    }
                    break;
                case R.id.nextStepButton /* 2131297139 */:
                    y();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.register_ola_nick_by_fb_phonenumber, (ViewGroup) null);
        a(viewInflate);
        this.f = AnimationUtils.loadAnimation(e(), R.anim.shake);
        return viewInflate;
    }
}
