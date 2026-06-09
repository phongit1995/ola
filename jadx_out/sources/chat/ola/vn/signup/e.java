package chat.ola.vn.signup;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.f;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import com.mg.ola.common.widget.OlaTextView;

/* JADX INFO: loaded from: classes.dex */
public class e extends a implements View.OnClickListener {
    private ImageView a;
    private EditText b;
    private Animation c;
    private View d;

    @Override // chat.ola.vn.m.f, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        if (i != 2) {
            if (m.a(str)) {
                return;
            }
            i.b(j(), getString(R.string.message_inform), str);
        } else {
            try {
                this.b.startAnimation(this.c);
                this.b.setText("");
                j.d(getActivity(), R.string.message_fail_wrong_verification_code);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.m.f
    protected void b(Bundle bundle) {
        super.b(bundle);
        y();
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.signup.e.2
            @Override // java.lang.Runnable
            public void run() {
                try {
                    o.a((Context) e.this.getActivity(), (View) e.this.b, true);
                } catch (Throwable unused) {
                }
            }
        }, 300L);
    }

    @Override // chat.ola.vn.signup.a
    public a c() {
        return null;
    }

    @Override // chat.ola.vn.signup.a
    public String e() {
        return OlaApplication.a(R.string.string_back);
    }

    @Override // chat.ola.vn.m.f
    public String e_() {
        return OlaApplication.a(R.string.string_register);
    }

    @Override // chat.ola.vn.signup.a
    public String h() {
        return OlaApplication.a(R.string.string_finish);
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
        View viewInflate = layoutInflater.inflate(R.layout.ola_sign_up_step3, (ViewGroup) null);
        this.a = (ImageView) viewInflate.findViewById(R.id.verificationImageView);
        this.b = (EditText) viewInflate.findViewById(R.id.verificationEditText);
        OlaTextView olaTextView = (OlaTextView) viewInflate.findViewById(R.id.termAndConditionTextView);
        olaTextView.setText(chat.ola.vn.util.i.b(olaTextView, getString(R.string.string_term_hint), null, f.a, true));
        olaTextView.setOlaSpanClickListener(chat.ola.vn.q.a.a());
        this.b.setOnEditorActionListener(new TextView.OnEditorActionListener() { // from class: chat.ola.vn.signup.e.1
            @Override // android.widget.TextView.OnEditorActionListener
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if ((keyEvent == null || keyEvent.getKeyCode() != 66) && i != 6) {
                    return false;
                }
                e.this.x();
                return false;
            }
        });
        this.c = AnimationUtils.loadAnimation(j(), R.anim.shake);
        this.d = viewInflate.findViewById(R.id.nextStepButton);
        this.d.setOnClickListener(this);
        return viewInflate;
    }

    @Override // chat.ola.vn.signup.a
    public void x() {
        try {
            String string = this.b.getText().toString();
            if (m.a(string)) {
                this.b.startAnimation(this.c);
                j.d(getActivity(), R.string.message_fail_please_enter_verification_code);
            } else {
                j().c(true);
                OlaApplication.b.a(OlaSignUpActivity.e, OlaSignUpActivity.f, OlaSignUpActivity.g, OlaSignUpActivity.h, OlaSignUpActivity.i, OlaSignUpActivity.j, string, OlaSignUpActivity.l, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }

    public void y() {
        try {
            if (OlaSignUpActivity.k == null) {
                j().c(true);
                OlaApplication.b.i((short) 0);
            } else {
                j().c(false);
                this.a.setImageBitmap(BitmapFactory.decodeByteArray(OlaSignUpActivity.k, 0, OlaSignUpActivity.k.length));
            }
        } catch (Throwable unused) {
        }
    }
}
