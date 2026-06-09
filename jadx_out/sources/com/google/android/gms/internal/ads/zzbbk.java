package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzbbk {
    static final /* synthetic */ int[] zzdti;
    static final /* synthetic */ int[] zzdtj = new int[zzbbw.values().length];

    static {
        try {
            zzdtj[zzbbw.BYTE_STRING.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzdtj[zzbbw.MESSAGE.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            zzdtj[zzbbw.STRING.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        zzdti = new int[zzbbl.values().length];
        try {
            zzdti[zzbbl.MAP.ordinal()] = 1;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            zzdti[zzbbl.VECTOR.ordinal()] = 2;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            zzdti[zzbbl.SCALAR.ordinal()] = 3;
        } catch (NoSuchFieldError unused6) {
        }
    }
}
