package com.google.android.gms.internal.ads;

import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
@zzadh
final class zzud {
    private static final zzua zzbpe = zzua.zzlk();
    private static final float zzbpf = ((Float) zzkb.zzik().zzd(zznk.zzazk)).floatValue();
    private static final long zzbpg = ((Long) zzkb.zzik().zzd(zznk.zzazi)).longValue();
    private static final float zzbph = ((Float) zzkb.zzik().zzd(zznk.zzazl)).floatValue();
    private static final long zzbpi = ((Long) zzkb.zzik().zzd(zznk.zzazj)).longValue();

    @VisibleForTesting
    private static int zzb(long j, int i) {
        return (int) ((j >>> ((i % 16) * 4)) & 15);
    }

    static boolean zzlv() {
        int iZzlr = zzbpe.zzlr();
        int iZzls = zzbpe.zzls();
        int iZzlq = zzbpe.zzlq() + zzbpe.zzlp();
        int iZzb = Integer.MAX_VALUE;
        if (iZzls > ((iZzlr >= 16 || zzbpi == 0) ? zzbph != 0.0f ? ((int) (zzbph * iZzlr)) + 1 : Integer.MAX_VALUE : zzb(zzbpi, iZzlr))) {
            return false;
        }
        if (iZzlr < 16 && zzbpg != 0) {
            iZzb = zzb(zzbpg, iZzlr);
        } else if (zzbpf != 0.0f) {
            iZzb = (int) (zzbpf * iZzlr);
        }
        return iZzlq <= iZzb;
    }
}
