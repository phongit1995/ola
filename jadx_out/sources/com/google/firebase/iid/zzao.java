package com.google.firebase.iid;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

/* JADX INFO: loaded from: classes2.dex */
final class zzao extends Handler {
    private final /* synthetic */ zzan zzcp;

    /* JADX WARN: 'super' call moved to the top of the method (can break code semantics) */
    zzao(zzan zzanVar, Looper looper) {
        super(looper);
        this.zzcp = zzanVar;
    }

    @Override // android.os.Handler
    public final void handleMessage(Message message) {
        this.zzcp.zzb(message);
    }
}
