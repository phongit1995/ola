package chat.ola.vn.tutorial;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.i.i;
import chat.ola.vn.util.m;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class OlaTutorialActivity extends chat.ola.vn.c implements View.OnClickListener {
    public static boolean e = false;
    public static boolean f = false;
    static byte g;
    private c h;
    private TextView i;
    private TextView j;
    private TextView k;
    private View l;
    private Runnable m;

    public static void a(Context context) {
        g = (byte) 0;
        Intent intent = new Intent(context, (Class<?>) OlaTutorialActivity.class);
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        context.startActivity(intent);
    }

    public void B() {
        c cVarC;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.h != null && (cVarC = this.h.c()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.tutorialContent, cVarC, cVarC.getClass().getName());
                cVarC.a(this.h);
                try {
                    if (this.h instanceof a) {
                        cVarC.a((c) null);
                    }
                } catch (Throwable unused) {
                }
                f(cVarC.e_(), cVarC.d());
                this.j.setVisibility(cVarC.h() != null ? 0 : 4);
                this.h = cVarC;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void C() {
        c cVarH;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.h != null && (cVarH = this.h.h()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                fragmentTransactionBeginTransaction.replace(R.id.tutorialContent, cVarH, cVarH.getClass().getName());
                f(cVarH.e_(), cVarH.d());
                this.j.setVisibility(cVarH.h() != null ? 0 : 4);
                this.h = cVarH;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void c(boolean z) {
        View view;
        int i;
        if (this.m == null) {
            this.m = new Runnable() { // from class: chat.ola.vn.tutorial.OlaTutorialActivity.1
                @Override // java.lang.Runnable
                public void run() {
                    OlaTutorialActivity.this.l.setVisibility(8);
                    i.a(OlaTutorialActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                }
            };
        }
        OlaApplication.c(this.m);
        if (z) {
            OlaApplication.a(this.m, 60000L);
            view = this.l;
            i = 0;
        } else {
            view = this.l;
            i = 8;
        }
        view.setVisibility(i);
    }

    public void f(String str) {
        try {
            this.i.setText(str);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void f(String str, String str2) {
        TextView textView;
        int i;
        f(str);
        if (m.a(str2)) {
            textView = this.k;
            i = 4;
        } else {
            this.k.setText(str2);
            textView = this.k;
            i = 0;
        }
        textView.setVisibility(i);
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        try {
            C();
        } catch (Throwable unused) {
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
                this.h.e();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        c cVar;
        String name;
        super.onCreate(bundle);
        setContentView(R.layout.app_tutorial_layout);
        this.l = findViewById(R.id.loadingProgressBarViewLayout);
        this.i = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.j = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        this.j.setText(R.string.string_back);
        this.j.setOnClickListener(this);
        this.k = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.k.setOnClickListener(this);
        try {
            if (f) {
                chat.ola.vn.v.e.a();
            }
        } catch (Throwable unused) {
        }
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (e) {
                this.h = (c) Fragment.instantiate(this, a.class.getName());
                cVar = this.h;
                name = a.class.getName();
            } else {
                if (f) {
                    g = (byte) 1;
                }
                if (g != 0) {
                    this.h = (c) Fragment.instantiate(this, b.class.getName());
                    cVar = this.h;
                    name = b.class.getName();
                } else {
                    this.h = (c) Fragment.instantiate(this, d.class.getName());
                    cVar = this.h;
                    name = d.class.getName();
                }
            }
            fragmentTransactionBeginTransaction.add(R.id.tutorialContent, cVar, name);
            f(this.h.e_(), this.h.d());
            this.j.setVisibility(this.h.h() != null ? 0 : 4);
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
