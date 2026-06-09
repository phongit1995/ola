package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzee extends zzei {
    public zzee(zzcz zzczVar, String str, String str2, zzba zzbaVar, int i, int i2) {
        super(zzczVar, str, str2, zzbaVar, i, 48);
    }

    @Override // com.google.android.gms.internal.ads.zzei
    protected final void zzar() {
        zzba zzbaVar;
        int i;
        this.zztq.zzel = 2;
        boolean zBooleanValue = ((Boolean) this.zztz.invoke(null, this.zzps.getContext())).booleanValue();
        synchronized (this.zztq) {
            try {
                if (zBooleanValue) {
                    zzbaVar = this.zztq;
                    i = 1;
                } else {
                    zzbaVar = this.zztq;
                    i = 0;
                }
                zzbaVar.zzel = i;
            } catch (Throwable th) {
                throw th;
            }
        }
    }
}
