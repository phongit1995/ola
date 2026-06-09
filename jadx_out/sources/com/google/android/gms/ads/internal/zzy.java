package com.google.android.gms.ads.internal;

import android.content.Context;
import android.graphics.Rect;
import android.os.RemoteException;
import android.support.annotation.Nullable;
import android.support.v4.util.ArrayMap;
import android.view.View;
import android.view.ViewTreeObserver;
import android.webkit.WebView;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.dynamic.ObjectWrapper;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzait;
import com.google.android.gms.internal.ads.zzaix;
import com.google.android.gms.internal.ads.zzajh;
import com.google.android.gms.internal.ads.zzaji;
import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzakk;
import com.google.android.gms.internal.ads.zzang;
import com.google.android.gms.internal.ads.zzaqw;
import com.google.android.gms.internal.ads.zzasg;
import com.google.android.gms.internal.ads.zzasi;
import com.google.android.gms.internal.ads.zzfp;
import com.google.android.gms.internal.ads.zzjj;
import com.google.android.gms.internal.ads.zzjn;
import com.google.android.gms.internal.ads.zzkb;
import com.google.android.gms.internal.ads.zzlo;
import com.google.android.gms.internal.ads.zzxn;
import com.google.android.gms.internal.ads.zzxz;
import com.google.android.gms.internal.ads.zzyc;
import java.lang.ref.WeakReference;
import java.util.List;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zzy extends zzi implements ViewTreeObserver.OnGlobalLayoutListener, ViewTreeObserver.OnScrollChangedListener {
    private boolean zzvm;
    private boolean zzxf;
    private WeakReference<Object> zzxg;

    public zzy(Context context, zzjn zzjnVar, String str, zzxn zzxnVar, zzang zzangVar, zzw zzwVar) {
        super(context, zzjnVar, str, zzxnVar, zzangVar, zzwVar);
        this.zzxg = new WeakReference<>(null);
    }

    private final void zzc(zzaqw zzaqwVar) {
        WebView webView;
        View view;
        if (zzcp() && (webView = zzaqwVar.getWebView()) != null && (view = zzaqwVar.getView()) != null && zzbv.zzfa().zzi(this.zzvw.zzrt)) {
            int i = this.zzvw.zzacr.zzcve;
            int i2 = this.zzvw.zzacr.zzcvf;
            StringBuilder sb = new StringBuilder(23);
            sb.append(i);
            sb.append(".");
            sb.append(i2);
            this.zzwb = zzbv.zzfa().zza(sb.toString(), webView, "", "javascript", zzbz());
            if (this.zzwb != null) {
                zzbv.zzfa().zza(this.zzwb, view);
                zzbv.zzfa().zzm(this.zzwb);
                this.zzxf = true;
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$UnknownArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:593)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    private final boolean zzd(@Nullable zzajh zzajhVar, zzajh zzajhVar2) {
        if (zzajhVar2.zzceq) {
            View viewZze = zzas.zze(zzajhVar2);
            if (viewZze == null) {
                zzakb.zzdk("Could not get mediation view");
                return false;
            }
            View nextView = this.zzvw.zzacs.getNextView();
            if (nextView != 0) {
                if (nextView instanceof zzaqw) {
                    ((zzaqw) nextView).destroy();
                }
                this.zzvw.zzacs.removeView(nextView);
            }
            if (!zzas.zzf(zzajhVar2)) {
                try {
                    if (zzbv.zzfh().zzt(this.zzvw.zzrt)) {
                        new zzfp(this.zzvw.zzrt, viewZze).zza(new zzaix(this.zzvw.zzrt, this.zzvw.zzacp));
                    }
                    if (zzajhVar2.zzcof != null) {
                        this.zzvw.zzacs.setMinimumWidth(zzajhVar2.zzcof.widthPixels);
                        this.zzvw.zzacs.setMinimumHeight(zzajhVar2.zzcof.heightPixels);
                    }
                    zzg(viewZze);
                } catch (Exception e) {
                    zzbv.zzeo().zza(e, "BannerAdManager.swapViews");
                    zzakb.zzc("Could not add mediation view to view hierarchy.", e);
                    return false;
                }
            }
        } else if (zzajhVar2.zzcof != null && zzajhVar2.zzbyo != null) {
            zzajhVar2.zzbyo.zza(zzasi.zzb(zzajhVar2.zzcof));
            this.zzvw.zzacs.removeAllViews();
            this.zzvw.zzacs.setMinimumWidth(zzajhVar2.zzcof.widthPixels);
            this.zzvw.zzacs.setMinimumHeight(zzajhVar2.zzcof.heightPixels);
            zzg(zzajhVar2.zzbyo.getView());
        }
        if (this.zzvw.zzacs.getChildCount() > 1) {
            this.zzvw.zzacs.showNext();
        }
        if (zzajhVar != null) {
            View nextView2 = this.zzvw.zzacs.getNextView();
            if (nextView2 instanceof zzaqw) {
                ((zzaqw) nextView2).destroy();
            } else if (nextView2 != 0) {
                this.zzvw.zzacs.removeView(nextView2);
            }
            this.zzvw.zzfn();
        }
        this.zzvw.zzacs.setVisibility(0);
        return true;
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    @Nullable
    public final zzlo getVideoController() {
        Preconditions.checkMainThread("getVideoController must be called from the main thread.");
        if (this.zzvw.zzacw == null || this.zzvw.zzacw.zzbyo == null) {
            return null;
        }
        return this.zzvw.zzacw.zzbyo.zztm();
    }

    @Override // android.view.ViewTreeObserver.OnGlobalLayoutListener
    public final void onGlobalLayout() {
        zzd(this.zzvw.zzacw);
    }

    @Override // android.view.ViewTreeObserver.OnScrollChangedListener
    public final void onScrollChanged() {
        zzd(this.zzvw.zzacw);
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final void setManualImpressionsEnabled(boolean z) {
        Preconditions.checkMainThread("setManualImpressionsEnabled must be called from the main thread.");
        this.zzvm = z;
    }

    @Override // com.google.android.gms.ads.internal.zzd, com.google.android.gms.internal.ads.zzks
    public final void showInterstitial() {
        throw new IllegalStateException("Interstitial is NOT supported by BannerAdManager.");
    }

    @Override // com.google.android.gms.ads.internal.zzi
    protected final zzaqw zza(zzaji zzajiVar, @Nullable zzx zzxVar, @Nullable zzait zzaitVar) {
        AdSize adSizeZzhy;
        zzjn zzjnVar;
        if (this.zzvw.zzacv.zzard == null && this.zzvw.zzacv.zzarf) {
            zzbw zzbwVar = this.zzvw;
            if (zzajiVar.zzcos.zzarf) {
                zzjnVar = this.zzvw.zzacv;
            } else {
                String str = zzajiVar.zzcos.zzcet;
                if (str != null) {
                    String[] strArrSplit = str.split("[xX]");
                    strArrSplit[0] = strArrSplit[0].trim();
                    strArrSplit[1] = strArrSplit[1].trim();
                    adSizeZzhy = new AdSize(Integer.parseInt(strArrSplit[0]), Integer.parseInt(strArrSplit[1]));
                } else {
                    adSizeZzhy = this.zzvw.zzacv.zzhy();
                }
                zzjnVar = new zzjn(this.zzvw.zzrt, adSizeZzhy);
            }
            zzbwVar.zzacv = zzjnVar;
        }
        return super.zza(zzajiVar, zzxVar, zzaitVar);
    }

    @Override // com.google.android.gms.ads.internal.zzd
    protected final void zza(@Nullable zzajh zzajhVar, boolean z) {
        if (zzcp()) {
            zzaqw zzaqwVar = zzajhVar != null ? zzajhVar.zzbyo : null;
            if (zzaqwVar != null) {
                if (!this.zzxf) {
                    zzc(zzaqwVar);
                }
                if (this.zzwb != null) {
                    zzaqwVar.zza("onSdkImpression", new ArrayMap());
                }
            }
        }
        super.zza(zzajhVar, z);
        if (zzas.zzf(zzajhVar)) {
            zzac zzacVar = new zzac(this);
            if (zzajhVar == null || !zzas.zzf(zzajhVar)) {
                return;
            }
            zzaqw zzaqwVar2 = zzajhVar.zzbyo;
            View view = zzaqwVar2 != null ? zzaqwVar2.getView() : null;
            if (view == null) {
                zzakb.zzdk("AdWebView is null");
                return;
            }
            try {
                List<String> list = zzajhVar.zzbtw != null ? zzajhVar.zzbtw.zzbsi : null;
                if (list != null && !list.isEmpty()) {
                    zzxz zzxzVarZzmo = zzajhVar.zzbtx != null ? zzajhVar.zzbtx.zzmo() : null;
                    zzyc zzycVarZzmp = zzajhVar.zzbtx != null ? zzajhVar.zzbtx.zzmp() : null;
                    if (list.contains("2") && zzxzVarZzmo != null) {
                        zzxzVarZzmo.zzk(ObjectWrapper.wrap(view));
                        if (!zzxzVarZzmo.getOverrideImpressionRecording()) {
                            zzxzVarZzmo.recordImpression();
                        }
                        zzaqwVar2.zza("/nativeExpressViewClicked", zzas.zza(zzxzVarZzmo, (zzyc) null, zzacVar));
                        return;
                    }
                    if (!list.contains("1") || zzycVarZzmp == null) {
                        zzakb.zzdk("No matching template id and mapper");
                        return;
                    }
                    zzycVarZzmp.zzk(ObjectWrapper.wrap(view));
                    if (!zzycVarZzmp.getOverrideImpressionRecording()) {
                        zzycVarZzmp.recordImpression();
                    }
                    zzaqwVar2.zza("/nativeExpressViewClicked", zzas.zza((zzxz) null, zzycVarZzmp, zzacVar));
                    return;
                }
                zzakb.zzdk("No template ids present in mediation response");
            } catch (RemoteException e) {
                zzakb.zzc("Error occurred while recording impression and registering for clicks", e);
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:28:0x007e  */
    @Override // com.google.android.gms.ads.internal.zzi, com.google.android.gms.ads.internal.zzd, com.google.android.gms.ads.internal.zza
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public final boolean zza(@android.support.annotation.Nullable com.google.android.gms.internal.ads.zzajh r5, final com.google.android.gms.internal.ads.zzajh r6) {
        /*
            Method dump skipped, instruction units count: 324
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.gms.ads.internal.zzy.zza(com.google.android.gms.internal.ads.zzajh, com.google.android.gms.internal.ads.zzajh):boolean");
    }

    @Override // com.google.android.gms.ads.internal.zza, com.google.android.gms.internal.ads.zzks
    public final boolean zzb(zzjj zzjjVar) {
        zzy zzyVar = this;
        zzjj zzjjVar2 = zzjjVar;
        if (zzjjVar2.zzaqb != zzyVar.zzvm) {
            zzjjVar2 = new zzjj(zzjjVar2.versionCode, zzjjVar2.zzapw, zzjjVar2.extras, zzjjVar2.zzapx, zzjjVar2.zzapy, zzjjVar2.zzapz, zzjjVar2.zzaqa, zzjjVar2.zzaqb || zzyVar.zzvm, zzjjVar2.zzaqc, zzjjVar2.zzaqd, zzjjVar2.zzaqe, zzjjVar2.zzaqf, zzjjVar2.zzaqg, zzjjVar2.zzaqh, zzjjVar2.zzaqi, zzjjVar2.zzaqj, zzjjVar2.zzaqk, zzjjVar2.zzaql);
            zzyVar = this;
        }
        return super.zzb(zzjjVar2);
    }

    @Override // com.google.android.gms.ads.internal.zzi, com.google.android.gms.ads.internal.zza
    protected final void zzbq() {
        zzaqw zzaqwVar = this.zzvw.zzacw != null ? this.zzvw.zzacw.zzbyo : null;
        if (!this.zzxf && zzaqwVar != null) {
            zzc(zzaqwVar);
        }
        super.zzbq();
    }

    @Override // com.google.android.gms.ads.internal.zzd
    protected final boolean zzca() {
        boolean z;
        zzbv.zzek();
        if (zzakk.zzl(this.zzvw.zzrt, "android.permission.INTERNET")) {
            z = true;
        } else {
            zzkb.zzif().zza(this.zzvw.zzacs, this.zzvw.zzacv, "Missing internet permission in AndroidManifest.xml.", "Missing internet permission in AndroidManifest.xml. You must have the following declaration: <uses-permission android:name=\"android.permission.INTERNET\" />");
            z = false;
        }
        zzbv.zzek();
        if (!zzakk.zzaj(this.zzvw.zzrt)) {
            zzkb.zzif().zza(this.zzvw.zzacs, this.zzvw.zzacv, "Missing AdActivity with android:configChanges in AndroidManifest.xml.", "Missing AdActivity with android:configChanges in AndroidManifest.xml. You must have the following declaration within the <application> element: <activity android:name=\"com.google.android.gms.ads.AdActivity\" android:configChanges=\"keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize\" />");
            z = false;
        }
        if (!z && this.zzvw.zzacs != null) {
            this.zzvw.zzacs.setVisibility(0);
        }
        return z;
    }

    @Override // com.google.android.gms.internal.ads.zzaam
    public final void zzcz() {
        this.zzvv.zzdy();
    }

    @VisibleForTesting
    final void zzd(@Nullable zzajh zzajhVar) {
        if (zzajhVar == null || zzajhVar.zzcoc || this.zzvw.zzacs == null || !zzbv.zzek().zza(this.zzvw.zzacs, this.zzvw.zzrt) || !this.zzvw.zzacs.getGlobalVisibleRect(new Rect(), null)) {
            return;
        }
        if (zzajhVar != null && zzajhVar.zzbyo != null && zzajhVar.zzbyo.zzuf() != null) {
            zzajhVar.zzbyo.zzuf().zza((zzasg) null);
        }
        zza(zzajhVar, false);
        zzajhVar.zzcoc = true;
    }
}
