package chat.ola.vn.signup.fb;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaSignUpByFacebookActivity extends chat.ola.vn.c implements View.OnClickListener {
    private static boolean e = false;
    private b f;
    private TextView g;
    private TextView h;
    private View i;
    private Runnable j;
    private TextView k;

    public static boolean a(Context context, String str) {
        return a(context, str, (List<String>) null);
    }

    public static boolean a(Context context, String str, List<String> list) {
        try {
            if (e || m.a(str)) {
                return false;
            }
            Intent intent = new Intent(context, (Class<?>) OlaSignUpByFacebookActivity.class);
            intent.putExtra("_trust_token", str);
            if (list != null) {
                try {
                    String[] strArr = new String[list.size()];
                    for (int i = 0; i < strArr.length; i++) {
                        strArr[i] = new String(list.get(i));
                    }
                    intent.putExtra("_byte_data", strArr);
                } catch (Throwable unused) {
                }
            }
            context.startActivity(intent);
            return true;
        } catch (Throwable unused2) {
        }
        return false;
    }

    public void B() {
        b bVarC;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null && (bVarC = this.f.c()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.signupByFbFragmentContent, bVarC, bVarC.getClass().getName());
                bVarC.a(this.f);
                f(bVarC.e_(), bVarC.h());
                this.h.setVisibility(bVarC.d() != null ? 0 : 4);
                this.f = bVarC;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public b C() {
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null) {
                b bVarD = this.f.d();
                if (bVarD != null) {
                    fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                    fragmentTransactionBeginTransaction.replace(R.id.signupByFbFragmentContent, bVarD, bVarD.getClass().getName());
                    f(bVarD.e_(), bVarD.h());
                    this.h.setVisibility(bVarD.d() != null ? 0 : 4);
                    fragmentTransactionBeginTransaction.commit();
                }
                this.f = bVarD;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return this.f;
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
            if (this.j == null) {
                this.j = new Runnable() { // from class: chat.ola.vn.signup.fb.OlaSignUpByFacebookActivity.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            OlaSignUpByFacebookActivity.this.i.setVisibility(8);
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.j);
            if (z) {
                OlaApplication.a(this.j, 60000L);
                view = this.i;
                i = 0;
            } else {
                view = this.i;
                i = 8;
            }
            view.setVisibility(i);
        } catch (Throwable unused) {
        }
    }

    public void f(String str) {
        try {
            this.g.setText(str);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void f(String str, String str2) {
        f(str);
        if (m.a(str2)) {
            this.k.setVisibility(4);
        } else {
            this.k.setVisibility(0);
            this.k.setText(str2);
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (C() == null) {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                C();
            } else {
                if (id != R.id.olaActionBarButtonTextView) {
                    return;
                }
                this.f.j();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        b bVar;
        String name;
        super.onCreate(bundle);
        e = true;
        setContentView(R.layout.ola_signup_by_facebook_layout);
        this.g = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.i = findViewById(R.id.loadingProgressBarViewLayout);
        this.h = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        this.h.setText(R.string.string_back);
        this.h.setOnClickListener(this);
        this.k = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.k.setVisibility(4);
        this.k.setOnClickListener(this);
        try {
            String stringExtra = getIntent().getStringExtra("_trust_token");
            String[] stringArrayExtra = getIntent().getStringArrayExtra("_byte_data");
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (stringArrayExtra == null || stringArrayExtra.length <= 0) {
                d.a = stringExtra;
                if (m.a(h.S)) {
                    d.c = null;
                    this.f = (b) Fragment.instantiate(this, c.class.getName());
                    bVar = this.f;
                    name = c.class.getName();
                } else {
                    d.c = h.S;
                    this.f = (b) Fragment.instantiate(this, d.class.getName());
                    bVar = this.f;
                    name = d.class.getName();
                }
            } else {
                this.f = (b) Fragment.instantiate(this, a.class.getName());
                Bundle bundle2 = new Bundle();
                bundle2.putString("_trust_token", stringExtra);
                bundle2.putStringArray("_byte_data", stringArrayExtra);
                this.f.setArguments(bundle2);
                bVar = this.f;
                name = a.class.getName();
            }
            fragmentTransactionBeginTransaction.add(R.id.signupByFbFragmentContent, bVar, name);
            f(this.f.e_(), this.f.h());
            this.h.setVisibility(this.f.d() != null ? 0 : 4);
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        e = false;
        super.onDestroy();
    }
}
