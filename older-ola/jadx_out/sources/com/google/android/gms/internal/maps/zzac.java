package com.google.android.gms.internal.maps;

import android.os.IInterface;

/* JADX INFO: loaded from: classes2.dex */
public interface zzac extends IInterface {
    void clearTileCache();

    boolean getFadeIn();

    String getId();

    float getTransparency();

    float getZIndex();

    boolean isVisible();

    void remove();

    void setFadeIn(boolean z);

    void setTransparency(float f);

    void setVisible(boolean z);

    void setZIndex(float f);

    boolean zza(zzac zzacVar);

    int zzi();
}
