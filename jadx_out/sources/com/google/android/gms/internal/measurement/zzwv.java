package com.google.android.gms.internal.measurement;

import android.database.ContentObserver;
import android.os.Handler;

/* JADX INFO: loaded from: classes2.dex */
final class zzwv extends ContentObserver {
    private final /* synthetic */ zzwu zzbpf;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzwv(zzwu zzwuVar, Handler handler) {
        super(null);
        this.zzbpf = zzwuVar;
    }

    @Override // android.database.ContentObserver
    public final void onChange(boolean z) {
        this.zzbpf.zzsi();
        this.zzbpf.zzsk();
    }
}
