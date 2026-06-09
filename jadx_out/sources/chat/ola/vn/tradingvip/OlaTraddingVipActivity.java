package chat.ola.vn.tradingvip;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.R;
import chat.ola.vn.entity.ah;
import chat.ola.vn.i.i;
import chat.ola.vn.util.j;
import chat.ola.vn.util.m;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class OlaTraddingVipActivity extends chat.ola.vn.c implements View.OnClickListener {
    public static ah e;
    private a f;
    private TextView g;
    private View h;
    private View i;
    private ImageView j;

    public static void a(Context context, String str) {
        a(context, str, (ah) null);
    }

    public static void a(Context context, String str, ah ahVar) {
        e = ahVar;
        Intent intent = new Intent(context, (Class<?>) OlaTraddingVipActivity.class);
        if (!m.a(str)) {
            intent.putExtra("_buddy_id", str);
        }
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public void B() {
        a aVarC;
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null && (aVarC = this.f.c()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.traddingVipFragment, aVarC, aVarC.getClass().getName());
                aVarC.a(this.f);
                f(aVarC.e_());
                this.f = aVarC;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public a C() {
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.f != null) {
                a aVarD = this.f.d();
                if (aVarD != null) {
                    fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                    fragmentTransactionBeginTransaction.replace(R.id.traddingVipFragment, aVarD, aVarD.getClass().getName());
                    f(aVarD.e_());
                    fragmentTransactionBeginTransaction.commit();
                }
                this.f = aVarD;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return this.f;
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(int i, String str, byte[] bArr, chat.ola.vn.entity.d[] dVarArr, short s) {
        int i2;
        try {
            c(false);
            switch (i) {
                case 7:
                case 10:
                    i2 = R.string.message_notify_wrong_password;
                    break;
                case 8:
                    i2 = R.string.message_fail_transfer_ken_invalide_receiver;
                    break;
                case 9:
                default:
                    if (m.a(str)) {
                        j.c(this, R.string.message_fail_unknow_reason);
                        return;
                    } else {
                        i.b(this, getString(R.string.dialog_title_fail), str);
                        return;
                    }
            }
            i.a(this, R.string.dialog_title_fail, i2);
        } catch (Throwable unused) {
        }
    }

    public void c(boolean z) {
        this.i.setVisibility(z ? 0 : 8);
        this.i.postDelayed(new Runnable() { // from class: chat.ola.vn.tradingvip.OlaTraddingVipActivity.1
            @Override // java.lang.Runnable
            public void run() {
                if (OlaTraddingVipActivity.this.i.getVisibility() == 0) {
                    OlaTraddingVipActivity.this.i.setVisibility(8);
                }
            }
        }, 60000L);
    }

    public void f(String str) {
        this.g.setText(str);
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
        if (C() == null) {
            super.onBackPressed();
        }
    }

    @Override // android.view.View.OnClickListener
    public void onClick(View view) {
        int id = view.getId();
        if (id == R.id.olaActionBarBackViewLayout) {
            onBackPressed();
        } else {
            if (id != R.id.olaActionBarMoreButtonImageView) {
                return;
            }
            finish();
        }
    }

    @Override // chat.ola.vn.c, android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        a aVar;
        String name;
        super.onCreate(bundle);
        setContentView(R.layout.ola_tradding_vip_layout);
        this.i = findViewById(R.id.traddingVipProgressBar);
        this.g = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (e == null) {
                this.f = (a) Fragment.instantiate(this, b.class.getName());
                aVar = this.f;
                name = b.class.getName();
            } else {
                this.f = (a) Fragment.instantiate(this, c.class.getName());
                aVar = this.f;
                name = c.class.getName();
            }
            fragmentTransactionBeginTransaction.add(R.id.traddingVipFragment, aVar, name);
            f(this.f.e_());
            this.h = findViewById(R.id.olaActionBarBackViewLayout);
            this.h.setOnClickListener(this);
            this.j = (ImageView) findViewById(R.id.olaActionBarMoreButtonImageView);
            this.j.setImageResource(R.drawable.ic_action_quit);
            this.j.setOnClickListener(this);
            this.j.setVisibility(0);
            this.h.setVisibility(0);
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
