package com.google.android.gms.internal.measurement;

import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zzxb extends zzwx<Long> {
    zzxb(zzxh zzxhVar, String str, Long l) {
        super(zzxhVar, str, l, null);
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.measurement.zzwx
    /* JADX INFO: renamed from: zzfb, reason: merged with bridge method [inline-methods] */
    public final Long zzfa(String str) {
        try {
            return Long.valueOf(Long.parseLong(str));
        } catch (NumberFormatException unused) {
            String str2 = this.zzbpk;
            StringBuilder sb = new StringBuilder(String.valueOf(str2).length() + 25 + String.valueOf(str).length());
            sb.append("Invalid long value for ");
            sb.append(str2);
            sb.append(": ");
            sb.append(str);
            Log.e("PhenotypeFlag", sb.toString());
            return null;
        }
    }
}
