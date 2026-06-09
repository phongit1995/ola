package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
final class zzbz {
    private final byte[] buffer;
    private final zzci zzmo;

    private zzbz(int i) {
        this.buffer = new byte[i];
        this.zzmo = zzci.zzb(this.buffer);
    }

    /* synthetic */ zzbz(int i, zzbv zzbvVar) {
        this(i);
    }

    public final zzbu zzca() {
        if (this.zzmo.zzdc() != 0) {
            throw new IllegalStateException("Did not write as much data as expected.");
        }
        return new zzcb(this.buffer);
    }

    public final zzci zzcb() {
        return this.zzmo;
    }
}
