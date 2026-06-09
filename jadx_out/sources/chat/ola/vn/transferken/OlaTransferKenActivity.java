package chat.ola.vn.transferken;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.h;
import chat.ola.vn.i.i;
import chat.ola.vn.message.e;
import chat.ola.vn.message.f;
import chat.ola.vn.message.j;
import chat.ola.vn.util.m;
import com.google.android.gms.common.util.CrashUtils;

/* JADX INFO: loaded from: classes.dex */
public class OlaTransferKenActivity extends chat.ola.vn.c implements View.OnClickListener {
    private a e;
    private TextView f;
    private View g;
    private View h;
    private ImageView i;
    private Runnable j;

    public static void a(Context context) {
        Intent intent = new Intent(context, (Class<?>) OlaTransferKenActivity.class);
        intent.setFlags(CrashUtils.ErrorDialogData.BINDER_CRASH);
        context.startActivity(intent);
        try {
            ((Activity) context).overridePendingTransition(R.anim.push_left_in, R.anim.push_left_out);
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, String str) {
        Intent intent = new Intent(context, (Class<?>) OlaTransferKenActivity.class);
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
            if (this.e != null && (aVarC = this.e.c()) != null) {
                fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_window_in_from_right, R.anim.anim_window_out_to_left);
                fragmentTransactionBeginTransaction.replace(R.id.transferKenFragment, aVarC, aVarC.getClass().getName());
                aVarC.a(this.e);
                f(aVarC.e_());
                this.e = aVarC;
            }
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public a C() {
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            if (this.e != null) {
                a aVarD = this.e.d();
                if (aVarD != null) {
                    fragmentTransactionBeginTransaction.setCustomAnimations(R.anim.anim_in_from_left, R.anim.anim_out_to_right);
                    fragmentTransactionBeginTransaction.replace(R.id.transferKenFragment, aVarD, aVarD.getClass().getName());
                    f(aVarD.e_());
                    fragmentTransactionBeginTransaction.commit();
                }
                this.e = aVarD;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return this.e;
    }

    @Override // chat.ola.vn.c
    protected void a() {
    }

    /* JADX WARN: Removed duplicated region for block: B:11:0x001e  */
    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(int r1, java.lang.String r2, byte[] r3, chat.ola.vn.entity.d[] r4, short r5) {
        /*
            r0 = this;
            r2 = 0
            r0.c(r2)
            r2 = 10
            r3 = 2131689631(0x7f0f009f, float:1.9008283E38)
            if (r1 == r2) goto L1e
            r2 = 39
            if (r1 == r2) goto L17
            switch(r1) {
                case 7: goto L1e;
                case 8: goto L13;
                default: goto L12;
            }
        L12:
            return
        L13:
            r1 = 2131690082(0x7f0f0262, float:1.9009198E38)
            goto L21
        L17:
            long r1 = java.lang.System.currentTimeMillis()
            chat.ola.vn.transferken.c.a = r1
            return
        L1e:
            r1 = 2131690204(0x7f0f02dc, float:1.9009445E38)
        L21:
            chat.ola.vn.i.i.a(r0, r3, r1)
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.transferken.OlaTransferKenActivity.a(int, java.lang.String, byte[], chat.ola.vn.entity.d[], short):void");
    }

    @Override // chat.ola.vn.c, chat.ola.vn.network.f
    public void a(short s) {
        c(false);
        c.a = System.currentTimeMillis();
        String str = c.c.c;
        try {
            f fVarD = h.t.d(str, (short) 0);
            if (fVarD == null) {
                fVarD = h.t.b(str, (short) 0, true);
            }
            if (fVarD != null) {
                j jVarB = e.b(str, c.b);
                jVarB.a((byte) 2);
                fVarD.a(jVarB);
                fVarD.K = Long.valueOf(System.currentTimeMillis());
                chat.ola.vn.util.c.b.c(OlaApplication.a(), str);
            }
        } catch (Throwable unused) {
        }
        chat.ola.vn.util.c.b.c(this, str);
        i.b(this, getString(R.string.dialog_title_inform), getString(R.string.message_transfer_ken_success_format, new Object[]{str})).setOnDismissListener(new DialogInterface.OnDismissListener() { // from class: chat.ola.vn.transferken.OlaTransferKenActivity.1
            @Override // android.content.DialogInterface.OnDismissListener
            public void onDismiss(DialogInterface dialogInterface) {
                try {
                    OlaTransferKenActivity.this.finish();
                } catch (Throwable unused2) {
                }
            }
        });
    }

    public void c(boolean z) {
        try {
            this.h.setVisibility(z ? 0 : 8);
            if (this.j == null) {
                this.j = new Runnable() { // from class: chat.ola.vn.transferken.OlaTransferKenActivity.2
                    @Override // java.lang.Runnable
                    public void run() {
                        if (OlaTransferKenActivity.this.h.getVisibility() != 8) {
                            OlaTransferKenActivity.this.h.setVisibility(8);
                        }
                    }
                };
            }
            OlaApplication.c(this.j);
            OlaApplication.a(this.j, 60000L);
        } catch (Throwable unused) {
        }
    }

    public void f(String str) {
        this.f.setText(str);
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
        super.onCreate(bundle);
        setContentView(R.layout.ola_transfer_ken_layout);
        this.h = findViewById(R.id.transferKenProgressBar);
        this.f = (TextView) findViewById(R.id.olaActionBarTitleTextView);
        try {
            FragmentTransaction fragmentTransactionBeginTransaction = getSupportFragmentManager().beginTransaction();
            this.e = (a) Fragment.instantiate(this, b.class.getName());
            fragmentTransactionBeginTransaction.add(R.id.transferKenFragment, this.e, b.class.getName());
            f(this.e.e_());
            this.g = findViewById(R.id.olaActionBarBackViewLayout);
            this.g.setOnClickListener(this);
            this.i = (ImageView) findViewById(R.id.olaActionBarMoreButtonImageView);
            this.i.setImageResource(R.drawable.ic_action_quit);
            this.i.setOnClickListener(this);
            this.i.setVisibility(0);
            this.g.setVisibility(0);
            fragmentTransactionBeginTransaction.commit();
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
