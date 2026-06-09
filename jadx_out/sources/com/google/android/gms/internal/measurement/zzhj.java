package com.google.android.gms.internal.measurement;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzhj extends zzhi {
    private boolean zzvn;

    zzhj(zzgn zzgnVar) {
        super(zzgnVar);
        this.zzacv.zzb(this);
    }

    final boolean isInitialized() {
        return this.zzvn;
    }

    protected final void zzch() {
        if (!isInitialized()) {
            throw new IllegalStateException("Not initialized");
        }
    }

    public final void zzgm() {
        if (this.zzvn) {
            throw new IllegalStateException("Can't initialize twice");
        }
        zzgo();
        this.zzacv.zzkf();
        this.zzvn = true;
    }

    protected abstract boolean zzgn();

    protected void zzgo() {
    }

    public final void zzm() {
        if (this.zzvn) {
            throw new IllegalStateException("Can't initialize twice");
        }
        if (zzgn()) {
            return;
        }
        this.zzacv.zzkf();
        this.zzvn = true;
    }
}
