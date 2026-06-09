package com.google.android.gms.internal.measurement;

import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zzxc extends zzwx<Integer> {
    zzxc(zzxh zzxhVar, String str, Integer num) {
        super(zzxhVar, str, num, null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.measurement.zzwx
    /* JADX INFO: renamed from: zzfc, reason: merged with bridge method [inline-methods] */
    public final Integer zzfa(String str) {
        try {
            return Integer.valueOf(Integer.parseInt(str));
        } catch (NumberFormatException unused) {
            String str2 = this.zzbpk;
            StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 28 + String.valueOf(str).length());
            sb.append("Invalid integer value for ");
            sb.append(str2);
            sb.append(": ");
            sb.append(str);
            Log.e("PhenotypeFlag", sb.toString());
            return null;
        }
    }
}
