package com.google.android.gms.internal.measurement;

import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zzxd extends zzwx<Boolean> {
    zzxd(zzxh zzxhVar, String str, Boolean bool) {
        super(zzxhVar, str, bool, null);
    }

    @Override // com.google.android.gms.internal.measurement.zzwx
    protected final /* synthetic */ Boolean zzfa(String str) {
        if (zzws.zzbom.matcher(str).matches()) {
            return true;
        }
        if (zzws.zzbon.matcher(str).matches()) {
            return false;
        }
        String str2 = this.zzbpk;
        StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 28 + String.valueOf(str).length());
        sb.append("Invalid boolean value for ");
        sb.append(str2);
        sb.append(": ");
        sb.append(str);
        Log.e("PhenotypeFlag", sb.toString());
        return null;
    }
}
