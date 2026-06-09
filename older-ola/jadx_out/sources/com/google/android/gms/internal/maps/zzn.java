package com.google.android.gms.internal.maps;

import android.os.IBinder;
import android.os.IInterface;
import java.util.List;

/* JADX INFO: loaded from: classes2.dex */
public interface zzn extends IInterface {
    int getActiveLevelIndex();

    int getDefaultLevelIndex();

    List<IBinder> getLevels();

    boolean isUnderground();

    boolean zzb(zzn zznVar);

    int zzi();
}
