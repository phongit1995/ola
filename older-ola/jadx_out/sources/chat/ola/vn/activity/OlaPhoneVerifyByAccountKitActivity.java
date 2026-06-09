package chat.ola.vn.activity;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.c;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.network.a.a.al;
import chat.ola.vn.sms.OlaSmsSendingActivity;
import chat.ola.vn.sms.b;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import com.facebook.accountkit.AccountKitLoginResult;
import com.facebook.accountkit.ui.AccountKitActivity;
import com.facebook.accountkit.ui.AccountKitConfiguration;
import com.facebook.accountkit.ui.LoginType;

/* JADX INFO: loaded from: classes.dex */
public class OlaPhoneVerifyByAccountKitActivity extends c implements al.a {
    private Runnable e;

    /* JADX INFO: Access modifiers changed from: private */
    @SuppressLint({"NewApi"})
    public void D() {
        if (b.a(this)) {
            B();
        } else {
            requestPermissions(new String[]{"android.permission.SEND_SMS", "android.permission.RECEIVE_SMS", "android.permission.READ_PHONE_STATE"}, 106);
        }
    }

    private void E() {
        try {
            if (this.e == null) {
                this.e = new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.6
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            i.b(OlaPhoneVerifyByAccountKitActivity.this, OlaPhoneVerifyByAccountKitActivity.this.getString(R.string.dialog_title_fail), OlaPhoneVerifyByAccountKitActivity.this.getString(R.string.message_process_timeout)).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.6.1
                                @Override // android.content.DialogInterface.OnDismissListener
                                public void onDismiss(DialogInterface dialogInterface) {
                                    OlaPhoneVerifyByAccountKitActivity.this.finish();
                                }
                            });
                        } catch (Throwable unused) {
                        }
                    }
                };
            }
            OlaApplication.c(this.e);
            OlaApplication.a(this.e, 60000L);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context) {
        try {
            context.startActivity(new Intent(context, (Class<?>) OlaPhoneVerifyByAccountKitActivity.class));
        } catch (Throwable unused) {
        }
    }

    public void B() {
        Intent intent = new Intent(this, (Class<?>) AccountKitActivity.class);
        AccountKitConfiguration.AccountKitConfigurationBuilder accountKitConfigurationBuilder = new AccountKitConfiguration.AccountKitConfigurationBuilder(LoginType.PHONE, AccountKitActivity.ResponseType.TOKEN);
        accountKitConfigurationBuilder.setTitleType(AccountKitActivity.TitleType.APP_NAME);
        accountKitConfigurationBuilder.setReadPhoneStateEnabled(true);
        accountKitConfigurationBuilder.setReceiveSMS(true);
        accountKitConfigurationBuilder.setFacebookNotificationsEnabled(true);
        intent.putExtra(AccountKitActivity.ACCOUNT_KIT_ACTIVITY_CONFIGURATION, accountKitConfigurationBuilder.build());
        startActivityForResult(intent, 5);
    }

    @Override // chat.ola.vn.network.a.a.al.a
    public void C() {
        i.a(this, R.string.dialog_title_inform, R.string.message_validate_phone_number_fail).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.5
            @Override // android.content.DialogInterface.OnDismissListener
            public void onDismiss(DialogInterface dialogInterface) {
                try {
                    OlaPhoneVerifyByAccountKitActivity.this.finish();
                } catch (Throwable unused) {
                }
            }
        });
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.network.a.a.al.a
    public void f(String str) {
        try {
            OlaApplication.b.b((String) null, (short) 0);
        } catch (Throwable unused) {
        }
        try {
            if (h.O.u == 0 && h.a) {
                OlaSmsSendingActivity.a(c.c());
            }
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.4
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        j.d(c.c(), R.string.message_validate_phone_number_success);
                    } catch (Throwable unused2) {
                    }
                }
            }, 2000L);
            finish();
        } catch (Throwable unused2) {
        }
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onActivityResult(int i, int i2, Intent intent) {
        if (i == 5) {
            try {
                AccountKitLoginResult accountKitLoginResult = (AccountKitLoginResult) intent.getParcelableExtra(AccountKitLoginResult.RESULT_KEY);
                if (accountKitLoginResult.getError() == null) {
                    if (accountKitLoginResult.wasCancelled()) {
                        finish();
                        return;
                    } else if (accountKitLoginResult.getAccessToken() != null) {
                        String token = accountKitLoginResult.getAccessToken().getToken();
                        if (!m.a(token)) {
                            try {
                                E();
                                OlaApplication.b.a(token, this);
                                return;
                            } catch (Throwable unused) {
                            }
                        }
                    }
                }
                i.a(this, R.string.dialog_title_inform, R.string.message_validate_phone_number_fail).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.3
                    @Override // android.content.DialogInterface.OnDismissListener
                    public void onDismiss(DialogInterface dialogInterface) {
                        try {
                            OlaPhoneVerifyByAccountKitActivity.this.finish();
                        } catch (Throwable unused2) {
                        }
                    }
                });
            } catch (Throwable unused2) {
            }
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.ola_loading_activity_layout);
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.1
            @Override // java.lang.Runnable
            public void run() {
                OlaPhoneVerifyByAccountKitActivity.this.D();
            }
        }, 500L);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity, android.support.v4.app.ActivityCompat.OnRequestPermissionsResultCallback
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        if (i == 106) {
            try {
                if (b.a(this)) {
                    B();
                } else {
                    i.b(this, R.string.dialog_title_confirm, R.string.message_require_permission_for_feature, R.string.string_retry, R.string.close, new DialogInterface.OnClickListener() { // from class: chat.ola.vn.activity.OlaPhoneVerifyByAccountKitActivity.2
                        @Override // android.content.DialogInterface.OnClickListener
                        public void onClick(DialogInterface dialogInterface, int i2) {
                            try {
                                dialogInterface.dismiss();
                                if (i2 != 0) {
                                    OlaPhoneVerifyByAccountKitActivity.this.finish();
                                } else {
                                    OlaPhoneVerifyByAccountKitActivity.this.D();
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    });
                }
            } catch (Throwable unused) {
            }
        }
    }
}
