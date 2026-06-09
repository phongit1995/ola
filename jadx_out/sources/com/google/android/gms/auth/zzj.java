package com.google.android.gms.auth;

import android.os.IBinder;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
final class zzj implements zzm<List<AccountChangeEvent>> {
    private final /* synthetic */ String zzu;
    private final /* synthetic */ int zzv;

    zzj(String str, int i) {
        this.zzu = str;
        this.zzv = i;
    }

    @Override // com.google.android.gms.auth.zzm
    public final /* synthetic */ List<AccountChangeEvent> zze(IBinder iBinder) {
        return ((AccountChangeEventsResponse) zzg.zzd(com.google.android.gms.internal.auth.zzi.zzd(iBinder).zzd(new AccountChangeEventsRequest().setAccountName(this.zzu).setEventIndex(this.zzv)))).getEvents();
    }
}
