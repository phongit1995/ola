package chat.ola.vn.signup;

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
import chat.ola.vn.countrypicker.OlaCountryPickerActivity;
import chat.ola.vn.f;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import com.facebook.appevents.AppEventsConstants;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;

/* JADX INFO: loaded from: classes.dex */
public class b extends a implements View.OnClickListener, chat.ola.vn.countrypicker.c {
    private EditText a;
    private TextView b;
    private TextView c;
    private Map<String, chat.ola.vn.countrypicker.a> d;
    private TextView e;
    private Animation f;
    private View g;

    private void a(Context context) {
        String networkCountryIso;
        try {
            if (m.b(OlaBottomTabActivity.y(), "VN")) {
                this.c.setText("VN");
                this.b.setText("+84");
            } else if (m.a(OlaBottomTabActivity.y())) {
                this.d = OlaCountryPickerActivity.a(getActivity());
                if (this.d != null) {
                    this.c.setText(OlaBottomTabActivity.y());
                    String strC = this.d.get(OlaBottomTabActivity.y()).c();
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
                if (!m.a(upperCase)) {
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
            this.a.addTextChangedListener(new TextWatcher() { // from class: chat.ola.vn.signup.b.1
                @Override // android.text.TextWatcher
                public void afterTextChanged(Editable editable) {
                    try {
                        OlaSignUpActivity.h = m.g(b.this.b.getText().toString(), b.this.a.getText().toString());
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
            this.a.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.b.2
                @Override // android.widget.TextView.OnEditorActionListener
                public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                    if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 6) {
                        return false;
                    }
                    try {
                        b.this.z();
                        return false;
                    } catch (Throwable unused) {
                        return false;
                    }
                }
            });
            this.c = (TextView) view.findViewById(R.id.countryNameTextView);
            this.e = (TextView) view.findViewById(R.id.phoneTipTextView);
            if (n.b(j())) {
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
            view.findViewById(R.id.alreadyHaveAccountTextView).setVisibility(8);
            if (!OlaBottomTabActivity.x() || m.a(h.S)) {
                return;
            }
            this.a.setText(h.S);
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

    private void y() {
        if (this.d == null) {
            this.d = OlaCountryPickerActivity.a(getActivity());
        }
        this.a.setText("");
        if (this.d != null) {
            for (chat.ola.vn.countrypicker.a aVar : this.d.values()) {
                String str = "+" + aVar.c();
                if ("".startsWith(str)) {
                    this.c.setText(aVar.a());
                    this.b.setText("+" + aVar.c());
                    this.a.setText("".substring(str.length()));
                    return;
                }
            }
        }
        this.c.setText("VN");
        this.b.setText("+84");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void z() {
        try {
            String string = this.a.getText().toString();
            while (!m.a(string) && string.startsWith(AppEventsConstants.EVENT_PARAM_VALUE_NO)) {
                try {
                    string = string.substring(1);
                } catch (Throwable unused) {
                }
            }
            if (OlaBottomTabActivity.x() && m.a(string)) {
                this.a.requestFocus();
                this.a.startAnimation(this.f);
                this.e.setTextColor(f.k);
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
                    this.e.setTextColor(f.k);
                    this.e.setText(getString(R.string.message_fail_phone_number_invalid));
                    return;
                }
            }
            OlaSignUpActivity.h = string;
            j().B();
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        if (i != 4) {
            return;
        }
        try {
            this.e.setVisibility(0);
            this.e.setTextColor(f.k);
            this.e.setText(getString(R.string.message_fail_phone_number_invalid));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.countrypicker.c
    public void a(chat.ola.vn.countrypicker.a aVar) {
        try {
            this.c.setText(aVar.a());
            this.b.setText("+" + aVar.c());
            OlaSignUpActivity.h = m.g(this.b.getText().toString(), this.a.getText().toString());
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        if (m.a(OlaSignUpActivity.h)) {
            OlaSignUpActivity.h = h.S;
        }
        if (m.a(OlaSignUpActivity.h)) {
            a(getActivity());
        } else {
            y();
        }
    }

    @Override // chat.ola.vn.signup.a
    public a c() {
        try {
            return (a) Fragment.instantiate(getActivity(), c.class.getName());
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.signup.a
    public String e() {
        return null;
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_register_account);
    }

    @Override // chat.ola.vn.signup.a
    public String h() {
        try {
            return getString(R.string.string_next);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            switch (view.getId()) {
                case R.id.alreadyHaveAccountTextView /* 2131296358 */:
                    if (!m.a(this.a.getText().toString())) {
                        i.a(getActivity(), R.string.string_already_have_account, R.string.string_already_have_account_confirm, R.string.string_continue, R.string.string_login, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.signup.b.3
                            @Override // android.content.DialogInterface.OnClickListener
                            public void onClick(DialogInterface dialogInterface, int i) {
                                if (i == 1) {
                                    try {
                                        b.this.v();
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
                    z();
                    break;
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate(R.layout.register_ola_nick_by_fb_phonenumber, (ViewGroup) null);
        a(viewInflate);
        this.f = AnimationUtils.loadAnimation(j(), R.anim.shake);
        return viewInflate;
    }
}
