package com.google.firebase.events;

import com.google.android.gms.common.annotation.KeepForSdk;

/* JADX INFO: loaded from: classes2.dex */
@KeepForSdk
public interface Publisher {
    @KeepForSdk
    void publish(Event<?> event);
}
