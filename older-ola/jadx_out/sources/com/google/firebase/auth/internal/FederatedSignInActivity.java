package com.google.firebase.auth.internal;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import com.google.android.gms.common.annotation.KeepName;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.internal.safeparcel.SafeParcelableSerializer;
import com.google.android.gms.internal.firebase_auth.zzbf;

/* JADX INFO: loaded from: classes2.dex */
@KeepName
public class FederatedSignInActivity extends FragmentActivity {
    private static boolean zzlo = false;
    private boolean zzlp = false;

    private final void zza(int i, Intent intent) {
        zzlo = false;
        setResult(-1, intent);
        finish();
    }

    private final void zze(int i) {
        zzlo = false;
        this.zzlp = false;
        setResult(0);
        finish();
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        String action = getIntent().getAction();
        if (!"com.google.firebase.auth.internal.SIGN_IN".equals(action) && !"com.google.firebase.auth.internal.GET_CRED".equals(action)) {
            String strValueOf = String.valueOf(action);
            Log.e("IdpSignInActivity", strValueOf.length() != 0 ? "Unknown action: ".concat(strValueOf) : new String("Unknown action: "));
        } else if (!zzlo) {
            zzlo = true;
            if (bundle != null) {
                this.zzlp = bundle.getBoolean("com.google.firebase.auth.internal.KEY_STARTED_SIGN_IN");
                return;
            }
            return;
        }
        setResult(0);
        finish();
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
    }

    @Override // android.support.v4.app.FragmentActivity, android.app.Activity
    protected void onResume() {
        Intent intent;
        super.onResume();
        boolean z = true;
        if (!this.zzlp) {
            Intent intent2 = new Intent("com.google.firebase.auth.api.gms.ui.START_WEB_SIGN_IN");
            intent2.setPackage("com.google.android.gms");
            intent2.putExtras(getIntent().getExtras());
            intent2.putExtra("com.google.firebase.auth.internal.OPERATION", getIntent().getAction());
            try {
                startActivityForResult(intent2, 40963);
            } catch (ActivityNotFoundException unused) {
                Log.w("IdpSignInActivity", "Could not launch web sign-in Intent. Google Play service is unavailable");
                zze(0);
            }
            this.zzlp = true;
            return;
        }
        Intent intent3 = getIntent();
        if ("com.google.firebase.auth.internal.WEB_SIGN_IN_FAILED".equals(intent3.getAction())) {
            Log.e("IdpSignInActivity", "Web sign-in failed, finishing");
            if (zzaf.zza(intent3)) {
                Status statusZzb = zzaf.zzb(intent3);
                zzlo = false;
                Intent intent4 = new Intent();
                zzaf.zza(intent4, statusZzb);
                setResult(-1, intent4);
                finish();
            } else {
                zze(0);
            }
        } else if (intent3.hasExtra("com.google.firebase.auth.internal.OPERATION") && intent3.hasExtra("com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST")) {
            String stringExtra = intent3.getStringExtra("com.google.firebase.auth.internal.OPERATION");
            if ("com.google.firebase.auth.internal.SIGN_IN".equals(stringExtra)) {
                zzbf zzbfVar = (zzbf) SafeParcelableSerializer.deserializeFromIntentExtra(intent3, "com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST", zzbf.CREATOR);
                intent = new Intent();
                SafeParcelableSerializer.serializeToIntentExtra(zzbfVar, intent, "com.google.firebase.auth.internal.CREDENTIAL_FOR_AUTH_RESULT");
            } else {
                if ("com.google.firebase.auth.internal.GET_CRED".equals(stringExtra)) {
                    intent = new Intent();
                    intent.putExtra("com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST", intent3.getByteArrayExtra("com.google.firebase.auth.internal.VERIFY_ASSERTION_REQUEST"));
                }
                z = false;
            }
            zza(-1, intent);
        } else {
            z = false;
        }
        if (z) {
            return;
        }
        zze(0);
    }

    @Override // android.support.v4.app.FragmentActivity, android.support.v4.app.SupportActivity, android.app.Activity
    protected void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        bundle.putBoolean("com.google.firebase.auth.internal.KEY_STARTED_SIGN_IN", this.zzlp);
    }
}
