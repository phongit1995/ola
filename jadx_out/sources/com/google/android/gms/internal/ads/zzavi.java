package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzavi {
    static final /* synthetic */ int[] zzdhz;
    static final /* synthetic */ int[] zzdia;
    static final /* synthetic */ int[] zzdib = new int[zzawk.values().length];

    static {
        try {
            zzdib[zzawk.UNCOMPRESSED.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzdib[zzawk.COMPRESSED.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        zzdia = new int[zzawy.values().length];
        try {
            zzdia[zzawy.NIST_P256.ordinal()] = 1;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            zzdia[zzawy.NIST_P384.ordinal()] = 2;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            zzdia[zzawy.NIST_P521.ordinal()] = 3;
        } catch (NoSuchFieldError unused5) {
        }
        zzdhz = new int[zzaxa.values().length];
        try {
            zzdhz[zzaxa.SHA1.ordinal()] = 1;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            zzdhz[zzaxa.SHA256.ordinal()] = 2;
        } catch (NoSuchFieldError unused7) {
        }
        try {
            zzdhz[zzaxa.SHA512.ordinal()] = 3;
        } catch (NoSuchFieldError unused8) {
        }
    }
}
