package com.google.firebase.auth.api.internal;

import android.content.Context;
import android.content.pm.PackageManager;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.util.Log;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.AndroidUtilsLight;
import com.google.android.gms.common.util.Hex;

/* JADX INFO: loaded from: classes2.dex */
public final class zzdl {
    private final String packageName;
    private final String zzjc;

    public zzdl(Context context) {
        this(context, context.getPackageName());
    }

    private zzdl(@NonNull Context context, @NonNull String str) {
        Preconditions.checkNotNull(context);
        this.packageName = Preconditions.checkNotEmpty(str);
        try {
            byte[] packageCertificateHashBytes = AndroidUtilsLight.getPackageCertificateHashBytes(context, this.packageName);
            if (packageCertificateHashBytes != null) {
                this.zzjc = Hex.bytesToStringUppercase(packageCertificateHashBytes, false);
                return;
            }
            String strValueOf = String.valueOf(str);
            Log.e("FBA-PackageInfo", strValueOf.length() != 0 ? "single cert required: ".concat(strValueOf) : new String("single cert required: "));
            this.zzjc = null;
        } catch (PackageManager.NameNotFoundException unused) {
            String strValueOf2 = String.valueOf(str);
            Log.e("FBA-PackageInfo", strValueOf2.length() != 0 ? "no pkg: ".concat(strValueOf2) : new String("no pkg: "));
            this.zzjc = null;
        }
    }

    public final String getPackageName() {
        return this.packageName;
    }

    @Nullable
    public final String zzan() {
        return this.zzjc;
    }
}
