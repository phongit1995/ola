package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzgx {
    public static int zzbe(int i) {
        if (i >= 0 && i <= 6) {
            return i;
        }
        StringBuilder sb = new StringBuilder(42);
        sb.append(i);
        sb.append(" is not a valid enum OobReqType");
        throw new IllegalArgumentException(sb.toString());
    }
}
