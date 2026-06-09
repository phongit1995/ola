package chat.ola.vn.activity;

import android.os.Bundle;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.EditText;
import android.widget.RadioGroup;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class RecoverPassStep1Activity extends c implements View.OnClickListener {
    private EditText e;
    private Animation f;
    private RadioGroup g;
    private View h;

    private void B() {
        try {
            this.e = (EditText) findViewById(R.id.accountNameEditText);
            findViewById(R.id.nextButton).setOnClickListener(this);
            findViewById(R.id.btnClose).setOnClickListener(this);
            this.h = findViewById(R.id.progressBar);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.btnClose) {
                finish();
            } else if (id == R.id.nextButton && m.a(this.e.getText().toString())) {
                j.a(this, getString(R.string.message_fail_phone_number_invalid));
                this.e.requestFocus();
                this.e.startAnimation(this.f);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.recover_pass_step1_layout);
        B();
        this.f = AnimationUtils.loadAnimation(this, R.anim.shake);
        this.g = (RadioGroup) findViewById(R.id.problemChooserRadioGroup);
        this.g.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() { // from class: chat.ola.vn.activity.RecoverPassStep1Activity.1
            @Override // android.widget.RadioGroup.OnCheckedChangeListener
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                if (i == R.id.forgotPasswordRadioButton) {
                    RecoverPassStep1Activity.this.findViewById(R.id.usernameInputLayout).setVisibility(0);
                } else if (i == R.id.forgotUsernameRadioButton || i == R.id.havingOtherProblemsRadioButton) {
                    RecoverPassStep1Activity.this.findViewById(R.id.usernameInputLayout).setVisibility(8);
                }
            }
        });
    }
}
