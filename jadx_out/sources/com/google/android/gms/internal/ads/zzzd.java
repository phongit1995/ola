package com.google.android.gms.internal.ads;

import com.google.ads.AdRequest;

/* JADX INFO: loaded from: classes.dex */
final /* synthetic */ class zzzd {
    private static final /* synthetic */ int[] zzbvf;
    static final /* synthetic */ int[] zzbvg = new int[AdRequest.ErrorCode.values().length];

    static {
        try {
            zzbvg[AdRequest.ErrorCode.INTERNAL_ERROR.ordinal()] = 1;
        } catch (NoSuchFieldError unused) {
        }
        try {
            zzbvg[AdRequest.ErrorCode.INVALID_REQUEST.ordinal()] = 2;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            zzbvg[AdRequest.ErrorCode.NETWORK_ERROR.ordinal()] = 3;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            zzbvg[AdRequest.ErrorCode.NO_FILL.ordinal()] = 4;
        } catch (NoSuchFieldError unused4) {
        }
        zzbvf = new int[AdRequest.Gender.values().length];
        try {
            zzbvf[AdRequest.Gender.FEMALE.ordinal()] = 1;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            zzbvf[AdRequest.Gender.MALE.ordinal()] = 2;
        } catch (NoSuchFieldError unused6) {
        }
        try {
            zzbvf[AdRequest.Gender.UNKNOWN.ordinal()] = 3;
        } catch (NoSuchFieldError unused7) {
        }
    }
}
