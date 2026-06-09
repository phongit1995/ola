package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface zzqo extends IInterface {
    void destroy();

    String getAdvertiser();

    String getBody();

    String getCallToAction();

    Bundle getExtras();

    String getHeadline();

    List getImages();

    String getMediationAdapterClassName();

    zzlo getVideoController();

    void performClick(Bundle bundle);

    boolean recordImpression(Bundle bundle);

    void reportTouchEvent(Bundle bundle);

    IObjectWrapper zzka();

    IObjectWrapper zzke();

    zzps zzkf();

    zzpw zzkg();
}
