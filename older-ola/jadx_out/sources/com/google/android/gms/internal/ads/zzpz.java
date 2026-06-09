package com.google.android.gms.internal.ads;

import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.RemoteException;
import com.google.android.gms.ads.formats.NativeAd;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzpz extends NativeAd.Image {
    private final Drawable mDrawable;
    private final Uri mUri;
    private final double zzbhv;
    private final zzpw zzbkm;

    public zzpz(zzpw zzpwVar) {
        IObjectWrapper iObjectWrapperZzjy;
        this.zzbkm = zzpwVar;
        Uri uri = null;
        try {
            iObjectWrapperZzjy = this.zzbkm.zzjy();
        } catch (RemoteException e) {
            zzane.zzb("", e);
        }
        Drawable drawable = iObjectWrapperZzjy != null ? (Drawable) ObjectWrapper.unwrap(iObjectWrapperZzjy) : null;
        this.mDrawable = drawable;
        try {
            uri = this.zzbkm.getUri();
        } catch (RemoteException e2) {
            zzane.zzb("", e2);
        }
        this.mUri = uri;
        double scale = 1.0d;
        try {
            scale = this.zzbkm.getScale();
        } catch (RemoteException e3) {
            zzane.zzb("", e3);
        }
        this.zzbhv = scale;
    }

    @Override // com.google.android.gms.ads.formats.NativeAd.Image
    public final Drawable getDrawable() {
        return this.mDrawable;
    }

    @Override // com.google.android.gms.ads.formats.NativeAd.Image
    public final double getScale() {
        return this.zzbhv;
    }

    @Override // com.google.android.gms.ads.formats.NativeAd.Image
    public final Uri getUri() {
        return this.mUri;
    }
}
