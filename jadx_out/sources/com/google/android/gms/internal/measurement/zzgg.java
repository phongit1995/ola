package com.google.android.gms.internal.measurement;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

/* JADX INFO: loaded from: classes2.dex */
public interface zzgg {
    BroadcastReceiver.PendingResult doGoAsync();

    void doStartService(Context context, Intent intent);
}
