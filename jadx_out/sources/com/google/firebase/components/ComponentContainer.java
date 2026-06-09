package com.google.firebase.components;

import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.firebase.inject.Provider;

/* JADX INFO: loaded from: classes2.dex */
@KeepForSdk
public interface ComponentContainer {
    @KeepForSdk
    <T> T get(Class<T> cls);

    @KeepForSdk
    <T> Provider<T> getProvider(Class<T> cls);
}
