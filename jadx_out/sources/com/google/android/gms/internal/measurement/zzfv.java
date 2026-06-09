package com.google.android.gms.internal.measurement;

import android.content.SharedPreferences;
import android.support.annotation.WorkerThread;
import com.google.android.gms.common.internal.Preconditions;

/* JADX INFO: loaded from: classes2.dex */
public final class zzfv {
    private boolean value;
    private final boolean zzamn;
    private boolean zzamo;
    private final /* synthetic */ zzft zzamp;
    private final String zzny;

    public zzfv(zzft zzftVar, String str, boolean z) {
        this.zzamp = zzftVar;
        Preconditions.checkNotEmpty(str);
        this.zzny = str;
        this.zzamn = true;
    }

    @WorkerThread
    public final boolean get() {
        if (!this.zzamo) {
            this.zzamo = true;
            this.value = this.zzamp.zzji().getBoolean(this.zzny, this.zzamn);
        }
        return this.value;
    }

    @WorkerThread
    public final void set(boolean z) {
        SharedPreferences.Editor editorEdit = this.zzamp.zzji().edit();
        editorEdit.putBoolean(this.zzny, z);
        editorEdit.apply();
        this.value = z;
    }
}
