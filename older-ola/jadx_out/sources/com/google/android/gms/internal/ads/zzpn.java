package com.google.android.gms.internal.ads;

import android.annotation.TargetApi;
import android.graphics.Point;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.FrameLayout;
import com.google.android.gms.ads.formats.NativeAd;
import com.google.android.gms.ads.formats.NativeAppInstallAd;
import com.google.android.gms.ads.formats.NativeContentAd;
import com.google.android.gms.ads.formats.UnifiedNativeAdAssetNames;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.IObjectWrapper;
import com.google.android.gms.dynamic.ObjectWrapper;
import java.lang.ref.WeakReference;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzpn extends zzqb implements View.OnClickListener, View.OnTouchListener, ViewTreeObserver.OnGlobalLayoutListener, ViewTreeObserver.OnScrollChangedListener {

    @VisibleForTesting
    private static final String[] zzbjs = {NativeAppInstallAd.ASSET_MEDIA_VIDEO, NativeContentAd.ASSET_MEDIA_VIDEO, UnifiedNativeAdAssetNames.ASSET_MEDIA_VIDEO};

    @VisibleForTesting
    @Nullable
    private zzoz zzbij;
    private final FrameLayout zzbjt;
    private View zzbju;
    private final boolean zzbjv;

    @VisibleForTesting
    @Nullable
    private View zzbjx;

    @VisibleForTesting
    @Nullable
    private FrameLayout zzvh;
    private final Object mLock = new Object();

    @VisibleForTesting
    private Map<String, WeakReference<View>> zzbjw = Collections.synchronizedMap(new HashMap());

    @VisibleForTesting
    private boolean zzbjy = false;

    @VisibleForTesting
    private Point zzbjz = new Point();

    @VisibleForTesting
    private Point zzbka = new Point();

    @VisibleForTesting
    private WeakReference<zzfp> zzbkb = new WeakReference<>(null);

    @TargetApi(21)
    public zzpn(FrameLayout frameLayout, FrameLayout frameLayout2) {
        this.zzbjt = frameLayout;
        this.zzvh = frameLayout2;
        com.google.android.gms.ads.internal.zzbv.zzfg();
        zzaor.zza((View) this.zzbjt, (ViewTreeObserver.OnGlobalLayoutListener) this);
        com.google.android.gms.ads.internal.zzbv.zzfg();
        zzaor.zza((View) this.zzbjt, (ViewTreeObserver.OnScrollChangedListener) this);
        this.zzbjt.setOnTouchListener(this);
        this.zzbjt.setOnClickListener(this);
        if (frameLayout2 != null && PlatformVersion.isAtLeastLollipop()) {
            frameLayout2.setElevation(Float.MAX_VALUE);
        }
        zznk.initialize(this.zzbjt.getContext());
        this.zzbjv = ((Boolean) zzkb.zzik().zzd(zznk.zzbcd)).booleanValue();
    }

    private final void zzkt() {
        synchronized (this.mLock) {
            if (!this.zzbjv && this.zzbjy) {
                int measuredWidth = this.zzbjt.getMeasuredWidth();
                int measuredHeight = this.zzbjt.getMeasuredHeight();
                if (measuredWidth != 0 && measuredHeight != 0 && this.zzvh != null) {
                    this.zzvh.setLayoutParams(new FrameLayout.LayoutParams(measuredWidth, measuredHeight));
                    this.zzbjy = false;
                }
            }
        }
    }

    private final void zzl(@Nullable View view) {
        if (this.zzbij != null) {
            zzoz zzozVarZzkn = this.zzbij instanceof zzoy ? ((zzoy) this.zzbij).zzkn() : this.zzbij;
            if (zzozVarZzkn != null) {
                zzozVarZzkn.zzl(view);
            }
        }
    }

    @VisibleForTesting
    private final int zzv(int i) {
        zzkb.zzif();
        return zzamu.zzb(this.zzbij.getContext(), i);
    }

    @Override // com.google.android.gms.internal.ads.zzqa
    public final void destroy() {
        synchronized (this.mLock) {
            if (this.zzvh != null) {
                this.zzvh.removeAllViews();
            }
            this.zzvh = null;
            this.zzbjw = null;
            this.zzbjx = null;
            this.zzbij = null;
            this.zzbjz = null;
            this.zzbka = null;
            this.zzbkb = null;
            this.zzbju = null;
        }
    }

    @Override // android.view.View.OnClickListener
    public final void onClick(View view) {
        zzoz zzozVarZzkn;
        String str;
        Map<String, WeakReference<View>> map;
        FrameLayout frameLayout;
        synchronized (this.mLock) {
            if (this.zzbij == null) {
                return;
            }
            this.zzbij.cancelUnconfirmedClick();
            Bundle bundle = new Bundle();
            bundle.putFloat("x", zzv(this.zzbjz.x));
            bundle.putFloat("y", zzv(this.zzbjz.y));
            bundle.putFloat("start_x", zzv(this.zzbka.x));
            bundle.putFloat("start_y", zzv(this.zzbka.y));
            if (this.zzbjx == null || !this.zzbjx.equals(view)) {
                this.zzbij.zza(view, this.zzbjw, bundle, this.zzbjt);
            } else {
                if (!(this.zzbij instanceof zzoy)) {
                    zzozVarZzkn = this.zzbij;
                    str = NativeContentAd.ASSET_ATTRIBUTION_ICON_IMAGE;
                    map = this.zzbjw;
                    frameLayout = this.zzbjt;
                } else if (((zzoy) this.zzbij).zzkn() != null) {
                    zzozVarZzkn = ((zzoy) this.zzbij).zzkn();
                    str = NativeContentAd.ASSET_ATTRIBUTION_ICON_IMAGE;
                    map = this.zzbjw;
                    frameLayout = this.zzbjt;
                }
                zzozVarZzkn.zza(view, str, bundle, map, frameLayout);
            }
        }
    }

    @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
    public final void onGlobalLayout() {
        synchronized (this.mLock) {
            zzkt();
            if (this.zzbij != null) {
                this.zzbij.zzc(this.zzbjt, this.zzbjw);
            }
        }
    }

    @Override // android.view.ViewTreeObserver.OnScrollChangedListener
    public final void onScrollChanged() {
        synchronized (this.mLock) {
            if (this.zzbij != null) {
                this.zzbij.zzc(this.zzbjt, this.zzbjw);
            }
            zzkt();
        }
    }

    @Override // android.view.View.OnTouchListener
    public final boolean onTouch(View view, MotionEvent motionEvent) {
        synchronized (this.mLock) {
            if (this.zzbij == null) {
                return false;
            }
            this.zzbjt.getLocationOnScreen(new int[2]);
            Point point = new Point((int) (motionEvent.getRawX() - r0[0]), (int) (motionEvent.getRawY() - r0[1]));
            this.zzbjz = point;
            if (motionEvent.getAction() == 0) {
                this.zzbka = point;
            }
            MotionEvent motionEventObtain = MotionEvent.obtain(motionEvent);
            motionEventObtain.setLocation(point.x, point.y);
            this.zzbij.zzd(motionEventObtain);
            motionEventObtain.recycle();
            return false;
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:139:0x01be A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:63:0x0105 A[Catch: all -> 0x0259, TryCatch #1 {, blocks: (B:5:0x0004, B:7:0x000f, B:8:0x0014, B:10:0x0016, B:12:0x001b, B:14:0x001f, B:15:0x002e, B:17:0x0037, B:19:0x0049, B:20:0x0052, B:22:0x0058, B:24:0x005e, B:26:0x0064, B:28:0x0074, B:30:0x007a, B:31:0x007d, B:34:0x0089, B:35:0x008c, B:37:0x0092, B:39:0x009c, B:43:0x00b0, B:45:0x00b4, B:47:0x00b6, B:49:0x00c8, B:50:0x00cd, B:52:0x00d8, B:54:0x00dc, B:56:0x00ea, B:58:0x00f6, B:61:0x0101, B:63:0x0105, B:69:0x010f, B:71:0x011a, B:73:0x011e, B:75:0x012e, B:76:0x0137, B:78:0x0151, B:79:0x0156, B:81:0x0165, B:83:0x0169, B:84:0x0180, B:86:0x018a, B:87:0x0191, B:96:0x01ae, B:98:0x01b2, B:99:0x01bb, B:100:0x01bd, B:119:0x01fc, B:121:0x0213, B:123:0x0219, B:125:0x021f, B:127:0x022f, B:129:0x0239, B:130:0x024d, B:131:0x0254, B:135:0x0258, B:90:0x0197, B:92:0x01a0, B:93:0x01a6, B:59:0x00fd, B:40:0x00a4, B:42:0x00aa, B:101:0x01be, B:103:0x01c7, B:105:0x01cc, B:107:0x01d8, B:108:0x01df, B:109:0x01e2, B:111:0x01e6, B:112:0x01e9, B:114:0x01eb, B:116:0x01f4, B:117:0x01f8), top: B:141:0x0004, inners: #0, #2 }] */
    /* JADX WARN: Removed duplicated region for block: B:64:0x0108  */
    /* JADX WARN: Removed duplicated region for block: B:66:0x010b A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:68:0x010e  */
    /* JADX WARN: Removed duplicated region for block: B:71:0x011a A[Catch: all -> 0x0259, TryCatch #1 {, blocks: (B:5:0x0004, B:7:0x000f, B:8:0x0014, B:10:0x0016, B:12:0x001b, B:14:0x001f, B:15:0x002e, B:17:0x0037, B:19:0x0049, B:20:0x0052, B:22:0x0058, B:24:0x005e, B:26:0x0064, B:28:0x0074, B:30:0x007a, B:31:0x007d, B:34:0x0089, B:35:0x008c, B:37:0x0092, B:39:0x009c, B:43:0x00b0, B:45:0x00b4, B:47:0x00b6, B:49:0x00c8, B:50:0x00cd, B:52:0x00d8, B:54:0x00dc, B:56:0x00ea, B:58:0x00f6, B:61:0x0101, B:63:0x0105, B:69:0x010f, B:71:0x011a, B:73:0x011e, B:75:0x012e, B:76:0x0137, B:78:0x0151, B:79:0x0156, B:81:0x0165, B:83:0x0169, B:84:0x0180, B:86:0x018a, B:87:0x0191, B:96:0x01ae, B:98:0x01b2, B:99:0x01bb, B:100:0x01bd, B:119:0x01fc, B:121:0x0213, B:123:0x0219, B:125:0x021f, B:127:0x022f, B:129:0x0239, B:130:0x024d, B:131:0x0254, B:135:0x0258, B:90:0x0197, B:92:0x01a0, B:93:0x01a6, B:59:0x00fd, B:40:0x00a4, B:42:0x00aa, B:101:0x01be, B:103:0x01c7, B:105:0x01cc, B:107:0x01d8, B:108:0x01df, B:109:0x01e2, B:111:0x01e6, B:112:0x01e9, B:114:0x01eb, B:116:0x01f4, B:117:0x01f8), top: B:141:0x0004, inners: #0, #2 }] */
    /* JADX WARN: Removed duplicated region for block: B:81:0x0165 A[Catch: all -> 0x0259, TryCatch #1 {, blocks: (B:5:0x0004, B:7:0x000f, B:8:0x0014, B:10:0x0016, B:12:0x001b, B:14:0x001f, B:15:0x002e, B:17:0x0037, B:19:0x0049, B:20:0x0052, B:22:0x0058, B:24:0x005e, B:26:0x0064, B:28:0x0074, B:30:0x007a, B:31:0x007d, B:34:0x0089, B:35:0x008c, B:37:0x0092, B:39:0x009c, B:43:0x00b0, B:45:0x00b4, B:47:0x00b6, B:49:0x00c8, B:50:0x00cd, B:52:0x00d8, B:54:0x00dc, B:56:0x00ea, B:58:0x00f6, B:61:0x0101, B:63:0x0105, B:69:0x010f, B:71:0x011a, B:73:0x011e, B:75:0x012e, B:76:0x0137, B:78:0x0151, B:79:0x0156, B:81:0x0165, B:83:0x0169, B:84:0x0180, B:86:0x018a, B:87:0x0191, B:96:0x01ae, B:98:0x01b2, B:99:0x01bb, B:100:0x01bd, B:119:0x01fc, B:121:0x0213, B:123:0x0219, B:125:0x021f, B:127:0x022f, B:129:0x0239, B:130:0x024d, B:131:0x0254, B:135:0x0258, B:90:0x0197, B:92:0x01a0, B:93:0x01a6, B:59:0x00fd, B:40:0x00a4, B:42:0x00aa, B:101:0x01be, B:103:0x01c7, B:105:0x01cc, B:107:0x01d8, B:108:0x01df, B:109:0x01e2, B:111:0x01e6, B:112:0x01e9, B:114:0x01eb, B:116:0x01f4, B:117:0x01f8), top: B:141:0x0004, inners: #0, #2 }] */
    @Override // com.google.android.gms.internal.ads.zzqa
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final void zza(com.google.android.gms.dynamic.IObjectWrapper r12) {
        /*
            Method dump skipped, instruction units count: 604
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzpn.zza(com.google.android.gms.dynamic.IObjectWrapper):void");
    }

    @Override // com.google.android.gms.internal.ads.zzqa
    public final IObjectWrapper zzak(String str) {
        synchronized (this.mLock) {
            View view = null;
            if (this.zzbjw == null) {
                return null;
            }
            WeakReference<View> weakReference = this.zzbjw.get(str);
            if (weakReference != null) {
                view = weakReference.get();
            }
            return ObjectWrapper.wrap(view);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzqa
    public final void zzb(IObjectWrapper iObjectWrapper, int i) {
        zzfp zzfpVar;
        if (com.google.android.gms.ads.internal.zzbv.zzfh().zzu(this.zzbjt.getContext()) && this.zzbkb != null && (zzfpVar = this.zzbkb.get()) != null) {
            zzfpVar.zzgm();
        }
        zzkt();
    }

    @Override // com.google.android.gms.internal.ads.zzqa
    public final void zzb(String str, IObjectWrapper iObjectWrapper) {
        View view = (View) ObjectWrapper.unwrap(iObjectWrapper);
        synchronized (this.mLock) {
            if (this.zzbjw == null) {
                return;
            }
            if (view != null) {
                this.zzbjw.put(str, new WeakReference<>(view));
                if (!NativeAd.ASSET_ADCHOICES_CONTAINER_VIEW.equals(str) && !UnifiedNativeAdAssetNames.ASSET_ADCHOICES_CONTAINER_VIEW.equals(str)) {
                    view.setOnTouchListener(this);
                    view.setClickable(true);
                    view.setOnClickListener(this);
                }
                return;
            }
            this.zzbjw.remove(str);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzqa
    public final void zzc(IObjectWrapper iObjectWrapper) {
        this.zzbij.setClickConfirmingView((View) ObjectWrapper.unwrap(iObjectWrapper));
    }
}
