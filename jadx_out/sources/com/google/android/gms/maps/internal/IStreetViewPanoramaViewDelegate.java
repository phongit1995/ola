package com.google.android.gms.maps.internal;

import android.os.Bundle;
import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;

/* JADX INFO: loaded from: classes2.dex */
public interface IStreetViewPanoramaViewDelegate extends IInterface {
    IStreetViewPanoramaDelegate getStreetViewPanorama();

    void getStreetViewPanoramaAsync(zzbp zzbpVar);

    IObjectWrapper getView();

    void onCreate(Bundle bundle);

    void onDestroy();

    void onLowMemory();

    void onPause();

    void onResume();

    void onSaveInstanceState(Bundle bundle);

    void onStart();

    void onStop();
}
