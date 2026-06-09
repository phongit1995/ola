package com.google.android.gms.internal.ads;

import android.content.Context;
import android.os.Bundle;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.view.View;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.dynamic.ObjectWrapper;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzoy extends zzpd {
    private Object mLock;

    @Nullable
    private zzxz zzbit;

    @Nullable
    private zzyc zzbiu;

    @Nullable
    private zzyf zzbiv;
    private final zzpa zzbiw;

    @Nullable
    private zzoz zzbix;
    private boolean zzbiy;

    private zzoy(Context context, zzpa zzpaVar, zzci zzciVar, zzpb zzpbVar) {
        super(context, zzpaVar, null, zzciVar, null, zzpbVar, null, null);
        this.zzbiy = false;
        this.mLock = new Object();
        this.zzbiw = zzpaVar;
    }

    public zzoy(Context context, zzpa zzpaVar, zzci zzciVar, zzxz zzxzVar, zzpb zzpbVar) {
        this(context, zzpaVar, zzciVar, zzpbVar);
        this.zzbit = zzxzVar;
    }

    public zzoy(Context context, zzpa zzpaVar, zzci zzciVar, zzyc zzycVar, zzpb zzpbVar) {
        this(context, zzpaVar, zzciVar, zzpbVar);
        this.zzbiu = zzycVar;
    }

    public zzoy(Context context, zzpa zzpaVar, zzci zzciVar, zzyf zzyfVar, zzpb zzpbVar) {
        this(context, zzpaVar, zzciVar, zzpbVar);
        this.zzbiv = zzyfVar;
    }

    private static HashMap<String, View> zzb(Map<String, WeakReference<View>> map) {
        HashMap<String, View> map2 = new HashMap<>();
        if (map == null) {
            return map2;
        }
        synchronized (map) {
            for (Map.Entry<String, WeakReference<View>> entry : map.entrySet()) {
                View view = entry.getValue().get();
                if (view != null) {
                    map2.put(entry.getKey(), view);
                }
            }
        }
        return map2;
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void cancelUnconfirmedClick() {
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                this.zzbix.cancelUnconfirmedClick();
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void setClickConfirmingView(View view) {
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                this.zzbix.setClickConfirmingView(view);
            }
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:35:0x0038, code lost:
    
        r4 = null;
     */
    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    @android.support.annotation.Nullable
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final android.view.View zza(android.view.View.OnClickListener r3, boolean r4) {
        /*
            r2 = this;
            java.lang.Object r0 = r2.mLock
            monitor-enter(r0)
            com.google.android.gms.internal.ads.zzoz r1 = r2.zzbix     // Catch: java.lang.Throwable -> L44
            if (r1 == 0) goto Lf
            com.google.android.gms.internal.ads.zzoz r1 = r2.zzbix     // Catch: java.lang.Throwable -> L44
            android.view.View r3 = r1.zza(r3, r4)     // Catch: java.lang.Throwable -> L44
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L44
            return r3
        Lf:
            r3 = 0
            com.google.android.gms.internal.ads.zzyf r4 = r2.zzbiv     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            if (r4 == 0) goto L1b
            com.google.android.gms.internal.ads.zzyf r4 = r2.zzbiv     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            com.google.android.gms.dynamic.IObjectWrapper r4 = r4.zzmv()     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            goto L38
        L1b:
            com.google.android.gms.internal.ads.zzxz r4 = r2.zzbit     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            if (r4 == 0) goto L26
            com.google.android.gms.internal.ads.zzxz r4 = r2.zzbit     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            com.google.android.gms.dynamic.IObjectWrapper r4 = r4.zzmv()     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            goto L38
        L26:
            com.google.android.gms.internal.ads.zzyc r4 = r2.zzbiu     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            if (r4 == 0) goto L37
            com.google.android.gms.internal.ads.zzyc r4 = r2.zzbiu     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            com.google.android.gms.dynamic.IObjectWrapper r4 = r4.zzmv()     // Catch: android.os.RemoteException -> L31 java.lang.Throwable -> L44
            goto L38
        L31:
            r4 = move-exception
            java.lang.String r1 = "Failed to call getAdChoicesContent"
            com.google.android.gms.internal.ads.zzakb.zzc(r1, r4)     // Catch: java.lang.Throwable -> L44
        L37:
            r4 = r3
        L38:
            if (r4 == 0) goto L42
            java.lang.Object r3 = com.google.android.gms.dynamic.ObjectWrapper.unwrap(r4)     // Catch: java.lang.Throwable -> L44
            android.view.View r3 = (android.view.View) r3     // Catch: java.lang.Throwable -> L44
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L44
            return r3
        L42:
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L44
            return r3
        L44:
            r3 = move-exception
            monitor-exit(r0)     // Catch: java.lang.Throwable -> L44
            throw r3
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.internal.ads.zzoy.zza(android.view.View$OnClickListener, boolean):android.view.View");
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zza(View view, Map<String, WeakReference<View>> map) {
        zzpa zzpaVar;
        Preconditions.checkMainThread("recordImpression must be called on the main UI thread.");
        synchronized (this.mLock) {
            this.zzbjd = true;
            if (this.zzbix != null) {
                this.zzbix.zza(view, map);
                this.zzbiw.recordImpression();
            } else {
                try {
                    if (this.zzbiv != null && !this.zzbiv.getOverrideImpressionRecording()) {
                        this.zzbiv.recordImpression();
                        zzpaVar = this.zzbiw;
                    } else if (this.zzbit != null && !this.zzbit.getOverrideImpressionRecording()) {
                        this.zzbit.recordImpression();
                        zzpaVar = this.zzbiw;
                    } else if (this.zzbiu != null && !this.zzbiu.getOverrideImpressionRecording()) {
                        this.zzbiu.recordImpression();
                        zzpaVar = this.zzbiw;
                    }
                    zzpaVar.recordImpression();
                } catch (RemoteException e) {
                    zzakb.zzc("Failed to call recordImpression", e);
                }
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zza(View view, Map<String, WeakReference<View>> map, Bundle bundle, View view2) {
        zzpa zzpaVar;
        Preconditions.checkMainThread("performClick must be called on the main UI thread.");
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                this.zzbix.zza(view, map, bundle, view2);
                this.zzbiw.onAdClicked();
            } else {
                try {
                    if (this.zzbiv != null && !this.zzbiv.getOverrideClickHandling()) {
                        this.zzbiv.zzj(ObjectWrapper.wrap(view));
                        zzpaVar = this.zzbiw;
                    } else if (this.zzbit != null && !this.zzbit.getOverrideClickHandling()) {
                        this.zzbit.zzj(ObjectWrapper.wrap(view));
                        zzpaVar = this.zzbiw;
                    } else if (this.zzbiu != null && !this.zzbiu.getOverrideClickHandling()) {
                        this.zzbiu.zzj(ObjectWrapper.wrap(view));
                        zzpaVar = this.zzbiw;
                    }
                    zzpaVar.onAdClicked();
                } catch (RemoteException e) {
                    zzakb.zzc("Failed to call performClick", e);
                }
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd
    public final void zza(View view, @Nullable Map<String, WeakReference<View>> map, @Nullable Map<String, WeakReference<View>> map2, View.OnTouchListener onTouchListener, View.OnClickListener onClickListener) {
        synchronized (this.mLock) {
            this.zzbiy = true;
            HashMap<String, View> mapZzb = zzb(map);
            HashMap<String, View> mapZzb2 = zzb(map2);
            try {
                if (this.zzbiv != null) {
                    this.zzbiv.zzb(ObjectWrapper.wrap(view), ObjectWrapper.wrap(mapZzb), ObjectWrapper.wrap(mapZzb2));
                } else if (this.zzbit != null) {
                    this.zzbit.zzb(ObjectWrapper.wrap(view), ObjectWrapper.wrap(mapZzb), ObjectWrapper.wrap(mapZzb2));
                    this.zzbit.zzk(ObjectWrapper.wrap(view));
                } else if (this.zzbiu != null) {
                    this.zzbiu.zzb(ObjectWrapper.wrap(view), ObjectWrapper.wrap(mapZzb), ObjectWrapper.wrap(mapZzb2));
                    this.zzbiu.zzk(ObjectWrapper.wrap(view));
                }
            } catch (RemoteException e) {
                zzakb.zzc("Failed to call prepareAd", e);
            }
            this.zzbiy = false;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zza(zzro zzroVar) {
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                this.zzbix.zza(zzroVar);
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzb(View view, Map<String, WeakReference<View>> map) {
        synchronized (this.mLock) {
            try {
                if (this.zzbiv != null) {
                    this.zzbiv.zzl(ObjectWrapper.wrap(view));
                } else if (this.zzbit != null) {
                    this.zzbit.zzl(ObjectWrapper.wrap(view));
                } else if (this.zzbiu != null) {
                    this.zzbiu.zzl(ObjectWrapper.wrap(view));
                }
            } catch (RemoteException e) {
                zzakb.zzc("Failed to call untrackView", e);
            }
        }
    }

    public final void zzc(@Nullable zzoz zzozVar) {
        synchronized (this.mLock) {
            this.zzbix = zzozVar;
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzcr() {
        if (this.zzbix != null) {
            this.zzbix.zzcr();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzcs() {
        if (this.zzbix != null) {
            this.zzbix.zzcs();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final boolean zzkj() {
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                return this.zzbix.zzkj();
            }
            return this.zzbiw.zzcu();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final boolean zzkk() {
        synchronized (this.mLock) {
            if (this.zzbix != null) {
                return this.zzbix.zzkk();
            }
            return this.zzbiw.zzcv();
        }
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzkl() {
        Preconditions.checkMainThread("recordDownloadedImpression must be called on main UI thread.");
        synchronized (this.mLock) {
            this.zzbje = true;
            if (this.zzbix != null) {
                this.zzbix.zzkl();
            }
        }
    }

    public final boolean zzkm() {
        boolean z;
        synchronized (this.mLock) {
            z = this.zzbiy;
        }
        return z;
    }

    public final zzoz zzkn() {
        zzoz zzozVar;
        synchronized (this.mLock) {
            zzozVar = this.zzbix;
        }
        return zzozVar;
    }

    @Override // com.google.android.gms.internal.ads.zzpd
    @Nullable
    public final zzaqw zzko() {
        return null;
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzkp() {
    }

    @Override // com.google.android.gms.internal.ads.zzpd, com.google.android.gms.internal.ads.zzoz
    public final void zzkq() {
    }
}
