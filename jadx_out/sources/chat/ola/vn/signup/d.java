package chat.ola.vn.signup;

import android.annotation.SuppressLint;
import android.app.DatePickerDialog;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import chat.ola.vn.util.o;
import com.google.android.gms.auth.api.credentials.CredentialsApi;
import java.util.Calendar;

/* JADX INFO: loaded from: classes.dex */
public class d extends a implements DatePickerDialog.OnDateSetListener, View.OnClickListener {
    private EditText a;
    private Animation b;
    private View c;
    private RadioGroup d;
    private Button e;
    private Button f;
    private Button g;

    private void a(View view) {
        View viewFindViewById;
        try {
            this.c = view.findViewById(R.id.nextStepButton);
            this.c.setOnClickListener(this);
            if (OlaSignUpActivity.j != null) {
                try {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTimeInMillis(OlaSignUpActivity.j.longValue());
                    this.e.setText("" + calendar.get(5));
                    this.f.setText("" + (calendar.get(2) + 1));
                    this.g.setText("" + calendar.get(1));
                } catch (Throwable unused) {
                }
            }
            switch (OlaSignUpActivity.l) {
                case 0:
                    viewFindViewById = view.findViewById(R.id.femaleRadioButton);
                    break;
                case 1:
                    viewFindViewById = view.findViewById(R.id.maleRadioButton);
                    break;
                case 2:
                    viewFindViewById = view.findViewById(R.id.flexibleRadioButton);
                    break;
                default:
                    return;
            }
            ((RadioButton) viewFindViewById).setChecked(true);
        } catch (Throwable unused2) {
        }
    }

    private void y() {
        try {
            if (this.a.isFocused()) {
                o.a((Context) getActivity(), (View) this.a, false);
                this.a.clearFocus();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        if (i == 2) {
            try {
                j.d(getActivity(), R.string.message_fail_wrong_verification_code);
            } catch (Throwable unused) {
            }
        } else {
            if (m.a(str)) {
                return;
            }
            i.b(j(), getString(R.string.message_inform), str);
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
    }

    @Override // chat.ola.vn.signup.a
    public a c() {
        try {
            if (OlaSignUpActivity.m == null || OlaSignUpActivity.k != null) {
                return (e) Fragment.instantiate(getActivity(), e.class.getName());
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.signup.a
    public String e() {
        return OlaApplication.a(R.string.string_back);
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_your_profile_info);
    }

    @Override // chat.ola.vn.signup.a
    public String h() {
        return OlaApplication.a(OlaSignUpActivity.m == null ? R.string.string_next : R.string.string_finish);
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id != R.id.dateButton && id != R.id.monthButton) {
                if (id == R.id.nextStepButton) {
                    x();
                    return;
                } else if (id != R.id.yearButton) {
                    return;
                }
            }
            y();
            new DatePickerDialog(getActivity(), this, CredentialsApi.CREDENTIAL_PICKER_REQUEST_CODE, 5, 15).show();
        } catch (Throwable unused) {
        }
    }

    @Override // android.support.v4.app.Fragment
    @SuppressLint({"NewApi"})
    public View onCreateView(LayoutInflater layoutInflater, ViewGroup viewGroup, Bundle bundle) {
        View viewInflate = layoutInflater.inflate((OlaSignUpActivity.m == null || OlaSignUpActivity.k != null) ? R.layout.ola_sign_up_step2 : R.layout.ola_sign_up_step2_finish, (ViewGroup) null);
        this.a = (EditText) viewInflate.findViewById(R.id.fullnameEditText);
        this.d = (RadioGroup) viewInflate.findViewById(R.id.genderRadioGroup);
        try {
            String strG = n.g(getActivity());
            if (!m.a(strG)) {
                this.a.setText(strG);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        this.b = AnimationUtils.loadAnimation(j(), R.anim.shake);
        this.e = (Button) viewInflate.findViewById(R.id.dateButton);
        this.e.setOnClickListener(this);
        this.f = (Button) viewInflate.findViewById(R.id.monthButton);
        this.f.setOnClickListener(this);
        this.g = (Button) viewInflate.findViewById(R.id.yearButton);
        this.g.setOnClickListener(this);
        this.c = viewInflate.findViewById(R.id.nextStepButton);
        this.c.setOnClickListener(this);
        a(viewInflate);
        return viewInflate;
    }

    @Override // android.app.DatePickerDialog.OnDateSetListener
    public void onDateSet(DatePicker datePicker, int i, int i2, int i3) {
        try {
            Calendar calendar = Calendar.getInstance();
            calendar.set(5, i3);
            calendar.set(2, i2);
            calendar.set(1, i);
            this.e.setText("" + i3);
            this.f.setText("" + (i2 + 1));
            this.g.setText("" + i);
            OlaSignUpActivity.j = Long.valueOf(calendar.getTimeInMillis());
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.signup.a
    public void x() {
        OlaSignUpActivity.g = this.a.getText().toString();
        int checkedRadioButtonId = this.d.getCheckedRadioButtonId();
        if (checkedRadioButtonId == R.id.femaleRadioButton) {
            OlaSignUpActivity.l = (byte) 0;
        } else if (checkedRadioButtonId == R.id.flexibleRadioButton || checkedRadioButtonId != R.id.maleRadioButton) {
            OlaSignUpActivity.l = (byte) 2;
        } else {
            OlaSignUpActivity.l = (byte) 1;
        }
        if (OlaSignUpActivity.j == null) {
            OlaSignUpActivity.j = Long.valueOf(System.currentTimeMillis());
        }
        if (OlaSignUpActivity.m != null && OlaSignUpActivity.k == null) {
            j().c(true);
            OlaApplication.b.a(OlaSignUpActivity.e, OlaSignUpActivity.f, OlaSignUpActivity.m, OlaSignUpActivity.g, OlaSignUpActivity.i, OlaSignUpActivity.j, OlaSignUpActivity.l, (short) 0);
        } else {
            if (OlaSignUpActivity.k == null) {
                OlaApplication.b.i((short) 0);
            }
            OlaSignUpActivity.g = this.a.getText().toString();
            j().B();
        }
    }
}
