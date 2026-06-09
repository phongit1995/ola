package chat.ola.vn.signup;

import android.accounts.Account;
import android.accounts.AccountManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.i.i;
import chat.ola.vn.tutorial.OlaTutorialActivity;
import chat.ola.vn.util.f;
import chat.ola.vn.util.m;
import chat.ola.vn.util.n;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaSignUpActivity extends chat.ola.vn.c implements View.OnClickListener {
    static String e = null;
    static String f = null;
    static String g = null;
    static String h = null;
    static String i = null;
    static Long j = null;
    static byte[] k = null;
    static byte l = -1;
    static String m;
    private a n;
    private TextView o;
    private TextView p;
    private View q;
    private TextView r;
    private Runnable s;

    private boolean D() {
        return (this.n == null || this.n.d() == null) ? false : true;
    }

    public static List<String> a(Context context) {
        ArrayList arrayList = null;
        try {
            AccountManager accountManager = AccountManager.get(context);
            if (Build.VERSION.SDK_INT >= 23 && chat.ola.vn.c.c().checkSelfPermission("android.permission.GET_ACCOUNTS") == 0) {
                ArrayList arrayList2 = null;
                for (Account account : accountManager.getAccountsByType("com.google")) {
                    try {
                        String strSubstring = account.name;
                        if (!m.a(strSubstring)) {
                            int iIndexOf = strSubstring.indexOf(64);
                            if (iIndexOf > 0) {
                                strSubstring = strSubstring.substring(0, iIndexOf);
                            }
                            if (!m.a(strSubstring)) {
                                if (arrayList2 == null) {
                                    arrayList2 = new ArrayList();
                                }
                                if (!arrayList2.contains(strSubstring)) {
                                    arrayList2.add(strSubstring);
                                }
                            }
                        }
                    } catch (Throwable unused) {
                    }
                }
                arrayList = arrayList2;
            }
        } catch (Throwable unused2) {
        }
        try {
            String strG = n.g(context);
            if (!m.a(strG)) {
                String strR = m.r(strG);
                if (arrayList == null) {
                    arrayList = new ArrayList();
                }
                if (!arrayList.contains(strR)) {
                    arrayList.add(strR);
                }
            }
            String strH = n.h(context);
            if (!m.a(strH)) {
                int iIndexOf2 = strH.indexOf(64);
                if (iIndexOf2 > 0) {
                    strH = strH.substring(0, iIndexOf2);
                }
                if (!m.a(strH)) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    if (!arrayList.contains(strH)) {
                        arrayList.add(strH);
                    }
                }
            }
        } catch (Throwable unused3) {
        }
        return arrayList;
    }

    public static void a(chat.ola.vn.c cVar) {
        a(cVar, (String) null);
    }

    public static void a(chat.ola.vn.c cVar, String str) {
        k = null;
        m = str;
        cVar.startActivityForResult(new Intent(cVar, (Class<?>) OlaSignUpActivity.class), 1);
        try {
            cVar.overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public void B() {
        a aVarC;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.n != null && (aVarC = this.n.c()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.signUpFragment, aVarC, aVarC.getClass().getName());
                aVarC.a(this.n);
                a(aVarC.e_(), aVarC.e(), aVarC.h());
                this.n = aVarC;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public a C() {
        a aVarD;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.n != null && (aVarD = this.n.d()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                fragmentTransactionBeginTransaction.replace(R.id.signUpFragment, aVarD, aVarD.getClass().getName());
                a(aVarD.e_(), aVarD.e(), aVarD.h());
                fragmentTransactionBeginTransaction.commit();
                this.n = aVarD;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return this.n;
    }

    @Override // chat.ola.vn.c
    protected void a() {
        try {
            if (m == null) {
                OlaApplication.b.i((short) 0);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:34:0x00bf A[Catch: Throwable -> 0x011c, TryCatch #0 {Throwable -> 0x011c, blocks: (B:16:0x0045, B:17:0x005a, B:30:0x00a4, B:33:0x00b8, B:34:0x00bf, B:36:0x00d6, B:38:0x00ee, B:40:0x0106), top: B:48:0x0026 }] */
    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(final int r16, final java.lang.String r17, final byte[] r18, final chat.ola.vn.entity.d[] r19, final short r20) {
        /*
            Method dump skipped, instruction units count: 296
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.signup.OlaSignUpActivity.a(int, java.lang.String, byte[], chat.ola.vn.entity.d[], short):void");
    }

    public void a(String str, String str2, String str3) {
        this.o.setText(str);
        if (m.a(str2)) {
            this.p.setVisibility(4);
        } else {
            this.p.setVisibility(0);
            this.p.setText(str2);
        }
        if (m.a(str3)) {
            this.r.setVisibility(4);
        } else {
            this.r.setVisibility(0);
            this.r.setText(str3);
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(String str, String str2, short s) {
        try {
            OlaTutorialActivity.f = false;
            c(false);
            Intent intent = new Intent();
            intent.putExtra("_username", str);
            intent.putExtra("_pass", str2);
            setResult(-1, intent);
            OlaBottomTabActivity.g = true;
            finish();
        } catch (Throwable unused) {
        }
        try {
            f.a().c("Reg nick MANUAL OK");
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(byte[] bArr, short s) {
        c(false);
        k = bArr;
        try {
            ((e) this.n).y();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c
    protected boolean b() {
        return false;
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void c(boolean z) {
        View view;
        int i2;
        if (this.s == null) {
            this.s = new Runnable() { // from class: chat.ola.vn.signup.OlaSignUpActivity.4
                @Override // java.lang.Runnable
                public void run() {
                    i.a(OlaSignUpActivity.this, R.string.dialog_title_inform, R.string.message_process_timeout);
                    OlaSignUpActivity.this.c(false);
                }
            };
        }
        OlaApplication.c(this.s);
        if (z) {
            OlaApplication.a(this.s, 60000L);
            view = this.q;
            i2 = 0;
        } else {
            view = this.q;
            i2 = 8;
        }
        view.setVisibility(i2);
    }

    @Override // chat.ola.vn.c, android.app.Activity
    public void finish() {
        super.finish();
        try {
            overridePendingTransition(R.anim.push_right_in, R.anim.push_right_out);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (D()) {
            C();
        } else {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        try {
            int id = view.getId();
            if (id == R.id.olaActionBarBackViewLayout) {
                onBackPressed();
            } else {
                if (id != R.id.olaActionBarButtonTextView) {
                    return;
                }
                this.n.x();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        a aVar;
        String name;
        super.onCreate(bundle);
        setContentView(R.layout.ola_sign_up_layout);
        this.q = findViewById(R.id.loadingProgressBar);
        this.q.setVisibility(8);
        this.o = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        this.p = (TextView) findViewById(R.id.olaActionBarBackViewLayout);
        this.r = (TextView) findViewById(R.id.olaActionBarButtonTextView);
        this.r.setVisibility(4);
        this.r.setOnClickListener(this);
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (m == null) {
                this.n = (a) Fragment.instantiate(this, b.class.getName());
                aVar = this.n;
                name = b.class.getName();
            } else {
                this.n = (a) Fragment.instantiate(this, c.class.getName());
                aVar = this.n;
                name = c.class.getName();
            }
            fragmentTransactionBeginTransaction.add(R.id.signUpFragment, aVar, name);
            a(this.n.e_(), this.n.e(), this.n.h());
            this.p.setText(R.string.string_cancel);
            this.p.setOnClickListener(this);
            this.p.setVisibility(0);
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
