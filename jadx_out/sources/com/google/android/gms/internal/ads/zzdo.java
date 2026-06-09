package com.google.android.gms.internal.ads;

import java.util.concurrent.ExecutionException;

/* JADX INFO: loaded from: classes.dex */
public final class zzdo extends zzei {
    private static final Object zztn = new Object();
    private static volatile zzbj zzto;
    private zzax zztp;

    public zzdo(zzcz zzczVar, String str, String str2, zzba zzbaVar, int i, int i2, zzax zzaxVar) {
        super(zzczVar, str, str2, zzbaVar, i, 27);
        this.zztp = null;
        this.zztp = zzaxVar;
    }

    private final String zzas() {
        try {
            if (this.zzps.zzak() != null) {
                this.zzps.zzak().get();
            }
            zzba zzbaVarZzaj = this.zzps.zzaj();
            if (zzbaVarZzaj == null || zzbaVarZzaj.zzcx == null) {
                return null;
            }
            return zzbaVarZzaj.zzcx;
        } catch (InterruptedException | ExecutionException unused) {
            return null;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:30:0x007e  */
    @Override // com.google.android.gms.internal.ads.zzei
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected final void zzar() {
        /*
            Method dump skipped, instruction units count: 290
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzdo.zzar():void");
    }
}
