package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface zzqk extends IInterface {
    void destroy();

    String getBody();

    String getCallToAction();

    Bundle getExtras();

    String getHeadline();

    List getImages();

    String getMediationAdapterClassName();

    String getPrice();

    double getStarRating();

    String getStore();

    zzlo getVideoController();

    void performClick(Bundle bundle);

    boolean recordImpression(Bundle bundle);

    void reportTouchEvent(Bundle bundle);

    zzpw zzjz();

    IObjectWrapper zzka();

    IObjectWrapper zzke();

    zzps zzkf();
}
