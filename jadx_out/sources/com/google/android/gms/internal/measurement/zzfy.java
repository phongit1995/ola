package com.google.android.gms.internal.measurement;

import android.content.SharedPreferences;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfy {
    private String value;
    private boolean zzamo;
    private final /* synthetic */ zzft zzamp;
    private final String zzamu;
    private final String zzny;

    public zzfy(zzft zzftVar, String str, String str2) {
        this.zzamp = zzftVar;
        Preconditions.checkNotEmpty(str);
        this.zzny = str;
        this.zzamu = null;
    }

    @WorkerThread
    public final void zzbv(String str) {
        if (zzkd.zzs(str, this.value)) {
            return;
        }
        SharedPreferences.Editor editorEdit = this.zzamp.zzji().edit();
        editorEdit.putString(this.zzny, str);
        editorEdit.apply();
        this.value = str;
    }

    @WorkerThread
    public final String zzjq() {
        if (!this.zzamo) {
            this.zzamo = true;
            this.value = this.zzamp.zzji().getString(this.zzny, null);
        }
        return this.value;
    }
}
