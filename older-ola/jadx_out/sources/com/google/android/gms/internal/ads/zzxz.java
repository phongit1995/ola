package com.google.android.gms.internal.ads;

import android.os.Bundle;
import android.os.IInterface;
import com.google.android.gms.dynamic.IObjectWrapper;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public interface zzxz extends IInterface {
    String getBody();

    String getCallToAction();

    Bundle getExtras();

    String getHeadline();

    List getImages();

    boolean getOverrideClickHandling();

    boolean getOverrideImpressionRecording();

    String getPrice();

    double getStarRating();

    String getStore();

    zzlo getVideoController();

    void recordImpression();

    void zzb(IObjectWrapper iObjectWrapper, IObjectWrapper iObjectWrapper2, IObjectWrapper iObjectWrapper3);

    void zzj(IObjectWrapper iObjectWrapper);

    zzpw zzjz();

    void zzk(IObjectWrapper iObjectWrapper);

    IObjectWrapper zzke();

    zzps zzkf();

    void zzl(IObjectWrapper iObjectWrapper);

    IObjectWrapper zzmv();

    IObjectWrapper zzmw();
}
