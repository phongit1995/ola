package chat.ola.vn.sms;

import android.annotation.SuppressLint;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.sms.a;
import chat.ola.vn.util.f;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class OlaSmsSendingActivity extends c implements a.InterfaceC0049a {
    private static String e;
    private static String f;
    private a g;
    private String h;
    private String i;
    private ProgressDialog j = null;
    private Runnable k;

    public static void a(Context context) {
        a(context, h.a());
    }

    public static void a(Context context, String str) {
        e = "8755";
        if (m.a(str)) {
            return;
        }
        try {
            f = "MGM BUYVIP " + str;
            context.startActivity(new Intent(context, (Class<?>) OlaSmsSendingActivity.class));
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str, String str2) {
        e = str;
        if (m.a(str2)) {
            return;
        }
        try {
            f = str2;
            context.startActivity(new Intent(context, (Class<?>) OlaSmsSendingActivity.class));
        } catch (Throwable unused) {
        }
    }

    private void a(boolean z, long j) {
        try {
            if (this.k == null) {
                this.k = new Runnable() { // from class: chat.ola.vn.sms.OlaSmsSendingActivity.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            try {
                                OlaSmsSendingActivity.this.j.dismiss();
                                OlaSmsSendingActivity.this.j = null;
                                i.b(c.c(), OlaSmsSendingActivity.this.getString(R.string.dialog_title_inform), OlaSmsSendingActivity.this.getString(R.string.message_send_sms_fail_confirm)).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.sms.OlaSmsSendingActivity.1.1
                                    @Override // android.content.DialogInterface.OnDismissListener
                                    public void onDismiss(DialogInterface dialogInterface) {
                                        OlaSmsSendingActivity.this.finish();
                                    }
                                });
                            } catch (Throwable unused) {
                                OlaSmsSendingActivity.this.finish();
                            }
                        } catch (Throwable unused2) {
                        }
                    }
                };
            }
            OlaApplication.c(this.k);
            if (!z) {
                if (this.j != null) {
                    this.j.dismiss();
                    this.j = null;
                    finish();
                    return;
                }
                return;
            }
            if (this.j != null) {
                if (!this.j.isShowing()) {
                }
                OlaApplication.b(this.k, j);
            }
            this.j = i.a((Context) this, (CharSequence) getString(R.string.string_please_wait), (CharSequence) getString(R.string.message_please_wait_sending_sms));
            this.j.show();
            OlaApplication.b(this.k, j);
        } catch (Throwable unused) {
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void c(boolean z) {
        a(z, 15000L);
    }

    @SuppressLint({"NewApi"})
    private void g(String str, String str2) {
        if (b.a(this)) {
            c(true);
            b.a(this, str, str2);
        } else {
            this.h = str;
            this.i = str2;
            requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS"}, 106);
        }
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.sms.a.InterfaceC0049a
    public void f(final String str, final String str2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.sms.OlaSmsSendingActivity.2
            @Override // java.lang.Runnable
            public void run() {
                f fVarA;
                String str3;
                if (b.a(str)) {
                    try {
                        OlaSmsSendingActivity.this.c(false);
                        i.b(OlaSmsSendingActivity.this, OlaSmsSendingActivity.this.getString(R.string.dialog_title_inform), str2).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.sms.OlaSmsSendingActivity.2.1
                            @Override // android.content.DialogInterface.OnDismissListener
                            public void onDismiss(DialogInterface dialogInterface) {
                                OlaSmsSendingActivity.this.finish();
                            }
                        });
                    } catch (Throwable unused) {
                    }
                    long j = 0;
                    try {
                        if (OlaSmsSendingActivity.e.endsWith("8555")) {
                            j = 5000;
                        } else if (OlaSmsSendingActivity.e.endsWith("8655")) {
                            j = 10000;
                        } else if (OlaSmsSendingActivity.e.endsWith("8755")) {
                            j = 15000;
                        }
                        long j2 = (j * 40) / 100;
                        if (OlaSmsSendingActivity.f.startsWith("MGM BUYVIP")) {
                            fVarA = f.a();
                            str3 = "Buy VIP by SMS";
                        } else {
                            if (!OlaSmsSendingActivity.f.startsWith("MGM NAP")) {
                                return;
                            }
                            fVarA = f.a();
                            str3 = "Deposit KEN by SMS";
                        }
                        fVarA.a(str3, j2);
                    } catch (Throwable unused2) {
                    }
                }
            }
        });
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    public void onBackPressed() {
        if (this.j == null || !this.j.isShowing()) {
            super.onBackPressed();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        try {
            this.g = new a();
            this.g.a(this);
            registerReceiver(this.g, new IntentFilter("android.provider.Telephony.SMS_RECEIVED"));
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onDestroy() {
        try {
            unregisterReceiver(this.g);
        } catch (Throwable unused) {
        }
        super.onDestroy();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 106) {
            for (int i2 = 0; i2 < iArr.length; i2++) {
                try {
                    if (iArr[0] != 0) {
                        this.h = null;
                        this.i = null;
                        finish();
                        return;
                    }
                } catch (Throwable unused) {
                    return;
                }
            }
            c(true);
            b.a(this, this.h, this.i);
        }
        this.h = null;
        this.i = null;
        finish();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onStart() {
        super.onStart();
        a(true, 15000L);
        g(e, f);
    }
}
