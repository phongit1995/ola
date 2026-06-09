package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzayu {
    static final /* synthetic */ int[] zzdnm;
    static final /* synthetic */ int[] zzdnn = new int[zzayv.values().length];

    static {
        try {
            zzdnn[zzayv.NIST_P256.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzdnn[zzayv.NIST_P384.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            zzdnn[zzayv.NIST_P521.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        zzdnm = new int[zzayw.values().length];
        try {
            zzdnm[zzayw.UNCOMPRESSED.ordinal()] = 1;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            zzdnm[zzayw.COMPRESSED.ordinal()] = 2;
        } catch (NoSuchFieldError unused5) {
        }
    }
}
