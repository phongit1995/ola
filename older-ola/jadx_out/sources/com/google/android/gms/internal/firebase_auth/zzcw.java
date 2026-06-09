package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final /* synthetic */ class zzcw {
    static final /* synthetic */ int[] zzql;
    static final /* synthetic */ int[] zzqm = new int[zzdj.values().length];

    static {
        try {
            zzqm[zzdj.BYTE_STRING.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzqm[zzdj.MESSAGE.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            zzqm[zzdj.STRING.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        zzql = new int[zzcx.values().length];
        try {
            zzql[zzcx.MAP.ordinal()] = 1;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            zzql[zzcx.VECTOR.ordinal()] = 2;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            zzql[zzcx.SCALAR.ordinal()] = 3;
        } catch (NoSuchFieldError unused6) {
        }
    }
}
